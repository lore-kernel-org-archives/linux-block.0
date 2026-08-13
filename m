Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B497B480DD2
	for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630503; cv=none; b=KNvFUcyarH8fvks1Xv9gWH/s/+wtYx7C29YahzUFvqEtfD9leXHREChh5cYsB69ugnb/WXIoO/4tYDeQHC9vK6Fqsb4YKE0XoyajCcazdGciWVmw75bKD52m7qu4uqpbYN6DTOitws+plryTusj+b0zaMFsSDUKWtrfiHJzrtN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630503; c=relaxed/simple;
	bh=4xQd0zOuI2uoBrx00yPItib4qQtArIVADPSNx5ayTtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=meiYpQ9kn7jSvF72HfvFyIGXQIYvxXcThSHjT/sdICVljcuP8BdtEdL77Dl0FP6diYL7nkkwT+eIxpW85eS8qrCiPre3gFvgLJ2lWDvcGBgBgoM7NBvKZxZHj5SXAKT9a8COkqsEeKDPr9mBFJ9foWeIKYHmVbR1wZuMUvpHiGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIZK1mJs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIZK1mJs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F981F00A3A;
	Thu, 13 Aug 2026 14:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786630501;
	bh=keQcOP4jnjYUR5XUYhTLm6mnptSyUsM7eKH/AxBQ4HI=;
	h=From:To:Cc:Subject:Date;
	b=BIZK1mJs6bnGcMx7T5CZaVwTAaawoceSy76W1ngDrIwPY7pJAcYTiDYNFNAbDQC7H
	 5XH9YvMkIAs8JsvBACNGXql7rhI1f0pC/bVbDfeds4ikulg1ryW9dTZip1WlMayy7A
	 D9iHSeNBsLIssKF+pONcneRHsaWbz/T3t0nHL3sb/gYSg6igTWLoRrd160w5s72dNq
	 T65vQbGwgy5bM14jlaBkDUulKXf6DF/e5V74zErXaJK5Tz/2t+QIIt9db85S/lBrLp
	 0KxQYLavMldS6szwu0G2QjJqJSUHO8Yj2byHRyv4gBMRtHklyHv1HOxBzyoYm4znnz
	 WwFVhaei8RsCw==
From: Niklas Cassel <cassel@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Shaohua Li <shli@fb.com>,
	Kyungchan Koh <kkc6196@fb.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	syzbot+643a6dd130546afdf1fb@syzkaller.appspotmail.com,
	linux-block@vger.kernel.org
Subject: [PATCH] null_blk: serialize configfs attribute updates with device setup
Date: Thu, 13 Aug 2026 16:14:56 +0200
Message-ID: <20260813141456.1625857-2-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6112; i=cassel@kernel.org; h=from:subject; bh=4xQd0zOuI2uoBrx00yPItib4qQtArIVADPSNx5ayTtg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJqLyb4nXN8Izh3Y2NryVb9K4wLdq0zy72mtv/xplOrn 9e5vjBf11HKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJHBZnZFi//52a5qcZ968b Oui+nvUx89iaye5HFrCo/9Zo+Jju0DyLkeGd2M0D7d/eHX+eY3Aoepu8b+tCwcrMox8/d/l/eVn f1cUGAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The attribute store methods generated with NULLB_DEVICE_ATTR() refuse to
change the configuration of a live device by testing
NULLB_DEV_FL_CONFIGURED, but that flag is only set by
nullb_device_power_store() after null_add_dev() has returned, and the
store methods take no lock at all. configfs only serializes writes to
the same open file (buffer->mutex), so a write to any attribute can run
concurrently with null_add_dev() and change the device configuration
while it is being used.

null_add_dev() reads the configuration several times, e.g. dev->zoned is
read once to set up the queue limits and once to initialize the zone
resources:

  CPU0: echo 1 > nullb0/power         CPU1: echo 1 > nullb0/zoned
  nullb_device_power_store()
    mutex_lock(&lock)
    null_add_dev()
      if (dev->zoned) -> false
        /* no BLK_FEAT_ZONED */       nullb_device_zoned_store()
                                        test_bit(FL_CONFIGURED) -> 0
                                        dev->zoned = true
      blk_mq_alloc_disk()
        /* queue is not zoned */
      if (nullb->dev->zoned) -> true
        null_register_zoned_dev()
          blk_revalidate_disk_zones()

