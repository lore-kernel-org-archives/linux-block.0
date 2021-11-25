Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5993C433EF
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 13:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355186AbhKYNmD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 08:42:03 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41360 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355123AbhKYNkB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 08:40:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2D19D1FD3C;
        Thu, 25 Nov 2021 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637847409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJC+I6441CyaNwmEv5MXgQPNM6NbVhZ0Rc4qTVwE4aw=;
        b=LqeSv9HC+RfvgAkEMdRsJ5UTtUdhBdqQ8TUDMn4+zYRYi3rNHmfJg8SCYnBB2THrtoOOb/
        12ujvmfqImvn6KS5NG7/hegGbZMPJY/8r4DclVE5hrJugXCkQT1P/bXnyOLNYklZ+jJKdz
        ue2B29cXjD5qdnRGHkVpWe7dFLJrtjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637847409;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJC+I6441CyaNwmEv5MXgQPNM6NbVhZ0Rc4qTVwE4aw=;
        b=CyQWnfZl54s7qj3s1BtCe1aYX5qeD7ChWC/K/T1TrZSmAmbMYsob7tT7DQR4pmXATMUPaM
        e7widr3iu1s3WVBw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 1D553A3B8D;
        Thu, 25 Nov 2021 13:36:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E3B7B1E0BD3; Thu, 25 Nov 2021 14:36:45 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/8] block: Provide blk_mq_sched_get_icq()
Date:   Thu, 25 Nov 2021 14:36:34 +0100
Message-Id: <20211125133645.27483-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211125133131.14018-1-jack@suse.cz>
References: <20211125133131.14018-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2286; h=from:subject; bh=CyorICWMZ55H6dqfkHqRSC8ZUzyfheG60RAO3agFGPc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhn5Fi5NUt8jSjiPHIbir7sDJXAgr+vm+RpPZXD8wM Zayd+J+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYZ+RYgAKCRCcnaoHP2RA2TNXCA DqIhU2VGSh+XL8qyCB79ybzreoaFSM3pi1K3DsVCYGBNRdsLQwe0SrPGoMuC/s0fwsSLNVyFJpYEi2 NFSXJ3JkSD823UtMfbmmCzvVst4DcP4A4s7/+Dm463qMpVFLnH950FW5ehF73TPlsraqH/O1L/OYYF Bjg7qhfwyoyjtAeiGpno3mO+gMoK5Dkn1MMxRgezocUmlntd6MUUA+y8gQoX8PO2OFsBVBG6a3xxM6 trDH88FZeJTz72oZKa/isIehAcVfphM6iwetBueH7VuV/qaE4Wkzp+AtP1iwQ0rjqWHhse64UZgEtE DK7pCpGroEkdVIuHNjSMg55RyeYDo7
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently we lookup ICQ only after the request is allocated. However BFQ
will want to decide how many scheduler tags it allows a given bfq queue
(effectively a process) to consume based on cgroup weight. So provide a
function blk_mq_sched_get_icq() so that BFQ can lookup ICQ earlier.

Acked-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-mq-sched.c | 26 +++++++++++++++-----------
 block/blk-mq-sched.h |  1 +
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index b942b38000e5..98c6a97729f2 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -18,9 +18,8 @@
 #include "blk-mq-tag.h"
 #include "blk-wbt.h"
 
-void blk_mq_sched_assign_ioc(struct request *rq)
+struct io_cq *blk_mq_sched_get_icq(struct request_queue *q)
 {
-	struct request_queue *q = rq->q;
 	struct io_context *ioc;
 	struct io_cq *icq;
 
@@ -28,22 +27,27 @@ void blk_mq_sched_assign_ioc(struct request *rq)
 	if (unlikely(!current->io_context))
 		create_task_io_context(current, GFP_ATOMIC, q->node);
 
-	/*
-	 * May not have an IO context if it's a passthrough request
-	 */
+	/* May not have an IO context if context creation failed */
 	ioc = current->io_context;
 	if (!ioc)
-		return;
+		return NULL;
 
 	spin_lock_irq(&q->queue_lock);
 	icq = ioc_lookup_icq(ioc, q);
 	spin_unlock_irq(&q->queue_lock);
+	if (icq)
+		return icq;
+	return ioc_create_icq(ioc, q, GFP_ATOMIC);
+}
+EXPORT_SYMBOL(blk_mq_sched_get_icq);
 
-	if (!icq) {
-		icq = ioc_create_icq(ioc, q, GFP_ATOMIC);
-		if (!icq)
-			return;
-	}
+void blk_mq_sched_assign_ioc(struct request *rq)
+{
+	struct io_cq *icq;
+
+	icq = blk_mq_sched_get_icq(rq->q);
+	if (!icq)
+		return;
 	get_io_context(icq->ioc);
 	rq->elv.icq = icq;
 }
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 25d1034952b6..add651ec06da 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -8,6 +8,7 @@
 
 #define MAX_SCHED_RQ (16 * BLKDEV_DEFAULT_RQ)
 
+struct io_cq *blk_mq_sched_get_icq(struct request_queue *q);
 void blk_mq_sched_assign_ioc(struct request *rq);
 
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
-- 
2.26.2

