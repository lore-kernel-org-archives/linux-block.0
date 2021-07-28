Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EA8C4338F
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 04:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D60D60F00
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 04:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhG1E2X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jul 2021 00:28:23 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:12321 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhG1E2W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 00:28:22 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GZLBc2jWNz7ywZ;
        Wed, 28 Jul 2021 12:23:36 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 12:28:19 +0800
Received: from huawei.com (10.90.53.225) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 28 Jul
 2021 12:28:19 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        Christoph Hellwig <hch@lst.de>, <houtao1@huawei.com>
Subject: [PATCH] nbd: do del_gendisk() asynchronously
Date:   Wed, 28 Jul 2021 12:42:11 +0800
Message-ID: <20210728044211.115787-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.25.0.4.g0ad7144999
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
nbd_genl_disconnect                    blkdev_open
nbd_disconnect_and_put
				       lock bd_mutex
// last ref
nbd_put
    lock nbd_index_mutex
	del_gendisk                    nbd_open
					   try lock nbd_index_mutex
	    try lock bd_mutex

 or

// AA dead-lock
nbd_release
    lock bd_mutex
    nbd_put
        try lock bd_mutex

Instead of fixing block layer (e.g, introduce another lock), fixing
the nbd driver to call del_gendisk() in a kworker. To ensure the
reuse of nbd index succeeds, moving the calling idr_remove() after
del_gendisk(), so if the reused index is not found in nbd_index_idr,
the old disk must have been deleted. And reusing the existing
destroy_complete to ensure nbd_genl_connect() will wait for
the completion of del_gendisk().

Also adding a new workqueue for nbd removal, so nbd_cleanup()
can ensure all removals completes before exits.

Reported-by: syzbot+0fe7752e52337864d29b@syzkaller.appspotmail.com
Fixes: c76f48eb5c08 ("block: take bd_mutex around delete_partitions in del_gendisk")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 drivers/block/nbd.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index c38317979f74e..c1cbfd944f2cd 100644
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
@@ -233,8 +235,10 @@ static const struct device_attribute backend_attr = {
 	.show = backend_show,
 };
 
-static void nbd_dev_remove(struct nbd_device *nbd)
+static void nbd_dev_remove_work(struct work_struct *work)
 {
+	struct nbd_device *nbd =
+		container_of(work, struct nbd_device, remove_work);
 	struct gendisk *disk = nbd->disk;
 
 	if (disk) {
@@ -243,6 +247,13 @@ static void nbd_dev_remove(struct nbd_device *nbd)
 		blk_mq_free_tag_set(&nbd->tag_set);
 	}
 
+	mutex_lock(&nbd_index_mutex);
+	/*
+	 * Remove from idr after del_gendisk() completes,
+	 * so if the same id is reused, add_disk() will succeed
+	 */
+	idr_remove(&nbd_index_idr, nbd->index);
+
 	/*
 	 * Place this in the last just before the nbd is freed to
 	 * make sure that the disk and the related kobject are also
@@ -251,6 +262,7 @@ static void nbd_dev_remove(struct nbd_device *nbd)
 	 */
 	if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags) && nbd->destroy_complete)
 		complete(nbd->destroy_complete);
+	mutex_unlock(&nbd_index_mutex);
 
 	kfree(nbd);
 }
@@ -259,8 +271,7 @@ static void nbd_put(struct nbd_device *nbd)
 {
 	if (refcount_dec_and_mutex_lock(&nbd->refs,
 					&nbd_index_mutex)) {
-		idr_remove(&nbd_index_idr, nbd->index);
-		nbd_dev_remove(nbd);
+		queue_work(nbd_del_wq, &nbd->remove_work);
 		mutex_unlock(&nbd_index_mutex);
 	}
 }
@@ -1679,6 +1690,7 @@ static int nbd_dev_add(int index)
 	nbd->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
 		BLK_MQ_F_BLOCKING;
 	nbd->tag_set.driver_data = nbd;
+	INIT_WORK(&nbd->remove_work, nbd_dev_remove_work);
 	nbd->destroy_complete = NULL;
 	nbd->backend = NULL;
 
@@ -2416,7 +2428,14 @@ static int __init nbd_init(void)
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
@@ -2457,6 +2476,9 @@ static void __exit nbd_cleanup(void)
 		nbd_put(nbd);
 	}
 
+	/* Wait for nbd_dev_remove_work() completes */
+	destroy_workqueue(nbd_del_wq);
+
 	idr_destroy(&nbd_index_idr);
 	genl_unregister_family(&nbd_genl_family);
 	unregister_blkdev(NBD_MAJOR, "nbd");
-- 
2.25.0.4.g0ad7144999

