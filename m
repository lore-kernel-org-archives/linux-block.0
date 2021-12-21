Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FA0C433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 14:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbhLUOQl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 09:16:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237889AbhLUOQl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 09:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640096200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lpPzHB7hBamQXXGWKmJTzrOZB3nWlieMNuYyy0Jc2C4=;
        b=BFN0GQCO5X8g2i3OAmbML7bNi3LDvMqAgBcI6p7KRQwh4dvtoDflxS4BE1MPIFSnFFohTp
        tGyA3OAtpiGAaLjB+GTx15Oi2qRFKxmHSc8CVctc65BbHURP39kf73BQGzJeeVqa4k3Zpz
        44v+5gOm/Gj9OVht2wpu4X1w0uW9iUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-0N-z0Yw8ON-5xnbD-YNp-w-1; Tue, 21 Dec 2021 09:16:37 -0500
X-MC-Unique: 0N-z0Yw8ON-5xnbD-YNp-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F8C21006AA0;
        Tue, 21 Dec 2021 14:16:36 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C56AF519BA;
        Tue, 21 Dec 2021 14:16:05 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/3] block: add blk_alloc_disk_srcu
Date:   Tue, 21 Dec 2021 22:14:58 +0800
Message-Id: <20211221141459.1368176-3-ming.lei@redhat.com>
In-Reply-To: <20211221141459.1368176-1-ming.lei@redhat.com>
References: <20211221141459.1368176-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add blk_alloc_disk_srcu() so that we can allocate srcu inside request queue
for supporting blocking ->queue_rq().

dm-rq needs this API.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/genhd.c         |  5 +++--
 include/linux/genhd.h | 12 ++++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 3c139a1b6f04..d21786fbb7bb 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1333,12 +1333,13 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 }
 EXPORT_SYMBOL(__alloc_disk_node);
 
-struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass)
+struct gendisk *__blk_alloc_disk(int node, bool alloc_srcu,
+		struct lock_class_key *lkclass)
 {
 	struct request_queue *q;
 	struct gendisk *disk;
 
-	q = blk_alloc_queue(node, false);
+	q = blk_alloc_queue(node, alloc_srcu);
 	if (!q)
 		return NULL;
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 6906a45bc761..20259340b962 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -227,23 +227,27 @@ void blk_drop_partitions(struct gendisk *disk);
 struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 		struct lock_class_key *lkclass);
 extern void put_disk(struct gendisk *disk);
-struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass);
+struct gendisk *__blk_alloc_disk(int node, bool alloc_srcu,
+		struct lock_class_key *lkclass);
 
 /**
- * blk_alloc_disk - allocate a gendisk structure
+ * __alloc_disk - allocate a gendisk structure
  * @node_id: numa node to allocate on
+ * @alloc_srcu: allocate srcu instance for supporting blocking ->queue_rq
  *
  * Allocate and pre-initialize a gendisk structure for use with BIO based
  * drivers.
  *
  * Context: can sleep
  */
-#define blk_alloc_disk(node_id)						\
+#define __alloc_disk(node_id, alloc_srcu)				\
 ({									\
 	static struct lock_class_key __key;				\
 									\
-	__blk_alloc_disk(node_id, &__key);				\
+	__blk_alloc_disk(node_id, alloc_srcu, &__key);			\
 })
+#define blk_alloc_disk(node_id) __alloc_disk(node_id, false)
+#define blk_alloc_disk_srcu(node_id) __alloc_disk(node_id, true)
 void blk_cleanup_disk(struct gendisk *disk);
 
 int __register_blkdev(unsigned int major, const char *name,
-- 
2.31.1

