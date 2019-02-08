Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219F7C282CC
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D1E218D4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="t9d9w6gm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfBHRej (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:34:39 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53245 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfBHRej (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 12:34:39 -0500
Received: by mail-it1-f196.google.com with SMTP id r11so5305957itc.2
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 09:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/hv74R61uSx6qH8M6q4G3Wff9psoZdekyLR18O4KJGE=;
        b=t9d9w6gmN0EShYm4ANa1KdSvTpRDYnlK+JnzWgCxudRoGNHx2S24/vL1YXZQ8rpn57
         qqr3nGKZ+3RK1z2hL1/OOKiBK3iAAB047XMZt+ej6c65ru07qVDOZzgm8esieeBt0Abo
         6VEq5wdrkVupkN3Z7rC4cVSEq5OKJunQImjedIAQr86DJbt0QR5ucwcs2Tj0Z1rQSyz6
         BI10iIZgkqBvftIuUcYmZDMNnKla6vpygKPU1ElUYxzsswYeMkhjYx4mjQiBED6yltWe
         RWV5tnp6cHrmyEUiyj0dhBcn6OR3LZlgRKTsT/bYfF5hCdJxecESSQ2TBEH+txaOaATR
         GHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/hv74R61uSx6qH8M6q4G3Wff9psoZdekyLR18O4KJGE=;
        b=e+tHUBJ0ybzfeemlpUOZKH3X4x/2wOtwXGW2yXDZLAmusgNr1vnTG74EAN88z6hm/5
         kzh6VU3++t3Hc/gLzQSyHebZzfiEfM+0nMDgCAG0bv98IZNyKQHh7KKUUDv8DJTw2WeL
         41i8u6APQmQonSbaVccP3Ifh/kGW0BuWOquYsAPIFui/ZuJtSaqoC+I6Jg1umOrRV7gD
         s3EiqMlUkxFLPdoDQ5E6lZkRgdPgubezQ682EzHNRUlzlPj7bXwlPJuvW8JZw44einwY
         +91nOFpt5XLMMvpmQGfZ5RqGw+nbdijBk+TqJp2s2rRv2fctpmrYBF+M3FXWMfJRp8WI
         yHKA==
X-Gm-Message-State: AHQUAub0gHKlPwwpoJnyb8lh9VIHNc+C8rgnDmxmmTM6+V9xguYiVgXr
        Gy3ggNIUrsa4StSVvCIMyLarK252/q40Hg==
X-Google-Smtp-Source: AHgI3IbjdybMTBErCXSrbgqj/JNZqSAwPokHmfGkuQXPIlFzUE7itiI9fsbPorE2N7IxIozdMeNkWw==
X-Received: by 2002:a24:4d05:: with SMTP id l5mr9379919itb.147.1549647277955;
        Fri, 08 Feb 2019 09:34:37 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f142sm1522627itc.15.2019.02.08.09.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:34:36 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/19] block: wire up block device iopoll method
Date:   Fri,  8 Feb 2019 10:34:06 -0700
Message-Id: <20190208173423.27014-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190208173423.27014-1-axboe@kernel.dk>
References: <20190208173423.27014-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Just call blk_poll on the iocb cookie, we can derive the block device
from the inode trivially.

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 58a4c1217fa8..f18d076a2596 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -293,6 +293,14 @@ struct blkdev_dio {
 
 static struct bio_set blkdev_dio_pool;
 
+static int blkdev_iopoll(struct kiocb *kiocb, bool wait)
+{
+	struct block_device *bdev = I_BDEV(kiocb->ki_filp->f_mapping->host);
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), wait);
+}
+
 static void blkdev_bio_end_io(struct bio *bio)
 {
 	struct blkdev_dio *dio = bio->bi_private;
@@ -410,6 +418,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 				bio->bi_opf |= REQ_HIPRI;
 
 			qc = submit_bio(bio);
+			WRITE_ONCE(iocb->ki_cookie, qc);
 			break;
 		}
 
@@ -2076,6 +2085,7 @@ const struct file_operations def_blk_fops = {
 	.llseek		= block_llseek,
 	.read_iter	= blkdev_read_iter,
 	.write_iter	= blkdev_write_iter,
+	.iopoll		= blkdev_iopoll,
 	.mmap		= generic_file_mmap,
 	.fsync		= blkdev_fsync,
 	.unlocked_ioctl	= block_ioctl,
-- 
2.17.1

