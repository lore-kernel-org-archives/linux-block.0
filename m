Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9F9C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6848320868
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6848320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeLADsX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:48:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeLADsW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 22:48:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6D6283F3D;
        Fri, 30 Nov 2018 16:38:29 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2886B1949B;
        Fri, 30 Nov 2018 16:38:25 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Guangwu Zhang <guazhang@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Subject: [PATCH] block: fix single range discard merge
Date:   Sat,  1 Dec 2018 00:38:18 +0800
Message-Id: <20181130163818.6540-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 30 Nov 2018 16:38:29 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are actually two kinds of discard merge:

- one is the normal discard merge, just like normal read/write request,
and call it single-range discard

- another is the multi-range discard, queue_max_discard_segments(rq->q) > 1

For the former case, queue_max_discard_segments(rq->q) is 1, and we
should handle this kind of discard merge like the normal read/write
request.

This patch fixes the following kernel panic issue[1], which is caused by
not removing the single-range discard request from elevator queue.

Guangwu has one raid discard test case, in which this issue is a bit
easier to trigger, and I verified that this patch can fix the kernel
panic issue in Guangwu's test case.

[1] kernel panic log from Jens's report

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000148
 PGD 0 P4D 0.
 Oops: 0000 [#1] SMP PTI
 CPU: 37 PID: 763 Comm: kworker/37:1H Not tainted \
4.20.0-rc3-00649-ge64d9a554a91-dirty #14  Hardware name: Wiwynn \
Leopard-Orv2/Leopard-DDR BW, BIOS LBM08   03/03/2017       Workqueue: kblockd \
blk_mq_run_work_fn                                            RIP: \
0010:blk_mq_get_driver_tag+0x81/0x120                                       Code: 24 \
10 48 89 7c 24 20 74 21 83 fa ff 0f 95 c0 48 8b 4c 24 28 65 48 33 0c 25 28 00 00 00 \
0f 85 96 00 00 00 48 83 c4 30 5b 5d c3 <48> 8b 87 48 01 00 00 8b 40 04 39 43 20 72 37 \
f6 87 b0 00 00 00 02  RSP: 0018:ffffc90004aabd30 EFLAGS: 00010246                     \
  RAX: 0000000000000003 RBX: ffff888465ea1300 RCX: ffffc90004aabde8
 RDX: 00000000ffffffff RSI: ffffc90004aabde8 RDI: 0000000000000000
 RBP: 0000000000000000 R08: ffff888465ea1348 R09: 0000000000000000
 R10: 0000000000001000 R11: 00000000ffffffff R12: ffff888465ea1300
 R13: 0000000000000000 R14: ffff888465ea1348 R15: ffff888465d10000
 FS:  0000000000000000(0000) GS:ffff88846f9c0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000148 CR3: 000000000220a003 CR4: 00000000003606e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  blk_mq_dispatch_rq_list+0xec/0x480
  ? elv_rb_del+0x11/0x30
  blk_mq_do_dispatch_sched+0x6e/0xf0
  blk_mq_sched_dispatch_requests+0xfa/0x170
  __blk_mq_run_hw_queue+0x5f/0xe0
  process_one_work+0x154/0x350
  worker_thread+0x46/0x3c0
  kthread+0xf5/0x130
  ? process_one_work+0x350/0x350
  ? kthread_destroy_worker+0x50/0x50
  ret_from_fork+0x1f/0x30
 Modules linked in: sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel \
kvm switchtec irqbypass iTCO_wdt iTCO_vendor_support efivars cdc_ether usbnet mii \
cdc_acm i2c_i801 lpc_ich mfd_core ipmi_si ipmi_devintf ipmi_msghandler acpi_cpufreq \
button sch_fq_codel nfsd nfs_acl lockd grace auth_rpcgss oid_registry sunrpc nvme \
nvme_core fuse sg loop efivarfs autofs4  CR2: 0000000000000148                        \

 ---[ end trace 340a1fb996df1b9b ]---
 RIP: 0010:blk_mq_get_driver_tag+0x81/0x120
 Code: 24 10 48 89 7c 24 20 74 21 83 fa ff 0f 95 c0 48 8b 4c 24 28 65 48 33 0c 25 28 \
00 00 00 0f 85 96 00 00 00 48 83 c4 30 5b 5d c3 <48> 8b 87 48 01 00 00 8b 40 04 39 43 \
20 72 37 f6 87 b0 00 00 00 02

Fixes: 445251d0f4d329a ("blk-mq: fix discard merge with scheduler attached")
Reported-by: Jens Axboe <axboe@kernel.dk>
Cc: Guangwu Zhang <guazhang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index e7696c47489a..7695034f4b87 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -820,7 +820,7 @@ static struct request *attempt_merge(struct request_queue *q,
 
 	req->__data_len += blk_rq_bytes(next);
 
-	if (req_op(req) != REQ_OP_DISCARD)
+	if (!blk_discard_mergable(req))
 		elv_merge_requests(q, req, next);
 
 	/*
-- 
2.9.5

