Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42444C4338F
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 01:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE9960FC4
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 01:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbhHEB7g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Aug 2021 21:59:36 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7783 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237415AbhHEB7g (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Aug 2021 21:59:36 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GgBcK3QlzzYl4P;
        Thu,  5 Aug 2021 09:59:13 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 09:59:20 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 5 Aug 2021
 09:59:19 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        Christoph Hellwig <hch@lst.de>, <houtao1@huawei.com>
Subject: [PATCH v2] nbd: do del_gendisk() asynchronously for NBD_DESTROY_ON_DISCONNECT
Date:   Thu, 5 Aug 2021 10:12:15 +0800
Message-ID: <20210805021215.855751-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now open_mutex is used to synchronize partition operations (e.g,
blk_drop_partitions() and blkdev_reread_part()), however it makes
nbd driver broken, because nbd may call del_gendisk() in nbd_release()
or nbd_genl_disconnect() if NBD_CFLAG_DESTROY_ON_DISCONNECT is enabled,
and deadlock occurs, as shown below:

// AB-BA dead-lock
nbd_genl_disconnect            blkdev_open
  nbd_disconnect_and_put
                                 lock bd_mutex
  // last ref
  nbd_put
    lock nbd_index_mutex
      del_gendisk
                                   nbd_open
                                     try lock nbd_index_mutex
        try lock bd_mutex

 or

// AA dead-lock
nbd_release
  lock bd_mutex
    nbd_put
      try lock bd_mutex

Instead of fixing block layer (e.g, introduce another lock), fixing
the nbd driver to call del_gendisk() in a kworker when
NBD_DESTROY_ON_DISCONNECT is enabled. When NBD_DESTROY_ON_DISCONNECT
is disabled, nbd device will always be destroy through module removal,
and there is no risky of deadlock.

To ensure the reuse of nbd index succeeds, moving the calling of
idr_remove() after del_gendisk(), so if the reused index is not found
in nbd_index_idr, the old disk must have been deleted. And reusing
the existing destroy_complete mechanism to ensure nbd_genl_connect()
will wait for the completion of del_gendisk().

Also adding a new workqueue for nbd removal, so nbd_cleanup()
can ensure all removals complete before exits.

Reported-by: syzbot+0fe7752e52337864d29b@syzkaller.appspotmail.com
Fixes: c76f48eb5c08 ("block: take bd_mutex around delete_partitions in del_gendisk")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
v2:
  * only call del_gendisk() asynchronously for NBD_DESTROY_ON_DISCONNECT, so
    the most normal case will not be affected.
  * skip the asynchronously-removing nbd in nbd_exit_cb(), else there
    will be underflow for nbd->refs.
  * fix the indentations of commit message.
---
 drivers/block/nbd.c | 70 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 9 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index c38317979f74..9a7c9a425ab0 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -49,6 +49,7 @@
 
 static DEFINE_IDR(nbd_index_idr);
 static DEFINE_MUTEX(nbd_index_mutex);
+static struct workqueue_struct *nbd_del_wq;
 static int nbd_total_devices = 0;
 
 struct nbd_sock {
@@ -113,6 +114,7 @@ struct nbd_device {
 	struct mutex config_lock;
 	struct gendisk *disk;
 	struct workqueue_struct *recv_workq;
+	struct work_struct remove_work;
 
 	struct list_head list;
 	struct task_struct *task_recv;
@@ -233,7 +235,7 @@ static const struct device_attribute backend_attr = {
 	.show = backend_show,
 };
 
-static void nbd_dev_remove(struct nbd_device *nbd)
+static void nbd_del_disk(struct nbd_device *nbd)
 {
 	struct gendisk *disk = nbd->disk;
 
@@ -242,24 +244,60 @@ static void nbd_dev_remove(struct nbd_device *nbd)
 		blk_cleanup_disk(disk);
 		blk_mq_free_tag_set(&nbd->tag_set);
 	}
+}
 
+/*
+ * Place this in the last just before the nbd is freed to
+ * make sure that the disk and the related kobject are also
+ * totally removed to avoid duplicate creation of the same
+ * one.
+ */
+static void nbd_notify_destroy_completion(struct nbd_device *nbd)
+{
+	if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags) &&
+	    nbd->destroy_complete)
+		complete(nbd->destroy_complete);
+}
+
+static void nbd_dev_remove_work(struct work_struct *work)
+{
+	struct nbd_device *nbd =
+		container_of(work, struct nbd_device, remove_work);
+
+	nbd_del_disk(nbd);
+
+	mutex_lock(&nbd_index_mutex);
 	/*
-	 * Place this in the last just before the nbd is freed to
-	 * make sure that the disk and the related kobject are also
-	 * totally removed to avoid duplicate creation of the same
-	 * one.
+	 * Remove from idr after del_gendisk() completes,
+	 * so if the same id is reused, the following
+	 * add_disk() will succeed.
 	 */
-	if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags) && nbd->destroy_complete)
-		complete(nbd->destroy_complete);
+	idr_remove(&nbd_index_idr, nbd->index);
+
+	nbd_notify_destroy_completion(nbd);
+	mutex_unlock(&nbd_index_mutex);
 
 	kfree(nbd);
 }
 