blk_revalidate_disk_zones() is then called for a queue that does not
have BLK_FEAT_ZONED set, which triggers its WARN_ON_ONCE() and fails the
device setup with -EIO:

  WARNING: CPU: 2 PID: 322 at block/blk-zoned.c:2357 blk_revalidate_disk_zones+0x4c/0x560

Clearing dev->zoned in the same window is worse: the queue is created
with BLK_FEAT_ZONED but the zone resources are never initialized, so
add_disk() succeeds for a zoned disk that has no zones. And a store that
lands after the last dev->zoned test leaves dev->zoned set while
dev->zones is still NULL, which null_process_zoned_cmd() dereferences on
the first write.

Fix this by taking the global lock, which nullb_device_power_store()
already holds across null_add_dev() and null_del_dev(), around both the
NULLB_DEV_FL_CONFIGURED test and the update of the device configuration.
The submit_queues and poll_queues apply callbacks are now called with
that lock held, so remove the locking they did themselves.

Since the store methods can run as soon as configfs_register_subsystem()
returns, that is, before null_init() gets to mutex_init(&lock), also
initialize the lock statically with DEFINE_MUTEX().

Fixes: 3bf2bd20734e ("nullb: add configfs interface")
Reported-by: syzbot+643a6dd130546afdf1fb@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-block/6a7d0b3f.ac361c09.22ff0a.004c.GAE@google.com/
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/block/null_blk/main.c | 39 ++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index f8c0fd57e041..2e8f99873956 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -66,7 +66,7 @@ struct nullb_page {
 #define NULLB_PAGE_FREE (MAP_SZ - 2)
 
 static LIST_HEAD(nullb_list);
-static struct mutex lock;
+static DEFINE_MUTEX(lock);
 static int null_major;
 static DEFINE_IDA(nullb_indexes);
 static struct blk_mq_tag_set tag_set;
@@ -340,7 +340,15 @@ static ssize_t nullb_device_bool_attr_store(bool *val, const char *page,
 	return count;
 }
 
-/* The following macro should only be used with TYPE = {uint, ulong, bool}. */
+/*
+ * The following macro should only be used with TYPE = {uint, ulong, bool}.
+ *
+ * The device configuration is modified under the global lock to serialize
+ * attribute changes against null_add_dev() and null_del_dev(): without this,
+ * an attribute could be changed while null_add_dev() is running, that is,
+ * before NULLB_DEV_FL_CONFIGURED is set, which would let null_add_dev()
+ * observe inconsistent values for the device configuration.
+ */
 #define NULLB_DEVICE_ATTR(NAME, TYPE, APPLY)				\
 static ssize_t								\
 nullb_device_##NAME##_show(struct config_item *item, char *page)	\
@@ -360,13 +368,16 @@ nullb_device_##NAME##_store(struct config_item *item, const char *page,	\
 	ret = nullb_device_##TYPE##_attr_store(&new_value, page, count);\
 	if (ret < 0)							\
 		return ret;						\
+	mutex_lock(&lock);						\
 	if (apply_fn)							\
 		ret = apply_fn(dev, new_value);				\
 	else if (test_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags)) 	\
 		ret = -EBUSY;						\
+	if (ret >= 0)							\
+		dev->NAME = new_value;					\
+	mutex_unlock(&lock);						\
 	if (ret < 0)							\
 		return ret;						\
-	dev->NAME = new_value;						\
 	return count;							\
 }									\
 CONFIGFS_ATTR(nullb_device_, NAME);
@@ -379,6 +390,8 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
 	struct blk_mq_tag_set *set;
 	int ret, nr_hw_queues;
 
+	lockdep_assert_held(&lock);
+
 	if (!dev->nullb)
 		return 0;
 
@@ -421,25 +434,13 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
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
+	return nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
 }
 
 NULLB_DEVICE_ATTR(size, ulong, NULL);
@@ -2166,8 +2167,6 @@ static int __init null_init(void)
 	if (ret)
 		return ret;
 
-	mutex_init(&lock);
-
 	null_major = register_blkdev(0, "nullb");
 	if (null_major < 0) {
 		ret = null_major;
@@ -2211,8 +2210,6 @@ static void __exit null_exit(void)
 
 	if (tag_set.ops)
 		blk_mq_free_tag_set(&tag_set);
-
-	mutex_destroy(&lock);
 }
 
 module_init(null_init);
-- 
2.55.0

