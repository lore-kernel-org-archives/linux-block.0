Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC7B3F1674;
	Wed,  8 Jul 2026 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496843; cv=none; b=W8I5ORpwfY+wX4xsCxOHsQ9dxb3dMQis/QMuJd7nHHxAyQYeRNc4nJJj1H/esjN2vEBdGZpSD4VnLAFLE1w/HSDXQzdvN9qSGImskUqWWi31KMQIg+sbqKuWtyRiP+GdcC6avOgwkVSI3Cjy7qCb0v0yFL1PRgxZ7XiuT/eRN9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496843; c=relaxed/simple;
	bh=w0ygcxbil/8BKkGQW2me5op1bmR9YI3iw5GVRSuXnNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvlc5kKP2p/FfXiPM50TV3CgSEfLNpTB/AxrjtUmTpPlfksuWx6alUrewzdn1vUSHSttICZM7NiE8yNzrrLbWSLu9dEOYYLSmB/copV3HSaW4HwfHUmqw12ikhDf//sM+02pVAkV7MS27XDr1zdn3+ZGdvV94LXghAIimCauzfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gw9CT31zHzKHMMD;
	Wed,  8 Jul 2026 15:46:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 101574058C;
	Wed,  8 Jul 2026 15:47:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgCnt3N4AE5qQOTkAQ--.19577S10;
	Wed, 08 Jul 2026 15:47:05 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	nilay@linux.ibm.com,
	kch@nvidia.com,
	johannes.thumshirn@wdc.com,
	kbusch@kernel.org,
	bvanassche@acm.org,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huawei.com
Subject: [PATCH V3 6/6] null_blk: mark racy configfs attribute accesses with READ_ONCE/WRITE_ONCE
Date: Wed,  8 Jul 2026 15:39:17 +0800
Message-ID: <20260708073917.2172392-7-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260708073917.2172392-1-wozizhi@huaweicloud.com>
References: <20260708073917.2172392-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnt3N4AE5qQOTkAQ--.19577S10
X-Coremail-Antispam: 1UD129KBjvJXoWxuw4kJFy3uryrZr43XFW3Awb_yoWftF1fpa
	ykGa15Xw18XFsxua9rZ3WDXrnag3WkJr1fJry7A3yFkw15ur1avr95JFy5XayUtFykAFW3
	Za15JFWvyFW5WrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07UZTmfUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

The _show callback in the NULLB_DEVICE_ATTR macro reads dev->NAME and the
_store path writes dev->NAME.  configfs does not serialize accesses across
separate open file descriptions (buffer->mutex is per-fd), and _show takes
no lock, so a concurrent read and write on the same attribute is a data
race. Mark the _show read with READ_ONCE() and the _store write with
WRITE_ONCE() in the macro. The non-macro "power" attribute has the same
issue between power_show and power_store and is marked the same way.

The same _show readers also race against writes to these fields outside
_store that run after the configfs item becomes visible:

1. nullb_update_nr_hw_queues() (submit_queues, poll_queues),
2. null_validate_conf() (queue_mode, submit_queues, poll_queues, irqmode,
blocking, cache_size, mbps),
3. null_config_discard() (discard),
4. null_init_zoned_dev() (zone_capacity, zone_nr_conv,
zone_append_max_sectors, zone_max_active, zone_max_open),
5. null_add_dev() (index).

These run under the file-scope lock (taken in the macro for _store, and in
power_store for setup), but _show does not take that lock, so a plain write
still races with the READ_ONCE() read. Mark all of them with WRITE_ONCE().

Writes in null_alloc_dev() are intentionally left as plain assignments: it
runs from the .make_group callback before the configfs item is published,
so _show cannot run concurrently with it. The dev->power write in
nullb_group_drop_item() is also left plain: configfs takes frag_sem for
write and sets frag_dead during rmdir, and drop_item runs only after that,
so attribute show/store (frag_sem readers) cannot be concurrent with it.

The setup-side reads in null_validate_conf()/null_config_discard()/etc.
no longer race with _store now that _store takes the file-scope lock; those
reads are therefore left plain. This patch closes the remaining
_show-vs-write data races.

