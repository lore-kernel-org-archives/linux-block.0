Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79971C433B4
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 13:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD1361019
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 13:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346058AbhDMNpP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 09:45:15 -0400
Received: from iris.vrvis.at ([92.60.8.8]:50232 "EHLO iris.vrvis.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344847AbhDMNpK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 09:45:10 -0400
X-Greylist: delayed 1913 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Apr 2021 09:45:09 EDT
Received: from [10.43.0.118]
        by iris.vrvis.at with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <valentin@vrvis.at>)
        id 1lWIqF-0004pC-Ns; Tue, 13 Apr 2021 15:12:53 +0200
To:     Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Valentin Kleibel <valentin@vrvis.at>
Message-ID: <b6aea08d-7190-e341-8780-13ba8e015dd4@vrvis.at>
Date:   Tue, 13 Apr 2021 15:12:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: aoe: kernel crash on blk_update_request: I/O error, BUG: scheduling
 while atomic
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Dear Maintainers,

It seems we found a race condition in the aoe driver that leads to a
kernel crash. It is triggered when an aoe device is unavailable and
therefore produces an I/O error in the code that tries to remove the
device. (drivers/block/aoe/aoedev.c: aoedev_downdev)

I reproduced this behaviour successfully with kernels 5.10.26 and 
5.10.28 from the debian archives (bullseye an unstable). Kernel 4.19.181 
from debian buster is confirmed not to be affected.
The bug was also reported to debian [1] and kernel.org [2].

example process to reproduce:
* add an aoe-target to a lvm2 volume group
* make the aoe target unavailable (e.g. set the network dev down) but
don't flush it
* run a command that scans all physical volumes, e.g. 'vgs'
* wait for aoe to time out (default for aoe_deadsecs is 180s)

