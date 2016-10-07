Return-Path: <dyoung@redhat.com>
Date: Fri, 7 Oct 2016 12:03:32 +0800
From: Dave Young <dyoung@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: loop mount: kernel BUG at lib/percpu-refcount.c:231
Message-ID: <20161007040332.GA16400@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Hi,

Below bug happened to me while loop mount a file image after stopping a
kvm guest. But it only happend once til now..

[ 4761.031686] ------------[ cut here ]------------
[ 4761.075984] kernel BUG at lib/percpu-refcount.c:231!
[ 4761.120184] invalid opcode: 0000 [#1] SMP
[ 4761.164307] Modules linked in: loop(+) macvtap macvlan tun ccm rfcomm fuse snd_hda_codec_hdmi cmac bnep vfat fat kvm_intel kvm irqbypass arc4 i915 rtsx_pci_sdmmc intel_gtt drm_kms_helper iwlmvm syscopyarea sysfillrect sysimgblt fb_sys_fops mac80211 drm snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_codec btusb snd_hwdep iwlwifi snd_hda_core input_leds btrtl snd_seq pcspkr serio_raw btbcm snd_seq_device i2c_i801 btintel cfg80211 bluetooth snd_pcm i2c_smbus rtsx_pci mfd_core e1000e ptp pps_core snd_timer thinkpad_acpi wmi snd soundcore rfkill video nfsd auth_rpcgss nfs_acl lockd grace sunrpc
[ 4761.323045] CPU: 1 PID: 25890 Comm: modprobe Not tainted 4.8.0+ #168
[ 4761.377791] Hardware name: LENOVO 20ARS1BJ02/20ARS1BJ02, BIOS GJET86WW (2.36 ) 12/04/2015
[ 4761.433704] task: ffff986fd1b7d780 task.stack: ffffa85842528000
[ 4761.490120] RIP: 0010:[<ffffffffae2b2ef8>]  [<ffffffffae2b2ef8>] __percpu_ref_switch_to_percpu+0xf8/0x100
[ 4761.548138] RSP: 0018:ffffa8584252bb38  EFLAGS: 00010246
[ 4761.604673] RAX: 0000000000000000 RBX: ffff986fbdca3200 RCX: 0000000000000000
[ 4761.662416] RDX: 0000000000983288 RSI: 0000000000000001 RDI: ffff986fbdca3958
[ 4761.720473] RBP: ffffa8584252bb80 R08: 0000000800000000 R09: 00000008ffffffff
[ 4761.779270] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[ 4761.837603] R13: ffff9870fa22c800 R14: ffff9870fa22c80c R15: ffff986fbdca3200
[ 4761.895870] FS:  00007fc286eb4640(0000) GS:ffff98711f240000(0000) knlGS:0000000000000000
[ 4761.954596] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4762.012978] CR2: 0000555c3a20ee78 CR3: 0000000212988000 CR4: 00000000001406e0
[ 4762.072454] Stack:
[ 4762.131283]  ffff9870f2f37800 ffff9870c8e46000 ffff9870fa22c880 ffffa8584252bbb8
[ 4762.190776]  ffffffffae2a147c 00000000ba169577 ffff986fbdca3200 ffff9870fa22c870
[ 4762.251149]  ffff9870fa22c800 ffffa8584252bb90 ffffffffae2b3294 ffffa8584252bbc8
[ 4762.311657] Call Trace:
[ 4762.371157]  [<ffffffffae2a147c>] ? kobject_uevent_env+0xfc/0x3b0
[ 4762.431483]  [<ffffffffae2b3294>] percpu_ref_switch_to_percpu+0x14/0x20
[ 4762.492093]  [<ffffffffae28188e>] blk_register_queue+0xbe/0x120
[ 4762.552727]  [<ffffffffae28e854>] device_add_disk+0x1c4/0x470
[ 4762.614155]  [<ffffffffc02e2c19>] loop_add+0x1d9/0x260 [loop]
[ 4762.674042]  [<ffffffffc02ff119>] loop_init+0x119/0x16c [loop]
[ 4762.733949]  [<ffffffffc02ff000>] ? 0xffffffffc02ff000
[ 4762.793563]  [<ffffffffae00043b>] do_one_initcall+0x4b/0x180
[ 4762.853068]  [<ffffffffae1375b3>] ? free_vmap_area_noflush+0x43/0xb0
[ 4762.913665]  [<ffffffffae0fc699>] do_init_module+0x55/0x1c4
[ 4762.973400]  [<ffffffffae0bce14>] load_module+0x1fc4/0x23e0
[ 4763.033545]  [<ffffffffae0ba2f0>] ? __symbol_put+0x60/0x60
[ 4763.094281]  [<ffffffffae0bd368>] SYSC_init_module+0x138/0x150
[ 4763.154985]  [<ffffffffae0bd479>] SyS_init_module+0x9/0x10
[ 4763.215577]  [<ffffffffae5c01bb>] entry_SYSCALL_64_fastpath+0x1e/0xad
[ 4763.277044] Code: 00 48 c7 c7 20 c7 a8 ae 48 63 d2 e8 63 ef ff ff 3b 05 81 a9 7d 00 89 c2 7c cd 48 8b 43 08 48 83 e0 fe 48 89 43 08 e9 3c ff ff ff <0f> 0b e8 81 b6 d9 ff 90 55 48 89 e5 41 54 4c 8d 67 d8 53 48 89 
[ 4763.342964] RIP  [<ffffffffae2b2ef8>] __percpu_ref_switch_to_percpu+0xf8/0x100
[ 4763.407151]  RSP <ffffa8584252bb38>

Thanks
Dave
