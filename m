Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02137C433EF
	for <linux-block@archiver.kernel.org>; Fri, 18 Mar 2022 13:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbiCRND7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Mar 2022 09:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbiCRND5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Mar 2022 09:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACBC42DCBC4
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 06:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647608557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=li8ebHlVxVGlGPWtEM0x2PNlp7fHo8gSIvITwDuvHaw=;
        b=NvXFJwJqnPn7+Euw+w50JjLOGV3mwmd8l/W7ZlJ62qirTH1zKAk5JYfAF+sXA8Q/fS1xuw
        jTAIPWMgM7M/jywXd64KTUQ58bEod4FWDfQDqcZLu2aqneWiaUPkxvmOlJv2kx10Z7u/sE
        ceGeZo/sWCpTqZWdswsYP8zSJk76t9M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-axSZuNDfNlWxfiwnWZVpeg-1; Fri, 18 Mar 2022 09:02:34 -0400
X-MC-Unique: axSZuNDfNlWxfiwnWZVpeg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4716185A794;
        Fri, 18 Mar 2022 13:02:33 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B68B2156897;
        Fri, 18 Mar 2022 13:02:24 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Yu Kuai <yukuai3@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/3] block: cancel all throttled bios in del_gendisk()
Date:   Fri, 18 Mar 2022 21:01:44 +0800
Message-Id: <20220318130144.1066064-4-ming.lei@redhat.com>
In-Reply-To: <20220318130144.1066064-1-ming.lei@redhat.com>
References: <20220318130144.1066064-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Throttled bios can't be issued after del_gendisk() is done, thus
it's better to cancel them immediately rather than waiting for
throttle is done.

For example, if user thread is throttled with low bps while it's
issuing large io, and the device is deleted. The user thread will
wait for a long time for io to return.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-throttle.c | 36 +++++++++++++++++++++++++++++++++++-
 block/blk-throttle.h |  3 +++
 block/genhd.c        |  3 +++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 880701d0106f..469c483719be 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -874,7 +874,8 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 	       bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
 
 	/* If tg->bps = -1, then BW is unlimited */
-	if (bps_limit == U64_MAX && iops_limit == UINT_MAX) {
+	if ((bps_limit == U64_MAX && iops_limit == UINT_MAX) ||
+	    tg->flags & THROTL_TG_CANCELING) {
 		if (wait)
 			*wait = 0;
 		return true;
@@ -1776,6 +1777,39 @@ static bool throtl_hierarchy_can_upgrade(struct throtl_grp *tg)
 	return false;
 }
 
+void blk_throtl_cancel_bios(struct request_queue *q)
+{
+	struct cgroup_subsys_state *pos_css;
+	struct blkcg_gq *blkg;
+
+	spin_lock_irq(&q->queue_lock);
+	/*
+	 * queue_lock is held, rcu lock is not needed here technically.
+	 * However, rcu lock is still held to emphasize that following
+	 * path need RCU protection and to prevent warning from lockdep.
+	 */
+	rcu_read_lock();
+	blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg) {
+		struct throtl_grp *tg = blkg_to_tg(blkg);
+		struct throtl_service_queue *sq = &tg->service_queue;
+
+		/*
+		 * Set the flag to make sure throtl_pending_timer_fn() won't
+		 * stop until all throttled bios are dispatched.
+		 */
+		blkg_to_tg(blkg)->flags |= THROTL_TG_CANCELING;
+		/*
+		 * Update disptime after setting the above flag to make sure
+		 * throtl_select_dispatch() won't exit without dispatching.
+		 */
+		tg_update_disptime(tg);
+
+		throtl_schedule_pending_timer(sq, jiffies + 1);
+	}
+	rcu_read_unlock();
+	spin_unlock_irq(&q->queue_lock);
+}
+
 static bool throtl_can_upgrade(struct throtl_data *td,
 	struct throtl_grp *this_tg)
 {
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index b23a9f3abb82..c1b602996127 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -56,6 +56,7 @@ enum tg_state_flags {
 	THROTL_TG_PENDING	= 1 << 0,	/* on parent's pending tree */
 	THROTL_TG_WAS_EMPTY	= 1 << 1,	/* bio_lists[] became non-empty */
 	THROTL_TG_HAS_IOPS_LIMIT = 1 << 2,	/* tg has iops limit */
+	THROTL_TG_CANCELING	= 1 << 3,	/* starts to cancel bio */
 };
 
 enum {
@@ -162,11 +163,13 @@ static inline int blk_throtl_init(struct request_queue *q) { return 0; }
 static inline void blk_throtl_exit(struct request_queue *q) { }
 static inline void blk_throtl_register_queue(struct request_queue *q) { }
 static inline bool blk_throtl_bio(struct bio *bio) { return false; }
+static inline void blk_throtl_cancel_bios(struct request_queue *q) { }
 #else /* CONFIG_BLK_DEV_THROTTLING */
 int blk_throtl_init(struct request_queue *q);
 void blk_throtl_exit(struct request_queue *q);
 void blk_throtl_register_queue(struct request_queue *q);
 bool __blk_throtl_bio(struct bio *bio);
+void blk_throtl_cancel_bios(struct request_queue *q);
 static inline bool blk_throtl_bio(struct bio *bio)
 {
 	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
diff --git a/block/genhd.c b/block/genhd.c
index 56f66c6fee94..8244f09e058d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -25,6 +25,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/badblocks.h>
 #include <linux/part_stat.h>
+#include "blk-throttle.h"
 
 #include "blk.h"
 #include "blk-mq-sched.h"
@@ -627,6 +628,8 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_mq_freeze_queue_wait(q);
 
+	blk_throtl_cancel_bios(disk->queue);
+
 	blk_sync_queue(q);
 	blk_flush_integrity();
 	/*
-- 
2.31.1