Suggested-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 drivers/block/null_blk/main.c  | 47 +++++++++++++++++-----------------
 drivers/block/null_blk/zoned.c | 18 ++++++-------
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 9e0002e4aeec..fd3c993a67b2 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -346,7 +346,7 @@ static ssize_t								\
 nullb_device_##NAME##_show(struct config_item *item, char *page)	\
 {									\
 	return nullb_device_##TYPE##_attr_show(				\
-				to_nullb_device(item)->NAME, page);	\
+			READ_ONCE(to_nullb_device(item)->NAME), page);	\
 }									\
 static ssize_t								\
 nullb_device_##NAME##_store(struct config_item *item, const char *page,	\
@@ -366,7 +366,7 @@ nullb_device_##NAME##_store(struct config_item *item, const char *page,	\
 	else if (test_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags)) 	\
 		ret = -EBUSY;						\
 	if (!ret)							\
-		dev->NAME = new_value;					\
+		WRITE_ONCE(dev->NAME, new_value);			\
 	mutex_unlock(&lock);						\
 	if (ret < 0)							\
 		return ret;						\
@@ -404,8 +404,8 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
 	 */
 	dev->prev_submit_queues = dev->submit_queues;
 	dev->prev_poll_queues = dev->poll_queues;
-	dev->submit_queues = submit_queues;
-	dev->poll_queues = poll_queues;
+	WRITE_ONCE(dev->submit_queues, submit_queues);
+	WRITE_ONCE(dev->poll_queues, poll_queues);
 
 	set = dev->nullb->tag_set;
 	nr_hw_queues = submit_queues + poll_queues;
@@ -414,8 +414,8 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
 
 	if (ret) {
 		/* on error, revert the queue numbers */
-		dev->submit_queues = dev->prev_submit_queues;
-		dev->poll_queues = dev->prev_poll_queues;
+		WRITE_ONCE(dev->submit_queues, dev->prev_submit_queues);
+		WRITE_ONCE(dev->poll_queues, dev->prev_poll_queues);
 	}
 
 	return ret;
@@ -469,7 +469,8 @@ NULLB_DEVICE_ATTR(badblocks_partial_io, bool, NULL);
 
 static ssize_t nullb_device_power_show(struct config_item *item, char *page)
 {
-	return nullb_device_bool_attr_show(to_nullb_device(item)->power, page);
+	return nullb_device_bool_attr_show(
+			READ_ONCE(to_nullb_device(item)->power), page);
 }
 
 static ssize_t nullb_device_power_store(struct config_item *item,
@@ -496,11 +497,11 @@ static ssize_t nullb_device_power_store(struct config_item *item,
 		}
 
 		set_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
-		dev->power = newp;
+		WRITE_ONCE(dev->power, newp);
 		ret = count;
 	} else if (dev->power && !newp) {
 		if (test_and_clear_bit(NULLB_DEV_FL_UP, &dev->flags)) {
-			dev->power = newp;
+			WRITE_ONCE(dev->power, newp);
 			null_del_dev(dev->nullb);
 		}
 		clear_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
@@ -1783,13 +1784,13 @@ static void null_config_discard(struct nullb *nullb, struct queue_limits *lim)
 		return;
 
 	if (!nullb->dev->memory_backed) {
-		nullb->dev->discard = false;
+		WRITE_ONCE(nullb->dev->discard, false);
 		pr_info("discard option is ignored without memory backing\n");
 		return;
 	}
 
 	if (nullb->dev->zoned) {
-		nullb->dev->discard = false;
+		WRITE_ONCE(nullb->dev->discard, false);
 		pr_info("discard option is ignored in zoned mode\n");
 		return;
 	}
@@ -1881,31 +1882,31 @@ static int null_validate_conf(struct nullb_device *dev)
 	}
 	if (dev->queue_mode == NULL_Q_BIO) {
 		pr_err("BIO-based IO path is no longer available, using blk-mq instead.\n");
-		dev->queue_mode = NULL_Q_MQ;
+		WRITE_ONCE(dev->queue_mode, NULL_Q_MQ);
 	}
 
 	if (dev->use_per_node_hctx) {
 		if (dev->submit_queues != nr_online_nodes)
-			dev->submit_queues = nr_online_nodes;
+			WRITE_ONCE(dev->submit_queues, nr_online_nodes);
 	} else if (dev->submit_queues > nr_cpu_ids)
-		dev->submit_queues = nr_cpu_ids;
+		WRITE_ONCE(dev->submit_queues, nr_cpu_ids);
 	else if (dev->submit_queues == 0)