+static void nbd_dev_remove(struct nbd_device *nbd)
+{
+	/* Call del_gendisk() asynchrounously to prevent deadlock */
+	if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags)) {
+		queue_work(nbd_del_wq, &nbd->remove_work);
+		return;
+	}
+
+	nbd_del_disk(nbd);
+	idr_remove(&nbd_index_idr, nbd->index);
+	nbd_notify_destroy_completion(nbd);
+	kfree(nbd);
+}
+
 static void nbd_put(struct nbd_device *nbd)
 {
 	if (refcount_dec_and_mutex_lock(&nbd->refs,
 					&nbd_index_mutex)) {
-		idr_remove(&nbd_index_idr, nbd->index);
 		nbd_dev_remove(nbd);
 		mutex_unlock(&nbd_index_mutex);
 	}
@@ -1679,6 +1717,7 @@ static int nbd_dev_add(int index)
 	nbd->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
 		BLK_MQ_F_BLOCKING;
 	nbd->tag_set.driver_data = nbd;
+	INIT_WORK(&nbd->remove_work, nbd_dev_remove_work);
 	nbd->destroy_complete = NULL;
 	nbd->backend = NULL;
 
@@ -2416,7 +2455,14 @@ static int __init nbd_init(void)
 	if (register_blkdev(NBD_MAJOR, "nbd"))
 		return -EIO;
 
+	nbd_del_wq = alloc_workqueue("nbd-del", WQ_UNBOUND, 0);
+	if (!nbd_del_wq) {
+		unregister_blkdev(NBD_MAJOR, "nbd");
+		return -ENOMEM;
+	}
+
 	if (genl_register_family(&nbd_genl_family)) {
+		destroy_workqueue(nbd_del_wq);
 		unregister_blkdev(NBD_MAJOR, "nbd");
 		return -EINVAL;
 	}
@@ -2434,7 +2480,10 @@ static int nbd_exit_cb(int id, void *ptr, void *data)
 	struct list_head *list = (struct list_head *)data;
 	struct nbd_device *nbd = ptr;
 
-	list_add_tail(&nbd->list, list);
+	/* Skip nbd that is being removed asynchronously */
+	if (refcount_read(&nbd->refs))
+		list_add_tail(&nbd->list, list);
+
 	return 0;
 }
 
@@ -2457,6 +2506,9 @@ static void __exit nbd_cleanup(void)
 		nbd_put(nbd);
 	}
 
+	/* Also wait for nbd_dev_remove_work() completes */
+	destroy_workqueue(nbd_del_wq);
+
 	idr_destroy(&nbd_index_idr);
 	genl_unregister_family(&nbd_genl_family);
 	unregister_blkdev(NBD_MAJOR, "nbd");
-- 
2.29.2

