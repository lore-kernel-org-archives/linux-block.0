Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654D0C77B73
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 15:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjDTPmb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjDTPm0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 11:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F17D5251
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 08:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682005292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92twkPxGd5T574eTL5Yh2cPAApi82Wy5O16krM4Zwow=;
        b=CoeCAc8OO6qOuGepH10IgylUF/vpPTSgxlMb/KXfldW9LriKRikshrzmRUiMIhfwKwUbBQ
        QtkT/RtHsrp3oQWZ4dG0i2PdC+Tt8mP0Q+JZ9HfkfyeUGRWg2/JhEg+/DDmrEON++VqWjV
        jTyevk5A3eAmk/ZEnzNVEjNvHHsUpYY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-Zgu_UCK4MJyl62fbt446dg-1; Thu, 20 Apr 2023 11:41:31 -0400
X-MC-Unique: Zgu_UCK4MJyl62fbt446dg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC3C02A59552;
        Thu, 20 Apr 2023 15:41:30 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0757492B05;
        Thu, 20 Apr 2023 15:41:29 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/7] ublk: support to copy any part of request pages
Date:   Thu, 20 Apr 2023 23:40:30 +0800
Message-Id: <20230420154032.1272836-6-ming.lei@redhat.com>
In-Reply-To: <20230420154032.1272836-1-ming.lei@redhat.com>
References: <20230420154032.1272836-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add 'offset' to 'struct ublk_map_data', so that ublk_copy_user_pages()
can be used to copy any sub-buffer(linear mapped) of the request.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 11ce55f0c395..7d21ee22e503 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -504,19 +504,36 @@ static void ublk_copy_io_pages(struct ublk_io_iter *data,
 	}
 }
 
+static bool ublk_advance_io_iter(const struct request *req,
+		struct ublk_io_iter *iter, unsigned int offset)
+{
+	struct bio *bio = req->bio;
+
+	for_each_bio(bio) {
+		if (bio->bi_iter.bi_size > offset) {
+			iter->bio = bio;
+			iter->iter = bio->bi_iter;
+			bio_advance_iter(iter->bio, &iter->iter, offset);
+			return true;
+		}
+		offset -= bio->bi_iter.bi_size;
+	}
+	return false;
+}
+
 /*
  * Copy data between request pages and io_iter, and 'offset'
  * is the start point of linear offset of request.
  */
 static size_t ublk_copy_user_pages(const struct request *req,
-		struct iov_iter *uiter, int dir)
+		unsigned offset, struct iov_iter *uiter, int dir)
 {
-	struct ublk_io_iter iter = {
-		.bio	= req->bio,
-		.iter	= req->bio->bi_iter,
-	};
+	struct ublk_io_iter iter;
 	size_t done = 0;
 
+	if (!ublk_advance_io_iter(req, &iter, offset))
+		return 0;
+
 	while (iov_iter_count(uiter) && iter.bio) {
 		unsigned nr_pages;
 		size_t len, off;
@@ -569,7 +586,7 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 		import_single_range(dir, u64_to_user_ptr(io->addr), rq_bytes,
 				&iov, &iter);
 
-		return ublk_copy_user_pages(req, &iter, dir);
+		return ublk_copy_user_pages(req, 0, &iter, dir);
 	}
 	return rq_bytes;
 }
@@ -589,7 +606,7 @@ static int ublk_unmap_io(const struct ublk_queue *ubq,
 
 		import_single_range(dir, u64_to_user_ptr(io->addr), io->res,
 				&iov, &iter);
-		return ublk_copy_user_pages(req, &iter, dir);
+		return ublk_copy_user_pages(req, 0, &iter, dir);
 	}
 	return rq_bytes;
 }
-- 
2.39.2

