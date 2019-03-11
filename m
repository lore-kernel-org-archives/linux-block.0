Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE224C43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 20:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB582064A
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 20:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334765;
	bh=3m8bFCYDlXEGZyQhUNm1WjQz5c6P5Vdtsxvq+UlIGI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1h+73UTeOkMuM5B5aUUMXXvZ6cZfxMR5UmRwxHA72B1ns4jy3EbhthuvbT6aBblbS
	 Zp0WO1bjNFMYjXQ08OXk7Z/sXyupUyhkZZHVVt+Hg3Wrc0lE4E3TfMpI06gbOxLftt
	 lMXEgdWfN5hud/PYW4zKgZMjrwllyfQxDYen8290=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfCKT5z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:57:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729223AbfCKT5y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 15:57:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3D392084F;
        Mon, 11 Mar 2019 19:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334273;
        bh=3m8bFCYDlXEGZyQhUNm1WjQz5c6P5Vdtsxvq+UlIGI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jfI11nftL/HqiyhOBKZTMmsfiEJpYDqpcpZz/FXErXdLBN04bcOEfZnK59rYAxPeS
         R2mIGcYCKc6JCvVWYh4A1RA6wgdascJC8+IEju+Zyrb9eP74B76c79oiWJG6UZqUD4
         1B397ZTQaDyodDMD0SxOAIwkwX+1h/3N4wGADWsI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jianchao Wang <jianchao.w.wang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 29/44] blk-mq: insert rq with DONTPREP to hctx dispatch list when requeue
Date:   Mon, 11 Mar 2019 15:56:45 -0400
Message-Id: <20190311195700.138462-29-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195700.138462-1-sashal@kernel.org>
References: <20190311195700.138462-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jianchao Wang <jianchao.w.wang@oracle.com>

[ Upstream commit aef1897cd36dcf5e296f1d2bae7e0d268561b685 ]

When requeue, if RQF_DONTPREP, rq has contained some driver
specific data, so insert it to hctx dispatch list to avoid any
merge. Take scsi as example, here is the trace event log (no
io scheduler, because RQF_STARTED would prevent merging),

   kworker/0:1H-339   [000] ...1  2037.209289: block_rq_insert: 8,0 R 4096 () 32768 + 8 [kworker/0:1H]
scsi_inert_test-1987  [000] ....  2037.220465: block_bio_queue: 8,0 R 32776 + 8 [scsi_inert_test]
scsi_inert_test-1987  [000] ...2  2037.220466: block_bio_backmerge: 8,0 R 32776 + 8 [scsi_inert_test]
   kworker/0:1H-339   [000] ....  2047.220913: block_rq_issue: 8,0 R 8192 () 32768 + 16 [kworker/0:1H]
scsi_inert_test-1996  [000] ..s1  2047.221007: block_rq_complete: 8,0 R () 32768 + 8 [0]
scsi_inert_test-1996  [000] .Ns1  2047.221045: block_rq_requeue: 8,0 R () 32776 + 8 [0]
   kworker/0:1H-339   [000] ...1  2047.221054: block_rq_insert: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
   kworker/0:1H-339   [000] ...1  2047.221056: block_rq_issue: 8,0 R 4096 () 32776 + 8 [kworker/0:1H]
scsi_inert_test-1986  [000] ..s1  2047.221119: block_rq_complete: 8,0 R () 32776 + 8 [0]

(32768 + 8) was requeued by scsi_queue_insert and had RQF_DONTPREP.
Then it was merged with (32776 + 8) and issued. Due to RQF_DONTPREP,
the sdb only contained the part of (32768 + 8), then only that part
was completed. The lucky thing was that scsi_io_completion detected
it and requeued the remaining part. So we didn't get corrupted data.
However, the requeue of (32776 + 8) is not expected.

Suggested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 23a53b67cf0d..7d53f2314d7c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -701,12 +701,20 @@ static void blk_mq_requeue_work(struct work_struct *work)
 	spin_unlock_irq(&q->requeue_lock);
 
 	list_for_each_entry_safe(rq, next, &rq_list, queuelist) {
-		if (!(rq->rq_flags & RQF_SOFTBARRIER))
+		if (!(rq->rq_flags & (RQF_SOFTBARRIER | RQF_DONTPREP)))
 			continue;
 
 		rq->rq_flags &= ~RQF_SOFTBARRIER;
 		list_del_init(&rq->queuelist);
-		blk_mq_sched_insert_request(rq, true, false, false);
+		/*
+		 * If RQF_DONTPREP, rq has contained some driver specific
+		 * data, so insert it to hctx dispatch list to avoid any
+		 * merge.
+		 */
+		if (rq->rq_flags & RQF_DONTPREP)
+			blk_mq_request_bypass_insert(rq, false);
+		else
+			blk_mq_sched_insert_request(rq, true, false, false);
 	}
 
 	while (!list_empty(&rq_list)) {
-- 
2.19.1

