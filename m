Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7660EC4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 14:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5641E611C9
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 14:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbhHFOaG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 10:30:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231979AbhHFOaF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 6 Aug 2021 10:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628260189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gSnu/aP1K8BTE584PRmDJjSK8aJMHAFLzkH76oZhIvE=;
        b=E3J4D6B6rMlVSj1cxAT+PTYQsIrEn4UujW9jXNbUh7ekQe0K/GZCQdvx5kiXpayBvzzq81
        05c5InXgiKN3Zyua5UYWf8aOJLWvq6HBiri7sBsUMY8Yl5XmA3zSiI4cUOhNCKpEwYUpNi
        cccfWUjoahEntO6Hlh1Vv5Sx2X4ieO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-nqPHld96Ndqnq_rJmeQIow-1; Fri, 06 Aug 2021 10:29:48 -0400
X-MC-Unique: nqPHld96Ndqnq_rJmeQIow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8950A87D543;
        Fri,  6 Aug 2021 14:29:46 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 899DB5D9D5;
        Fri,  6 Aug 2021 14:29:42 +0000 (UTC)
From:   pkalever@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        josef@toxicpanda.com, axboe@kernel.dk, idryomov@redhat.com,
        xiubli@redhat.com,
        Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
Subject: [PATCH v1 1/2] block: cleanup: define default command timeout and use it
Date:   Fri,  6 Aug 2021 19:59:13 +0530
Message-Id: <20210806142914.70556-2-pkalever@redhat.com>
In-Reply-To: <20210806142914.70556-1-pkalever@redhat.com>
References: <20210806142914.70556-1-pkalever@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>

defined BLK_DEFAULT_CMD_TIMEOUT and reuse it everywhere else.

Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
---
 block/blk-mq.c         | 2 +-
 drivers/block/nbd.c    | 2 +-
 include/linux/blkdev.h | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2c4ac51e54eb..1cba91eca6ee 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3289,7 +3289,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		goto err_hctxs;
 
 	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
-	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
+	blk_queue_rq_timeout(q, set->timeout ? set->timeout : BLK_DEFAULT_CMD_TIMEOUT);
 
 	q->tag_set = set;
 
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index c38317979f74..16a1a14b1fd1 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1376,7 +1376,7 @@ static void nbd_set_cmd_timeout(struct nbd_device *nbd, u64 timeout)
 	if (timeout)
 		blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
 	else
-		blk_queue_rq_timeout(nbd->disk->queue, 30 * HZ);
+		blk_queue_rq_timeout(nbd->disk->queue, BLK_DEFAULT_CMD_TIMEOUT);
 }
 
 /* Must be called with config_lock held */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d3afea47ade6..e50a9a5356d3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -378,6 +378,8 @@ static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
 
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+#define BLK_DEFAULT_CMD_TIMEOUT	(30*HZ) /* 30 seconds */
+
 struct request_queue {
 	struct request		*last_merge;
 	struct elevator_queue	*elevator;
-- 
2.31.1

