Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B497C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0808322419
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MF3i1+am"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0808322419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733019AbeKOCGd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:06:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41730 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732786AbeKOCGc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 21:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7R17pTPAyZnuR3pHztiVv7aVx94MSG6iD0Xvbbzzhxg=; b=MF3i1+amqX3tIl3SCjOfiQKJ8b
        vf4HFEnr0NfnUm2NSampgn7EiIsqaq7Ktw1VDLmPkjpdS9KHoap8Fe6JAv1hY8QwXXE5P87+CydZb
        L46FggdZDJulvg1195BvHI9iPGYj2LFIBImyGDpxYluZgzLCanh8yGZiITIzUJ1M+U2xUYe9b/KHE
        0nmL4X3feCkXRukLy4fTIRL/7TOZm0m19suQjOGVhN8y3fYO1eeeIFE1T8pecRooHfrQz6XMNtlqH
        vjlmwkzDOWqwE7GrN358Q/FtUjzR/dHle67Kswpq4Yfr+Ohm6jUiN8pqQrwXll4wfMX11VT47p0Rj
        10FyaXFQ==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMxcp-0006Bo-FI; Wed, 14 Nov 2018 16:02:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
Subject: [PATCH 08/16] block: remove a few unused exports
Date:   Wed, 14 Nov 2018 17:02:11 +0100
Message-Id: <20181114160219.28328-9-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114160219.28328-1-hch@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c   | 6 ------
 block/blk-ioc.c      | 3 ---
 block/blk-mq-sysfs.c | 1 -
 block/blk-softirq.c  | 1 -
 block/blk-stat.c     | 4 ----
 block/blk-wbt.c      | 2 --
 6 files changed, 17 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index a95cddb39f1c..3296c0b7353a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -424,7 +424,6 @@ const char *blkg_dev_name(struct blkcg_gq *blkg)
 		return dev_name(blkg->q->backing_dev_info->dev);
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(blkg_dev_name);
 
 /**
  * blkcg_print_blkgs - helper for printing per-blkg data
@@ -860,7 +859,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	}
 	return ret;
 }
-EXPORT_SYMBOL_GPL(blkg_conf_prep);
 
 /**
  * blkg_conf_finish - finish up per-blkg config update
@@ -876,7 +874,6 @@ void blkg_conf_finish(struct blkg_conf_ctx *ctx)
 	rcu_read_unlock();
 	put_disk_and_module(ctx->disk);
 }
-EXPORT_SYMBOL_GPL(blkg_conf_finish);
 
 static int blkcg_print_stat(struct seq_file *sf, void *v)
 {
@@ -1691,7 +1688,6 @@ void blkcg_maybe_throttle_current(void)
 	rcu_read_unlock();
 	blk_put_queue(q);
 }
-EXPORT_SYMBOL_GPL(blkcg_maybe_throttle_current);
 
 /**
  * blkcg_schedule_throttle - this task needs to check for throttling
@@ -1725,7 +1721,6 @@ void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay)
 		current->use_memdelay = use_memdelay;
 	set_notify_resume(current);
 }
-EXPORT_SYMBOL_GPL(blkcg_schedule_throttle);
 
 /**
  * blkcg_add_delay - add delay to this blkg
@@ -1740,7 +1735,6 @@ void blkcg_add_delay(struct blkcg_gq *blkg, u64 now, u64 delta)
 	blkcg_scale_delay(blkg, now);
 	atomic64_add(delta, &blkg->delay_nsec);
 }
-EXPORT_SYMBOL_GPL(blkcg_add_delay);
 
 module_param(blkcg_debug_stats, bool, 0644);
 MODULE_PARM_DESC(blkcg_debug_stats, "True if you want debug stats, false if not");
diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 56755ad5ac88..f91ca6b70d6a 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -28,7 +28,6 @@ void get_io_context(struct io_context *ioc)
 	BUG_ON(atomic_long_read(&ioc->refcount) <= 0);
 	atomic_long_inc(&ioc->refcount);
 }
-EXPORT_SYMBOL(get_io_context);
 
 static void icq_free_icq_rcu(struct rcu_head *head)
 {
@@ -160,7 +159,6 @@ void put_io_context(struct io_context *ioc)
 	if (free_ioc)
 		kmem_cache_free(iocontext_cachep, ioc);
 }
-EXPORT_SYMBOL(put_io_context);
 
 /**
  * put_io_context_active - put active reference on ioc
@@ -315,7 +313,6 @@ struct io_context *get_task_io_context(struct task_struct *task,
 
 	return NULL;
 }
-EXPORT_SYMBOL(get_task_io_context);
 
 /**
  * ioc_lookup_icq - lookup io_cq from ioc
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 2d737f9e7ba7..3d25b9c419e9 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -350,7 +350,6 @@ int blk_mq_register_dev(struct device *dev, struct request_queue *q)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(blk_mq_register_dev);
 
 void blk_mq_sysfs_unregister(struct request_queue *q)
 {
diff --git a/block/blk-softirq.c b/block/blk-softirq.c
index 1534066e306e..457d9ba3eb20 100644
--- a/block/blk-softirq.c
+++ b/block/blk-softirq.c
@@ -143,7 +143,6 @@ void __blk_complete_request(struct request *req)
 
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL(__blk_complete_request);
 
 static __init int blk_softirq_init(void)
 {
diff --git a/block/blk-stat.c b/block/blk-stat.c
index 90561af85a62..696a04176e4d 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -130,7 +130,6 @@ blk_stat_alloc_callback(void (*timer_fn)(struct blk_stat_callback *),
 
 	return cb;
 }
-EXPORT_SYMBOL_GPL(blk_stat_alloc_callback);
 
 void blk_stat_add_callback(struct request_queue *q,
 			   struct blk_stat_callback *cb)
@@ -151,7 +150,6 @@ void blk_stat_add_callback(struct request_queue *q,
 	blk_queue_flag_set(QUEUE_FLAG_STATS, q);
 	spin_unlock(&q->stats->lock);
 }
-EXPORT_SYMBOL_GPL(blk_stat_add_callback);
 
 void blk_stat_remove_callback(struct request_queue *q,
 			      struct blk_stat_callback *cb)
@@ -164,7 +162,6 @@ void blk_stat_remove_callback(struct request_queue *q,
 
 	del_timer_sync(&cb->timer);
 }
-EXPORT_SYMBOL_GPL(blk_stat_remove_callback);
 
 static void blk_stat_free_callback_rcu(struct rcu_head *head)
 {
@@ -181,7 +178,6 @@ void blk_stat_free_callback(struct blk_stat_callback *cb)
 	if (cb)
 		call_rcu(&cb->rcu, blk_stat_free_callback_rcu);
 }
-EXPORT_SYMBOL_GPL(blk_stat_free_callback);
 
 void blk_stat_enable_accounting(struct request_queue *q)
 {
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index e5a66c574683..919444d75489 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -754,8 +754,6 @@ void wbt_disable_default(struct request_queue *q)
 	if (rwb->enable_state == WBT_STATE_ON_DEFAULT)
 		rwb->wb_normal = 0;
 }
-EXPORT_SYMBOL_GPL(wbt_disable_default);
-
 
 static struct rq_qos_ops wbt_rqos_ops = {
 	.throttle = wbt_wait,
-- 
2.19.1

