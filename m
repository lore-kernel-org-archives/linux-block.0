Return-Path: <SRS0=0oGL=ZE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DC6C43331
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 07:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216D4206A3
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 07:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfKLHWM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:22:12 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:53909 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfKLHWM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Nov 2019 02:22:12 -0500
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id xAC7LxeW025742
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 12 Nov 2019 16:21:59 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id xAC7LxBi016909;
        Tue, 12 Nov 2019 16:21:59 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id xAC7Lw6N014521;
        Tue, 12 Nov 2019 16:21:59 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.138] [10.38.151.138]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-10285490; Tue, 12 Nov 2019 16:19:59 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC10GP.gisp.nec.co.jp ([10.38.151.138]) with mapi id 14.03.0439.000; Tue,
 12 Nov 2019 16:19:58 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "Christoph Hellwig" <hch@lst.de>
Subject: [PATCH] block: check bi_size overflow before merge
Thread-Topic: [PATCH] block: check bi_size overflow before merge
Thread-Index: AQHVmSmWA0ngVR4YPkytxCjMfxSMwA==
Date:   Tue, 12 Nov 2019 07:19:58 +0000
Message-ID: <20191112071957.GA10061@jeru.linux.bs1.fc.nec.co.jp>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <2C78F9E1C952E343A3FAE404DC74C128@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__bio_try_merge_page() may merge a page to bio without bio_full() check
and cause bi_size overflow.

The overflow typically ends up with sd_init_command() warning on zero
segment request with call trace like this:

    ------------[ cut here ]------------
    WARNING: CPU: 2 PID: 1986 at drivers/scsi/scsi_lib.c:1025 scsi_init_io+0x156/0x180
    CPU: 2 PID: 1986 Comm: kworker/2:1H Kdump: loaded Not tainted 5.4.0-rc7 #1
    Workqueue: kblockd blk_mq_run_work_fn
    RIP: 0010:scsi_init_io+0x156/0x180
    RSP: 0018:ffffa11487663bf0 EFLAGS: 00010246
    RAX: 00000000002be0a0 RBX: ffff8e6e9ff30118 RCX: 0000000000000000
    RDX: 00000000ffffffe1 RSI: 0000000000000000 RDI: ffff8e6e9ff30118
    RBP: ffffa11487663c18 R08: ffffa11487663d28 R09: ffff8e6e9ff30150
    R10: 0000000000000001 R11: 0000000000000000 R12: ffff8e6e9ff30000
    R13: 0000000000000001 R14: ffff8e74a1cf1800 R15: ffff8e6e9ff30000
    FS:  0000000000000000(0000) GS:ffff8e6ea7680000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 00007fff18cf0fe8 CR3: 0000000659f0a001 CR4: 00000000001606e0
    Call Trace:
     sd_init_command+0x326/0xb40 [sd_mod]
     scsi_queue_rq+0x502/0xaa0
     ? blk_mq_get_driver_tag+0xe7/0x120
     blk_mq_dispatch_rq_list+0x256/0x5a0
     ? elv_rb_del+0x24/0x30
     ? deadline_remove_request+0x7b/0xc0
     blk_mq_do_dispatch_sched+0xa3/0x140
     blk_mq_sched_dispatch_requests+0xfb/0x170
     __blk_mq_run_hw_queue+0x81/0x130
     blk_mq_run_work_fn+0x1b/0x20
     process_one_work+0x179/0x390
     worker_thread+0x4f/0x3e0
     kthread+0x105/0x140
     ? max_active_store+0x80/0x80
     ? kthread_bind+0x20/0x20
     ret_from_fork+0x35/0x40
    ---[ end trace f9036abf5af4a4d3 ]---
    blk_update_request: I/O error, dev sdd, sector 2875552 op 0x1:(WRITE) flags 0x0 phys_seg 0 prio class 0
    XFS (sdd1): writeback error on sector 2875552

__bio_try_merge_page() should check the overflow before actually doing
merge.

Fixes: 07173c3ec276c ("block: enable multipage bvecs")
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>

diff --git a/block/bio.c b/block/bio.c
--- a/block/bio.c
+++ b/block/bio.c
@@ -751,7 +751,7 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return false;
 
-	if (bio->bi_vcnt > 0) {
+	if (bio->bi_vcnt > 0 && !bio_full(bio, len)) {
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 
 		if (page_is_mergeable(bv, page, len, off, same_page)) {
