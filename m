Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4083C43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 10:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbiGNKcO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 06:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237787AbiGNKcO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 06:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 619364A83C
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 03:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657794732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OeswGrolcg8+AQoeEfEFFVTly+D+0pAzVmZBozFM9Uw=;
        b=GYcLT25EfRtoTmegIINU1kqt8HHaDIXn0EAn9LENf6UKTqc9JNCRHc2stgfZ4IiIi76xdO
        KQxK/ssBcbUTv8QzRZEwbwYDQhwbYGkVvOQ6hU5UwxNgE5xYJsgbQKh3XSmt2AVrt54IkU
        HQyakSBk/gbgU4CDSdQrX+/lLIbQwp4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-dWFtilJpPnia5ygz7RKPqQ-1; Thu, 14 Jul 2022 06:32:09 -0400
X-MC-Unique: dWFtilJpPnia5ygz7RKPqQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04F9F8032F6;
        Thu, 14 Jul 2022 10:32:09 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F043401E54;
        Thu, 14 Jul 2022 10:32:07 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] ublk_drv: fix request queue leak
Date:   Thu, 14 Jul 2022 18:32:01 +0800
Message-Id: <20220714103201.131648-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Call blk_cleanup_queue() in release code path for fixing request
queue leak.

Also for-5.20/block has cleaned up blk_cleanup_queue(), which is
basically merged to del_gendisk() if blk_mq_alloc_disk() is used
for allocating disk and queue.

However, ublk may not add disk in case of starting device failure, then
del_gendisk() won't be called when removing ublk device, so blk_mq_exit_queue
will not be callsed, and it can be bit hard to deal with this kind of
merge conflict.

Turns out ublk's queue/disk use model is very similar with scsi, so switch
to scsi's model by allocating disk and queue independently, then it can be
quite easy to handle v5.20 merge conflict by replacing blk_cleanup_queue
with blk_mq_destroy_queue.

Reported-by: Jens Axboe <axboe@kernel.dk>
Fixes: 3fee8d7599e1 ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 35fa06ee70ff..eeeac43e1dc1 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -155,6 +155,8 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
 
 static struct miscdevice ublk_misc;
 
+static struct lock_class_key ublk_bio_compl_lkclass;
+
 static inline bool ublk_can_use_task_work(const struct ublk_queue *ubq)
 {
 	if (IS_BUILTIN(CONFIG_BLK_DEV_UBLK) &&
@@ -634,7 +636,7 @@ static void ublk_commit_rqs(struct blk_mq_hw_ctx *hctx)
 static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
 		unsigned int hctx_idx)
 {
-	struct ublk_device *ub = hctx->queue->queuedata;
+	struct ublk_device *ub = driver_data;
 	struct ublk_queue *ubq = ublk_get_queue(ub, hctx->queue_num);
 
 	hctx->driver_data = ubq;
@@ -1076,6 +1078,8 @@ static void ublk_cdev_rel(struct device *dev)
 {
 	struct ublk_device *ub = container_of(dev, struct ublk_device, cdev_dev);
 
+	blk_cleanup_queue(ub->ub_queue);
+
 	put_disk(ub->ub_disk);
 
 	blk_mq_free_tag_set(&ub->tag_set);
@@ -1165,14 +1169,17 @@ static int ublk_add_dev(struct ublk_device *ub)
 	if (err)
 		goto out_deinit_queues;
 
-	disk = ub->ub_disk = blk_mq_alloc_disk(&ub->tag_set, ub);
+	ub->ub_queue = blk_mq_init_queue(&ub->tag_set);
+	if (IS_ERR(ub->ub_queue))
+		goto out_cleanup_tags;
+	ub->ub_queue->queuedata = ub;
+
+	disk = ub->ub_disk = __alloc_disk_node(ub->ub_queue, NUMA_NO_NODE,
+			&ublk_bio_compl_lkclass);
 	if (IS_ERR(disk)) {
 		err = PTR_ERR(disk);
-		goto out_cleanup_tags;
+		goto out_free_request_queue;
 	}
-	ub->ub_queue = ub->ub_disk->queue;
-
-	ub->ub_queue->queuedata = ub;
 
 	blk_queue_logical_block_size(ub->ub_queue, bsize);
 	blk_queue_physical_block_size(ub->ub_queue, bsize);
@@ -1204,6 +1211,8 @@ static int ublk_add_dev(struct ublk_device *ub)
 
 	return 0;
 
+out_free_request_queue:
+	blk_cleanup_queue(ub->ub_queue);
 out_cleanup_tags:
 	blk_mq_free_tag_set(&ub->tag_set);
 out_deinit_queues:
-- 
2.31.1