result: kernel crash
relevant dmesg output:
[....]
[  183.855191] mlx4_en: enp65s0d1: Close port called
[  183.931534] mlx4_en: enp65s0d1: Link Down
[  408.620155] blk_update_request: I/O error, dev etherd/e42.0, sector
4096 op 0x0:(READ) flags 0x0 phys_seg 2 prio class 0
[  408.620235] blk_update_request: I/O error, dev etherd/e42.0, sector 0
op 0x0:(READ) flags 0x0 phys_seg 2 prio class 0
[  408.620290] BUG: scheduling while atomic: swapper/16/0/0x00000100
[  408.620325] Modules linked in: sctp bridge 8021q garp stp mrp llc
psmouse dlm configfs aoe ipmi_ssif amd64_edac_mod edac_mce_amd
amd_energy kvm_amd kvm irqbypass ghash_clmulni_intel aesni_intel libaes
crypto_simd cryptd glue_helper rapl pcspkr ast drm_vram_helper
drm_ttm_helper ttm drm_kms_helper cec drm evdev joydev ccp sg sp5100_tco
rng_core watchdog k10temp acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler
acpi_cpufreq button ext4 crc16 mbcache jbd2 dm_mod raid10 raid456
async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq
libcrc32c crc32c_generic raid0 multipath linear mlx4_ib ib_uverbs
mlx4_en raid1 md_mod sd_mod t10_pi crc_t10dif crct10dif_generic ib_core
hid_generic usbhid hid crct10dif_pclmul crct10dif_common crc32_pclmul
crc32c_intel xhci_pci igb mpt3sas xhci_hcd ahci libahci i2c_algo_bit dca
ptp libata pps_core raid_class usbcore scsi_transport_sas mlx4_core
scsi_mod i2c_piix4 usb_common
[  408.620422] CPU: 16 PID: 0 Comm: swapper/16 Not tainted
5.10.0-5-amd64 #1 Debian 5.10.26-1
[  408.620424] Hardware name: Supermicro AS -2013S-C0R/H11SSL-C, BIOS
2.1 02/21/2020
[  408.620425] Call Trace:
[  408.620428]  <IRQ>
[  408.620437]  dump_stack+0x6b/0x83
[  408.620442]  __schedule_bug.cold+0x4c/0x58
[  408.620446]  __schedule+0x719/0x870
[  408.620449]  schedule+0x46/0xb0
[  408.620453]  blk_mq_freeze_queue_wait+0x62/0x90
[  408.620458]  ? add_wait_queue_exclusive+0x70/0x70
[  408.620466]  aoedev_downdev+0x106/0x150 [aoe]
[  408.620471]  rexmit_timer+0x4ea/0x500 [aoe]
[  408.620476]  ? rexmit_deferred+0x380/0x380 [aoe]
[  408.620480]  call_timer_fn+0x29/0xf0
[  408.620483]  __run_timers.part.0+0x1d3/0x240
[  408.620485]  ? ktime_get+0x38/0xa0
[  408.620488]  ? lapic_next_event+0x1d/0x20
[  408.620491]  ? clockevents_program_event+0x8d/0xf0
[  408.620494]  run_timer_softirq+0x26/0x50
[  408.620496]  __do_softirq+0xc5/0x275
[  408.620499]  asm_call_irq_on_stack+0x12/0x20
[  408.620501]  </IRQ>
[  408.620505]  do_softirq_own_stack+0x37/0x40
[  408.620509]  irq_exit_rcu+0x8e/0xc0
[  408.620512]  sysvec_apic_timer_interrupt+0x36/0x80
[  408.620515]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[  408.620520] RIP: 0010:cpuidle_enter_state+0xc7/0x350
[  408.620523] Code: 8b 3d dd 5b b7 6b e8 d8 4f a2 ff 49 89 c5 0f 1f 44
00 00 31 ff e8 69 5a a2 ff 45 84 ff 0f 85 fa 00 00 00 fb 66 0f 1f 44 00
00 <45> 85 f6 0f 88 06 01 00 00 49 63 c6 4c 2b 2c 24 48 8d 14 40 48 8d
[  408.620525] RSP: 0018:ffffba890038fea8 EFLAGS: 00000246
[  408.620527] RAX: ffff9c18afc2bc00 RBX: 0000000000000002 RCX:
000000000000001f
[  408.620529] RDX: 0000000000000000 RSI: 000000003677d46d RDI:
0000000000000000
[  408.620530] RBP: ffff9c28d634b000 R08: 0000005f23a8382d R09:
0000000000000018
[  408.620531] R10: 0000000000000dd5 R11: 0000000000001169 R12:
ffffffff955b8fa0
[  408.620532] R13: 0000005f23a8382d R14: 0000000000000002 R15:
0000000000000000
[  408.620537]  ? cpuidle_enter_state+0xb7/0x350
[  408.620540]  cpuidle_enter+0x29/0x40
[  408.620543]  do_idle+0x1ef/0x2b0
[  408.620546]  cpu_startup_entry+0x19/0x20
[  408.620550]  secondary_startup_64_no_verify+0xb0/0xbb
[  408.620561] bad: scheduling from the idle thread!
[  408.620591] CPU: 16 PID: 0 Comm: swapper/16 Tainted: G        W
   5.10.0-5-amd64 #1 Debian 5.10.26-1
