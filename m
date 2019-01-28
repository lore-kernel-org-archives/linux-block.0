Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608FBC282CD
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCF621738
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TyxyrdsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfA1Vfu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:35:50 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33658 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfA1Vft (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 16:35:49 -0500
Received: by mail-it1-f195.google.com with SMTP id m8so12005775itk.0
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 13:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/hv74R61uSx6qH8M6q4G3Wff9psoZdekyLR18O4KJGE=;
        b=TyxyrdsYeb+20XofMf+SB/iIm173iyQzMVAYJFCH2DBcpuVQQRX0I64AgvG5POjNu6
         UFHDjUsa2sqGDdCAWpRBtyuzxEQxbP2ABAspIrmzWiExMrw+8v/bKIc96jv7Ydymx9HV
         eF8TElqUzhHWbLL1hSxF/v8KbhjPSZ+yWXs+HfbJChUH0plb8WUUKilCl2cXMAS3NkcP
         tD71HZ1D2Diz1/wgTdhR0giJvEitDj+iHXktdjj7M+7P1BoMc4PiC22Erdw4d5aJAONE
         Gd4/mBNevKz8s1qcMS1gmpwwSAY7WVI+LkGBC0/zH1VO3BfE4WKZFWrdOvCFNO2o7Gjx
         51FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/hv74R61uSx6qH8M6q4G3Wff9psoZdekyLR18O4KJGE=;
        b=izyd5RBhW/QecR78jp0lrEFQeL9rU4y/yS8Z7wD5oN1t81/UeSO3gWAV+ye+SJ7ly8
         Gqr+kIuLgSfD9XTuTs0CRVQWGf40alzwmeAk0FxPu1c5GfcKQFNuKCa2WgCz0QfYhtqx
         eleZh/PCUl8fzF1iIs+ftI39FU+k9f8WFuEgUtnvixf/FEyFVQCJFeqacaiAb41jGJNI
         Yjs4vR7cVRXNBcdLJ2bxo7R2QYjXlY2wcKhPRQZUhLUzwoIj4BNFleX7TaplH8iCYbXD
         0HUoHaaC/6BreVzitKRYWraLntu1TAlVJWqGRRIwuCRTpjr4w7wNbXzG1ptvJ/kcZVOH
         uW8g==
X-Gm-Message-State: AJcUukc9aeF/Pebfanzx7+uI86niHD9PVv8Vc2gMsjtSiWWUJeB6f+vU
        LHZUGfuFUJ9eNFBxWUmFZ/x7+g==
X-Google-Smtp-Source: ALg8bN5Ck1AFGMOuLAxXKU+ESG4B9bCX527pz6ToI/Vzu3LYpl4PGYwQy++4FDJWCroAK2CR0QvGsg==
X-Received: by 2002:a02:708e:: with SMTP id f136mr14365972jac.118.1548711348385;
        Mon, 28 Jan 2019 13:35:48 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u25sm13782077iob.23.2019.01.28.13.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:35:47 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/18] block: wire up block device iopoll method
Date:   Mon, 28 Jan 2019 14:35:22 -0700
Message-Id: <20190128213538.13486-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128213538.13486-1-axboe@kernel.dk>
References: <20190128213538.13486-1-axboe@kernel.dk>
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

