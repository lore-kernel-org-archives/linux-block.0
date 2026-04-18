Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A69B25D1E9
	for <linux-block@vger.kernel.org>; Sat, 18 Apr 2026 04:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776487162; cv=none; b=GwPGnnl/yWGLtkTQf63f2QuNpnaUy7lM3AUBJNP9wkEUhbQ02eXtawO8Ch6hAAI0Yf1tYXMGVXXeo6/oMmDsGZ3KbCo48mU8+QyZpqCMBH27vClk80jp4zHxysXjG8qGBlILQ3mbLfwSTXyRmAseAtojPN+6D5o2ZM54jRj3qUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776487162; c=relaxed/simple;
	bh=EuAEeFK892ZS2G1Z25jnmucG4o+COaU1yf+RBB4Kmhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pBo+epjOkZ4FXm+hrXmnuejXHcpjifiBUu/lx6sGwLgEo9K6/1rK6PdVIglkzsX32gnrp3B3p898MvOPa1BHN4HfbNS87ynYDPYo7VvvmrIGFeQY1I2OtcQLvrui2F+0U5wdzoRX8qBvSd7L6OYBonNQBBTgBFWawzDHgCohQDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=ZH7ggVuF; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="ZH7ggVuF"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1273349c56bso1805123c88.0
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 21:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776487159; x=1777091959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPQWFcKDDvgZYYbrbudyLF6+cLUupJKpHd1gt+TwN08=;
        b=ZH7ggVuFN9u4BUrXI/haCy3t9+suRz0w0/4T/PHxT/R7QEVyLZvLSEHSO9JhaVuH3h
         aGVLVLt1B2q8eOxvdaIsRF2mqKr8oBjHU25Iazb4XXCG2ytEWeFHoLlmsNiyjqwRcY6U
         5VXF2POHLup4epxdyxm+mYo22ERIj8DVJTLIJHv5dwptw2EJv8WmA58SJpjXk437uuu6
         JU1Do0T2sRN9y9iM8l0ewnwHhH+ZlvS9DVu3SVhOX8mvtG93P/EClITZ1felvJSg4rYc
         IuhtdDza1lT2+XNTxZ6lrYB3HxDcYBr6rwWMv/GrcrCAKfwkGiMmVKYLS1Ky2o4t15uO
         kPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776487159; x=1777091959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XPQWFcKDDvgZYYbrbudyLF6+cLUupJKpHd1gt+TwN08=;
        b=PnRBX+l/anNfaQn1WKP/9NV7+cCLqCvdetYUcmV4oEJ1rsyCLIBqNUPH4+JL94oNL6
         Zu/11CcFQ50UmDH7yk70zazZEbYpwxJ5z7VCd4QHnmct1s/33Ha5WayCOWJiN/qtZ3G3
         kkpH/pU5FDGrEKNFUELrqXEKrsXHlbhqtx+U0NRSoemkiYsghEulXUlO8AyWy3zud1JZ
         r0iNylfGKgokDvEqt5wma6BWFdTACH8AmOuMXgeR0VnYyG0OcjUv0JznRxfOjonJQz21
         XXrrWe1XQsqCp3wREudMYchg7dGnip5QToiej894PQ9ccPUcMCINYV8hmii5+6pc4Lk+
         VARA==
X-Forwarded-Encrypted: i=1; AFNElJ/cTMADCilldREL9J20BkNf4rm8YuqAAxzhcRmVH1g4ZDjMcVsIPLuzx5Vz+vGM8CsdxImC/Aal3ESE1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8kogPYixsoc/NTaheRase8dg1bWkP+wM3tRWEJ+BCr3jRGgMC
	gmTzeklpwo/mrodicL8l/qlHt1FehtiTE6bTrf+PmLj0ucnU89wJMFSaHZOObfuB5Fw=
X-Gm-Gg: AeBDieujx7/+ocpgSq+YDCXgP1Au5WtFasCjeCrNAnFScIZ7/12yUC1AwnCBbLh8biR
	ll7bt3BftDjadp1goFJx2Nv418nP8XknW0bkAO+8KCcUTrRC+qu+ErBOPR2octmDFjbmFp2sphM
	EWvzfqScl9zEVMEfBM2poaR0WI9LXQIFKST8bZn5VXlIhTKx2/FDvpQrTRJPPSxlBKDolRURG2j
	f24lkwTTKZDU1frUa2mwHcVqCuTMRixRzIgPJcRIhv4IHECa3VG2+tbGQ5gNsDfMeNNzpIVKAFp
	jXLeSJwyd1Rmc22kJ1iAe9C3bRrJQNgk+PTEbAffaA1qqJ0CJExfW8p+t2cra/0yP42pCDpmCE5
	vyhx9pZjUMtX97bwuN82gu1+v9E5Q6MHvER5oDBq6H8wORWQ8YIjB7GHsFoc41LDJ7zx/XGFpiE
	wxRIFSaAdK2AlFYcmv1Vac1Y0UJYBZYfr7Ky8PQzGSy8ZDVQ==
