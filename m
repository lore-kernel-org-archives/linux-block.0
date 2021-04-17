Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4399C433B4
	for <linux-block@archiver.kernel.org>; Sat, 17 Apr 2021 15:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8BD261210
	for <linux-block@archiver.kernel.org>; Sat, 17 Apr 2021 15:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbhDQPaS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 17 Apr 2021 11:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhDQPaS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Apr 2021 11:30:18 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0338C061574
        for <linux-block@vger.kernel.org>; Sat, 17 Apr 2021 08:29:51 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 10so11411817pfl.1
        for <linux-block@vger.kernel.org>; Sat, 17 Apr 2021 08:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+LdbO/s78uh+xUrBsLu0mvO2itiHZoImX1tzOUsX0kQ=;
        b=It7GvFK8YdRBDqvLaOUjJxSMPBfCM4Aqg8dNJU0gVgAoXwX1FFt9ueKf5NDKa9QUQJ
         8YR1dZjkQyoNZ+X+YswNgwHMe2fqoaoHw7gkG0Al3wRoh+DOTaAwE612wnKA8LSZthuv
         VnZ8OJawRkDkv5K5lIAO4HEfnV4I7nrgtQvhuF1nWbpZqIFrpzFWz9vmBdZbyiS48Nm+
         stS6qH28sVzcOyzAe2ZRFkn8VrdCX28It6E+Kup+u+LAsy6B0sKm6r2eTUjUt3VNZU7O
         9vT80h6mvHXkp5qd+p58CfzfAJ/P3DLJ2zw4rYoJIn6S3nbglg+mEmMojBUI27CiEbuU
         Ecgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+LdbO/s78uh+xUrBsLu0mvO2itiHZoImX1tzOUsX0kQ=;
        b=Kgvr8MVkb1RDLMQs6z04dJhcwk6B6btIFNpbHgNgRpnDuAotO4fTxrUyvHIGxE2h8g
         4ZoR7MJjn9mjKrDmPKOMLqN18wQ8Eto6A71LnPLWVZROJXn0gUnf3FWDlYSM+eCsfTvs
         5GUQxaicO6ann34gq5Y3N+Kj0snV2Poit0Z+ANhrYcIJyfx6Fsu7ghcLMUNuBrD1q2C3
         GQJkT9Empe/kQp/qKWCtZNDIcv6o+VA+DnZ0rlU0E9FTFvkZgiBl+p1rEMC6p4VAPfLY
         Q6XslNa+vH+UB2fCbKuq35kSsWRwWwg3g50wwqrN96UQgviPH1YjOhMnW8i/dAJEriDO
         KpRg==
X-Gm-Message-State: AOAM530DaROtXu9AmWuJXh077RWd6a5lQJTiN1LAQOoHgu1QzyRhMuTP
        77OdtB+ZQDOMl9/ugMCHLlFMELKV5gIXXw==
X-Google-Smtp-Source: ABdhPJyWlF3Am7J5vHDZ+CSIPiVL/UoUbgFOJWK3+PJSBNcnJACAYQe6V3xtDNGjqBe061kGl6X/0g==
X-Received: by 2002:a63:531b:: with SMTP id h27mr3839574pgb.395.1618673391145;
        Sat, 17 Apr 2021 08:29:51 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id l35sm8034015pgm.10.2021.04.17.08.29.49
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 08:29:50 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] null_blk: poll queue support
Message-ID: <baca710d-0f2a-16e2-60bd-b105b854e0ae@kernel.dk>
Date:   Sat, 17 Apr 2021 09:29:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There's currently no way to experiment with polled IO with null_blk,
which seems like an oversight. This patch adds support for polled IO.
We keep a list of issued IOs on submit, and then process that list
when mq_ops->poll() is invoked.

A new parameter is added, poll_queues. It defaults to 1 like the
submit queues, meaning we'll have 1 poll queue available.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Just a quick hack, works for me though in testing.

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 51bfd7737552..0a0d1c262701 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -92,6 +92,10 @@ static int g_submit_queues = 1;
 module_param_named(submit_queues, g_submit_queues, int, 0444);
 MODULE_PARM_DESC(submit_queues, "Number of submission queues");
 
