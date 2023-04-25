Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24314C6FD18
	for <linux-block@archiver.kernel.org>; Tue, 25 Apr 2023 03:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjDYDnt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 23:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjDYDnp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 23:43:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E4CBB9D
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 20:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682394132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5izQNQ0ZSJSlRZmuwBYDa94AT6DPpy0TMBalVtgzryE=;
        b=iVMeq23rEYGeQTt6hr5E/BNcKunIsFT3+mbyGC1SBkVVI9UwzbSxwU6fOsCCGOLqItz56W
        0ckcllOjAQZW/u19NqM8OGW486q43VFkIoWqnuYN48KdKaB+mvHtzI4pjHAxRmDtqtr69O
        2LkgMvy+WK46pnvQlJtwUMqOheyctQA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-ZtZyBZZJOlu5QYCRK0QHGA-1; Mon, 24 Apr 2023 23:42:08 -0400
X-MC-Unique: ZtZyBZZJOlu5QYCRK0QHGA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55F1785A588;
        Tue, 25 Apr 2023 03:42:08 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4CBE492B03;
        Tue, 25 Apr 2023 03:42:06 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Changhui Zhong <czhong@redhat.com>
Subject: [PATCH] block: sync part's ->bd_has_submit_bio with disk's
Date:   Tue, 25 Apr 2023 11:41:54 +0800
Message-Id: <20230425034154.110099-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

submit_bio() always uses bio->bi_bdev->bd_has_submit_bio to decide if
disk's ->submit_bio() is called, and bio->bi_bdev could point to one
partition device.

So we have to sync part bdev's ->bd_has_submit_bio with disk's.

Reported-by: Changhui Zhong <czhong@redhat.com>
Link: https://lore.kernel.org/linux-block/ZEdItaPqif8fp85H@ovpn-8-24.pek2.redhat.com/T/#t
Fixes: 9f4107b07b17 ("block: store bdev->bd_disk->fops->submit_bio state in bdev")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index 850852fe4b78..f1aee35ca266 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -418,8 +418,11 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	bdev->bd_partno = partno;
 	bdev->bd_inode = inode;
 	bdev->bd_queue = disk->queue;
+	if (partno)
+		bdev->bd_has_submit_bio = disk->part0->bd_has_submit_bio;
+	else
+		bdev->bd_has_submit_bio = false;
 	bdev->bd_stats = alloc_percpu(struct disk_stats);
-	bdev->bd_has_submit_bio = false;
 	if (!bdev->bd_stats) {
 		iput(inode);
 		return NULL;
-- 
2.40.0

