Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E50C636D3
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 04:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjAaEFq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Jan 2023 23:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAaEFo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2023 23:05:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36D637547
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2023 20:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675137900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tofNQpFIcbtdk9ulc05zTr/b11IIM8I5M6KWy1q1jOg=;
        b=BNkcM61lzX4TDKaKDjNMF1BFcyLOFVidyxJQss8B5sl5c+sT8qF5OhLrKKgAJWpxGR7wEm
        TUKh4pvp0MKRXuMGadjSiF7eH3r4N81frA3UVkLrO1eREt6fENgXSlKDKVE8MskVMH6Iwl
        sJqR//FqL4YFU18x8jynmUxAYf7VZAI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-X3MGZEaoOdilhvqie5kcQQ-1; Mon, 30 Jan 2023 23:04:58 -0500
X-MC-Unique: X3MGZEaoOdilhvqie5kcQQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09D3C380663B;
        Tue, 31 Jan 2023 04:04:58 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 250EF140EBF6;
        Tue, 31 Jan 2023 04:04:56 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH for-6.3 1/1] ublk_drv: only allow owner to open unprivileged disk
Date:   Tue, 31 Jan 2023 12:04:46 +0800
Message-Id: <20230131040446.214583-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Owner of one unprivileged ublk device could be one evil user, which
can grant this disk's privilege to other users deliberately, and
this way could be like making one trap and waiting for other users
to be caught.

So only owner to open unprivileged disk even though the owner
grants disk privilege to other user. This way is reasonable too
given anyone can create ublk disk, and no need other's grant.

Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
Fixes: 4093cb5a0634 ("ublk_drv: add mechanism for supporting unprivileged ublk device")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 55 +++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a725a236a38f..c932e9ea5a0f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -377,8 +377,50 @@ static void ublk_free_disk(struct gendisk *disk)
 	put_device(&ub->cdev_dev);
 }
 
+static void ublk_store_owner_uid_gid(unsigned int *owner_uid,
+		unsigned int *owner_gid)
+{
+	kuid_t uid;
+	kgid_t gid;
+
+	current_uid_gid(&uid, &gid);
+
+	*owner_uid = from_kuid(&init_user_ns, uid);
+	*owner_gid = from_kgid(&init_user_ns, gid);
+}
+
+static int ublk_open(struct block_device *bdev, fmode_t mode)
+{
+	struct ublk_device *ub = bdev->bd_disk->private_data;
+
+	if (capable(CAP_SYS_ADMIN))
+		return 0;
+
+	/*
+	 * If it is one unprivileged device, only owner can open
+	 * the disk. Otherwise it could be one trap made by one
+	 * evil user who grants this disk's privileges to other
+	 * users deliberately.
+	 *
+	 * This way is reasonable too given anyone can create
+	 * unprivileged device, and no need other's grant.
+	 */
+	if (ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV) {
+		unsigned int curr_uid, curr_gid;
+
+		ublk_store_owner_uid_gid(&curr_uid, &curr_gid);
+
+		if (curr_uid != ub->dev_info.owner_uid || curr_gid !=
+				ub->dev_info.owner_gid)
+			return -EPERM;
+	}
+
+	return 0;
+}
+
 static const struct block_device_operations ub_fops = {
 	.owner =	THIS_MODULE,
+	.open =		ublk_open,
 	.free_disk =	ublk_free_disk,
 };
 
@@ -1620,17 +1662,6 @@ static int ublk_ctrl_get_queue_affinity(struct ublk_device *ub,
 	return ret;
 }
 
-static void ublk_store_owner_uid_gid(struct ublksrv_ctrl_dev_info *info)
-{
-	kuid_t uid;
-	kgid_t gid;
-
-	current_uid_gid(&uid, &gid);
-
-	info->owner_uid = from_kuid(&init_user_ns, uid);
-	info->owner_gid = from_kgid(&init_user_ns, gid);
-}
-
 static inline void ublk_dump_dev_info(struct ublksrv_ctrl_dev_info *info)
 {
 	pr_devel("%s: dev id %d flags %llx\n", __func__,
@@ -1664,7 +1695,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		return -EPERM;
 
 	/* the created device is always owned by current user */
-	ublk_store_owner_uid_gid(&info);
+	ublk_store_owner_uid_gid(&info.owner_uid, &info.owner_gid);
 
 	if (header->dev_id != info.dev_id) {
 		pr_warn("%s: dev id not match %u %u\n",
-- 
2.31.1

