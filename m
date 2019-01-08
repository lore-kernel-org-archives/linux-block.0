Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6A3C43387
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F0B214C6
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WKGSsE3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfAHQ5B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:57:01 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36867 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729089AbfAHQ45 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 11:56:57 -0500
Received: by mail-io1-f68.google.com with SMTP id g8so3679957iok.4
        for <linux-block@vger.kernel.org>; Tue, 08 Jan 2019 08:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IbkWyHpTil5Vluy4ET88nT33hqg2kUPldnzNz+Wucw8=;
        b=WKGSsE3GVW9OsVc6pbFMMMUfluphyhQxm+ObcPPl00IniEBmjXgVTsgY/SXK/5gLwp
         k35Bv9lXLPJkYM/Lkqm7609uOZKMS8X6KqA8QHlo1fjF/RQ52BMfOhz/Yn2BCHNJzqpX
         CaUb7LJM0yIJFLaRuO9Jm90oU2ELqhHFWin5HhV5mgjPOONFL7UYvaekXxPSO5lRrfDE
         oOZl3BSl7+uRpwXKH3/yU74oOzwP7a+logTO72+9dmJAltHaVTrIlPTIakyJeC5ny/LA
         o9TE4Moiji6eHd2uSEIK1bg3371Ge5SR5fitPK7xeQYliH4hmNzGOksyae6ELSp73tJN
         qoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IbkWyHpTil5Vluy4ET88nT33hqg2kUPldnzNz+Wucw8=;
        b=boidMWy0gF2D9cYpl1v2AXMbA+FgIN53SsaBWNPGYK6JWx6wR4vNYEs4dsUBp5byxF
         vqM6rICz1mvEGKxnXXYAlzTHR9qZHpwXUsMWYNm4w4BDiDDCWZC2sTxFsNNwpAyaJbmP
         5mvGeGfK0IqqblFnc4RyW7B/TvwmVaY+EHTMj3xIS8itYio2E+cODldR+gnDRb6VBwYF
         jPhgMxQyH5DyIuFYgg8xEQK37vRCkA3DYlO3zN3OBl34WiWW7U5lJd8kJXdUB2pWWkxl
         MRjbXG2kxqmBxJp2n0EFZjDzzJ1YK+9/btD/RK9aVdXY1OYrIy3LA7p/cbybCBALXh5L
         tnCA==
X-Gm-Message-State: AJcUukdx/hNyIBlQHfDdp5F0+wnitAFQFMq+/QHKR1t7VgtPKi5snnqX
        x3kJX+BBUBhEhh4LEzMbq5ZkgoXskScYIg==
X-Google-Smtp-Source: ALg8bN7PK0bJChPrkEfd87P4OlBsx3bJVa6o/YBjRxu3xADa5xBLsRqOAkUDcbXSPxHO+Gr9/SoO/w==
X-Received: by 2002:a6b:b902:: with SMTP id j2mr1581017iof.220.1546966616572;
        Tue, 08 Jan 2019 08:56:56 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m10sm17563442ioq.25.2019.01.08.08.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:56:55 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/16] block: wire up block device iopoll method
Date:   Tue,  8 Jan 2019 09:56:31 -0700
Message-Id: <20190108165645.19311-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108165645.19311-1-axboe@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
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
index c546cdce77e6..5415579f3e14 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -279,6 +279,14 @@ struct blkdev_dio {
 
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
@@ -396,6 +404,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 				bio->bi_opf |= REQ_HIPRI;
 
 			qc = submit_bio(bio);
+			WRITE_ONCE(iocb->ki_cookie, qc);
 			break;
 		}
 
@@ -2068,6 +2077,7 @@ const struct file_operations def_blk_fops = {
 	.llseek		= block_llseek,
 	.read_iter	= blkdev_read_iter,
 	.write_iter	= blkdev_write_iter,
+	.iopoll		= blkdev_iopoll,
 	.mmap		= generic_file_mmap,
 	.fsync		= blkdev_fsync,
 	.unlocked_ioctl	= block_ioctl,
-- 
2.17.1

