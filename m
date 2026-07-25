Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662BC374A19
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 02:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784946843; cv=none; b=J8vruRMdwQ6qwFC0LBxKCvh1qWhM0BmVDcCctfSFWulYRxxSqm03HPixTpD3zAT4uGnSL3UY4mSvKZ5rI5a5fPpj8u6ffwDYaexdffKCiAUz8lTlm6tv7AZwJHKQJQUV93xrrEWAdJB1yJMgfkOTv5bj8uResTaqxZn9zKdMBy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784946843; c=relaxed/simple;
	bh=DaGY0r5nagzSzUY65Gk30lGXtidPE44ExKYkRKwo//I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mK6F4d+Cr452zdMHKldiNS70r2JRx0D8vAL6KMILhYwJyuxJQWGE3J5b1nj9tVeWPIOalR41odv4OKr54e4TgPOcRGWwpILsHMW55Ns0SkAyNLqrZ4bNLNRCydK0pVPZm9rF3IDp9Qo1Bhaai6yJyxeByVnVjlVgh/ZQu3pep1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h6TS26zSNzYQtwd
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 10:33:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6BC2A40897
	for <linux-block@vger.kernel.org>; Sat, 25 Jul 2026 10:33:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgA3SHSSIGRqCkPTCQ--.40042S12;
	Sat, 25 Jul 2026 10:33:56 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	nilay@linux.ibm.com,
	bvanassche@acm.org,
	yukuai@fygo.io,
	kch@nvidia.com,
	johannes.thumshirn@wdc.com,
	kbusch@kernel.org,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huawei.com
Subject: [PATCH V6 08/10] null_blk: convert file-scope mutex users to guard(mutex)
Date: Sat, 25 Jul 2026 10:25:07 +0800
Message-ID: <20260725022509.714271-9-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260725022509.714271-1-wozizhi@huaweicloud.com>
References: <20260725022509.714271-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3SHSSIGRqCkPTCQ--.40042S12
X-Coremail-Antispam: 1UD129KBjvJXoWxXry7Cr13Gr15Jr47Zr17trb_yoWrXry3pr
	WYgFWYgr47WF17Zr4q934DuF90ywn29F48G348Ca1fuasrZr9Fyrn8JFy5Wa4rG3y7ZrW5
	XF4kXr1fAay7JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7Cj
	xVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07UZTmfUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

Using guard()/scoped_guard() ties lock release to scope exit, removing the
need for manual mutex_unlock() calls and preventing missed unlocks on error
paths.

The per-attribute apply wrappers are left untouched, as those are reworked
separately by the configfs show/store serialization patches.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 drivers/block/null_blk/main.c | 46 +++++++++++++----------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index ad6dfed12464..962b0e05ce50 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -502,15 +502,15 @@ static ssize_t nullb_device_power_store(struct config_item *item,
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
@@ -524,8 +524,6 @@ static ssize_t nullb_device_power_store(struct config_item *item,
 		clear_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
 	}
 
-out:
-	mutex_unlock(&lock);
 	return ret;
 }
 
@@ -588,13 +586,9 @@ static ssize_t nullb_device_zone_readonly_store(struct config_item *item,
 						const char *page, size_t count)
 {
 	struct nullb_device *dev = to_nullb_device(item);
-	ssize_t ret;
-
-	mutex_lock(&lock);
-	ret = zone_cond_store(dev, page, count, BLK_ZONE_COND_READONLY);
-	mutex_unlock(&lock);
 
-	return ret;
+	guard(mutex)(&lock);
+	return zone_cond_store(dev, page, count, BLK_ZONE_COND_READONLY);
 }
 CONFIGFS_ATTR_WO(nullb_device_, zone_readonly);
 
@@ -602,13 +596,9 @@ static ssize_t nullb_device_zone_offline_store(struct config_item *item,
 					       const char *page, size_t count)
 {
 	struct nullb_device *dev = to_nullb_device(item);
-	ssize_t ret;
-
-	mutex_lock(&lock);
-	ret = zone_cond_store(dev, page, count, BLK_ZONE_COND_OFFLINE);
-	mutex_unlock(&lock);
 
-	return ret;
+	guard(mutex)(&lock);
+	return zone_cond_store(dev, page, count, BLK_ZONE_COND_OFFLINE);
 }
 CONFIGFS_ATTR_WO(nullb_device_, zone_offline);
 
@@ -726,10 +716,9 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
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
@@ -2100,14 +2089,13 @@ static struct nullb *null_find_dev_by_name(const char *name)
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
@@ -2121,9 +2109,9 @@ static int null_create_dev(void)
 	if (!dev)
 		return -ENOMEM;
 
-	mutex_lock(&lock);
-	ret = null_add_dev(dev);
-	mutex_unlock(&lock);
+	scoped_guard(mutex, &lock) {
+		ret = null_add_dev(dev);
+	}
 	if (ret) {
 		null_free_dev(dev);
 		return ret;
@@ -2215,12 +2203,12 @@ static void __exit null_exit(void)
 
 	configfs_unregister_subsystem(&nullb_subsys);
 
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
 
 	unregister_blkdev(null_major, "nullb");
 
-- 
2.52.0

