Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB667C433FE
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 14:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC8F3610D0
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 14:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhJNOG2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 10:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhJNOGZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 10:06:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D537C061570;
        Thu, 14 Oct 2021 07:04:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i12so19859325wrb.7;
        Thu, 14 Oct 2021 07:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qu3wfbcbDBRoEiFSBFw8GNfAxgn5icQsmAb4gNPUck=;
        b=NtF+pXe9D9jiV9qdP2lV6TFfAT0Qh/N+Ys7vjDDKXItwxpgTY/GppMkEpzY9F+HHhz
         06bem6LC4L6M2QeU/7DoetBOmKhRwzzDjptKK2n8bCopcbg0SBGX6HJxbXkdsPdpJJ2N
         oWy+nJiHj9nlCXh3vP8xxVrdZPQAPpB/AQM3jU/nVLn4Ss5FhJ0n0E3pIUJ3oMhBSyH6
         Gvfz15tQD8c5pxTLHFiAEo24pREqScIp3ZQjG6dA7wDIRU3r0NGRSt1eEjT55OgQ1FyD
         p7yh9Vm5URC5f59Qc6vXTUXjivYmjRGHETwUrxNAlqNMqnjpwRRz1Tr18XNyODOmcgdF
         k/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qu3wfbcbDBRoEiFSBFw8GNfAxgn5icQsmAb4gNPUck=;
        b=GwenpC3jbIjttCKfDWe0FzkuZFZIAB0xnWsMiFG/Rg5UBr+zhV1ftOY+vdyDZVGvJH
         Yr/cL64bRITdcag83ffdkIr1wSz//2m7gmiO6T9oSL6TZvvTzIhXh7WaGvPAYmppDL+c
         WS1WqwwM06V3Op2tHUFDI9v0FLmABiLEWCjFVWmKTtOZYnsUBVjjWiOlnc9l3U1p6laO
         pHT5u++/B1xRWY0zzkJYRUc3tJLYTavCRdXmvXdCQSv6xUL3FUOAwgWU0bOo9YVPXOhp
         fzu0Tn6XUljZbuSA4NzoTysXo5xuV6HTrwlEmMTr/Bafw4dVLM7LABMzy9NcCk67Ldkd
         4NZw==
X-Gm-Message-State: AOAM5317tqpMEhgZ/zDc/ICfnx78ZNGYIcoR/yDVqpSBk5/n6lr69dMS
        bWbfrYsmy6/DK1HND+aaP1WtIx4gsbI=
X-Google-Smtp-Source: ABdhPJyZDmi78ck2x8xyMR/imlvRg/M//3eJTrZDeHDYFifeem5IYpO0NVHJOEEGtudeHtfuadpPZg==
X-Received: by 2002:a5d:6dad:: with SMTP id u13mr6914930wrs.370.1634220259039;
        Thu, 14 Oct 2021 07:04:19 -0700 (PDT)
Received: from localhost.localdomain ([185.69.145.214])
        by smtp.gmail.com with ESMTPSA id p8sm2273461wmg.15.2021.10.14.07.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:04:18 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>, asml.silence@gmail.com
Subject: [PATCH 3/5] block: use bdev_get_queue() in bio.c
Date:   Thu, 14 Oct 2021 15:03:28 +0100
Message-Id: <85c36ea784d285a5075baa10049e6b59e15fb484.1634219547.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1634219547.git.asml.silence@gmail.com>
References: <cover.1634219547.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Convert bdev->bd_disk->queue to bdev_get_queue(), it's uses a cached
queue pointer and so is fater.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 7377fc93606a..fb3704a61e07 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -910,7 +910,7 @@ EXPORT_SYMBOL(bio_add_pc_page);
 int bio_add_zone_append_page(struct bio *bio, struct page *page,
 			     unsigned int len, unsigned int offset)
 {
-	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	bool same_page = false;
 
 	if (WARN_ON_ONCE(bio_op(bio) != REQ_OP_ZONE_APPEND))
@@ -1054,7 +1054,7 @@ static int bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 
 static int bio_iov_bvec_set_append(struct bio *bio, struct iov_iter *iter)
 {
-	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	struct iov_iter i = *iter;
 
 	iov_iter_truncate(&i, queue_max_zone_append_sectors(q) << 9);
@@ -1132,7 +1132,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
 {
 	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
 	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
-	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	unsigned int max_append_sectors = queue_max_zone_append_sectors(q);
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
@@ -1469,10 +1469,10 @@ void bio_endio(struct bio *bio)
 		return;
 
 	if (bio->bi_bdev && bio_flagged(bio, BIO_TRACKED))
-		rq_qos_done_bio(bio->bi_bdev->bd_disk->queue, bio);
+		rq_qos_done_bio(bdev_get_queue(bio->bi_bdev), bio);
 
 	if (bio->bi_bdev && bio_flagged(bio, BIO_TRACE_COMPLETION)) {
-		trace_block_bio_complete(bio->bi_bdev->bd_disk->queue, bio);
+		trace_block_bio_complete(bdev_get_queue(bio->bi_bdev), bio);
 		bio_clear_flag(bio, BIO_TRACE_COMPLETION);
 	}
 
-- 
2.33.0

