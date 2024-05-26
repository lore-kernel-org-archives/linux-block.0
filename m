Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD17E8F4E;
	Sun, 26 May 2024 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716717961; cv=none; b=VV5uVXhddwpAlWBsqlbmDx4R56PRx1TunOB4Bu0eiHaQTG4xmHLgpfH7jRmHPBbqnyCF4zQEcm8uPmk8ZOuM17pbhPVtId9pgXjII42XPh4FaCSsfB3C9EmkapvbG/7XfSu2hQNwgki3L3h0C5p9t2Z64/paZfzw1Qi0Ks66SkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716717961; c=relaxed/simple;
	bh=U8sViIwTvfqyAEFWwJYA2QuGtxh5YeclfUPtRLMvasM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LUbQGRN1/k8+xiScB2y1YA07RoaeOd+SsBbZO6MLP43Jy4TdhYzG91k3ZSHEpZMD94xiTGfFGO4jGoQDfM1UuSdVt5z6SJ/14PpFQIgyzulh/NyPxQCRdUmb4gNBGbS53p94jIlfex0WJtHx7RdCEE84ZRjhJGh2xpqmeItAlCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoIoZrxE; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoIoZrxE"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c9d70d93dbso4673396b6e.3;
        Sun, 26 May 2024 03:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716717958; x=1717322758; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k3rp31B0mQlFat0bx4wPf89tw+hDPDO09XoleO7LiSM=;
        b=KoIoZrxE98yoeRh0/2W2bQ5ojy5lL+xXhOSPreFU0MRTJYKxFOI/m6L9t8DvnxoW70
         Mfv5qV+MevFwjc7ujLIHF+De3EhJBcdeROb06XbyvIao3FimQMs8nGRp3rJK3Op8a3vd
         jxmUsXsPokw4Bb5IxEIaPN/U/LG5ad3qWxla4Jm7zNap9TE7+HkaN/QKFgdg1KChLSss
         ax9tIATO3j3nl/oJWZdlCavn6XlEtHOgtR448cjzgMVISdE1VKLqTnQkMem+IOQQ0D4N
         JJYlRKuFsJUg6lRWFjS+dha2l8aKvoassazBnpGgYB0T5IRDloOMpn6PS7S+kr9T1JTE
         HthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716717958; x=1717322758;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k3rp31B0mQlFat0bx4wPf89tw+hDPDO09XoleO7LiSM=;
        b=XVO+fmjX2tTTF8kBqoMr2uB7FVzSeGP74ezBrYIlCULwT0g2/rUq62wpw6CNNMIYVH
         OqcJosnz3+Ssnh6bI+BOw+zYZrPiG6qOU1PW3f9X+JqcVelLRmrSJ26rQqFw+QY2T4Sk
         gxqxvvYAZfgnUzaJeFJbVRabIlVGTWJrrKu8+rvjlIhSya2hM1+f/CZHO9UwxqIvAFrS
         lJFxMmf3Rn6xxn1fZi3YyhEgN3H6lA8Up+aY2xreJmL6GAT4ZfsNvuWBOCrQZezdFNTv
         1HC1LXwwCYFEzRLZeEy11jTZdYmknvmtcjWhwEsDEYCaF25LXabmh6DLps8mO2Hhol+u
         IMjg==
X-Forwarded-Encrypted: i=1; AJvYcCUPPq7JVFoiwTWs4m4Kgz+VwmNhE5e9/IFCTWu49txzEnxvrHZGx4cewrs1RCWBXEGFU8RDeLlH3Ge474FUAdEAmav/9Ujz
X-Gm-Message-State: AOJu0Ywzu3ODWM20UUFYNz1rgKWT7PGAL4mg95t/l26j0DCnXx1tl1UG
	AnG8Z0NGhWe/5O9XOybc9SX+RKDUNnbXBqjKa+Uw47kSIBjbsIRsthayLXlqZTKNia1cPYSZ5Tj
	QNuSODUlpAmC25vH8p8O26jBec4aajt8oX3M=
X-Google-Smtp-Source: AGHT+IGiSUJmIhl1ePzTyzUGUvs86MfJk1/2h6Lz8k5iISWTHRBnUECH2J5x2MLQvd3FhlXdS02aaYVPrr7f77y00NQ=
X-Received: by 2002:a05:6808:3d0:b0:3c9:a968:d0b2 with SMTP id
 5614622812f47-3d1a61138a5mr6500681b6e.32.1716717958104; Sun, 26 May 2024
 03:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Rankin <rankincj@gmail.com>
