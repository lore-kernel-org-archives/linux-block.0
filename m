Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9522F42A177;
	Mon,  6 Jul 2026 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341774; cv=none; b=UwEMNx2rYqKciol+XVnuBIk72u198W8wpXN7YwkPtYMbmE1jt8fdV5MPYxNaJRtdqbtW2nAW7a1K2nWpZB3NCPlKwkcgZH5w+TchAImADsGXceU5385o60yv/wAtWZZ9E4NSu2OWF7uXB9BRIHJAuTWk/n1MaRhxh04mzIVP78c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341774; c=relaxed/simple;
	bh=q8EhL52n2GSzYVXzbDwiBIHeBvviKI+SKVfRV0YxfEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXLFfwDzU5LGKyyXmledKJ48SKMqZrfGXlwNb1OiRZ28jNU61pMkN5a003SEhBezFhl62a4Bq05izEmOC/uCYxIuPwpVoHO22QMv7vlRvaWfYXtkblLxJ7+IorTJBMR5YKP6Pn33Nxs/ViIvxbiErHps81LFYARg5cMpPmAAFEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gv3t00rPxzYQtrM;
	Mon,  6 Jul 2026 20:42:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B024340583;
	Mon,  6 Jul 2026 20:42:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgCnt3PIoktqeukMAQ--.50096S6;
	Mon, 06 Jul 2026 20:42:49 +0800 (CST)
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
Subject: [PATCH 2/3] null_blk: give the file-scope mutex a descriptive name
Date: Mon,  6 Jul 2026 20:35:06 +0800
Message-ID: <20260706123507.3809871-3-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706123507.3809871-1-wozizhi@huaweicloud.com>
References: <20260706123507.3809871-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnt3PIoktqeukMAQ--.50096S6
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4DGr4UKr43CrW5Xw1xAFb_yoWrJF1rpF
	4YgFWj9r17Wa17ZrWDK34DuFyFq3Wv9rWxtry8C3Z5CasrZr9Fvr1DtFy5Wr18G3yxArs8
	XFWDX3Z3AayUJrUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0jN
	t3UUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

The file-scope lock mutex mainly serializes access to the global nullb_list
and related device setup. Rename it to "nullb_list_lock" to make its
purpose clear. No functional change.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 drivers/block/null_blk/main.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index eba204b27785..a775e70e16fc 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -66,7 +66,7 @@ struct nullb_page {
 #define NULLB_PAGE_FREE (MAP_SZ - 2)
 
 static LIST_HEAD(nullb_list);
-static DEFINE_MUTEX(lock);
+static DEFINE_MUTEX(nullb_list_lock);
 static int null_major;
 static DEFINE_IDA(nullb_indexes);
 static struct blk_mq_tag_set tag_set;
@@ -423,9 +423,9 @@ static int nullb_apply_submit_queues(struct nullb_device *dev,
 {
 	int ret;
 
-	mutex_lock(&lock);
+	mutex_lock(&nullb_list_lock);
 	ret = nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
-	mutex_unlock(&lock);
+	mutex_unlock(&nullb_list_lock);
 
 	return ret;
 }
@@ -435,9 +435,9 @@ static int nullb_apply_poll_queues(struct nullb_device *dev,
 {
 	int ret;
 
-	mutex_lock(&lock);
+	mutex_lock(&nullb_list_lock);
 	ret = nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
-	mutex_unlock(&lock);
+	mutex_unlock(&nullb_list_lock);
 
 	return ret;
 }
@@ -493,7 +493,7 @@ static ssize_t nullb_device_power_store(struct config_item *item,
 		return ret;
 
 	ret = count;
-	mutex_lock(&lock);
+	mutex_lock(&nullb_list_lock);
 	if (!dev->power && newp) {
 		if (test_and_set_bit(NULLB_DEV_FL_UP, &dev->flags))
 			goto out;
@@ -516,7 +516,7 @@ static ssize_t nullb_device_power_store(struct config_item *item,
 	}
 
 out:
-	mutex_unlock(&lock);
+	mutex_unlock(&nullb_list_lock);
 	return ret;
 }
 
@@ -707,10 +707,10 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 	struct nullb_device *dev = to_nullb_device(item);
 
 	if (test_and_clear_bit(NULLB_DEV_FL_UP, &dev->flags)) {
-		mutex_lock(&lock);
+		mutex_lock(&nullb_list_lock);
 		dev->power = false;
 		null_del_dev(dev->nullb);
-		mutex_unlock(&lock);
+		mutex_unlock(&nullb_list_lock);
 	}
 	nullb_del_fault_config(dev);
 	config_item_put(item);
@@ -2081,14 +2081,14 @@ static struct nullb *null_find_dev_by_name(const char *name)
 {
 	struct nullb *nullb = NULL, *nb;
 
-	mutex_lock(&lock);
+	mutex_lock(&nullb_list_lock);
 	list_for_each_entry(nb, &nullb_list, list) {
 		if (strcmp(nb->disk_name, name) == 0) {
 			nullb = nb;
 			break;
 		}
 	}
-	mutex_unlock(&lock);
+	mutex_unlock(&nullb_list_lock);
 
 	return nullb;
 }
@@ -2102,9 +2102,9 @@ static int null_create_dev(void)
 	if (!dev)
 		return -ENOMEM;
 
-	mutex_lock(&lock);
+	mutex_lock(&nullb_list_lock);
 	ret = null_add_dev(dev);
-	mutex_unlock(&lock);
+	mutex_unlock(&nullb_list_lock);
 	if (ret) {
 		null_free_dev(dev);
 		return ret;
@@ -2200,17 +2200,17 @@ static void __exit null_exit(void)
 
 	unregister_blkdev(null_major, "nullb");
 
-	mutex_lock(&lock);
+	mutex_lock(&nullb_list_lock);
 	while (!list_empty(&nullb_list)) {
 		nullb = list_entry(nullb_list.next, struct nullb, list);
 		null_destroy_dev(nullb);
 	}
-	mutex_unlock(&lock);
+	mutex_unlock(&nullb_list_lock);
 
 	if (tag_set.ops)
 		blk_mq_free_tag_set(&tag_set);
 
-	mutex_destroy(&lock);
+	mutex_destroy(&nullb_list_lock);
 }
 
 module_init(null_init);
-- 
2.52.0