-		dev->submit_queues = 1;
+		WRITE_ONCE(dev->submit_queues, 1);
 	dev->prev_submit_queues = dev->submit_queues;
 
 	if (dev->poll_queues > g_poll_queues)
-		dev->poll_queues = g_poll_queues;
+		WRITE_ONCE(dev->poll_queues, g_poll_queues);
 	dev->prev_poll_queues = dev->poll_queues;
-	dev->irqmode = min_t(unsigned int, dev->irqmode, NULL_IRQ_TIMER);
+	WRITE_ONCE(dev->irqmode, min_t(unsigned int, dev->irqmode, NULL_IRQ_TIMER));
 
 	/* Do memory allocation, so set blocking */
 	if (dev->memory_backed)
-		dev->blocking = true;
+		WRITE_ONCE(dev->blocking, true);
 	else /* cache is meaningless */
-		dev->cache_size = 0;
-	dev->cache_size = min_t(unsigned long, ULONG_MAX / 1024 / 1024,
-						dev->cache_size);
-	dev->mbps = min_t(unsigned int, 1024 * 40, dev->mbps);
+		WRITE_ONCE(dev->cache_size, 0);
+	WRITE_ONCE(dev->cache_size, min_t(unsigned long, ULONG_MAX / 1024 / 1024,
+					  dev->cache_size));
+	WRITE_ONCE(dev->mbps, min_t(unsigned int, 1024 * 40, dev->mbps));
 
 	if (dev->zoned &&
 	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
@@ -2015,7 +2016,7 @@ static int null_add_dev(struct nullb_device *dev)
 		goto out_cleanup_disk;
 
 	nullb->index = rv;
-	dev->index = rv;
+	WRITE_ONCE(dev->index, rv);
 
 	if (config_item_name(&dev->group.cg_item)) {
 		/* Use configfs dir name as the device name */
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 384bdce6a9b7..75613eaf3ea9 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -66,7 +66,7 @@ int null_init_zoned_dev(struct nullb_device *dev,
 	}
 
 	if (!dev->zone_capacity)
-		dev->zone_capacity = dev->zone_size;
+		WRITE_ONCE(dev->zone_capacity, dev->zone_size);
 
 	if (dev->zone_capacity > dev->zone_size) {
 		pr_err("zone capacity (%lu MB) larger than zone size (%lu MB)\n",
@@ -99,29 +99,29 @@ int null_init_zoned_dev(struct nullb_device *dev,
 	spin_lock_init(&dev->zone_res_lock);
 
 	if (dev->zone_nr_conv >= dev->nr_zones) {
-		dev->zone_nr_conv = dev->nr_zones - 1;
+		WRITE_ONCE(dev->zone_nr_conv, dev->nr_zones - 1);
 		pr_info("changed the number of conventional zones to %u",
 			dev->zone_nr_conv);
 	}
 
-	dev->zone_append_max_sectors =
-		min(ALIGN_DOWN(dev->zone_append_max_sectors,
-			       dev->blocksize >> SECTOR_SHIFT),
-		    zone_capacity_sects);
+	WRITE_ONCE(dev->zone_append_max_sectors,
+		   min(ALIGN_DOWN(dev->zone_append_max_sectors,
+				  dev->blocksize >> SECTOR_SHIFT),
+		       zone_capacity_sects));
 
 	/* Max active zones has to be < nbr of seq zones in order to be enforceable */
 	if (dev->zone_max_active >= dev->nr_zones - dev->zone_nr_conv) {
-		dev->zone_max_active = 0;
+		WRITE_ONCE(dev->zone_max_active, 0);
 		pr_info("zone_max_active limit disabled, limit >= zone count\n");
 	}
 
 	/* Max open zones has to be <= max active zones */
 	if (dev->zone_max_active && dev->zone_max_open > dev->zone_max_active) {
-		dev->zone_max_open = dev->zone_max_active;
+		WRITE_ONCE(dev->zone_max_open, dev->zone_max_active);
 		pr_info("changed the maximum number of open zones to %u\n",
 			dev->zone_max_open);
 	} else if (dev->zone_max_open >= dev->nr_zones - dev->zone_nr_conv) {
-		dev->zone_max_open = 0;
+		WRITE_ONCE(dev->zone_max_open, 0);
 		pr_info("zone_max_open limit disabled, limit >= zone count\n");
 	}
 	dev->need_zone_res_mgmt = dev->zone_max_active || dev->zone_max_open;
-- 
2.52.0

