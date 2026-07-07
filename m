Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E1F37DABD;
	Tue,  7 Jul 2026 03:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783393411; cv=none; b=gEhRgA9W+xzXEtHntFGrKeYbYinT/W9ztHcNJeXsPvzWk4Og7qDbcPrGvVlHrTQ1pyCCbOwQQXZbxulgbnsuwOczwWrG0dOm8bSbKmbc1SnwcNFEYZAqbtieDms8Kovpy4LmiXCRz4OoAQbqYjfPivURBUB9L1qmkloHdpS6g+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783393411; c=relaxed/simple;
	bh=uSq5gceFqfjcRdKsQ/VyDFC3YOiW85WOGdg82adqCj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVENFpW+dKL1PRR0YYXOPyvPcXQxU3UqtOmEtnDQ8sp7gKxQA7qItt/KKRwwOOuq0e4IQOzR4WS+ofBAF791Fn2W7MNc6nnQwpQ6U+SJifMLEm5w1X6jQoQ89dE2AcSYpvCr3N8RQ7QDeu87NU/RQ32gqDgsBySH8JWlzYMaGWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gvQyg3TqwzKHMLt;
	Tue,  7 Jul 2026 11:03:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2B188406C1;
	Tue,  7 Jul 2026 11:03:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgA3SHR8bExq6ahUAQ--.61638S6;
	Tue, 07 Jul 2026 11:03:26 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	nilay@linux.ibm.com,
	linux-block@vger.kernel.org,
	kch@nvidia.com,
	johannes.thumshirn@wdc.com,
	kbusch@kernel.org,
	bvanassche@acm.org
Cc: linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huawei.com
Subject: [PATCH V2 2/6] null_blk: give the file-scope mutex a descriptive name
Date: Tue,  7 Jul 2026 10:55:38 +0800
Message-ID: <20260707025542.1299859-3-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260707025542.1299859-1-wozizhi@huaweicloud.com>
References: <20260707025542.1299859-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3SHR8bExq6ahUAQ--.61638S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1fCry3KF13ZFykGryfZwb_yoWrJw4DpF
	4YgFWjgr12gF47XrWDt34kuF1Fqw1F9Fy8try8C3WfCa9rZr9F9r1DtFy5Wr18G34fArs8
	XFWqqFn3Aa1UArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFSdy
	UUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

The file-scope lock mutex serializes access to global null_blk state,
including the nullb_list and device creation/removal. Rename it to
"nullb_global_lock" to make its purpose clear. No functional change.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 drivers/block/null_blk/main.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index eba204b27785..98f6935bb502 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -66,7 +66,7 @@ struct nullb_page {
 #define NULLB_PAGE_FREE (MAP_SZ - 2)
 
 static LIST_HEAD(nullb_list);
-static DEFINE_MUTEX(lock);
+static DEFINE_MUTEX(nullb_global_lock);
 static int null_major;
 static DEFINE_IDA(nullb_indexes);
 static struct blk_mq_tag_set tag_set;
@@ -423,9 +423,9 @@ static int nullb_apply_submit_queues(struct nullb_device *dev,
 {
 	int ret;
 
-	mutex_lock(&lock);
+	mutex_lock(&nullb_global_lock);
 	ret = nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
-	mutex_unlock(&lock);
+	mutex_unlock(&nullb_global_lock);
 
 	return ret;
 }
@@ -435,9 +435,9 @@ static int nullb_apply_poll_queues(struct nullb_device *dev,
 {
 	int ret;
 
-	mutex_lock(&lock);
+	mutex_lock(&nullb_global_lock);
 	ret = nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
-	mutex_unlock(&lock);
+	mutex_unlock(&nullb_global_lock);
 
 	return ret;
 }
@@ -493,7 +493,7 @@ static ssize_t nullb_device_power_store(struct config_item *item,
 		return ret;
 
 	ret = count;
-	mutex_lock(&lock);
+	mutex_lock(&nullb_global_lock);
 	if (!dev->power && newp) {
 		if (test_and_set_bit(NULLB_DEV_FL_UP, &dev->flags))
 			goto out;
@@ -516,7 +516,7 @@ static ssize_t nullb_device_power_store(struct config_item *item,
 	}
 
 out:
-	mutex_unlock(&lock);
+	mutex_unlock(&nullb_global_lock);
 	return ret;
 }
 
@@ -707,10 +707,10 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 	struct nullb_device *dev = to_nullb_device(item);
 
 	if (test_and_clear_bit(NULLB_DEV_FL_UP, &dev->flags)) {
-		mutex_lock(&lock);
+		mutex_lock(&nullb_global_lock);
 		dev->power = false;
 		null_del_dev(dev->nullb);
-		mutex_unlock(&lock);
+		mutex_unlock(&nullb_global_lock);
 	}
 	nullb_del_fault_config(dev);
 	config_item_put(item);
@@ -2081,14 +2081,14 @@ static struct nullb *null_find_dev_by_name(const char *name)
 {
 	struct nullb *nullb = NULL, *nb;
 
-	mutex_lock(&lock);
+	mutex_lock(&nullb_global_lock);
 	list_for_each_entry(nb, &nullb_list, list) {
 		if (strcmp(nb->disk_name, name) == 0) {
 			nullb = nb;
 			break;
 		}
 	}
-	mutex_unlock(&lock);
+	mutex_unlock(&nullb_global_lock);
 
 	return nullb;
 }
@@ -2102,9 +2102,9 @@ static int null_create_dev(void)
 	if (!dev)
 		return -ENOMEM;
 
-	mutex_lock(&lock);
+	mutex_lock(&nullb_global_lock);
 	ret = null_add_dev(dev);
-	mutex_unlock(&lock);
+	mutex_unlock(&nullb_global_lock);
 	if (ret) {
 		null_free_dev(dev);
 		return ret;
@@ -2200,17 +2200,17 @@ static void __exit null_exit(void)
 
 	unregister_blkdev(null_major, "nullb");
 
-	mutex_lock(&lock);
+	mutex_lock(&nullb_global_lock);
 	while (!list_empty(&nullb_list)) {
 		nullb = list_entry(nullb_list.next, struct nullb, list);
 		null_destroy_dev(nullb);
 	}
-	mutex_unlock(&lock);
+	mutex_unlock(&nullb_global_lock);
 
 	if (tag_set.ops)
 		blk_mq_free_tag_set(&tag_set);
 
-	mutex_destroy(&lock);
+	mutex_destroy(&nullb_global_lock);
 }
 
 module_init(null_init);
-- 
2.52.0

