Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D44C282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A555E21855
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OyR2jGy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfAWPfq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:35:46 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34162 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfAWPfq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 10:35:46 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so1364730plz.1
        for <linux-block@vger.kernel.org>; Wed, 23 Jan 2019 07:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/hv74R61uSx6qH8M6q4G3Wff9psoZdekyLR18O4KJGE=;
        b=OyR2jGy8GKWmCU4KHGs9ZDnW4JkOKPZSVECtlEqqVLpskwoNmGZ8g9WCXURbWPef9B
         HN8w1TMKgLYOspncHvI+4j2QFhIJBKTI4g22rFy4YrMfOgXzxQR3YjtofRHrgkTq67jy
         hb6nxQVFuOy4KisNmoDFtt0g9+dEiY5XIAVgE8AL33wXB2gbmhOHcUoF1NQcklylLP+a
         rI7WIEJqf1PnBk7rEWlzIl+TvhQlAjpPQ0cFUmHVUSgV1VSee11BdmM+7PYMFA59ZXfo
         VQ+EW4a36f4iqeFoyprExmsf7xjH/nYLdssa4/FkEPo24noigyyeIVcF0YQqlqdhpNyD
         u1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/hv74R61uSx6qH8M6q4G3Wff9psoZdekyLR18O4KJGE=;
        b=osk/EVSpdY5RNapNjMO7CzNcD4pfap79E7u+tCr2u1umJGV7CDAOWftuw/06nwPLNR
         8Qa463fSJl1n9T78mLSZF8K/oYYCtG7xgO6PqtnPIvNBR+d8Wg+xvQhHjfS01c23A5Io
         oPVSNn5sD6lwwhQSzZOIoNm/H+4Rjfqjze3h5MAJI2hz9cpJdLYaTKeAyqeWAimVMqTm
         Thc1XAkkLZYzuzva39b7dUFWnc/0pQLbD+FDzGoFEusVwXz11eWU+VJVB+rRgnsSbfTB
         pH3J7a79d2MInj15e5NOLCrjSPPGwkexfevHMYGzMtWR8XAld2+ZfWEvjo+sumcSqeBb
         H/Ew==
X-Gm-Message-State: AJcUukevwvbz9XCgdjyrTInTLgX4MjIjRh8u2v61Zgu1Vi94AsGH/ZxK
        a84WuYOjWw8WflM7Ef7Kxa0KtKf7lFb1VA==
X-Google-Smtp-Source: ALg8bN45vTPFu/DGOK2VlprkMzuL7BblKMxYBCbWGXK6j1dlQJrUQsTnOZvZ5kaxlTaOFi3tP4ffBQ==
X-Received: by 2002:a17:902:b707:: with SMTP id d7mr2535035pls.29.1548257745448;
        Wed, 23 Jan 2019 07:35:45 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm30731715pfl.16.2019.01.23.07.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 07:35:44 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/18] block: wire up block device iopoll method
Date:   Wed, 23 Jan 2019 08:35:13 -0700
Message-Id: <20190123153536.7081-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123153536.7081-1-axboe@kernel.dk>
References: <20190123153536.7081-1-axboe@kernel.dk>
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

