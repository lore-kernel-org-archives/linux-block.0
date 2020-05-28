Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D816FC433DF
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 19:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B619D208A7
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 19:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590693085;
	bh=388jovjOXCiQP4qLNBBSVu6nGhIP80psiUikZcHSvNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZI/Dnd853k0rW8rojWFzm9HAtw6AI8Im5VFMvL6aEFi/F+1POzCqtMvmzkTDf/YEu
	 O2Kh0wwVh+5d8wmaoY7EqzZPIt2ncLEw9gfsP7Iwag8OFUEvjyPYUDoUmslB2oNJRp
	 ML0bXhN3wrBfT1t6fvFnangCuSSFodSgYM51CSKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406122AbgE1TLY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 15:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406096AbgE1TLW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 15:11:22 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1CE2207BC;
        Thu, 28 May 2020 19:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590693081;
        bh=388jovjOXCiQP4qLNBBSVu6nGhIP80psiUikZcHSvNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Df0fmXMqqAVQjFPkBLiQ9itUvC5d2zZr+zU8G0NiGagZVb7zx4t9w5QZEzD+++6Ct
         YEwNQt0OQWv8vAAg6SAuPuF/IBY07Jv6XPXyIJDvxke9JQmyZgFeHpeJrtR+CXFZUC
         CUrqHcuUQQ8dg/9Rwy+85Hsg5xORMbHH3m/laQrk=
Date:   Thu, 28 May 2020 12:11:18 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Alan Adamson <alan.adamson@oracle.com>
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCHv3 2/2] nvme: cancel requests for real
Message-ID: <20200528191118.GB3504306@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200528153441.3501777-1-kbusch@kernel.org>
 <20200528153441.3501777-2-kbusch@kernel.org>
 <68629453-d776-59e5-cdc9-8681eb2bab37@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68629453-d776-59e5-cdc9-8681eb2bab37@oracle.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 28, 2020 at 11:39:10AM -0700, Alan Adamson wrote:
> Still seeing a hang.
 
Is it really stuck or are you just not waiting long enough?

The default timeout is 30 seconds, and we wait that long once after
submission, and again after abort for a total of 60 seconds.

But then there's also the retry logic, which by default will retry a
non-permanenet error 5 times (a cancelled request normally qualifies for
retries).

An top of all that, you have to add the time it takes to initialize your
controller. Your controller appears to init quite fast, so that part is
probably negligable for you.

You can expect your fake timeout with 100% probablility to take 150
seconds minimum to return a retryable request. Your "stuck" task has
only been waiting 122 seconds.
 