Date: Sun, 26 May 2024 11:05:47 +0100
Message-ID: <CAK2bqVJGsz8r8D-x=4N6p9nXQ=v4AwpMAg2frotmdSdtjvnexg@mail.gmail.com>
Subject: [BUG] NPE with Linux 6.8.10 and Linux 6.8.11 SCSI optical drive.
To: linux-block@vger.kernel.org, Linux Stable <stable@vger.kernel.org>
Cc: axboe@kernel.dk, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I have recently purchased a new UHD optical disc which is proving so
difficult to read that both the 6.8.10 and 6.8.11 kernels throw NPE
errors:

With vanilla 6.8.11:
[  173.866492] BUG: kernel NULL pointer dereference, address: 0000000000000048
[  173.872158] #PF: supervisor read access in kernel mode
[  173.875995] #PF: error_code(0x0000) - not-present page
[  173.879836] PGD 0 P4D 0
[  173.881075] Oops: 0000 [#1] PREEMPT SMP PTI
[  173.883960] CPU: 0 PID: 4183 Comm: umount Tainted: G          I E
   6.8.10 #2
[  173.890052] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[  173.897619] RIP: 0010:blk_try_enter_queue+0xc/0x75
[  173.901120] Code: 41 00 eb 04 65 48 ff 08 58 e9 05 90 d6 ff 90 90
90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 89 f5 53 48 89 fb e8 04
54 d6 ff <48> 8b 43 48 a8 03 74 0f f6 43 48 02 75 4d 48 8b 53 50 48 8b
02 eb
[  173.918568] RSP: 0018:ffffc90002e87b60 EFLAGS: 00010202
[  173.922493] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
[  173.928324] RDX: ffff88810c434740 RSI: 0000000000000000 RDI: 0000000000000000
[  173.934156] RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000001b58
[  173.939991] R10: 0000000000000020 R11: 0000000000000223 R12: 0000000000000000
[  173.945824] R13: 0000000000000000 R14: ffffc90002e87d20 R15: 0000000000001b58
[  173.951656] FS:  00007fc145466800(0000) GS:ffff888343c00000(0000)
knlGS:0000000000000000
[  173.958442] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  173.962887] CR2: 0000000000000048 CR3: 00000001413be000 CR4: 00000000000006f0
[  173.968720] Call Trace:
[  173.969867]  <TASK>
[  173.970671]  ? __die_body+0x1a/0x5c
[  173.972862]  ? page_fault_oops+0x321/0x36e
[  173.975664]  ? exc_page_fault+0x105/0x117
[  173.978374]  ? asm_exc_page_fault+0x22/0x30
[  173.981263]  ? blk_try_enter_queue+0xc/0x75
[  173.984147]  blk_queue_enter+0x37/0x10b
[  173.986688]  blk_mq_alloc_request+0x154/0x1b7
[  173.989750]  scsi_alloc_request+0xa/0x57 [scsi_mod]
[  173.993351]  scsi_execute_cmd+0x5d/0x174 [scsi_mod]
[  173.996948]  sr_do_ioctl+0x8d/0x1ac [sr_mod]
[  173.999930]  sr_packet+0x39/0x42 [sr_mod]
[  174.002653]  cdrom_get_disc_info+0x60/0xc9 [cdrom]
[  174.006156]  cdrom_mrw_exit+0x25/0xe6 [cdrom]
[  174.009220]  ? xa_destroy+0x7e/0xb8
[  174.011413]  ? preempt_latency_start+0x2b/0x46
[  174.014560]  sr_free_disk+0x40/0x56 [sr_mod]
[  174.017542]  disk_release+0xb6/0xc4
[  174.019735]  device_release+0x5a/0x80
[  174.022098]  kobject_put+0x84/0xa4
[  174.024204]  bdev_release+0x153/0x165
[  174.026573]  deactivate_locked_super+0x2f/0x68
[  174.029726]  cleanup_mnt+0xab/0xd3
[  174.031832]  task_work_run+0x6b/0x80
[  174.034110]  resume_user_mode_work+0x22/0x55
[  174.037082]  syscall_exit_to_user_mode+0x5d/0x7b
[  174.040404]  do_syscall_64+0x86/0xdc
[  174.042681]  entry_SYSCALL_64_after_hwframe+0x60/0x68
[  174.046434] RIP: 0033:0x7fc14568715b
[  174.048739] Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3
0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 89 9c 0c 00
f7 d8
[  174.066185] RSP: 002b:00007ffddee09a88 EFLAGS: 00000246 ORIG_RAX:
00000000000000a6
[  174.072450] RAX: 0000000000000000 RBX: 000055607dd37e60 RCX: 00007fc14568715b
[  174.078283] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055607dd38270
[  174.084117] RBP: 00007ffddee09b60 R08: 000055607dd3a350 R09: 00007fc145751b20
[  174.089947] R10: 0000000000000008 R11: 0000000000000246 R12: 000055607dd37f68
[  174.095773] R13: 0000000000000000 R14: 000055607dd38270 R15: 000055607dd393d0
[  174.101608]  </TASK>
[  174.102500] Modules linked in: udf snd_seq_dummy rpcrdma rdma_cm
iw_cm ib_cm ib_core nf_nat_ftp nf_conntrack_ftp cfg80211 af_packet
nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet
nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat
ebtable_broute ip6table_nat ip6table_mangle ip6table_raw
ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c iptable_mangle iptable_raw iptable_security
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter
ip_tables x_tables it87 hwmon_vid bnep binfmt_misc
snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic
snd_hda_intel uvcvideo intel_powerclamp coretemp snd_intel_dspcfg
btusb kvm_intel uvc videobuf2_vmalloc videobuf2_memops btintel
snd_hda_codec snd_usb_audio btbcm videobuf2_v4l2 kvm bluetooth
snd_virtuoso snd_hda_core videodev snd_usbmidi_lib snd_oxygen_lib
snd_mpu401_uart snd_hwdep usb_storage snd_seq videobuf2_common
snd_rawmidi
[  174.102617]  input_leds ecdh_generic mc joydev snd_seq_device
led_class rfkill snd_pcm ecc iTCO_wdt r8169 gpio_ich irqbypass pktcdvd
snd_hrtimer realtek intel_cstate snd_timer intel_uncore mdio_devres
psmouse libphy snd i2c_i801 mxm_wmi acpi_cpufreq i2c_smbus
tiny_power_button pcspkr lpc_ich soundcore i7core_edac button nfsd(E)
auth_rpcgss nfs_acl lockd grace sunrpc fuse dm_mod loop configfs dax
nfnetlink zram zsmalloc amdgpu ext4 crc32c_generic crc16 mbcache jbd2
video amdxcp i2c_algo_bit mfd_core drm_ttm_helper ttm drm_exec
gpu_sched sr_mod drm_suballoc_helper drm_buddy drm_display_helper
cdrom sd_mod hid_microsoft usbhid drm_kms_helper ahci libahci
pata_jmicron drm uhci_hcd xhci_pci libata ehci_pci ehci_hcd xhci_hcd
scsi_mod usbcore firewire_ohci crc32c_intel sha512_ssse3 firewire_core
sha256_ssse3 drm_panel_orientation_quirks cec sha1_ssse3 serio_raw bsg
rc_core crc_itu_t usb_common scsi_common wmi msr
[  174.269914] CR2: 0000000000000048
[  174.271981] ---[ end trace 0000000000000000 ]---
[  174.275308] RIP: 0010:blk_try_enter_queue+0xc/0x75
[  174.278892] Code: 41 00 eb 04 65 48 ff 08 58 e9 05 90 d6 ff 90 90
90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 89 f5 53 48 89 fb e8 04
54 d6 ff <48> 8b 43 48 a8 03 74 0f f6 43 48 02 75 4d 48 8b 53 50 48 8b
02 eb
[  174.296345] RSP: 0018:ffffc90002e87b60 EFLAGS: 00010202
[  174.300320] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
[  174.306156] RDX: ffff88810c434740 RSI: 0000000000000000 RDI: 0000000000000000
[  174.312035] RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000001b58
[  174.317946] R10: 0000000000000020 R11: 0000000000000223 R12: 0000000000000000
[  174.323860] R13: 0000000000000000 R14: ffffc90002e87d20 R15: 0000000000001b58
[  174.329743] FS:  00007fc145466800(0000) GS:ffff888343c00000(0000)
knlGS:0000000000000000
[  174.336601] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  174.341136] CR2: 0000000000000048 CR3: 00000001413be000 CR4: 00000000000006f0

