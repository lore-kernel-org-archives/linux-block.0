Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3539C4332F
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 18:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbhKWS42 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhKWS42 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 13:56:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECF3C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 10:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=AV0Yxs3G364zkbmnFtC8iJByb9KKDmxqOfoFvu9Rctw=; b=n/nwet1OT3MUQCYAU+Wph9fjWz
        Q5+Zf5N4zDXrTb8VJlibmSpPkzOdK8xU/d42ndoBtxs4YzAZBx8EqtnVfib16eWENoNfF5JLNG7RC
        wGsytbRaG3Fvid71mMB+DrE/xeb2B0qjPEclwfHLVveh9zR4Xuncs1jkii3QuCHFuys5hYl63yUZZ
        JO+51oLFIevmvnt81vtibk5x/rbgIXbgcOgq1weqF6lex0FngJyA+VCn/XNc+J4LCooCiQwtBPp5i
        CjprFeoxvR25TJr9hdf0Go4ayysvaaZ0vTXW26ybwYmbMFK1p0TO4pFvbo8al4N5y9Yi6J1vHX+RB
        ooJgzqbA==;
Received: from [2001:4bb8:191:f9ce:a710:1fc3:2b4:5435] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpaur-00FzRs-Pw; Tue, 23 Nov 2021 18:53:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/8] block: remove the e argument to elevator_exit
Date:   Tue, 23 Nov 2021 19:53:07 +0100
Message-Id: <20211123185312.1432157-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123185312.1432157-1-hch@lst.de>
References: <20211123185312.1432157-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All callers pass q->elevator.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c | 2 +-
 block/blk.h       | 2 +-
 block/elevator.c  | 8 +++++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index cc6221c3f0d10..87ce3b1414c81 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -747,7 +747,7 @@ static void blk_exit_queue(struct request_queue *q)
 	 */
 	if (q->elevator) {
 		ioc_clear_queue(q);
-		elevator_exit(q, q->elevator);
+		elevator_exit(q);
 	}
 
 	/*
diff --git a/block/blk.h b/block/blk.h
index 2266cb1f7df53..4df2ce8d4999b 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -266,7 +266,7 @@ void blk_insert_flush(struct request *rq);
 
 int elevator_switch_mq(struct request_queue *q,
 			      struct elevator_type *new_e);
-void elevator_exit(struct request_queue *, struct elevator_queue *);
+void elevator_exit(struct request_queue *q);
 int elv_register_queue(struct request_queue *q, bool uevent);
 void elv_unregister_queue(struct request_queue *q);
 
diff --git a/block/elevator.c b/block/elevator.c
index 3536cdd5fa129..ec98aed39c4f5 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -188,8 +188,10 @@ static void elevator_release(struct kobject *kobj)
 	kfree(e);
 }
 
-void elevator_exit(struct request_queue *q, struct elevator_queue *e)
+void elevator_exit(struct request_queue *q)
 {
+	struct elevator_queue *e = q->elevator;
+
 	mutex_lock(&e->sysfs_lock);
 	blk_mq_exit_sched(q, e);
 	mutex_unlock(&e->sysfs_lock);
@@ -596,7 +598,7 @@ int elevator_switch_mq(struct request_queue *q,
 
 		ioc_clear_queue(q);
 		blk_mq_sched_free_rqs(q);
-		elevator_exit(q, q->elevator);
+		elevator_exit(q);
 	}
 
 	ret = blk_mq_init_sched(q, new_e);
@@ -607,7 +609,7 @@ int elevator_switch_mq(struct request_queue *q,
 		ret = elv_register_queue(q, true);
 		if (ret) {
 			blk_mq_sched_free_rqs(q);
-			elevator_exit(q, q->elevator);
+			elevator_exit(q);
 			goto out;
 		}
 	}
-- 
2.30.2

