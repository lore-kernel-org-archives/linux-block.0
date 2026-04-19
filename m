Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CF337474B
	for <linux-block@vger.kernel.org>; Sun, 19 Apr 2026 05:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776575431; cv=none; b=IEOUnO6U203vDKAb112Ap4nfSGqVR/fSuGBIq38HT0gNdPaIXgDAIeDvM8rIwlwnUc+rRX2BRUP+XN8DfiCX6s2cvi3ZenqnzE9oRQ79kSnwf8l1226cxvmB66TcGhGtI+xU26Qx9U31FbLeBCVPSAu8HkjQgbU3APxY7Xh+INU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776575431; c=relaxed/simple;
	bh=gwDqP9yDbzzfOxhnT3lE8YyE3aPMyRu2JFI3h3HUtqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l9gihfCPyIEh+Ymsm2zTFofjXN1TtQP7vHNEOlTb0+3AUrb48FGL1ISA1FYFFvPt6vo4kWF7HSYjiHcfiLt9nnotKQV6jVmGuRVI46pOCy1nhLQdueN9/0l3XsXkSFLiN9Q87RP0rQObA/ODDlFD4OsuyvtBdIPwbjplNoy2ITE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Y59PDoqa; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Y59PDoqa"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2e622a9da9cso3332148eec.0
        for <linux-block@vger.kernel.org>; Sat, 18 Apr 2026 22:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776575425; x=1777180225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtITekU1IEwHH+QuPDPtQERBlqYgHkZoN+inSFWdW/w=;
        b=Y59PDoqaU4/V59fnQiJyKaREGM74xjB35MLxDV7LthQmCc6dP+KSS2g3iRNqbuUV2M
         C6peDGYt5ABsRQ65kSq8/ElV9egSrl3sabgPXzZMq6rJZSiZrXoe3KsGHk2oGt6HkKz3
         R4FaOP3LrvAjpYck7WgALn4AJlC/jWmO7ui4W4pFWt9LyVGMeySAdYXyPt/+RdlH+OUs
         O6UDhRMQvRwq1oSMtW2QztYX97TbrPtMmlmuLHn8uOElU72TGqMU6bcCvW/eJtnxWGD8
         2Cm/WZQlGKtFMiYkuqTPpkYr8CX2J8SgFilxbv63NZfCbjQe7aiX4tJaRmdEt9qtuI1e
         GvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776575425; x=1777180225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NtITekU1IEwHH+QuPDPtQERBlqYgHkZoN+inSFWdW/w=;
        b=CKNH9aYVm3366RxMh6b6fdo+Ij7b+k3h/54MPy0RUsLATV7LPOQtBQkQWQa9/W0RPO
         ThjwPyQqUbKUj+bkli7LlsUVnZqkFq5DnGNTUIfEEQSlp5jnsdlxnnqbg/udD6aqCX/h
         PNyXAAAhHnf5qEFdJST8TF2tevJioLDiBOYxzEnSaYXty+qXI8yBqAaMld4mCJOEpxaQ
         sDamOHUEKgDC3qcM9mX8YRk/T0Up4sFJWpMr7a5HW8XjjxxZ+iMikpRkHvHkNo3OyocE
         3zOspYzGu/j1FUvRHsAK5BeFVZiCFBemTspuZ3Nt5VtxMffVX2A/cEkijoHjwddN14+P
         LotQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Iiq8dPNKSmr84vlLrh/PEDnt0+Ym8goVUjnVC60WWy0BhFqd8gf5RzHa9DoMMZXniqS2CeEUw7/9lng==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe5j2U6F+PR0qGC8A6U/+LCOwkhzLZcNjKqwr7uzNYamcZgcQN
	g23pciMCi25SQTr+s8leSatq9etQ7eectihJ+8YzU20/dtOG52eE8qHqhWXRdOrknRg=
X-Gm-Gg: AeBDievIqV7Ff+B7xSTQ+DLMbvZK4TbQjMMhl/9dHI9uRGkyap0rB/zsECd9Lt88lJo
	Joj7/bJKbHTyLdDxxJQD6WF773jkcuKAZ6zGvwj0dd3Gtl25a7Qa0CB+5yPmnkxcE/PkEfohJXf
	j65ulKVcaCJQE5b1XICObs3M5XFHDXgoQ2xmYYVB7UBMVGyomk3E3tIEBDM9P7TS7zTJldqxBC4
	L95ZHQn7iM+7mYw/Nmqj8KLV7iHf5Kep3aKMq4ozGTDQZHylC2mSuBERwyL7bhpQSUFkrfrtynu
	K03w2WfT7MlvUVRYnS638BSvMUAk+/Bo00Bbnkax622kMBTowNHThvw12L08M965D1aJx88KI8o
	bCPVMsD9jneCXczbH9uPpbLLMV4DArCmpGQkT1XIaGiYOG2NmBXbNG6WEibkTWo+txgDNSmH01E
	D+ExIoBTJMwdR+drGqt7ic4QGtlHEFnq8q0evtl2bcVC8ZNw==