> [  182.883552] nvme nvme0: I/O 960 QID 26 timeout, aborting
> [  182.883608] nvme nvme0: Abort status: 0x0
> [  213.088659] nvme nvme0: I/O 960 QID 26 timeout, reset controller
> [  213.109414] nvme nvme0: Shutdown timeout set to 10 seconds
> [  213.112785] nvme nvme0: 56/0/0 default/read/poll queues
> [  213.112880] FAULT_INJECTION: forcing a failure.
>                name fail_io_timeout, interval 1, probability 100, space 0,
> times 998
> [  213.112882] CPU: 53 PID: 0 Comm: swapper/53 Not tainted 5.7.0-rc7+ #2
> [  213.112883] Hardware name: Oracle Corporation ORACLE SERVER
> X6-2/ASM,MOTHERBOARD,1U, BIOS 38050100 08/30/2016
> [  213.112883] Call Trace:
> [  213.112884]  <IRQ>
> [  213.112887]  dump_stack+0x6d/0x9a
> [  213.112888]  should_fail.cold.5+0x32/0x42
> [  213.112889]  blk_should_fake_timeout+0x26/0x30
> [  213.112890]  blk_mq_complete_request+0x15/0x30
> [  213.112893]  nvme_irq+0xd9/0x1f0 [nvme]
> [  213.112896]  __handle_irq_event_percpu+0x44/0x190
> [  213.112897]  handle_irq_event_percpu+0x32/0x80
> [  213.112898]  handle_irq_event+0x3b/0x5a
> [  213.112900]  handle_edge_irq+0x87/0x190
> [  213.112901]  do_IRQ+0x54/0xe0
> [  213.112903]  common_interrupt+0xf/0xf
> [  213.112903]  </IRQ>
> [  213.112905] RIP: 0010:cpuidle_enter_state+0xc1/0x400
> [  213.112906] Code: ff e8 e3 41 93 ff 80 7d c7 00 74 17 9c 58 0f 1f 44 00
> 00 f6 c4 02 0f 85 d2 02 00 00 31 ff e8 16 c3 99 ff fb 66 0f 1f 44 00 00 <45>
> 85 e4 0f 88 3d 02 00 00 49 63 c4 48 8d 14 40 48 8d 0c c5 00 00
> [  213.112907] RSP: 0018:ffffae4ecc6cbe40 EFLAGS: 00000246 ORIG_RAX:
> ffffffffffffffdd
> [  213.112908] RAX: ffff9b537fc6cc40 RBX: ffffce4ebfc43200 RCX:
> 000000000000001f
> [  213.112909] RDX: 000000319e847448 RSI: 0000000031573862 RDI:
> 0000000000000000
> [  213.112909] RBP: ffffae4ecc6cbe80 R08: 0000000000000002 R09:
> 000000000002c4c0
> [  213.112910] R10: 011c655cc6d029f4 R11: ffff9b537fc6bb44 R12:
> 0000000000000002
> [  213.112911] R13: ffffffffa374c120 R14: ffffffffa374c208 R15:
> ffffffffa374c1f0
> [  213.112913]  cpuidle_enter+0x2e/0x40
> [  213.112915]  call_cpuidle+0x23/0x40
> [  213.112916]  do_idle+0x230/0x270
> [  213.112917]  cpu_startup_entry+0x1d/0x20
> [  213.112919]  start_secondary+0x170/0x1c0
> [  213.112920]  secondary_startup_64+0xb6/0xc0
> [  243.293996] nvme nvme0: I/O 960 QID 26 timeout, aborting
> [  243.294050] nvme nvme0: Abort status: 0x0
> [  273.498939] nvme nvme0: I/O 960 QID 26 timeout, reset controller
> [  273.509832] nvme nvme0: new error during reset
> [  273.519648] nvme nvme0: Shutdown timeout set to 10 seconds
> [  273.523310] nvme nvme0: 56/0/0 default/read/poll queues
> [  273.523397] FAULT_INJECTION: forcing a failure.
>                name fail_io_timeout, interval 1, probability 100, space 0,
> times 997
> [  273.523399] CPU: 53 PID: 0 Comm: swapper/53 Not tainted 5.7.0-rc7+ #2
> [  273.523400] Hardware name: Oracle Corporation ORACLE SERVER
> X6-2/ASM,MOTHERBOARD,1U, BIOS 38050100 08/30/2016
> [  273.523400] Call Trace:
> [  273.523401]  <IRQ>
> [  273.523404]  dump_stack+0x6d/0x9a
> [  273.523405]  should_fail.cold.5+0x32/0x42
> [  273.523406]  blk_should_fake_timeout+0x26/0x30
> [  273.523407]  blk_mq_complete_request+0x15/0x30
> [  273.523410]  nvme_irq+0xd9/0x1f0 [nvme]
> [  273.523412]  __handle_irq_event_percpu+0x44/0x190
> [  273.523413]  handle_irq_event_percpu+0x32/0x80
> [  273.523415]  handle_irq_event+0x3b/0x5a
> [  273.523416]  handle_edge_irq+0x87/0x190
> [  273.523417]  do_IRQ+0x54/0xe0
> [  273.523419]  common_interrupt+0xf/0xf
> [  273.523420]  </IRQ>
> [  273.523422] RIP: 0010:cpuidle_enter_state+0xc1/0x400
> [  273.523423] Code: ff e8 e3 41 93 ff 80 7d c7 00 74 17 9c 58 0f 1f 44 00
> 00 f6 c4 02 0f 85 d2 02 00 00 31 ff e8 16 c3 99 ff fb 66 0f 1f 44 00 00 <45>
> 85 e4 0f 88 3d 02 00 00 49 63 c4 48 8d 14 40 48 8d 0c c5 00 00
> [  273.523424] RSP: 0018:ffffae4ecc6cbe40 EFLAGS: 00000246 ORIG_RAX:
> ffffffffffffffdd
> [  273.523425] RAX: ffff9b537fc6cc40 RBX: ffffce4ebfc43200 RCX:
> 000000000000001f
> [  273.523425] RDX: 0000003faf43ca28 RSI: 0000000031573862 RDI:
> 0000000000000000
> [  273.523426] RBP: ffffae4ecc6cbe80 R08: 0000000000000002 R09:
> 000000000002c4c0
> [  273.523426] R10: 011c658143e5b34c R11: ffff9b537fc6bb44 R12:
> 0000000000000002
> [  273.523427] R13: ffffffffa374c120 R14: ffffffffa374c208 R15:
> ffffffffa374c1f0
> [  273.523429]  cpuidle_enter+0x2e/0x40
> [  273.523431]  call_cpuidle+0x23/0x40
> [  273.523432]  do_idle+0x230/0x270
> [  273.523433]  cpu_startup_entry+0x1d/0x20
> [  273.523435]  start_secondary+0x170/0x1c0
> [  273.523436]  secondary_startup_64+0xb6/0xc0
> [  303.704204] nvme nvme0: I/O 960 QID 26 timeout, aborting
> [  303.704245] nvme nvme0: Abort status: 0x0
> [  333.909140] nvme nvme0: I/O 960 QID 26 timeout, reset controller
> [  333.928010] nvme nvme0: new error during reset
> [  333.934087] nvme nvme0: Shutdown timeout set to 10 seconds
> [  333.937470] nvme nvme0: 56/0/0 default/read/poll queues
> [  333.937571] FAULT_INJECTION: forcing a failure.
>                name fail_io_timeout, interval 1, probability 100, space 0,
> times 996
> [  333.937588] CPU: 53 PID: 0 Comm: swapper/53 Not tainted 5.7.0-rc7+ #2
> [  333.937588] Hardware name: Oracle Corporation ORACLE SERVER
> X6-2/ASM,MOTHERBOARD,1U, BIOS 38050100 08/30/2016
> [  333.937589] Call Trace:
> [  333.937590]  <IRQ>
> [  333.937592]  dump_stack+0x6d/0x9a
> [  333.937593]  should_fail.cold.5+0x32/0x42
> [  333.937594]  blk_should_fake_timeout+0x26/0x30
> [  333.937595]  blk_mq_complete_request+0x15/0x30
> [  333.937598]  nvme_irq+0xd9/0x1f0 [nvme]
> [  333.937600]  __handle_irq_event_percpu+0x44/0x190
> [  333.937602]  handle_irq_event_percpu+0x32/0x80
> [  333.937603]  handle_irq_event+0x3b/0x5a
> [  333.937604]  handle_edge_irq+0x87/0x190
> [  333.937606]  do_IRQ+0x54/0xe0
> [  333.937607]  common_interrupt+0xf/0xf
> [  333.937608]  </IRQ>
> [  333.937610] RIP: 0010:cpuidle_enter_state+0xc1/0x400
> [  333.937611] Code: ff e8 e3 41 93 ff 80 7d c7 00 74 17 9c 58 0f 1f 44 00
> 00 f6 c4 02 0f 85 d2 02 00 00 31 ff e8 16 c3 99 ff fb 66 0f 1f 44 00 00 <45>
> 85 e4 0f 88 3d 02 00 00 49 63 c4 48 8d 14 40 48 8d 0c c5 00 00
> [  333.937612] RSP: 0018:ffffae4ecc6cbe40 EFLAGS: 00000246 ORIG_RAX:
> ffffffffffffffdd
> [  333.937613] RAX: ffff9b537fc6cc40 RBX: ffffce4ebfc43200 RCX:
> 000000000000001f
> [  333.937613] RDX: 0000004dc03adbda RSI: 0000000031573862 RDI:
> 0000000000000000
> [  333.937614] RBP: ffffae4ecc6cbe80 R08: 0000000000000002 R09:
> 000000000002c4c0
> [  333.937615] R10: 011c65a5c18bd252 R11: ffff9b537fc6bb44 R12:
> 0000000000000002
> [  333.937615] R13: ffffffffa374c120 R14: ffffffffa374c208 R15:
> ffffffffa374c1f0
> [  333.937617]  cpuidle_enter+0x2e/0x40
> [  333.937619]  call_cpuidle+0x23/0x40
> [  333.937620]  do_idle+0x230/0x270
> [  333.937621]  cpu_startup_entry+0x1d/0x20
> [  333.937623]  start_secondary+0x170/0x1c0
> [  333.937624]  secondary_startup_64+0xb6/0xc0
> [  364.114200] nvme nvme0: I/O 960 QID 26 timeout, aborting
> [  364.114241] nvme nvme0: Abort status: 0x0
> [  369.745713] INFO: task kworker/u114:2:1182 blocked for more than 122
> seconds.
> [  369.745758]       Not tainted 5.7.0-rc7+ #2
> [  369.745787] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> [  369.745808] kworker/u114:2  D    0  1182      2 0x80004000
> [  369.745817] Workqueue: nvme-wq nvme_scan_work [nvme_core]
> [  369.745818] Call Trace:
> [  369.745823]  __schedule+0x2dc/0x710
> [  369.745828]  ? __kfifo_to_user_r+0x90/0x90
> [  369.745829]  schedule+0x44/0xb0
> [  369.745831]  blk_mq_freeze_queue_wait+0x4b/0xb0
> [  369.745833]  ? finish_wait+0x80/0x80
> [  369.745834]  blk_mq_freeze_queue+0x1a/0x20
> [  369.745837]  nvme_update_disk_info+0x62/0x3b0 [nvme_core]
> [  369.745839]  __nvme_revalidate_disk+0x8d/0x140 [nvme_core]
> [  369.745842]  nvme_revalidate_disk+0xa4/0x140 [nvme_core]
> [  369.745843]  ? blk_mq_run_hw_queue+0xba/0x100
> [  369.745847]  revalidate_disk+0x2b/0xa0
> [  369.745850]  nvme_validate_ns+0x46/0x5b0 [nvme_core]
> [  369.745852]  ? __nvme_submit_sync_cmd+0xe0/0x1b0 [nvme_core]
> [  369.745855]  nvme_scan_work+0x25a/0x310 [nvme_core]
> [  369.745859]  process_one_work+0x1ab/0x380
> [  369.745861]  worker_thread+0x37/0x3b0
> [  369.745862]  kthread+0x120/0x140
> [  369.745863]  ? create_worker+0x1b0/0x1b0
> [  369.745864]  ? kthread_park+0x90/0x90
> [  369.745867]  ret_from_fork+0x35/0x40
