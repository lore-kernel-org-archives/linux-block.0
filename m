Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464D0C433FE
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 18:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbhKWS41 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhKWS41 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 13:56:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6D2C061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 10:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TxopiawMk03HwZ9wz/IcrCBDMNhIQjhE6mC6XqErdSs=; b=KIlXTF/ik+S8egpFE5kYRCz5xx
        2B4/plJhd0uBjBT1BwkHvWVl37CzP/Wt6f2ReBL0HscuxvAZdO5t5mv+IJJC2ZYvSIzZ+aEEJMYrr
        Ropf/l299eSb+98PTHQ3NILJrbSpmoBPbjActp/C6RsVrK9peyhDV8L5ShZ9rVKg7+P+afY0OExwB
        V7LZ21k8BoxY8cUmUhl4wJZJSHLCxfOPtzjFY1/ZReN8TLsf9KpMuwfqzKRLyh3vk5e4JmlrgpexG
        NsR02T+7+TvE9JswATGCfS0mK4N14w7Lggxm/ghwQLuufVqYFWOGMv7Q4dZR7addZHa3Gx1IS4VrQ
        NiFt1FQQ==;
Received: from [2001:4bb8:191:f9ce:a710:1fc3:2b4:5435] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpauq-00FzRW-6c; Tue, 23 Nov 2021 18:53:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/8] block: remove elevator_exit
Date:   Tue, 23 Nov 2021 19:53:06 +0100
Message-Id: <20211123185312.1432157-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123185312.1432157-1-hch@lst.de>
References: <20211123185312.1432157-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Open code elevator_exit in it's only caller, and rename __elevator_exit to
elevator_exit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-sysfs.c |  2 +-
 block/blk.h       | 11 +----------
 block/elevator.c  |  4 +++-
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e1b846ec58cb8..cc6221c3f0d10 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -747,7 +747,7 @@ static void blk_exit_queue(struct request_queue *q)
 	 */
 	if (q->elevator) {
 		ioc_clear_queue(q);
-		__elevator_exit(q, q->elevator);
+		elevator_exit(q, q->elevator);
 	}
 
 	/*
diff --git a/block/blk.h b/block/blk.h
index 1346085d89cee..2266cb1f7df53 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -266,19 +266,10 @@ void blk_insert_flush(struct request *rq);
 
 int elevator_switch_mq(struct request_queue *q,
 			      struct elevator_type *new_e);
-void __elevator_exit(struct request_queue *, struct elevator_queue *);
+void elevator_exit(struct request_queue *, struct elevator_queue *);
 int elv_register_queue(struct request_queue *q, bool uevent);
 void elv_unregister_queue(struct request_queue *q);
 
-static inline void elevator_exit(struct request_queue *q,
-		struct elevator_queue *e)
-{
-	lockdep_assert_held(&q->sysfs_lock);
-
-	blk_mq_sched_free_rqs(q);
-	__elevator_exit(q, e);
-}
-
 ssize_t part_size_show(struct device *dev, struct device_attribute *attr,
 		char *buf);
 ssize_t part_stat_show(struct device *dev, struct device_attribute *attr,
diff --git a/block/elevator.c b/block/elevator.c
index 19a78d5516ba7..3536cdd5fa129 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -188,7 +188,7 @@ static void elevator_release(struct kobject *kobj)
 	kfree(e);
 }
 
-void __elevator_exit(struct request_queue *q, struct elevator_queue *e)
+void elevator_exit(struct request_queue *q, struct elevator_queue *e)
 {
 	mutex_lock(&e->sysfs_lock);
 	blk_mq_exit_sched(q, e);
@@ -595,6 +595,7 @@ int elevator_switch_mq(struct request_queue *q,
 			elv_unregister_queue(q);
 
 		ioc_clear_queue(q);
+		blk_mq_sched_free_rqs(q);
 		elevator_exit(q, q->elevator);
 	}
 
@@ -605,6 +606,7 @@ int elevator_switch_mq(struct request_queue *q,
 	if (new_e) {
 		ret = elv_register_queue(q, true);
 		if (ret) {
+			blk_mq_sched_free_rqs(q);
 			elevator_exit(q, q->elevator);
 			goto out;
 		}
-- 
2.30.2

