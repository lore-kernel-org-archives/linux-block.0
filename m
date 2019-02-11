Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56C3C282CE
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 19:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916D020863
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 19:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Z4ozwC/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733254AbfBKTBA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:01:00 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51592 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbfBKTA7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 14:00:59 -0500
Received: by mail-it1-f196.google.com with SMTP id y184so922081itc.1
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 11:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g1khetRWDSOe+fsRbjBpFbSMReoIe0SnrK1N2gfwJWc=;
        b=Z4ozwC/7X3SSM/0mGl+KD3mBBUVWxelJ7dxptlPZ8Mr2gqn/f/BHdq6c90kPeoVGah
         u4xqH26pCCgVSoD5Vl33SyroJh7gWiyQh+4z9KkRngUxr7WxvuO8+ICE/+NM6HaWaRpI
         QVeHm+0o8ImB1PF9mZbWNzbAPlEpHEI4PXWfher88IFaRUtgpbJ0YHXbINPUm4KxU9Ot
         SWILECtiW939Z1KdrcRDIRriqZEiThIxtcMkGzh/NXQ4z0KzGuPehySFrtUeEBc0m7GP
         1Y8wh6I3nwF8QCLrT83gO/zsY0sF220zo15a0bZevhtdzCQfXVSkkVezr9qg82Vfi4tW
         ckhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g1khetRWDSOe+fsRbjBpFbSMReoIe0SnrK1N2gfwJWc=;
        b=ZiiVxXu0Tqc5hLxCQit5id0e6jZ4kks71se4AOCexPovyWtOrE+JbL+NP4dDnA/uGS
         EyZdLY8MaKlexPYqZMj6arqkNpoNMDTYeMxub5gqMpJ0v+WT4jWpPE6DHbNYYfJtyipT
         H8XGlrJGLzIDMYhdQcrxxqgLb4Rf8UcbrU/ULUtJTrosVtTgddZT0Zw1VbvAJ2dr2Kg3
         hkMtzqoCIFubAF/UO6nJtOTQUmXaFZnhSAW7fzATJ9Iw3gyLpD9cfj3/uT4gz6hnxtrL
         /PYwyarRu64vdWWu+9apNsEXIaDE1I1EehX7m3YTvYtdWefz3B3NbzxdjvdUF2CAKSWw
         AR0Q==
X-Gm-Message-State: AHQUAua04pQGq2WQfJPMjomkrrdTSuZo5vEH79KBVsP4HcOK+CJkTCHT
        T2gp5QILpqGMxWBFuzmf4xbjbA==
X-Google-Smtp-Source: AHgI3IaYT7vh/P9qYoqj3E7lreeSHrbk1T+P+BNBixkUttvDIoxjZQAVxerp7En0RDRJP9sfCI0m/g==
X-Received: by 2002:a6b:7517:: with SMTP id l23mr7791058ioh.74.1549911658990;
        Mon, 11 Feb 2019 11:00:58 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h184sm62446ith.41.2019.02.11.11.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:00:58 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/19] block: wire up block device iopoll method
Date:   Mon, 11 Feb 2019 12:00:32 -0700
Message-Id: <20190211190049.7888-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211190049.7888-1-axboe@kernel.dk>
References: <20190211190049.7888-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Just call blk_poll on the iocb cookie, we can derive the block device
from the inode trivially.

Reviewed-by: Hannes Reinecke <hare@suse.com>
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