X-Received: by 2002:a05:7300:d512:b0:2c7:3a7:c7a7 with SMTP id 5a478bee46e88-2e47951866bmr4844518eec.25.1776575424876;
        Sat, 18 Apr 2026 22:10:24 -0700 (PDT)
Received: from chrysanthemum.. ([2804:7f0:b081:9846:8d5b:e745:5172:e188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8b3dd9sm8745052eec.27.2026.04.18.22.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 22:10:24 -0700 (PDT)
From: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
To: axboe@kernel.dk
Cc: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>,
	Ellian Carlos <elliancarlos@gmail.com>,
	Gabriel B L de Oliveira <gabrielblo@ime.usp.br>,
	linux-block@vger.kernel.org
Subject: [PATCH v2 1/2] nullblk: main: use lock guards
Date: Sun, 19 Apr 2026 02:10:08 -0300
Message-Id: <20260419051009.796491-2-ricardo.kojo@ime.usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260419051009.796491-1-ricardo.kojo@ime.usp.br>
References: <20260419051009.796491-1-ricardo.kojo@ime.usp.br>
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
 drivers/block/null_blk/main.c     | 86 ++++++++++++-------------------
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 34 insertions(+), 53 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index f8c0fd57e041..9714dea1ec01 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -421,25 +421,15 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
 static int nullb_apply_submit_queues(struct nullb_device *dev,
 				     unsigned int submit_queues)
 {
-	int ret;
-
-	mutex_lock(&lock);
-	ret = nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
-	mutex_unlock(&lock);
-
-	return ret;
+	guard(mutex)(&lock);
+	return nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
 }
 
 static int nullb_apply_poll_queues(struct nullb_device *dev,
 				   unsigned int poll_queues)
 {
-	int ret;
-
-	mutex_lock(&lock);
-	ret = nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
-	mutex_unlock(&lock);
-
-	return ret;
+	guard(mutex)(&lock);
+	return nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
 }
 
 NULLB_DEVICE_ATTR(size, ulong, NULL);
@@ -493,15 +483,15 @@ static ssize_t nullb_device_power_store(struct config_item *item,
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
@@ -515,8 +505,6 @@ static ssize_t nullb_device_power_store(struct config_item *item,
 		clear_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
 	}
 
-out:
-	mutex_unlock(&lock);
 	return ret;
 }
 
@@ -707,10 +695,9 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
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
@@ -1205,7 +1192,7 @@ blk_status_t null_handle_discard(struct nullb_device *dev,
 	size_t n = nr_sectors << SECTOR_SHIFT;
 	size_t temp;
 
-	spin_lock_irq(&nullb->lock);
+	guard(spinlock_irq)(&nullb->lock);
 	while (n > 0) {
 		temp = min_t(size_t, n, dev->blocksize);
 		null_free_sector(nullb, sector, false);
@@ -1214,7 +1201,6 @@ blk_status_t null_handle_discard(struct nullb_device *dev,
 		sector += temp >> SECTOR_SHIFT;
 		n -= temp;
 	}
-	spin_unlock_irq(&nullb->lock);
 
 	return BLK_STS_OK;
 }
@@ -1226,7 +1212,7 @@ static blk_status_t null_handle_flush(struct nullb *nullb)
 	if (!null_cache_active(nullb))
 		return 0;
 
-	spin_lock_irq(&nullb->lock);
+	guard(spinlock_irq)(&nullb->lock);
 	while (true) {
 		err = null_make_cache_space(nullb,
 			nullb->dev->cache_size * 1024 * 1024);
@@ -1235,7 +1221,6 @@ static blk_status_t null_handle_flush(struct nullb *nullb)
 	}
 
 	WARN_ON(!radix_tree_empty(&nullb->dev->cache));
-	spin_unlock_irq(&nullb->lock);
 	return errno_to_blk_status(err);
 }
 
@@ -1292,7 +1277,7 @@ static blk_status_t null_handle_data_transfer(struct nullb_cmd *cmd,
 	struct req_iterator iter;
 	struct bio_vec bvec;
 
-	spin_lock_irq(&nullb->lock);
+	guard(spinlock_irq)(&nullb->lock);
 	rq_for_each_segment(bvec, rq, iter) {
 		len = bvec.bv_len;
 		if (transferred_bytes + len > max_bytes)
@@ -1307,7 +1292,6 @@ static blk_status_t null_handle_data_transfer(struct nullb_cmd *cmd,
 		if (transferred_bytes >= max_bytes)
 			break;
 	}
-	spin_unlock_irq(&nullb->lock);
 
 	return err;
 }
@@ -1592,11 +1576,11 @@ static int null_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
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
@@ -1624,14 +1608,12 @@ static enum blk_eh_timer_return null_timeout_rq(struct request *rq)
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
@@ -1692,9 +1674,9 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
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
@@ -2081,14 +2063,13 @@ static struct nullb *null_find_dev_by_name(const char *name)
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
@@ -2101,10 +2082,9 @@ static int null_create_dev(void)
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
@@ -2202,12 +2182,12 @@ static void __exit null_exit(void)
 
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

