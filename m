Return-Path: <kkolasa@winsoft.pl>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk
From: Krzysztof Kolasa <kkolasa@winsoft.pl>
Subject: Oops on the system startup in the function part_in_flight()
Message-ID: <964a2654-3b86-c9f6-1522-0854d1e4ab0d@winsoft.pl>
Date: Fri, 22 Sep 2017 10:25:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi all,

This error stops my system (daily build, linux-next) :

---------
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189584] BUG: unable to handle kernel NULL pointer dereference at 00000000000000f8
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189592] IP: part_in_flight+0x5/0x60
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189593] PGD 0 P4D 0
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189595] Oops: 0000 [#1] SMP
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189596] Modules linked in: rfcomm ccm bnep binfmt_misc snd_soc_skl snd_soc_skl_ipc snd_soc_sst_ipc snd_soc_sst_dsp snd_hda_ext_core snd_hda_codec_hdmi snd_soc_sst_match snd_hda_codec_conexant snd_hda_codec_generic snd_soc_core asus_nb_wmi asus_wmi sparse_keymap snd_hda_intel arc4 snd_hda_codec snd_hda_core snd_pcm snd_hwdep intel_rapl x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm uvcvideo videobuf2_vmalloc cdc_mbim cdc_wdm snd_seq_midi videobuf2_memops irqbypass videobuf2_v4l2 cdc_ncm videobuf2_core snd_seq_midi_event usbnet crct10dif_pclmul videodev crc32_pclmul btusb media snd_rawmidi btrtl btbcm mii ghash_clmulni_intel pcbc snd_seq aesni_intel iwlmvm aes_x86_64 crypto_simd cryptd glue_helper mac80211 intel_cstate snd_timer intel_rapl_perf snd_seq_device iwlwifi snd cfg80211 input_leds
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189623]  joydev serio_raw soundcore shpchp mei_me mei hci_uart btqca btintel intel_pch_thermal processor_thermal_device intel_soc_dts_iosf wmi int3403_thermal bluetooth intel_lpss_acpi ecdh_generic dell_smo8800 intel_lpss int3400_thermal int3402_thermal acpi_thermal_rel acpi_als int3406_thermal int340x_thermal_zone kfifo_buf tpm_crb asus_wireless acpi_pad industrialio mac_hid cuse coretemp parport_pc ppdev lp parport ip_tables x_tables autofs4 i915 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops e1000e drm psmouse ahci ptp pps_core libahci i2c_hid hid pinctrl_sunrisepoint video pinctrl_intel
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189648] CPU: 0 PID: 3299 Comm: gnome-shell Not tainted 4.14.0-rc1-winsoft-x64+ #4
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189649] Hardware name: ASUSTeK COMPUTER INC. BU403UA/BU403UA, BIOS BU403UA.305 09/12/2016
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189650] task: ffff9843e0ef2e80 task.stack: ffffbcd102a88000
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189652] RIP: 0010:part_in_flight+0x5/0x60
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189653] RSP: 0018:ffffbcd102a8bc88 EFLAGS: 00010297
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189654] RAX: ffff9844261fb070 RBX: ffff9844261e7000 RCX: ffff984425f67cc0
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189655] RDX: ffffbcd102a8bc90 RSI: ffff9844261e7000 RDI: 0000000000000000
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189656] RBP: ffffbcd102a8bcc8 R08: ffff9844261e7038 R09: ffff984414eb1e40
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189657] R10: ffff9843c2867938 R11: ffff9843e0ef2e80 R12: 00000000fffef9ae
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189658] R13: ffff9844261fb000 R14: 0000000000000000 R15: 0000000000000001
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189659] FS:  00007fac2e5a4100(0000) GS:ffff984433c00000(0000) knlGS:0000000000000000
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189660] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189661] CR2: 00000000000000f8 CR3: 0000000214fe2004 CR4: 00000000003606f0
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189662] Call Trace:
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189665]  ? part_round_stats+0xf6/0x170
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189668]  ? mntput+0x24/0x40
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189670]  part_stat_show+0x49/0x330
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189673]  dev_attr_show+0x20/0x50
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189675]  sysfs_kf_seq_show+0xb8/0x120
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189677]  kernfs_seq_show+0x21/0x30
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189678]  seq_read+0xc9/0x3f0
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189680]  kernfs_fop_read+0x134/0x180
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189682]  __vfs_read+0x37/0x160
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189684]  ? security_file_permission+0x9b/0xc0
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189686]  vfs_read+0x8e/0x130
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189687]  SyS_read+0x55/0xc0
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189689]  entry_SYSCALL_64_fastpath+0x1e/0xa9
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189691] RIP: 0033:0x7fac2b9a0d5d
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189691] RSP: 002b:00007fffffe44790 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189693] RAX: ffffffffffffffda RBX: 000055ce744db1d0 RCX: 00007fac2b9a0d5d
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189694] RDX: 0000000000001fff RSI: 00007fffffe45910 RDI: 0000000000000046
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189694] RBP: 00007fac2b9863e0 R08: 0000000000000000 R09: 0000000000000018
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189695] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189696] R13: 00007fabc4b8e3e0 R14: 000055ce7350a9e0 R15: 000055ce74640240
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189697] Code: 85 d2 74 e5 48 85 f6 74 0f 48 8b 56 28 48 83 ea 70 f0 ff 4c 02 48 5d c3 31 d2 eb f5 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 <48> 83 bf f8 00 00 00 00 75 3b 8b 8e 28 03 00 00 8b 86 2c 03 00
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189719] RIP: part_in_flight+0x5/0x60 RSP: ffffbcd102a8bc88
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189720] CR2: 00000000000000f8
Sep 21 22:09:00 krzysiek-asus1 kernel: [   31.189722] ---[ end trace 501f2c2fbb4c9161 ]---
---------

Krzysztof Kolasa