And with vanilla 6.8.10:
[ 4426.333116] BUG: kernel NULL pointer dereference, address: 0000000000000048
[ 4426.338778] #PF: supervisor read access in kernel mode
[ 4426.342617] #PF: error_code(0x0000) - not-present page
[ 4426.346455] PGD 0 P4D 0
[ 4426.347696] Oops: 0000 [#1] PREEMPT SMP PTI
[ 4426.350581] CPU: 4 PID: 9349 Comm: umount Tainted: G          I
   6.8.11 #1
[ 4426.356674] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[ 4426.364242] RIP: 0010:blk_try_enter_queue+0xc/0x75
[ 4426.367744] Code: 41 00 eb 04 65 48 ff 08 58 e9 05 90 d6 ff 90 90
90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 89 f5 53 48 89 fb e8 04
54 d6 ff <48> 8b 43 48 a8 03 74 0f f6 43 48 02 75 4d 48 8b 53 50 48 8b
02 eb
[ 4426.385189] RSP: 0018:ffffc9000186bb60 EFLAGS: 00010202
[ 4426.389114] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
[ 4426.394946] RDX: ffff8881852b3900 RSI: 0000000000000000 RDI: 0000000000000000
[ 4426.400780] RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000001b58
[ 4426.406611] R10: 0000000000000020 R11: 0000000000000235 R12: 0000000000000000
[ 4426.412445] R13: 0000000000000000 R14: ffffc9000186bd20 R15: 0000000000001b58
[ 4426.418279] FS:  00007f2d5041e800(0000) GS:ffff888343d00000(0000)
knlGS:0000000000000000
[ 4426.425063] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4426.429510] CR2: 0000000000000048 CR3: 000000021d394000 CR4: 00000000000006f0
[ 4426.435350] Call Trace:
[ 4426.436505]  <TASK>
[ 4426.437311]  ? __die_body+0x1a/0x5c
[ 4426.439511]  ? page_fault_oops+0x321/0x36e
[ 4426.442320]  ? exc_page_fault+0x105/0x117
[ 4426.445031]  ? asm_exc_page_fault+0x22/0x30
[ 4426.447924]  ? blk_try_enter_queue+0xc/0x75
[ 4426.450812]  blk_queue_enter+0x37/0x10b
[ 4426.453354]  blk_mq_alloc_request+0x154/0x1b7
[ 4426.456421]  scsi_alloc_request+0xa/0x57 [scsi_mod]
[ 4426.460026]  scsi_execute_cmd+0x5d/0x174 [scsi_mod]
[ 4426.463633]  sr_do_ioctl+0x8d/0x1ac [sr_mod]
[ 4426.466613]  sr_packet+0x39/0x42 [sr_mod]
[ 4426.469335]  cdrom_get_disc_info+0x60/0xc9 [cdrom]
[ 4426.472837]  cdrom_mrw_exit+0x25/0xe6 [cdrom]
[ 4426.475904]  ? xa_destroy+0x7e/0xb8
[ 4426.478104]  ? preempt_latency_start+0x2b/0x46
[ 4426.481251]  sr_free_disk+0x40/0x56 [sr_mod]
[ 4426.484232]  disk_release+0xb6/0xc4
[ 4426.486424]  device_release+0x5a/0x80
[ 4426.488790]  kobject_put+0x84/0xa4
[ 4426.490895]  bdev_release+0x153/0x165
[ 4426.493263]  deactivate_locked_super+0x2f/0x68
[ 4426.496408]  cleanup_mnt+0xab/0xd3
[ 4426.498514]  task_work_run+0x6b/0x80
[ 4426.500811]  resume_user_mode_work+0x22/0x55
[ 4426.503784]  syscall_exit_to_user_mode+0x5d/0x7b
[ 4426.507102]  do_syscall_64+0x86/0xdc
[ 4426.509383]  entry_SYSCALL_64_after_hwframe+0x60/0x68
[ 4426.513143] RIP: 0033:0x7f2d5063f15b
[ 4426.515456] Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3
0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 89 9c 0c 00
f7 d8
[ 4426.532903] RSP: 002b:00007fff2878dcb8 EFLAGS: 00000246 ORIG_RAX:
00000000000000a6
[ 4426.539167] RAX: 0000000000000000 RBX: 000055cd5ee85e60 RCX: 00007f2d5063f15b
[ 4426.545002] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055cd5ee86270
[ 4426.550891] RBP: 00007fff2878dd90 R08: 000055cd5ee88350 R09: 00007f2d50709b20
[ 4426.556719] R10: 0000000000000008 R11: 0000000000000246 R12: 000055cd5ee85f68
[ 4426.562550] R13: 0000000000000000 R14: 000055cd5ee86270 R15: 000055cd5ee873d0
[ 4426.568386]  </TASK>
[ 4426.569277] Modules linked in: sg udf usb_storage uinput
snd_seq_dummy rpcrdma rdma_cm iw_cm ib_cm ib_core nf_nat_ftp
nf_conntrack_ftp cfg80211 af_packet nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle
iptable_raw iptable_security ebtable_filter ebtables ip6table_filter
ip6_tables iptable_filter ip_tables x_tables it87 hwmon_vid bnep
rc_pinnacle_pctv_hd em28xx_rc binfmt_misc tda18271
snd_hda_codec_realtek snd_hda_codec_hdmi cxd2820r
snd_hda_codec_generic snd_hda_intel regmap_i2c em28xx_dvb dvb_core
uvcvideo btusb btintel uvc intel_powerclamp videobuf2_vmalloc coretemp
btbcm snd_usb_audio videobuf2_memops em28xx kvm_intel videobuf2_v4l2
bluetooth tveeprom snd_intel_dspcfg videodev snd_hda_codec
snd_virtuoso kvm
[ 4426.569392]  videobuf2_common
[ 4426.583929] usb 2-4: new high-speed USB device number 6 using ehci-pci
[ 4426.657557]  snd_oxygen_lib snd_usbmidi_lib snd_hda_core
snd_mpu401_uart snd_hwdep snd_rawmidi mc snd_seq input_leds led_class
joydev ecdh_generic rfkill snd_seq_device ecc iTCO_wdt gpio_ich r8169
snd_pcm irqbypass snd_hrtimer pktcdvd realtek snd_timer intel_cstate
mdio_devres snd libphy psmouse intel_uncore i2c_i801 pcspkr
acpi_cpufreq i2c_smbus mxm_wmi soundcore lpc_ich i7core_edac
tiny_power_button button nfsd auth_rpcgss nfs_acl lockd grace dm_mod
sunrpc fuse loop configfs dax nfnetlink zram zsmalloc amdgpu ext4
crc32c_generic crc16 mbcache jbd2 video amdxcp i2c_algo_bit mfd_core
drm_ttm_helper ttm drm_exec gpu_sched drm_suballoc_helper drm_buddy
drm_display_helper drm_kms_helper sr_mod hid_microsoft sd_mod cdrom
usbhid drm xhci_pci uhci_hcd ehci_pci ahci ehci_hcd pata_jmicron
libahci xhci_hcd libata drm_panel_orientation_quirks cec usbcore
crc32c_intel scsi_mod sha512_ssse3 rc_core firewire_ohci firewire_core
bsg serio_raw sha256_ssse3 sha1_ssse3 usb_common crc_itu_t scsi_common
wmi msr
[ 4426.750898] CR2: 0000000000000048
[ 4426.752950] ---[ end trace 0000000000000000 ]---
[ 4426.756276] RIP: 0010:blk_try_enter_queue+0xc/0x75
[ 4426.759776] Code: 41 00 eb 04 65 48 ff 08 58 e9 05 90 d6 ff 90 90
90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 89 f5 53 48 89 fb e8 04
54 d6 ff <48> 8b 43 48 a8 03 74 0f f6 43 48 02 75 4d 48 8b 53 50 48 8b
02 eb
[ 4426.777232] RSP: 0018:ffffc9000186bb60 EFLAGS: 00010202
[ 4426.781165] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
[ 4426.786998] RDX: ffff8881852b3900 RSI: 0000000000000000 RDI: 0000000000000000
[ 4426.790807] usb-storage 2-4:1.0: USB Mass Storage device detected
[ 4426.792867] RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000001b58
[ 4426.797877] scsi host10: usb-storage 2-4:1.0
[ 4426.803501] R10: 0000000000000020 R11: 0000000000000235 R12: 0000000000000000
[ 4426.812322] R13: 0000000000000000 R14: ffffc9000186bd20 R15: 0000000000001b58
[ 4426.818165] FS:  00007f2d5041e800(0000) GS:ffff888343d00000(0000)
knlGS:0000000000000000
[ 4426.824958] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4426.829402] CR2: 0000000000000048 CR3: 000000021d394000 CR4: 00000000000006f0
[ 4427.835567] scsi 10:0:0:0: CD-ROM            HL-DT-ST BD-RE BU40N
   1.00 PQ: 0 ANSI: 0

Cheers,
Chris
