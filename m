Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635E8C38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 08:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36697208D6
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 08:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7aT43h3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgEHISq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 04:18:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54496 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726797AbgEHISq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 04:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588925925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HANsaHy1dU2Rb19yMO1lq4mAO9YTPKvRylOPeyN4Yj0=;
        b=W7aT43h39n00CMRUhB2IMbX4w8q4meleorse2QNOWFjAE/Ftk+O1G0OEiZyJCNQSRC5BQn
        MXIAEiinGo8pi2JotA2QEcjvqtZ3CNG7rVHg0HEYsMVY7/yCD7qRRmIHMbn1lIX4b4RKYH
        JoYweIUHzIwcSDVRYm0NptHi34QYou4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-2kv-ly3vORq6mnEsmyAAfA-1; Fri, 08 May 2020 04:18:39 -0400
X-MC-Unique: 2kv-ly3vORq6mnEsmyAAfA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47FFA107ACF3;
        Fri,  8 May 2020 08:18:38 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B88A6F428;
        Fri,  8 May 2020 08:18:34 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH V3 4/4] block: don't hold part0's refcount in IO path
Date:   Fri,  8 May 2020 16:17:58 +0800
Message-Id: <20200508081758.1380673-5-ming.lei@redhat.com>
In-Reply-To: <20200508081758.1380673-1-ming.lei@redhat.com>
References: <20200508081758.1380673-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

gendisk can't be gone when there is IO activity, so not hold
part0's refcount in IO path.

Cc: Yufen Yu <yuyufen@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hou Tao <houtao1@huawei.com>
Reviewed-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk.h   | 13 ++++++-------
 block/genhd.c |  4 ++--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 133fb0b99759..8efd1ca5c975 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -376,19 +376,18 @@ int bdev_resize_partition(struct block_device *bdev, int partno,
 int disk_expand_part_tbl(struct gendisk *disk, int target);
 int hd_ref_init(struct hd_struct *part);
 
-static inline void hd_struct_get(struct hd_struct *part)
-{
-	percpu_ref_get(&part->ref);
-}
-
+/* no need to get/put refcount of part0 */
 static inline int hd_struct_try_get(struct hd_struct *part)
 {
-	return percpu_ref_tryget_live(&part->ref);
+	if (part->partno)
+		return percpu_ref_tryget_live(&part->ref);
+	return 1;
 }
 
 static inline void hd_struct_put(struct hd_struct *part)
 {
-	percpu_ref_put(&part->ref);
+	if (part->partno)
+		percpu_ref_put(&part->ref);
 }
 
 static inline void hd_free_part(struct hd_struct *part)
diff --git a/block/genhd.c b/block/genhd.c
index bf8cbb033d64..d97b95d1a2fd 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -345,7 +345,8 @@ static inline int sector_in_part(struct hd_struct *part, sector_t sector)
  *
  * CONTEXT:
  * RCU read locked.  The returned partition pointer is always valid
- * because its refcount is grabbed.
+ * because its refcount is grabbed except for part0, which lifetime
+ * is same with the disk.
  *
  * RETURNS:
  * Found partition on success, part0 is returned if no partition matches
@@ -378,7 +379,6 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
 			return part;
 		}
 	}
-	hd_struct_get(&disk->part0);
 	return &disk->part0;
 }
 
-- 
2.25.2

