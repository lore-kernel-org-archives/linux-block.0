Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8B8C4338F
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 15:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A06610A8
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 15:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbhHBP1h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 11:27:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3555 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbhHBP1g (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Aug 2021 11:27:36 -0400
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gdhh44YJHz6F7yZ;
        Mon,  2 Aug 2021 23:27:16 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 17:27:25 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 16:27:23 +0100
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>, <hch@lst.de>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tglx@linutronix.de>, John Garry <john.garry@huawei.com>
Subject: [RFC PATCH] null_blk: Add pseudo-managed interrupts support
Date:   Mon, 2 Aug 2021 23:22:36 +0800
Message-ID: <1627917756-122544-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk-mq supports draining HW queues contexts of active requests for when
the underlying HW uses managed interrupts signaling and all associated
CPUs are offlined.

Testing this feature may be difficult as appropriate HW may not be
available or certain configurations may also be difficult to create.

Add pseudo-managed interrupt support by making requests timeout when no
CPUs are online in the hctx cpumask at completion.

A new irqmode is added, NULL_IRQ_MANAGED. This mode is based on a timer,
as a time window needs to be created between "submission and completion"
for the CPU(s) to go offline, which other modes like softirq would not
provide.

Signed-off-by: John Garry <john.garry@huawei.com>
---
Based on v5.14-rc4 + "[PATCH V6 0/3] blk-mq: fix blk_mq_alloc_request_hctx"

Sending as an RFC to gauge interest before sending proper.

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d734e9ee1546..25484acfd6df 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -76,6 +76,7 @@ enum {
 	NULL_IRQ_NONE		= 0,
 	NULL_IRQ_SOFTIRQ	= 1,
 	NULL_IRQ_TIMER		= 2,
+	NULL_IRQ_MANAGED	= 3,
 };
 
 enum {
@@ -181,7 +182,7 @@ static int g_irqmode = NULL_IRQ_SOFTIRQ;
 static int null_set_irqmode(const char *str, const struct kernel_param *kp)
 {
 	return null_param_store_val(str, &g_irqmode, NULL_IRQ_NONE,
-					NULL_IRQ_TIMER);
+					NULL_IRQ_MANAGED);
 }
 
 static const struct kernel_param_ops null_irqmode_param_ops = {
@@ -190,7 +191,7 @@ static const struct kernel_param_ops null_irqmode_param_ops = {
 };
 
 device_param_cb(irqmode, &null_irqmode_param_ops, &g_irqmode, 0444);
-MODULE_PARM_DESC(irqmode, "IRQ completion handler. 0-none, 1-softirq, 2-timer");
+MODULE_PARM_DESC(irqmode, "IRQ completion handler. 0-none, 1-softirq, 2-timer, 3-pseudo managed");
 
 static unsigned long g_completion_nsec = 10000;
 module_param_named(completion_nsec, g_completion_nsec, ulong, 0444);
@@ -716,7 +717,18 @@ static void end_cmd(struct nullb_cmd *cmd)
 
 static enum hrtimer_restart null_cmd_timer_expired(struct hrtimer *timer)
 {
-	end_cmd(container_of(timer, struct nullb_cmd, timer));
+	struct nullb_cmd *cmd = container_of(timer, struct nullb_cmd, timer);
+	struct nullb_queue *nq = cmd->nq;
+	struct request *rq = cmd->rq;
+	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
+
+	if ((nq->dev->irqmode == NULL_IRQ_MANAGED) &&
+	    (cpumask_any_and(hctx->cpumask, cpu_online_mask) >= nr_cpu_ids)) {
+		/* All CPUs associated are offline -> trigger a timeout */
+		cmd->fake_timeout = true;
+	} else {
+		end_cmd(cmd);
+	}
 
 	return HRTIMER_NORESTART;
 }
@@ -1333,6 +1345,7 @@ static inline void nullb_complete_cmd(struct nullb_cmd *cmd)
 		end_cmd(cmd);
 		break;
 	case NULL_IRQ_TIMER:
+	case NULL_IRQ_MANAGED:
 		null_cmd_end_timer(cmd);
 		break;
 	}
@@ -1488,7 +1501,8 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
 
-	if (nq->dev->irqmode == NULL_IRQ_TIMER) {
+	if (nq->dev->irqmode == NULL_IRQ_TIMER ||
+	    nq->dev->irqmode == NULL_IRQ_MANAGED) {
 		hrtimer_init(&cmd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 		cmd->timer.function = null_cmd_timer_expired;
 	}
@@ -1568,12 +1582,23 @@ static int null_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
 	return 0;
 }
 
+static int null_map_queues(struct blk_mq_tag_set *set)
+{
+	struct blk_mq_queue_map *qmap = &set->map[HCTX_TYPE_DEFAULT];
+
+	if (g_irqmode == NULL_IRQ_MANAGED)
+		qmap->use_managed_irq = 1;
+
+	return blk_mq_map_queues(qmap);
+}
+
 static const struct blk_mq_ops null_mq_ops = {
 	.queue_rq       = null_queue_rq,
 	.complete	= null_complete_rq,
 	.timeout	= null_timeout_rq,
 	.init_hctx	= null_init_hctx,
 	.exit_hctx	= null_exit_hctx,
+	.map_queues	= null_map_queues,
 };
 
 static void null_del_dev(struct nullb *nullb)
@@ -1761,7 +1786,7 @@ static int null_validate_conf(struct nullb_device *dev)
 		dev->submit_queues = 1;
 
 	dev->queue_mode = min_t(unsigned int, dev->queue_mode, NULL_Q_MQ);
-	dev->irqmode = min_t(unsigned int, dev->irqmode, NULL_IRQ_TIMER);
+	dev->irqmode = min_t(unsigned int, dev->irqmode, NULL_IRQ_MANAGED);
 
 	/* Do memory allocation, so set blocking */
 	if (dev->memory_backed)
@@ -1961,6 +1986,12 @@ static int __init null_init(void)
 		pr_err("legacy IO path no longer available\n");
 		return -EINVAL;
 	}
+
+	if (g_queue_mode == NULL_Q_BIO && g_irqmode == NULL_IRQ_MANAGED) {
+		pr_err("bio queue mode not supported with pseudo-managed irqs\n");
+		return -EINVAL;
+	}
+
 	if (g_queue_mode == NULL_Q_MQ && g_use_per_node_hctx) {
 		if (g_submit_queues != nr_online_nodes) {
 			pr_warn("submit_queues param is set to %u.\n",
-- 
2.26.2