[  408.620593] Hardware name: Supermicro AS -2013S-C0R/H11SSL-C, BIOS
2.1 02/21/2020
[  408.620601] Call Trace:
[  408.620609]  <IRQ>
[  408.620617]  dump_stack+0x6b/0x83
[  408.620625]  dequeue_task_idle+0x28/0x40
[  408.620632]  __schedule+0x3bf/0x870
[  408.620641]  schedule+0x46/0xb0
[  408.620648]  blk_mq_freeze_queue_wait+0x62/0x90
[  408.620657]  ? add_wait_queue_exclusive+0x70/0x70
[  408.620666]  aoedev_downdev+0x106/0x150 [aoe]
[  408.620679]  rexmit_timer+0x4ea/0x500 [aoe]
[  408.620688]  ? rexmit_deferred+0x380/0x380 [aoe]
[  408.620694]  call_timer_fn+0x29/0xf0
[  408.620701]  __run_timers.part.0+0x1d3/0x240
[  408.620709]  ? ktime_get+0x38/0xa0
[  408.620715]  ? lapic_next_event+0x1d/0x20
[  408.620720]  ? clockevents_program_event+0x8d/0xf0
[  408.620728]  run_timer_softirq+0x26/0x50
[  408.620734]  __do_softirq+0xc5/0x275
[  408.620739]  asm_call_irq_on_stack+0x12/0x20
[  408.620743]  </IRQ>
[  408.620749]  do_softirq_own_stack+0x37/0x40
[  408.620757]  irq_exit_rcu+0x8e/0xc0
[  408.620767]  sysvec_apic_timer_interrupt+0x36/0x80
[  408.620774]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[  408.620786] RIP: 0010:cpuidle_enter_state+0xc7/0x350
[  408.620794] Code: 8b 3d dd 5b b7 6b e8 d8 4f a2 ff 49 89 c5 0f 1f 44
00 00 31 ff e8 69 5a a2 ff 45 84 ff 0f 85 fa 00 00 00 fb 66 0f 1f 44 00
00 <45> 85 f6 0f 88 06 01 00 00 49 63 c6 4c 2b 2c 24 48 8d 14 40 48 8d
[  408.620796] RSP: 0018:ffffba890038fea8 EFLAGS: 00000246
[  408.620798] RAX: ffff9c18afc2bc00 RBX: 0000000000000002 RCX:
000000000000001f
[  408.620801] RDX: 0000000000000000 RSI: 000000003677d46d RDI:
0000000000000000
[  408.620802] RBP: ffff9c28d634b000 R08: 0000005f23a8382d R09:
0000000000000018
[  408.620804] R10: 0000000000000dd5 R11: 0000000000001169 R12:
ffffffff955b8fa0
[  408.620805] R13: 0000005f23a8382d R14: 0000000000000002 R15:
0000000000000000
[  408.620810]  ? cpuidle_enter_state+0xb7/0x350
[  408.620813]  cpuidle_enter+0x29/0x40
[  408.620817]  do_idle+0x1ef/0x2b0
[  408.620820]  cpu_startup_entry+0x19/0x20
[  408.620822]  secondary_startup_64_no_verify+0xb0/0xbb
[  408.622975] bad: scheduling from the idle thread!
[  408.623007] CPU: 16 PID: 0 Comm: swapper/16 Tainted: G        W
   5.10.0-5-amd64 #1 Debian 5.10.26-1
[  408.623008] Hardware name: Supermicro AS -2013S-C0R/H11SSL-C, BIOS
2.1 02/21/2020
[  408.623010] Call Trace:
[  408.623012]  <IRQ>
[  408.623014]  dump_stack+0x6b/0x83
[  408.623017]  dequeue_task_idle+0x28/0x40
[  408.623020]  __schedule+0x3bf/0x870
[  408.623022]  schedule+0x46/0xb0
[  408.623024]  blk_mq_freeze_queue_wait+0x62/0x90
[  408.623027]  ? add_wait_queue_exclusive+0x70/0x70
[  408.623031]  aoedev_downdev+0x106/0x150 [aoe]
[  408.623035]  rexmit_timer+0x4ea/0x500 [aoe]
[  408.623040]  ? rexmit_deferred+0x380/0x380 [aoe]
[  408.623052]  call_timer_fn+0x29/0xf0
[  408.623061]  __run_timers.part.0+0x1d3/0x240
[  408.623069]  ? ktime_get+0x38/0xa0
[  408.623078]  ? lapic_next_event+0x1d/0x20
[  408.623087]  ? clockevents_program_event+0x8d/0xf0
[  408.623095]  run_timer_softirq+0x26/0x50
[  408.623103]  __do_softirq+0xc5/0x275
[  408.623106]  asm_call_irq_on_stack+0x12/0x20
[  408.623107]  </IRQ>
[  408.623110]  do_softirq_own_stack+0x37/0x40
[  408.623114]  irq_exit_rcu+0x8e/0xc0
[  408.623116]  sysvec_apic_timer_interrupt+0x36/0x80
[  408.623119]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[  408.623123] RIP: 0010:cpuidle_enter_state+0xc7/0x350
[  408.623125] Code: 8b 3d dd 5b b7 6b e8 d8 4f a2 ff 49 89 c5 0f 1f 44
00 00 31 ff e8 69 5a a2 ff 45 84 ff 0f 85 fa 00 00 00 fb 66 0f 1f 44 00
00 <45> 85 f6 0f 88 06 01 00 00 49 63 c6 4c 2b 2c 24 48 8d 14 40 48 8d
[  408.623127] RSP: 0018:ffffba890038fea8 EFLAGS: 00000246
[  408.623130] RAX: ffff9c18afc2bc00 RBX: 0000000000000002 RCX:
000000000000001f
[  408.623131] RDX: 0000000000000000 RSI: 000000003677d46d RDI:
0000000000000000
[  408.623132] RBP: ffff9c28d634b000 R08: 0000005f23a8382d R09:
0000000000000018
[  408.623133] R10: 0000000000000dd5 R11: 0000000000001169 R12:
ffffffff955b8fa0
[  408.623135] R13: 0000005f23a8382d R14: 0000000000000002 R15:
0000000000000000
[  408.623140]  ? cpuidle_enter_state+0xb7/0x350
[  408.623147]  cpuidle_enter+0x29/0x40
[  408.623154]  do_idle+0x1ef/0x2b0
[  408.623164]  cpu_startup_entry+0x19/0x20
[  408.623173]  secondary_startup_64_no_verify+0xb0/0xbb
[  408.623484] bad: scheduling from the idle thread!
[  408.623514] CPU: 16 PID: 0 Comm: swapper/16 Tainted: G        W
   5.10.0-5-amd64 #1 Debian 5.10.26-1