X-Received: by 2002:a05:7022:383:b0:128:d4db:447a with SMTP id a92af1059eb24-12c73fa73e6mr2847163c88.29.1776487159401;
        Fri, 17 Apr 2026 21:39:19 -0700 (PDT)
Received: from chrysanthemum.. ([2804:7f0:b081:9846:727f:bf80:6632:6056])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce460sm5273734eec.19.2026.04.17.21.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 21:39:18 -0700 (PDT)
From: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
To: axboe@kernel.dk
Cc: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>,
	Ellian Carlos <elliancarlos@gmail.com>,
	Gabriel B L de Oliveira <gabrielblo@ime.usp.br>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] nullblk: main: use lock guards
Date: Sat, 18 Apr 2026 01:38:36 -0300
Message-Id: <20260418043837.721045-2-ricardo.kojo@ime.usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260418043837.721045-1-ricardo.kojo@ime.usp.br>
References: <20260418043837.721045-1-ricardo.kojo@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard() and scoped_guard() for handling mutex and spin locks instead of
manually locking and unlocking. This prevents forgotten locks due to early
exits and remove the need of gotos.

Signed-off-by: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
Co-developed-by: Ellian Carlos <elliancarlos@gmail.com>
Signed-off-by: Ellian Carlos <elliancarlos@gmail.com>
Co-developed-by: Gabriel B L de Oliveira <gabrielblo@ime.usp.br>
Signed-off-by: Gabriel B L de Oliveira <gabrielblo@ime.usp.br>
---
 drivers/block/null_blk/main.c     | 74 +++++++++++++------------------
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 32 insertions(+), 43 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index f8c0fd57e041..fbe34e8a6c93 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -423,9 +423,8 @@ static int nullb_apply_submit_queues(struct nullb_device *dev,
 {
 	int ret;
 
-	mutex_lock(&lock);
+	guard(mutex)(&lock);
 	ret = nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
-	mutex_unlock(&lock);
 
 	return ret;
 }
@@ -435,9 +434,8 @@ static int nullb_apply_poll_queues(struct nullb_device *dev,
 {
 	int ret;
 
-	mutex_lock(&lock);
+	guard(mutex)(&lock);
 	ret = nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
-	mutex_unlock(&lock);
 
 	return ret;
 }
@@ -493,15 +491,15 @@ static ssize_t nullb_device_power_store(struct config_item *item,
 		return ret;
 
 	ret = count;
-	mutex_lock(&lock);
+	guard(mutex)(&lock);
 	if (!dev->power && newp) {
 		if (test_and_set_bit(NULLB_DEV_FL_UP, &dev->flags))
-			goto out;
+			return ret;
 
 		ret = null_add_dev(dev);
 		if (ret) {
 			clear_bit(NULLB_DEV_FL_UP, &dev->flags);
-			goto out;
+			return ret;
 		}
 
 		set_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
@@ -515,8 +513,6 @@ static ssize_t nullb_device_power_store(struct config_item *item,
 		clear_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
 	}
 
-out:
-	mutex_unlock(&lock);
 	return ret;
 }
 
@@ -707,10 +703,9 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 	struct nullb_device *dev = to_nullb_device(item);
 
 	if (test_and_clear_bit(NULLB_DEV_FL_UP, &dev->flags)) {
-		mutex_lock(&lock);
+		guard(mutex)(&lock);
 		dev->power = false;
 		null_del_dev(dev->nullb);
-		mutex_unlock(&lock);
 	}
 	nullb_del_fault_config(dev);
 	config_item_put(item);
@@ -1205,7 +1200,7 @@ blk_status_t null_handle_discard(struct nullb_device *dev,
 	size_t n = nr_sectors << SECTOR_SHIFT;
 	size_t temp;
 
-	spin_lock_irq(&nullb->lock);
+	guard(spinlock_irq)(&nullb->lock);
 	while (n > 0) {
 		temp = min_t(size_t, n, dev->blocksize);
 		null_free_sector(nullb, sector, false);
@@ -1214,7 +1209,6 @@ blk_status_t null_handle_discard(struct nullb_device *dev,
 		sector += temp >> SECTOR_SHIFT;
 		n -= temp;
 	}
-	spin_unlock_irq(&nullb->lock);
 
 	return BLK_STS_OK;
 }
@@ -1226,7 +1220,7 @@ static blk_status_t null_handle_flush(struct nullb *nullb)
 	if (!null_cache_active(nullb))
 		return 0;
 
-	spin_lock_irq(&nullb->lock);
+	guard(spinlock_irq)(&nullb->lock);
 	while (true) {
 		err = null_make_cache_space(nullb,
 			nullb->dev->cache_size * 1024 * 1024);
@@ -1235,7 +1229,6 @@ static blk_status_t null_handle_flush(struct nullb *nullb)
 	}
 
 	WARN_ON(!radix_tree_empty(&nullb->dev->cache));
-	spin_unlock_irq(&nullb->lock);
 	return errno_to_blk_status(err);
 }
 
@@ -1292,7 +1285,7 @@ static blk_status_t null_handle_data_transfer(struct nullb_cmd *cmd,
 	struct req_iterator iter;
 	struct bio_vec bvec;
 
-	spin_lock_irq(&nullb->lock);
+	guard(spinlock_irq)(&nullb->lock);
 	rq_for_each_segment(bvec, rq, iter) {
 		len = bvec.bv_len;
 		if (transferred_bytes + len > max_bytes)
@@ -1307,7 +1300,6 @@ static blk_status_t null_handle_data_transfer(struct nullb_cmd *cmd,
 		if (transferred_bytes >= max_bytes)
 			break;
 	}
-	spin_unlock_irq(&nullb->lock);
 
 	return err;
 }
@@ -1592,11 +1584,11 @@ static int null_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 	int nr = 0;
 	struct request *rq;
 
-	spin_lock(&nq->poll_lock);
-	list_splice_init(&nq->poll_list, &list);
-	list_for_each_entry(rq, &list, queuelist)
-		blk_mq_set_request_complete(rq);
-	spin_unlock(&nq->poll_lock);
+	scoped_guard(spinlock, &nq->poll_lock) {
+		list_splice_init(&nq->poll_list, &list);
+		list_for_each_entry(rq, &list, queuelist)
+			blk_mq_set_request_complete(rq);
+	}
 
 	while (!list_empty(&list)) {
 		struct nullb_cmd *cmd;
@@ -1624,14 +1616,12 @@ static enum blk_eh_timer_return null_timeout_rq(struct request *rq)
 	if (hctx->type == HCTX_TYPE_POLL) {
 		struct nullb_queue *nq = hctx->driver_data;
 
-		spin_lock(&nq->poll_lock);
-		/* The request may have completed meanwhile. */
-		if (blk_mq_request_completed(rq)) {
-			spin_unlock(&nq->poll_lock);
-			return BLK_EH_DONE;
+		scoped_guard(spinlock, &nq->poll_lock) {
+			/* The request may have completed meanwhile. */
+			if (blk_mq_request_completed(rq))
+				return BLK_EH_DONE;
+			list_del_init(&rq->queuelist);
 		}
-		list_del_init(&rq->queuelist);
-		spin_unlock(&nq->poll_lock);
 	}
 
 	pr_info("rq %p timed out\n", rq);
@@ -1692,9 +1682,9 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 	blk_mq_start_request(rq);
 
 	if (is_poll) {
-		spin_lock(&nq->poll_lock);
-		list_add_tail(&rq->queuelist, &nq->poll_list);
-		spin_unlock(&nq->poll_lock);
+		scoped_guard(spinlock, &nq->poll_lock) {
+			list_add_tail(&rq->queuelist, &nq->poll_list);
+		}
 		return BLK_STS_OK;
 	}
 	if (cmd->fake_timeout)
@@ -2081,14 +2071,13 @@ static struct nullb *null_find_dev_by_name(const char *name)
 {
 	struct nullb *nullb = NULL, *nb;
 
-	mutex_lock(&lock);
+	guard(mutex)(&lock);
 	list_for_each_entry(nb, &nullb_list, list) {
 		if (strcmp(nb->disk_name, name) == 0) {
 			nullb = nb;
 			break;
 		}
 	}
-	mutex_unlock(&lock);
 
 	return nullb;
 }
@@ -2101,10 +2090,9 @@ static int null_create_dev(void)
 	dev = null_alloc_dev();
 	if (!dev)
 		return -ENOMEM;
-
-	mutex_lock(&lock);
-	ret = null_add_dev(dev);
-	mutex_unlock(&lock);
+	scoped_guard(mutex, &lock) {
+		ret = null_add_dev(dev);
+	}
 	if (ret) {
 		null_free_dev(dev);
 		return ret;
@@ -2202,12 +2190,12 @@ static void __exit null_exit(void)
 
 	unregister_blkdev(null_major, "nullb");
 
-	mutex_lock(&lock);
-	while (!list_empty(&nullb_list)) {
-		nullb = list_entry(nullb_list.next, struct nullb, list);
-		null_destroy_dev(nullb);
+	scoped_guard(mutex, &lock) {
+		while (!list_empty(&nullb_list)) {
+			nullb = list_entry(nullb_list.next, struct nullb, list);
+			null_destroy_dev(nullb);
+		}
 	}
-	mutex_unlock(&lock);
 
 	if (tag_set.ops)
 		blk_mq_free_tag_set(&tag_set);
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 6c4c4bbe7dad..c2bb085d3582 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -14,6 +14,7 @@
 #include <linux/fault-inject.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
+#include <linux/cleanup.h>
 
 struct nullb_cmd {
 	blk_status_t error;
-- 
2.34.1

