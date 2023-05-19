Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CC7C77B7A
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 06:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjESGw2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 02:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjESGw1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 02:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44456E5C
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 23:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684479068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tYrinSODbjv02I4DEIs/htgJrD9KPS1tL18oq1XjFlc=;
        b=QjhN1c5M7+b/ilL2pcM7+iS3dMShkeGanYt4dvUiC+PcmXzkfJoViO4LESJ93P3GradV6+
        E+CQlDzjDuWz0WkA0qRSyxgi70y1gQ1eKjB/MjmsLuIW3i6iSwnIlWi3G7Ez8Jb2kP0bR/
        swZD14wTskl4TeGvoiByD6bevI47/lo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-hvg_o4_jMh-OSVsjTmk8Pw-1; Fri, 19 May 2023 02:51:02 -0400
X-MC-Unique: hvg_o4_jMh-OSVsjTmk8Pw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88EA4185A7A4;
        Fri, 19 May 2023 06:51:02 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF0C12026D16;
        Fri, 19 May 2023 06:51:01 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Harris James R <james.r.harris@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 5/7] ublk: support to copy any part of request pages
Date:   Fri, 19 May 2023 14:50:28 +0800
Message-Id: <20230519065030.351216-6-ming.lei@redhat.com>
In-Reply-To: <20230519065030.351216-1-ming.lei@redhat.com>
References: <20230519065030.351216-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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
index 353ccdb60729..13523c37a165 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -505,19 +505,36 @@ static void ublk_copy_io_pages(struct ublk_io_iter *data,
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
@@ -570,7 +587,7 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 		import_single_range(dir, u64_to_user_ptr(io->addr), rq_bytes,
 				&iov, &iter);
 
-		return ublk_copy_user_pages(req, &iter, dir);
+		return ublk_copy_user_pages(req, 0, &iter, dir);
 	}
 	return rq_bytes;
 }
@@ -590,7 +607,7 @@ static int ublk_unmap_io(const struct ublk_queue *ubq,
 
 		import_single_range(dir, u64_to_user_ptr(io->addr), io->res,
 				&iov, &iter);
-		return ublk_copy_user_pages(req, &iter, dir);
+		return ublk_copy_user_pages(req, 0, &iter, dir);
 	}
 	return rq_bytes;
 }
-- 
2.40.1