[  408.623515] Hardware name: Supermicro AS -2013S-C0R/H11SSL-C, BIOS
2.1 02/21/2020
[  408.623516] Call Trace:
[  408.623518]  <IRQ>
[  408.623520]  dump_stack+0x6b/0x83
[  408.623523]  dequeue_task_idle+0x28/0x40
[  408.623525]  __schedule+0x3bf/0x870
[  408.623528]  schedule+0x46/0xb0
[  408.623531]  blk_mq_freeze_queue_wait+0x62/0x90
[  408.623533]  ? add_wait_queue_exclusive+0x70/0x70
[  408.623537]  aoedev_downdev+0x106/0x150 [aoe]
[  408.623542]  rexmit_timer+0x4ea/0x500 [aoe]
[  408.623554]  ? rexmit_deferred+0x380/0x380 [aoe]
[  408.623563]  call_timer_fn+0x29/0xf0
[  408.623572]  __run_timers.part.0+0x1d3/0x240
[  408.623581]  ? ktime_get+0x38/0xa0
[  408.623587]  ? lapic_next_event+0x1d/0x20
[  408.623596]  ? clockevents_program_event+0x8d/0xf0
[  408.623604]  run_timer_softirq+0x26/0x50
[  408.623610]  __do_softirq+0xc5/0x275
[  408.623613]  asm_call_irq_on_stack+0x12/0x20
[  408.623615]  </IRQ>
[  408.623618]  do_softirq_own_stack+0x37/0x40
[  408.623620]  irq_exit_rcu+0x8e/0xc0
[  408.623623]  sysvec_apic_timer_interrupt+0x36/0x80
[  408.623626]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[  408.623630] RIP: 0010:cpuidle_enter_state+0xc7/0x350
[  408.623632] Code: 8b 3d dd 5b b7 6b e8 d8 4f a2 ff 49 89 c5 0f 1f 44
00 00 31 ff e8 69 5a a2 ff 45 84 ff 0f 85 fa 00 00 00 fb 66 0f 1f 44 00
00 <45> 85 f6 0f 88 06 01 00 00 49 63 c6 4c 2b 2c 24 48 8d 14 40 48 8d
[  408.623634] RSP: 0018:ffffba890038fea8 EFLAGS: 00000246
[  408.623636] RAX: ffff9c18afc2bc00 RBX: 0000000000000002 RCX:
000000000000001f
[  408.623637] RDX: 0000000000000000 RSI: 000000003677d46d RDI:
0000000000000000
[  408.623639] RBP: ffff9c28d634b000 R08: 0000005f23a8382d R09:
0000000000000018
[  408.623641] R10: 0000000000000dd5 R11: 0000000000001169 R12:
ffffffff955b8fa0
[  408.623644] R13: 0000005f23a8382d R14: 0000000000000002 R15:
0000000000000000
[  408.623651]  ? cpuidle_enter_state+0xb7/0x350
[  408.623660]  cpuidle_enter+0x29/0x40
[  408.623668]  do_idle+0x1ef/0x2b0
[  408.623677]  cpu_startup_entry+0x19/0x20
[  408.623685]  secondary_startup_64_no_verify+0xb0/0xbb
[  408.623991] bad: scheduling from the idle thread!
[  408.624027] CPU: 16 PID: 0 Comm: swapper/16 Tainted: G        W
   5.10.0-5-amd64 #1 Debian 5.10.26-1