+static int g_poll_queues = 1;
+module_param_named(poll_queues, g_poll_queues, int, 0444);
+MODULE_PARM_DESC(poll_queues, "Number of IOPOLL submission queues");
+
 static int g_home_node = NUMA_NO_NODE;
 module_param_named(home_node, g_home_node, int, 0444);
 MODULE_PARM_DESC(home_node, "Home node for the device");
@@ -347,6 +351,7 @@ static int nullb_apply_submit_queues(struct nullb_device *dev,
 NULLB_DEVICE_ATTR(size, ulong, NULL);
 NULLB_DEVICE_ATTR(completion_nsec, ulong, NULL);
 NULLB_DEVICE_ATTR(submit_queues, uint, nullb_apply_submit_queues);
+NULLB_DEVICE_ATTR(poll_queues, uint, nullb_apply_submit_queues);
 NULLB_DEVICE_ATTR(home_node, uint, NULL);
 NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
 NULLB_DEVICE_ATTR(blocksize, uint, NULL);
@@ -465,6 +470,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_size,
 	&nullb_device_attr_completion_nsec,
 	&nullb_device_attr_submit_queues,
+	&nullb_device_attr_poll_queues,
 	&nullb_device_attr_home_node,
 	&nullb_device_attr_queue_mode,
 	&nullb_device_attr_blocksize,
@@ -591,6 +597,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->size = g_gb * 1024;
 	dev->completion_nsec = g_completion_nsec;
 	dev->submit_queues = g_submit_queues;
+	dev->poll_queues = g_poll_queues;
 	dev->home_node = g_home_node;
 	dev->queue_mode = g_queue_mode;
 	dev->blocksize = g_bs;
@@ -1452,12 +1459,74 @@ static bool should_requeue_request(struct request *rq)
 	return false;
 }
 
