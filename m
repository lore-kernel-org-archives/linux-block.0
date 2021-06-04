Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC75C47096
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 00:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4385C61406
	for <linux-block@archiver.kernel.org>; Fri,  4 Jun 2021 00:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFDAGZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Jun 2021 20:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31009 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229656AbhFDAGZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Jun 2021 20:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622765079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d+bFfr6Xa5feZyHtnlj3QldeQG0fhNp8nYtTUpuhfSE=;
        b=PCtzA7HMF/wb4gJxzxgCyYT7lpJhB5ZyhRskdrrln3UKWuStIkVjTgQX7EUtRZxml7Mm+x
        VMruCYwugW78gaPBN8/rgt+A0ylWv9Jb3EdgDzFtilgALim+hqzRMlDYMy5pGCa6m93/pl
        FZLcKXzFa1WCFT729rq4gIT8OtCffSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349--J68nE8fNUq9gTmesS2l9g-1; Thu, 03 Jun 2021 20:04:36 -0400
X-MC-Unique: -J68nE8fNUq9gTmesS2l9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 253F3101371D;
        Fri,  4 Jun 2021 00:04:35 +0000 (UTC)
Received: from localhost (ovpn-12-139.pek2.redhat.com [10.72.12.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C92060657;
        Fri,  4 Jun 2021 00:04:30 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH] block: loop: fix deadlock between open and remove
Date:   Fri,  4 Jun 2021 08:04:24 +0800
Message-Id: <20210604000424.189928-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit c76f48eb5c08 ("block: take bd_mutex around delete_partitions in
del_gendisk") adds disk->part0->bd_mutex in del_gendisk(), this way
causes the following AB/BA deadlock between removing loop and opening
loop:

1) loop_control_ioctl(LOOP_CTL_REMOVE)
- mutex_lock(&loop_ctl_mutex)
- mutex_lock(&disk->part0->bd_mutex)	//del_gendisk

2) open look device
- mutex_lock(&disk->part0->bd_mutex)	//blkdev_get_by_dev
- mutex_lock(&loop_ctl_mutex)		//lo_open() <- __blkdev_get

Fixes the issue by not holding loop_ctl_mutex in lo_open(), and cover
the protection on bdev->bd_disk->private_data via disk->part0->bd_mutex.

Reported-by: Colin Ian King <colin.king@canonical.com>
Fixes: c76f48eb5c08 ("block: take bd_mutex around delete_partitions in del_gendisk")
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d58d68f3c7cd..b03d8f4c1cdf 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1883,20 +1883,14 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
 	int err;
 
 	/*
-	 * take loop_ctl_mutex to protect lo pointer from race with
-	 * loop_control_ioctl(LOOP_CTL_REMOVE), however, to reduce contention
-	 * release it prior to updating lo->lo_refcnt.
+	 * both ->private_data and ->lo_refcnt are covered by disk's
+	 * open_mutex, so race between open and remove can be avoided
 	 */
-	err = mutex_lock_killable(&loop_ctl_mutex);
-	if (err)
-		return err;
 	lo = bdev->bd_disk->private_data;
-	if (!lo) {
-		mutex_unlock(&loop_ctl_mutex);
+	if (!lo)
 		return -ENXIO;
-	}
+
 	err = mutex_lock_killable(&lo->lo_mutex);
-	mutex_unlock(&loop_ctl_mutex);
 	if (err)
 		return err;
 	atomic_inc(&lo->lo_refcnt);
@@ -2272,21 +2266,26 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 		ret = loop_lookup(&lo, parm);
 		if (ret < 0)
 			break;
-		ret = mutex_lock_killable(&lo->lo_mutex);
+		/* cover removing vs. opening loop device */
+		ret = mutex_lock_killable(&lo->lo_disk->part0->bd_mutex);
 		if (ret)
 			break;
-		if (lo->lo_state != Lo_unbound) {
-			ret = -EBUSY;
-			mutex_unlock(&lo->lo_mutex);
+		ret = mutex_lock_killable(&lo->lo_mutex);
+		if (ret) {
+			mutex_unlock(&lo->lo_disk->part0->bd_mutex);
 			break;
 		}
-		if (atomic_read(&lo->lo_refcnt) > 0) {
+		if (lo->lo_state != Lo_unbound ||
+				atomic_read(&lo->lo_refcnt) > 0) {
 			ret = -EBUSY;
 			mutex_unlock(&lo->lo_mutex);
+			mutex_unlock(&lo->lo_disk->part0->bd_mutex);
 			break;
 		}
-		lo->lo_disk->private_data = NULL;
 		mutex_unlock(&lo->lo_mutex);
+		lo->lo_disk->private_data = NULL;
+		mutex_unlock(&lo->lo_disk->part0->bd_mutex);
+
 		idr_remove(&loop_index_idr, lo->lo_number);
 		loop_remove(lo);
 		break;
-- 
2.29.2

