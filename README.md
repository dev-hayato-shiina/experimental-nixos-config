# experimental-nixos-config

_実験的な NixOS Configuration_

---

### virt-managerの一部初期設定

|項目|値|
|---|---|
|Memory|4096MiB|
|CPUs|1|
|disk image for the virtual machine|20.0GiB|
|Customize configuration before install|有効|

**概要 > Hypervisor Details**

|項目|値|
|---|---|
|Firmware|UEFI|

**ディスプレイ Spice**

|項目|値|
|---|---|
|Listen type|なし|
|OpenGL|有効 表示されているものを選択する|

**Video**

|項目|値|
|---|---|
|Model|Virtio|
|3D acceleration|有効|

---

### VirtualBoxの仮想マシンの初期設定の一部変更

**名前とオペレーティングシステム**

|項目|値|
|---|---|
|タイプ|Linux|
|Subtype|Other Linux|
|バージョン|Other Linux(64-bit)|

**ハードウェア**

|項目|値|
|---|---|
|メインメモリー|8192MB|
|プロセッサー数|2CPU|
|EFIを有効化|有効|

**ハードディスク**

|項目|値|
|---|---|
|仮想ハードディスクを作成する|有効|

**ハードディスクファイルの場所とサイズ**

|項目|値|
|---|---|
|サイズ|50GB|
|ハードディスクのファイルタイプと種類|VDI(Virtual Disk Image)|
|全サイズの事前割り当て|無効|

---

### VirtualBoxの仮想マシン作成後の一部設定変更

**設定 > Expert > ディスプレイ > スクリーン**

|項目|値|
|---|---|
|ビデオメモリー|128MB|
|3Dアクセラレーションを有効化|有効|

**設定 > Expert > ネットワーク > アダプター1 > ポートフォワーディング**

|項目|値|
|---|---|
|名前|SSH|
|プロトコル|TCP|
|ホストIP|127.0.0.1|
|ホストポート|2222|
|ゲストIP|-|
|ゲストポート|22|

---

### 初期構築

TODO: 記載する

---

### 2回目以降

TODO: 記載する

---

### SSH接続

#### VirtualBoxの場合

VirtualBoxでは、NAT環境のゲストOSへSSHするために`127.0.0.1:2222 -> ゲストOS:22`のようなポートフォワーディングを使っています。  
ホストPCで以下のコマンドを実行することでSSH接続することができます。

```bash
ssh -p 2222 alpha@localhost
```

#### KVM/QEMU + libvirt + virt-managerの場合

KVM/QEMU + libvirt + virt-managerでは、まずはポートフォワーディングを使わず、libvirtの`default`NATネットワーク上に作られるゲストIPへ直接SSHします。  
理由は、libvirtの`default`ネットワークでは仮想ブリッジ`virbr0`が作成され、ホストとゲストが同じ仮想ネットワーク上で通信できるため。  
ゲストにはDHCPで`192.168.122.x`のようなIPが割り当てられるので、ホストからそのIPの22番ポートへ直接接続できます。

この`default`ネットワークでDNS/DHCPを使うため、ホスト側には`dnsmasq`を入れる。  
NixOS Wikiでも、libvirtのdefault networkを使うには`dnsmasq`が必要で、`virsh net-start default`により有効化すると説明されている。

```bash
sudo virsh net-start default
sudo virsh net-autostart default
sudo virsh net-dhcp-leases default
ssh -p 22 <guest-user>@192.168.122.xxx
```

つまり、VirtualBoxのようにホスト側の `127.0.0.1:2222` へ転送するのではなく、libvirtの仮想ネットワーク内で割り当てられたゲストIPへ直接SSHする方針にする。

## コマンド一覧

指定ファイル以外の内容をコピーして、テキストファイルにペースト
```bash
sh copy.sh
```

NixOS Rebuild
```bash
nixos-rebuild switch --sudo --flake "path:$HOME/.config/nixos#nixos"
```

一時的にgitをインストールして、リポジトリクローン
```bash
nix shell nixpkgs#git -c git clone https://github.com/dev-hayato-shiina/experimental-nixos-config.git
```