+static int null_map_queues(struct blk_mq_tag_set *set)
+{
+	struct nullb *nullb = set->driver_data;
+	int i, qoff;
+
+	for (i = 0, qoff = 0; i < set->nr_maps; i++) {
+		struct blk_mq_queue_map *map = &set->map[i];
+
+		switch (i) {
+		case HCTX_TYPE_DEFAULT:
+			map->nr_queues = nullb->dev->submit_queues;
+			break;
+		case HCTX_TYPE_READ:
+			map->nr_queues = 0;
+			continue;
+		case HCTX_TYPE_POLL:
+			map->nr_queues = nullb->dev->poll_queues;
+			break;
+		}
+		map->queue_offset = qoff;
+		qoff += map->nr_queues;
+		blk_mq_map_queues(map);
+	}
+
+	return 0;
+}
+
+static int null_poll(struct blk_mq_hw_ctx *hctx)
+{
+	struct nullb_queue *nq = hctx->driver_data;
+	LIST_HEAD(list);
+	int nr = 0;
+
+	spin_lock(&nq->poll_lock);
+	list_splice_init(&nq->poll_list, &list);
+	spin_unlock(&nq->poll_lock);
+
+	while (!list_empty(&list)) {
+		struct nullb_cmd *cmd;
+		struct request *req;
+
+		req = list_first_entry(&list, struct request, queuelist);
+		list_del_init(&req->queuelist);
+		cmd = blk_mq_rq_to_pdu(req);
+		cmd->error = null_process_cmd(cmd, req_op(req), blk_rq_pos(req),
+						blk_rq_sectors(req));
+		nullb_complete_cmd(cmd);
+		nr++;
+	}
+
+	return nr;
+}
+
 static enum blk_eh_timer_return null_timeout_rq(struct request *rq, bool res)
 {
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 	struct nullb_cmd *cmd = blk_mq_rq_to_pdu(rq);
 
 	pr_info("rq %p timed out\n", rq);
 
+	if (hctx->type == HCTX_TYPE_POLL) {
+		struct nullb_queue *nq = hctx->driver_data;
+
+		spin_lock(&nq->poll_lock);
+		list_del_init(&rq->queuelist);
+		spin_unlock(&nq->poll_lock);
+	}
+
 	/*
 	 * If the device is marked as blocking (i.e. memory backed or zoned
 	 * device), the submission path may be blocked waiting for resources
@@ -1478,10 +1547,11 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nullb_queue *nq = hctx->driver_data;
 	sector_t nr_sectors = blk_rq_sectors(bd->rq);
 	sector_t sector = blk_rq_pos(bd->rq);
+	const bool is_poll = hctx->type == HCTX_TYPE_POLL;
 
 	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
 
-	if (nq->dev->irqmode == NULL_IRQ_TIMER) {
+	if (!is_poll && nq->dev->irqmode == NULL_IRQ_TIMER) {
 		hrtimer_init(&cmd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 		cmd->timer.function = null_cmd_timer_expired;
 	}
@@ -1505,6 +1575,13 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 			return BLK_STS_OK;
 		}
 	}
+
+	if (is_poll) {
+		spin_lock(&nq->poll_lock);
+		list_add_tail(&bd->rq->queuelist, &nq->poll_list);
+		spin_unlock(&nq->poll_lock);
+		return BLK_STS_OK;
+	}
 	if (cmd->fake_timeout)
 		return BLK_STS_OK;
 
@@ -1540,6 +1617,8 @@ static void null_init_queue(struct nullb *nullb, struct nullb_queue *nq)
 	init_waitqueue_head(&nq->wait);
 	nq->queue_depth = nullb->queue_depth;
 	nq->dev = nullb->dev;
+	INIT_LIST_HEAD(&nq->poll_list);
+	spin_lock_init(&nq->poll_lock);
 }
 
 static int null_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
@@ -1565,6 +1644,8 @@ static const struct blk_mq_ops null_mq_ops = {
 	.queue_rq       = null_queue_rq,
 	.complete	= null_complete_rq,
 	.timeout	= null_timeout_rq,
+	.poll		= null_poll,
+	.map_queues	= null_map_queues,
 	.init_hctx	= null_init_hctx,
 	.exit_hctx	= null_exit_hctx,
 };
@@ -1662,13 +1743,17 @@ static int setup_commands(struct nullb_queue *nq)
 
 static int setup_queues(struct nullb *nullb)
 {
-	nullb->queues = kcalloc(nr_cpu_ids, sizeof(struct nullb_queue),
+	int nqueues = nr_cpu_ids;
+
+	if (g_poll_queues)
+		nqueues *= 2;
+
+	nullb->queues = kcalloc(nqueues, sizeof(struct nullb_queue),
 				GFP_KERNEL);
 	if (!nullb->queues)
 		return -ENOMEM;
 
 	nullb->queue_depth = nullb->dev->hw_queue_depth;
-
 	return 0;
 }
 
@@ -1724,9 +1809,14 @@ static int null_gendisk_register(struct nullb *nullb)
 
 static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 {
+	int poll_queues;
+
 	set->ops = &null_mq_ops;
 	set->nr_hw_queues = nullb ? nullb->dev->submit_queues :
 						g_submit_queues;
+	poll_queues = nullb ? nullb->dev->poll_queues : g_poll_queues;
+	if (poll_queues)
+		set->nr_hw_queues *= 2;
 	set->queue_depth = nullb ? nullb->dev->hw_queue_depth :
 						g_hw_queue_depth;
 	set->numa_node = nullb ? nullb->dev->home_node : g_home_node;
@@ -1736,7 +1826,11 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 		set->flags |= BLK_MQ_F_NO_SCHED;
 	if (g_shared_tag_bitmap)
 		set->flags |= BLK_MQ_F_TAG_HCTX_SHARED;
-	set->driver_data = NULL;
+	set->driver_data = nullb;
+	if (g_poll_queues)
+		set->nr_maps = 3;
+	else
+		set->nr_maps = 1;
 
 	if ((nullb && nullb->dev->blocking) || g_blocking)
 		set->flags |= BLK_MQ_F_BLOCKING;
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 4876d5adb12d..ca16468176aa 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -32,6 +32,9 @@ struct nullb_queue {
 	struct nullb_device *dev;
 	unsigned int requeue_selection;
 
+	struct list_head poll_list;
+	spinlock_t poll_lock;
+
 	struct nullb_cmd *cmds;
 };
 
@@ -83,6 +86,7 @@ struct nullb_device {
 	unsigned int zone_max_open; /* max number of open zones */
 	unsigned int zone_max_active; /* max number of active zones */
 	unsigned int submit_queues; /* number of submission queues */
+	unsigned int poll_queues; /* number of IOPOLL submission queues */
 	unsigned int home_node; /* home node for the device */
 	unsigned int queue_mode; /* block interface */
 	unsigned int blocksize; /* block size */

-- 
Jens Axboe