[  408.624028] Hardware name: Supermicro AS -2013S-C0R/H11SSL-C, BIOS
2.1 02/21/2020
[  408.624029] Call Trace:
[  408.624030]  <IRQ>
[  408.624034]  dump_stack+0x6b/0x83
[  408.624036]  dequeue_task_idle+0x28/0x40
[  408.624038]  __schedule+0x3bf/0x870
[  408.624041]  schedule+0x46/0xb0
[  408.624043]  blk_mq_freeze_queue_wait+0x62/0x90
[  408.624047]  ? add_wait_queue_exclusive+0x70/0x70
[  408.624051]  aoedev_downdev+0x106/0x150 [aoe]
[  408.624054]  rexmit_timer+0x4ea/0x500 [aoe]
[  408.624058]  ? rexmit_deferred+0x380/0x380 [aoe]
[  408.624062]  call_timer_fn+0x29/0xf0
[  408.624064]  __run_timers.part.0+0x1d3/0x240
[  408.624066]  ? ktime_get+0x38/0xa0
[  408.624068]  ? lapic_next_event+0x1d/0x20
[  408.624070]  ? clockevents_program_event+0x8d/0xf0
[  408.624072]  run_timer_softirq+0x26/0x50
[  408.624075]  __do_softirq+0xc5/0x275
[  408.624077]  asm_call_irq_on_stack+0x12/0x20
[  408.624078]  </IRQ>
[  408.624080]  do_softirq_own_stack+0x37/0x40
[  408.624084]  irq_exit_rcu+0x8e/0xc0
[  408.624094]  sysvec_apic_timer_interrupt+0x36/0x80
[  408.624103]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[  408.624112] RIP: 0010:cpuidle_enter_state+0xc7/0x350
[  408.624121] Code: 8b 3d dd 5b b7 6b e8 d8 4f a2 ff 49 89 c5 0f 1f 44
00 00 31 ff e8 69 5a a2 ff 45 84 ff 0f 85 fa 00 00 00 fb 66 0f 1f 44 00
00 <45> 85 f6 0f 88 06 01 00 00 49 63 c6 4c 2b 2c 24 48 8d 14 40 48 8d
[  408.624130] RSP: 0018:ffffba890038fea8 EFLAGS: 00000246
[  408.624142] RAX: ffff9c18afc2bc00 RBX: 0000000000000002 RCX:
000000000000001f
[  408.624150] RDX: 0000000000000000 RSI: 000000003677d46d RDI:
0000000000000000
[  408.624158] RBP: ffff9c28d634b000 R08: 0000005f23a8382d R09:
0000000000000018
[  408.624163] R10: 0000000000000dd5 R11: 0000000000001169 R12:
ffffffff955b8fa0
[  408.624172] R13: 0000005f23a8382d R14: 0000000000000002 R15:
0000000000000000
[  408.624182]  ? cpuidle_enter_state+0xb7/0x350
[  408.624189]  cpuidle_enter+0x29/0x40
[  408.624196]  do_idle+0x1ef/0x2b0
[  408.624200]  cpu_startup_entry+0x19/0x20
[  408.624203]  secondary_startup_64_no_verify+0xb0/0xbb


These messages continue until the machine is reset.

It seems to be a regression from commit 3582dd291788 ("aoe: convert
aoeblk to blk-mq") and a similar bug has already been fixed [3].

running on kernel 4.19.0-16-amd64 we get the expected result that the
aoe device is removed upon timeout. dmesg output:
[....]
[  301.543788] mlx4_en: enp65s0d1: Close port called
[  301.608154] mlx4_en: enp65s0d1: Link Down
[  527.124182] print_req_error: I/O error, dev etherd/e42.0, sector 4096
[  527.124248] aoe: device 42.0 is not up
[  527.124251] print_req_error: I/O error, dev etherd/e42.0, sector 0
[  527.124299] aoe: device 42.0 is not up
[  527.124300] aoe: device 42.0 is not up
[  527.124316] aoe: device 42.0 is not up


Hope someone can resolve this issue,

thanks for your help,
Valentin Kleibel

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=986837
[2] https://bugzilla.kernel.org/show_bug.cgi?id=212665
[3] https://lkml.org/lkml/2019/8/27/400
