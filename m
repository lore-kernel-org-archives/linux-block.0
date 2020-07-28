Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE97BC433E0
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 16:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9045C2074F
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 16:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbgG1QUj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:20:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:48730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730679AbgG1QUj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 12:20:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 78388B5CC;
        Tue, 28 Jul 2020 16:20:48 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v1] block: Remove callback typedefs for blk_mq_ops
Date:   Tue, 28 Jul 2020 18:20:36 +0200
Message-Id: <20200728162036.118211-1-dwagner@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No need to define typedefs for the callbacks, because there is not a
single user except blk_mq_ops.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

v1: updated indentation

 include/linux/blk-mq.h | 50 ++++++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 23230c1d031e..9d2d5ad367a4 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -267,27 +267,9 @@ struct blk_mq_queue_data {
 	bool last;
 };
 
-typedef blk_status_t (queue_rq_fn)(struct blk_mq_hw_ctx *,
-		const struct blk_mq_queue_data *);
-typedef void (commit_rqs_fn)(struct blk_mq_hw_ctx *);
-typedef bool (get_budget_fn)(struct request_queue *);
-typedef void (put_budget_fn)(struct request_queue *);
-typedef enum blk_eh_timer_return (timeout_fn)(struct request *, bool);
-typedef int (init_hctx_fn)(struct blk_mq_hw_ctx *, void *, unsigned int);
-typedef void (exit_hctx_fn)(struct blk_mq_hw_ctx *, unsigned int);
-typedef int (init_request_fn)(struct blk_mq_tag_set *set, struct request *,
-		unsigned int, unsigned int);
-typedef void (exit_request_fn)(struct blk_mq_tag_set *set, struct request *,
-		unsigned int);
-
 typedef bool (busy_iter_fn)(struct blk_mq_hw_ctx *, struct request *, void *,
 		bool);
 typedef bool (busy_tag_iter_fn)(struct request *, void *, bool);
-typedef int (poll_fn)(struct blk_mq_hw_ctx *);
-typedef int (map_queues_fn)(struct blk_mq_tag_set *set);
-typedef bool (busy_fn)(struct request_queue *);
-typedef void (complete_fn)(struct request *);
-typedef void (cleanup_rq_fn)(struct request *);
 
 /**
  * struct blk_mq_ops - Callback functions that implements block driver
@@ -297,7 +279,8 @@ struct blk_mq_ops {
 	/**
 	 * @queue_rq: Queue a new request from block IO.
 	 */
-	queue_rq_fn		*queue_rq;
+	blk_status_t (*queue_rq)(struct blk_mq_hw_ctx *,
+				 const struct blk_mq_queue_data *);
 
 	/**
 	 * @commit_rqs: If a driver uses bd->last to judge when to submit
@@ -306,7 +289,7 @@ struct blk_mq_ops {
 	 * purpose of kicking the hardware (which the last request otherwise
 	 * would have done).
 	 */
-	commit_rqs_fn		*commit_rqs;
+	void (*commit_rqs)(struct blk_mq_hw_ctx *);
 
 	/**
 	 * @get_budget: Reserve budget before queue request, once .queue_rq is
@@ -314,37 +297,38 @@ struct blk_mq_ops {
 	 * reserved budget. Also we have to handle failure case
 	 * of .get_budget for avoiding I/O deadlock.
 	 */
-	get_budget_fn		*get_budget;
+	bool (*get_budget)(struct request_queue *);
+
 	/**
 	 * @put_budget: Release the reserved budget.
 	 */
-	put_budget_fn		*put_budget;
+	void (*put_budget)(struct request_queue *);
 
 	/**
 	 * @timeout: Called on request timeout.
 	 */
-	timeout_fn		*timeout;
+	enum blk_eh_timer_return (*timeout)(struct request *, bool);
 
 	/**
 	 * @poll: Called to poll for completion of a specific tag.
 	 */
-	poll_fn			*poll;
+	int (*poll)(struct blk_mq_hw_ctx *);
 
 	/**
 	 * @complete: Mark the request as complete.
 	 */
-	complete_fn		*complete;
+	void (*complete)(struct request *);
 
 	/**
 	 * @init_hctx: Called when the block layer side of a hardware queue has
 	 * been set up, allowing the driver to allocate/init matching
 	 * structures.
 	 */
-	init_hctx_fn		*init_hctx;
+	int (*init_hctx)(struct blk_mq_hw_ctx *, void *, unsigned int);
 	/**
 	 * @exit_hctx: Ditto for exit/teardown.
 	 */
-	exit_hctx_fn		*exit_hctx;
+	void (*exit_hctx)(struct blk_mq_hw_ctx *, unsigned int);
 
 	/**
 	 * @init_request: Called for every command allocated by the block layer
@@ -353,11 +337,13 @@ struct blk_mq_ops {
 	 * Tag greater than or equal to queue_depth is for setting up
 	 * flush request.
 	 */
-	init_request_fn		*init_request;
+	int (*init_request)(struct blk_mq_tag_set *set, struct request *,
+			    unsigned int, unsigned int);
 	/**
 	 * @exit_request: Ditto for exit/teardown.
 	 */
-	exit_request_fn		*exit_request;
+	void (*exit_request)(struct blk_mq_tag_set *set, struct request *,
+			     unsigned int);
 
 	/**
 	 * @initialize_rq_fn: Called from inside blk_get_request().
@@ -368,18 +354,18 @@ struct blk_mq_ops {
 	 * @cleanup_rq: Called before freeing one request which isn't completed
 	 * yet, and usually for freeing the driver private data.
 	 */
-	cleanup_rq_fn		*cleanup_rq;
+	void (*cleanup_rq)(struct request *);
 
 	/**
 	 * @busy: If set, returns whether or not this queue currently is busy.
 	 */
-	busy_fn			*busy;
+	bool (*busy)(struct request_queue *);
 
 	/**
 	 * @map_queues: This allows drivers specify their own queue mapping by
 	 * overriding the setup-time function that builds the mq_map.
 	 */
-	map_queues_fn		*map_queues;
+	int (*map_queues)(struct blk_mq_tag_set *set);
 
 #ifdef CONFIG_BLK_DEBUG_FS
 	/**
-- 
2.16.4

