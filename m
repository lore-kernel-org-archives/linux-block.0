Return-Path: <SRS0=Upb7=PP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C25C43387
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 19:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623922085A
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 19:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbfAGTlP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:41:15 -0500
Received: from ale.deltatee.com ([207.54.116.67]:42508 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfAGTlP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Jan 2019 14:41:15 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1ggalp-0008U0-HS; Mon, 07 Jan 2019 12:41:12 -0700
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <da851333-eadd-163a-8c78-e1f4ec5ec857@deltatee.com>
Date:   Mon, 7 Jan 2019 12:41:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------CB830E2FF86FDCA8B6E7F1D5"
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Regression in v5.0-rc1: Panic at boot
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------CB830E2FF86FDCA8B6E7F1D5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hey,

I found a regression in v5.0-rc1 this morning. My system panics on boot.
I've attached a log of the panic.

I bisected to find the problematic commit is:

Fixes: 9d037ad707ed ("block: remove req->timeout_list")

But it makes no sense to me why this commit would cause a problem like
this. I've attached a bisect log. I've also tested v5.0-rc1 with this
commit reverted and that boots fine.

The traceback seems to indicate the problem is on the bip_get_seed()
line in t10_pi_complete(). Which suggests that bio_integrity() is
returning NULL.

Thanks,

Logan

--------------CB830E2FF86FDCA8B6E7F1D5
Content-Type: text/x-log;
 name="bisect.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="bisect.log"

git bisect start
# good: [8fe28cb58bcb235034b64cbbb7550a8a43fd88be] Linux 4.20
git bisect good 8fe28cb58bcb235034b64cbbb7550a8a43fd88be
# bad: [bfeffd155283772bbe78c6a05dec7c0128ee500c] Linux 5.0-rc1
git bisect bad bfeffd155283772bbe78c6a05dec7c0128ee500c
# good: [e0c38a4d1f196a4b17d2eba36afff8f656a4f1de] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
git bisect good e0c38a4d1f196a4b17d2eba36afff8f656a4f1de
# bad: [02061181d3a9ccfe15ef6bc15fa56283acc47620] Merge tag 'staging-4.21-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect bad 02061181d3a9ccfe15ef6bc15fa56283acc47620
# bad: [75f95da078b2891cd186f074ffc15a8e7c3f082d] Merge tag 'libnvdimm-for-4.21' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
git bisect bad 75f95da078b2891cd186f074ffc15a8e7c3f082d
# bad: [0e9da3fbf7d81f0f913b491c8de1ba7883d4f217] Merge tag 'for-4.21/block-20181221' of git://git.kernel.dk/linux-block
git bisect bad 0e9da3fbf7d81f0f913b491c8de1ba7883d4f217
# good: [b12a9124eeb71d766a3e3eb594ebbb3fefc66902] Merge tag 'y2038-for-4.21' of ssh://gitolite.kernel.org:/pub/scm/linux/kernel/git/arnd/playground
git bisect good b12a9124eeb71d766a3e3eb594ebbb3fefc66902
# bad: [c6d962aebaf8ec5d867aac09ee33e3f528c2539d] nvme-pci: only allow polling with separate poll queues
git bisect bad c6d962aebaf8ec5d867aac09ee33e3f528c2539d
# bad: [511c49fe1804671800947b69281e07719fad25e2] fnic: fix fnic_scsi_host_{start,end}_tag
git bisect bad 511c49fe1804671800947b69281e07719fad25e2
# good: [3110fc79606fb6003949246c6fb325dd43445273] blk-mq: improve plug list sorting
git bisect good 3110fc79606fb6003949246c6fb325dd43445273
# good: [7baa85727d0406ffd2b2303cd803a145aa35c505] blk-mq-tag: change busy_iter_fn to return whether to continue or not
git bisect good 7baa85727d0406ffd2b2303cd803a145aa35c505
# good: [55c7bc37e05b5f7593b76d1c74e254b996b73d1a] mtip32xx: remove mtip_get_int_command
git bisect good 55c7bc37e05b5f7593b76d1c74e254b996b73d1a
# bad: [785ba83b4f3e4fde236f03205dd1cd98fd6a5255] scsi: push blk_status_t up into scsi_setup_{fs,scsi}_cmnd
git bisect bad 785ba83b4f3e4fde236f03205dd1cd98fd6a5255
# bad: [9d037ad707ed6069fbea4e38e6ee37e027b13f1d] block: remove req->timeout_list
git bisect bad 9d037ad707ed6069fbea4e38e6ee37e027b13f1d
# good: [27d420bc475e68c85d567d96caf215999d76fd16] mtip32xxx: use for_each_sg
git bisect good 27d420bc475e68c85d567d96caf215999d76fd16
# first bad commit: [9d037ad707ed6069fbea4e38e6ee37e027b13f1d] block: remove req->timeout_list
# good: [27d420bc475e68c85d567d96caf215999d76fd16] mtip32xxx: use for_each_sg
git bisect good 27d420bc475e68c85d567d96caf215999d76fd16
# first bad commit: [9d037ad707ed6069fbea4e38e6ee37e027b13f1d] block: remove req->timeout_list

--------------CB830E2FF86FDCA8B6E7F1D5
Content-Type: text/x-log;
 name="panic.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="panic.log"

[    8.542203] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
[    8.551091] PGD 0 P4D 0 
[    8.554022] Oops: 0000 [#1] SMP PTI
[    8.558020] CPU: 7 PID: 0 Comm: swapper/7 Not tainted 4.20.0-rc1.direct-00174-g9d037ad707ed #1410
[    8.568067] Hardware name: Supermicro SYS-7047GR-TRF/X9DRG-QF, BIOS 3.0a 12/05/2013
[    8.576759] RIP: 0010:t10_pi_complete+0x77/0x1c0
[    8.582021] Code: 65 4c 8b 2c 25 80 4d 01 00 4c 89 2c 24 44 88 64 24 17 48 8b 44 24 08 45 31 db f6 40 12 01 74 04 4c 8b 58 78 44 0f b6 54 24 17 <41> 8b 53 08 45 8b 43 10 45 8b 4b 14 41 8b 7b 18 45 85 c0 0f 84 ee
[    8.603162] RSP: 0018:ffff880479b83e90 EFLAGS: 00010246
[    8.609094] RAX: ffff88047569fe00 RBX: 0000000000000000 RCX: 00000000fffffff7
[    8.617172] RDX: 0000000000000008 RSI: 0000000000000000 RDI: ffff88047569fe00
[    8.625252] RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000200
[    8.633329] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[    8.641407] R13: ffff8804785eee40 R14: ffff880272457080 R15: ffff880274c7a400
[    8.649485] FS:  0000000000000000(0000) GS:ffff880479b80000(0000) knlGS:0000000000000000
[    8.658654] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.665178] CR2: 0000000000000008 CR3: 0000000475aae005 CR4: 00000000000606e0
[    8.673255] Call Trace:
[    8.676090]  <IRQ>
[    8.678444]  sd_done+0xf5/0x340
[    8.682057]  scsi_finish_command+0xc3/0x120
[    8.686840]  blk_done_softirq+0x83/0xb0
[    8.691242]  __do_softirq+0xa1/0x2e6
[    8.695341]  irq_exit+0xbc/0xd0
[    8.698958]  call_function_single_interrupt+0xf/0x20
[    8.704608]  </IRQ>
[    8.707054] RIP: 0010:cpuidle_enter_state+0xbc/0x330
[    8.712695] Code: 77 7e e8 57 e2 88 ff 49 89 c7 8b 05 46 52 c9 00 85 c0 7f 79 31 ff e8 f3 ec 88 ff 80 7c 24 0f 00 0f 85 fc 00 00 00 fb 45 85 ed <0f> 88 27 02 00 00 4c 2b 7c 24 10 48 ba cf f7 53 e3 a5 9b c4 20 4c
[    8.733836] RSP: 0018:ffffc90001a27e88 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff04
[    8.742412] RAX: ffff880479ba1200 RBX: ffffffff824adfe0 RCX: 000000000000001f
[    8.750491] RDX: 00000001fd27837e RSI: 00000000355559b4 RDI: 0000000000000000
[    8.758562] RBP: ffffe8ffffd979c0 R08: 0000000000000004 R09: 0000000000020a80
[    8.766632] R10: 00000000ffffffff R11: 0000000000000169 R12: ffff8804785eee40
[    8.774711] R13: 0000000000000002 R14: 0000000000000002 R15: 00000001fd27837e
[    8.782790]  ? cpuidle_enter_state+0xad/0x330
[    8.787754]  do_idle+0x1e1/0x240
[    8.791460]  cpu_startup_entry+0x19/0x20
[    8.795948]  start_secondary+0x196/0x1e0
[    8.800432]  secondary_startup_64+0xa4/0xb0
[    8.805213] Modules linked in:
[    8.808725] CR2: 0000000000000008
[    8.812537] ---[ end trace 28b6363ca135f1f8 ]---
[    8.822574] RIP: 0010:t10_pi_complete+0x77/0x1c0
[    8.827836] Code: 65 4c 8b 2c 25 80 4d 01 00 4c 89 2c 24 44 88 64 24 17 48 8b 44 24 08 45 31 db f6 40 12 01 74 04 4c 8b 58 78 44 0f b6 54 24 17 <41> 8b 53 08 45 8b 43 10 45 8b 4b 14 41 8b 7b 18 45 85 c0 0f 84 ee
[    8.848977] RSP: 0018:ffff880479b83e90 EFLAGS: 00010246
[    8.854925] RAX: ffff88047569fe00 RBX: 0000000000000000 RCX: 00000000fffffff7
[    8.863003] RDX: 0000000000000008 RSI: 0000000000000000 RDI: ffff88047569fe00
[    8.871083] RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000200
[    8.879162] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[    8.887241] R13: ffff8804785eee40 R14: ffff880272457080 R15: ffff880274c7a400
[    8.895311] FS:  0000000000000000(0000) GS:ffff880479b80000(0000) knlGS:0000000000000000
[    8.904471] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.910995] CR2: 0000000000000008 CR3: 0000000475aae005 CR4: 00000000000606e0
[    8.919072] Kernel panic - not syncing: Fatal exception in interrupt
[    8.926340] Kernel Offset: disabled
[    8.933578] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
[    8.942179] unchecked MSR access error: WRMSR to 0x83f (tried to write 0x00000000000000f6) at rIP: 0xffffffff810acf24 (native_apic_msr_write+0x24/0x40)
[    8.957469] Call Trace:
[    8.960301]  <IRQ>
[    8.962649]  arch_irq_work_raise+0x28/0x40
[    8.967331]  irq_work_queue+0x98/0xa0
[    8.971524]  enqueue_entity+0x6f3/0x7a0
[    8.975913]  enqueue_task_fair+0xa5/0x6d0
[    8.980496]  ? vt_console_print+0x223/0x3d0
[    8.985273]  ttwu_do_activate+0x44/0x80
[    8.989659]  sched_ttwu_pending+0x87/0xd0
[    8.994240]  scheduler_ipi+0x4d/0x130
[    8.998434]  reschedule_interrupt+0xf/0x20
[    9.003119] RIP: 0010:panic+0x20e/0x253
[    9.007503] Code: 48 83 c3 64 eb a6 83 3d d2 cf a6 01 00 74 05 e8 4b 40 02 00 48 c7 c6 00 28 b6 82 48 c7 c7 c8 c3 22 82 e8 e6 c9 05 00 fb 31 db <e8> a0 74 0b 00 4c 39 eb 7c 1d 41 83 f4 01 48 8b 05 80 cf a6 01 44
[    9.028644] RSP: 0018:ffff880479b83ce0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff02
[    9.037220] RAX: 0000000000000046 RBX: 0000000000000000 RCX: ffffffff82454f38
[    9.045297] RDX: 0000000000000000 RSI: 0000000000000096 RDI: ffffffff82b690cc
[    9.053374] RBP: ffff880479b83d58 R08: 0000000000000000 R09: 0000000000000000
[    9.061452] R10: 0000000000000019 R11: ffffffff82b6b10d R12: 0000000000000000
[    9.069530] R13: 0000000000000000 R14: 0000000000000046 R15: 0000000000000009
[    9.077609]  ? reschedule_interrupt+0xa/0x20
[    9.082477]  oops_end+0xbb/0xc0
[    9.086089]  no_context+0x1aa/0x3a0
[    9.090086]  page_fault+0x1e/0x30
[    9.093890] RIP: 0010:t10_pi_complete+0x77/0x1c0
[    9.099150] Code: 65 4c 8b 2c 25 80 4d 01 00 4c 89 2c 24 44 88 64 24 17 48 8b 44 24 08 45 31 db f6 40 12 01 74 04 4c 8b 58 78 44 0f b6 54 24 17 <41> 8b 53 08 45 8b 43 10 45 8b 4b 14 41 8b 7b 18 45 85 c0 0f 84 ee
[    9.120291] RSP: 0018:ffff880479b83e90 EFLAGS: 00010246
[    9.126222] RAX: ffff88047569fe00 RBX: 0000000000000000 RCX: 00000000fffffff7
[    9.134300] RDX: 0000000000000008 RSI: 0000000000000000 RDI: ffff88047569fe00
[    9.142379] RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000200
[    9.150456] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[    9.158534] R13: ffff8804785eee40 R14: ffff880272457080 R15: ffff880274c7a400
[    9.166614]  sd_done+0xf5/0x340
[    9.170223]  scsi_finish_command+0xc3/0x120
[    9.174999]  blk_done_softirq+0x83/0xb0
[    9.179386]  __do_softirq+0xa1/0x2e6
[    9.183481]  irq_exit+0xbc/0xd0
[    9.187081]  call_function_single_interrupt+0xf/0x20
[    9.192730]  </IRQ>
[    9.195172] RIP: 0010:cpuidle_enter_state+0xbc/0x330
[    9.200819] Code: 77 7e e8 57 e2 88 ff 49 89 c7 8b 05 46 52 c9 00 85 c0 7f 79 31 ff e8 f3 ec 88 ff 80 7c 24 0f 00 0f 85 fc 00 00 00 fb 45 85 ed <0f> 88 27 02 00 00 4c 2b 7c 24 10 48 ba cf f7 53 e3 a5 9b c4 20 4c
[    9.221960] RSP: 0018:ffffc90001a27e88 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff04
[    9.230545] RAX: ffff880479ba1200 RBX: ffffffff824adfe0 RCX: 000000000000001f
[    9.238622] RDX: 00000001fd27837e RSI: 00000000355559b4 RDI: 0000000000000000
[    9.246700] RBP: ffffe8ffffd979c0 R08: 0000000000000004 R09: 0000000000020a80
[    9.254777] R10: 00000000ffffffff R11: 0000000000000169 R12: ffff8804785eee40
[    9.262855] R13: 0000000000000002 R14: 0000000000000002 R15: 00000001fd27837e
[    9.270935]  ? cpuidle_enter_state+0xad/0x330
[    9.275905]  do_idle+0x1e1/0x240
[    9.279610]  cpu_startup_entry+0x19/0x20
[    9.284095]  start_secondary+0x196/0x1e0
[    9.288579]  secondary_startup_64+0xa4/0xb0

--------------CB830E2FF86FDCA8B6E7F1D5--
