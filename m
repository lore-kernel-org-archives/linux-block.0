Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C313C433EF
	for <linux-block@archiver.kernel.org>; Sat, 22 Jan 2022 11:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbiAVLMn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Jan 2022 06:12:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33184 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230053AbiAVLMn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Jan 2022 06:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642849962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tqhve7JJhbDQBptqG2AcZsgYpgBMvqtn5u69ofC0wkI=;
        b=bXGbQOKD3SR8ls0dBsqB2uKDCTx1It9Z2diHO7DR4m3y0xHjLfWb9ezDCZqmSAoWkPi7PF
        kldGOmXFch5QnFvj6uBvUAY3PCMpYxdwg14E9TkPF2FEaAhXaAb+CAnzBgtdT4xqWl6kgJ
        YYRRxNUfROEQXNEowY4SVuUA3W9SPTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-9Rq3Ax0EPSiVOhMzJ1MIAA-1; Sat, 22 Jan 2022 06:12:39 -0500
X-MC-Unique: 9Rq3Ax0EPSiVOhMzJ1MIAA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5501918397B3;
        Sat, 22 Jan 2022 11:12:38 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B1481081300;
        Sat, 22 Jan 2022 11:12:34 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 10/13] block: add helper of disk_release_queue for release queue data for disk
Date:   Sat, 22 Jan 2022 19:10:51 +0800
Message-Id: <20220122111054.1126146-11-ming.lei@redhat.com>
In-Reply-To: <20220122111054.1126146-1-ming.lei@redhat.com>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add one helper of disk_release_queue for releasing queue data for disk.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/genhd.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 5bd7bcd6246e..a86027619683 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1085,6 +1085,20 @@ static const struct attribute_group *disk_attr_groups[] = {
 	NULL
 };
 
+static void disk_release_queue(struct gendisk *disk)
+{
+	struct request_queue *q = disk->queue;
+
+	blk_mq_cancel_work_sync(q);
+
+	/*
+	 * Remove all references to @q from the block cgroup controller before
+	 * restoring @q->queue_lock to avoid that restoring this pointer causes
+	 * e.g. blkcg_print_blkgs() to crash.
+	 */
+	blkcg_exit_queue(q);
+}
+
 /**
  * disk_release - releases all allocated resources of the gendisk
  * @dev: the device representing this disk
@@ -1106,19 +1120,12 @@ static void disk_release(struct device *dev)
 	might_sleep();
 	WARN_ON_ONCE(disk_live(disk));
 
-	blk_mq_cancel_work_sync(disk->queue);
+	disk_release_queue(disk);
 
 	disk_release_events(disk);
 	kfree(disk->random);
 	xa_destroy(&disk->part_tbl);
 
-	/*
-	 * Remove all references to @q from the block cgroup controller before
-	 * restoring @q->queue_lock to avoid that restoring this pointer causes
-	 * e.g. blkcg_print_blkgs() to crash.
-	 */
-	blkcg_exit_queue(disk->queue);
-
 	disk->queue->disk = NULL;
 	blk_put_queue(disk->queue);
 	iput(disk->part0->bd_inode);	/* frees the disk */
-- 
2.31.1

