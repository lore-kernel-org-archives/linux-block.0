Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 108-166-122-24.static.cloud-ips.com ([108.166.122.24]:53955
        "EHLO smtp.gaealink.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S932761AbcIBUM7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Sep 2016 16:12:59 -0400
Received: from localhost (unknown [127.0.0.1])
        by smtp.gaealink.net (Postfix) with ESMTP id 453BC7E0EC
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2016 20:09:00 +0000 (UTC)
Received: from smtp.gaealink.net ([127.0.0.1])
        by localhost (smtp.gaealink.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3Meb1Qv6ddMJ for <linux-block@vger.kernel.org>;
        Fri,  2 Sep 2016 20:08:56 +0000 (UTC)
Received: from smtp.julianfamily.org (unknown [50.35.104.187])
        by smtp.gaealink.net (Postfix) with ESMTPA id 6BC947E03F
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2016 20:08:56 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp.julianfamily.org (Postfix) with ESMTP id D496D29000AF
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2016 20:05:55 +0000 (UTC)
Received: from smtp.julianfamily.org ([127.0.0.1])
        by localhost (smtp.julianfamily.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xd4RjII_c6Zc for <linux-block@vger.kernel.org>;
        Fri,  2 Sep 2016 20:05:50 +0000 (UTC)
Received: from [192.168.2.101] (questor.julianfamily.org [192.168.2.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.julianfamily.org (Postfix) with ESMTPSA id 60B2A29000AA
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2016 20:05:50 +0000 (UTC)
To: linux-block@vger.kernel.org
From: Joe Julian <joe@julianfamily.org>
Subject: paging request bug in blk_attempt_plug_merge
Message-ID: <f941722b-02da-d127-ac52-7f2a2f9e784f@julianfamily.org>
Date: Fri, 2 Sep 2016 13:05:41 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This happened during boot. The last thing to be logged before this 
happened was:

Sep 02 19:43:09 smtp redis-server[241]: 241:M 02 Sep 19:43:09.108 * Background saving started by pid 498

The bug was followed by:

Sep 02 19:43:10 smtp redis-server[241]: 498:C 02 Sep 19:43:10.226 * DB saved on disk
Sep 02 19:43:10 smtp redis-server[241]: 498:C 02 Sep 19:43:10.278 * RDB: 10 MB of memory used by copy-on-write

There should be plenty of free memory:

# free
               total        used        free      shared  buff/cache   available
Mem:        4051492      844128     2544472         380      662892     2992336
Swap:       2097148           0     2097148

If I can provide anything else, let me know.

[  608.723406] BUG: unable to handle kernel paging request at 
00000000ae4e4030
[  608.723406] IP: [<ffffffff812bc4a6>] blk_attempt_plug_merge+0x66/0x110
[  608.723406] PGD 0
[  608.723406] Oops: 0000 [#1] PREEMPT SMP
[  608.723406] Modules linked in: kvm_amd ttm kvm drm_kms_helper 
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel 
aes_x86_64 lrw drm syscopyarea sysfillrect sysimgblt fb_sys_fops 
gf128mul input_leds led_class joydev mousedev acpi_cpufreq psmouse 
intel_agp intel_gtt tpm_tis tpm glue_helper evdev ablk_helper ppdev 
cryptd i2c_piix4 mac_hid serio_raw pcspkr parport_pc parport button 
qemu_fw_cfg sch_fq_codel ip_tables x_tables xfs libcrc32c crc32c_generic 
ata_generic pata_acpi virtio_blk virtio_balloon virtio_net 
virtio_console atkbd libps2 crc32c_intel virtio_pci virtio_ring virtio 
uhci_hcd ehci_pci ata_piix ehci_hcd usbcore usb_common libata scsi_mod 
floppy i8042 serio
[  608.723406] CPU: 0 PID: 123 Comm: xfsaild/vda1 Not tainted 
4.7.2-1-ARCH #1
[  608.723406] Hardware name: OpenStack Foundation OpenStack Nova, BIOS 
1.9.3-20160701_074356-anatol 04/01/2014
[  608.723406] task: ffff880139b8aac0 ti: ffff8800b8bf0000 task.ti: 
ffff8800b8bf0000
[  608.723406] RIP: 0010:[<ffffffff812bc4a6>] [<ffffffff812bc4a6>] 
blk_attempt_plug_merge+0x66/0x110
[  608.723406] RSP: 0018:ffff8800b8bf3b18  EFLAGS: 00010282
[  608.723406] RAX: 0000000000000000 RBX: 00000000ae4e4000 RCX: 
0000000000cd9e30
[  608.723406] RDX: 0000000000cda640 RSI: ffff8800bb7c0200 RDI: 
ffff8801396558c0
[  608.723406] RBP: ffff8800b8bf3b50 R08: 0000000000000001 R09: 
0000000000000002
[  608.723406] R10: ffff8800bb7c0200 R11: 0000000000000010 R12: 
ffff880036e6c800
[  608.723406] R13: 0000000000000000 R14: ffff8800b8bf3d80 R15: 
ffff8800b8bf3b7c
[  608.723406] FS:  0000000000000000(0000) GS:ffff88013fc00000(0000) 
knlGS:0000000000000000
[  608.723406] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  608.723406] CR2: 00000000ae4e4030 CR3: 00000000bb24d000 CR4: 
00000000000406f0
[  608.723406] Stack:
[  608.723406]  0100000000001000 ffff8800bb7c0200 ffff880036e6c800 
0000000000000000
[  608.723406]  ffff880036e6c800 ffff880139b8aac0 0000000000000021 
ffff8800b8bf3bc0
[  608.723406]  ffffffff812c787d ffff88013a4a81e0 ffff88013a4a8210 
ffff8800bb7c0200
[  608.723406] Call Trace:
[  608.723406]  [<ffffffff812c787d>] blk_sq_make_request+0x1dd/0x410
[  608.723406]  [<ffffffff81174e55>] ? mempool_alloc_slab+0x15/0x20
[  608.723406]  [<ffffffff812bb382>] generic_make_request+0xf2/0x1a0
[  608.723406]  [<ffffffff812bb4a6>] submit_bio+0x76/0x160
[  608.723406]  [<ffffffffa01db64e>] ? xfs_inode_buf_verify+0x8e/0xd0 [xfs]
[  608.723406]  [<ffffffffa01e8c37>] _xfs_buf_ioapply+0x2d7/0x430 [xfs]
[  608.723406]  [<ffffffff810a42d0>] ? wake_up_q+0x70/0x70
[  608.723406]  [<ffffffffa01e910e>] ? 
__xfs_buf_delwri_submit+0x1ce/0x240 [xfs]
[  608.723406]  [<ffffffffa01e8e2d>] xfs_buf_submit+0x5d/0x170 [xfs]
[  608.723406]  [<ffffffffa01e910e>] __xfs_buf_delwri_submit+0x1ce/0x240 
[xfs]
[  608.723406]  [<ffffffffa01e9ebf>] ? 
xfs_buf_delwri_submit_nowait+0x2f/0x50 [xfs]
[  608.723406]  [<ffffffffa01e9ebf>] 
xfs_buf_delwri_submit_nowait+0x2f/0x50 [xfs]
[  608.723406]  [<ffffffffa0217358>] xfsaild+0x288/0x790 [xfs]
[  608.723406]  [<ffffffffa02170d0>] ? 
xfs_trans_ail_cursor_first+0x90/0x90 [xfs]
[  608.723406]  [<ffffffffa02170d0>] ? 
xfs_trans_ail_cursor_first+0x90/0x90 [xfs]
[  608.723406]  [<ffffffff81099598>] kthread+0xd8/0xf0
[  608.723406]  [<ffffffff815de9bf>] ret_from_fork+0x1f/0x40
[  608.723406]  [<ffffffff810994c0>] ? kthread_worker_fn+0x170/0x170
[  608.723406] Code: bf d0 00 00 00 00 4c 0f 44 f0 49 8b 5e 08 49 39 de 
74 7d 49 89 cd 49 89 d7 48 89 75 d0 49 89 fc eb 09 48 8b 5b 08 49 39 de 
74 65 <4c> 3b 63 30 75 f1 41 83 07 01 4d 85 ed 74 04 49 89 5d 00 4c 3b
[  608.723406] RIP  [<ffffffff812bc4a6>] blk_attempt_plug_merge+0x66/0x110
[  608.723406]  RSP <ffff8800b8bf3b18>
[  608.723406] CR2: 00000000ae4e4030
[  608.723406] ---[ end trace 2e24aa1c8b062434 ]---

