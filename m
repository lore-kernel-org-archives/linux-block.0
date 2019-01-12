Return-Path: <SRS0=tPwK=PU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C771C43387
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF4E20872
	for <linux-block@archiver.kernel.org>; Sat, 12 Jan 2019 21:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hEwFXZQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfALVaZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:30:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37420 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfALVaY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Jan 2019 16:30:24 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so7799902pgb.4
        for <linux-block@vger.kernel.org>; Sat, 12 Jan 2019 13:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IbkWyHpTil5Vluy4ET88nT33hqg2kUPldnzNz+Wucw8=;
        b=hEwFXZQtjXrOzXhD4Yz0yWcj8gFtgx2EWPEeNFcgu9qrhvQ0sdYdtUfb+ahkkLHiSu
         xO1HhJX+Qm/Eq5aNGzM0DlqgV9TWFSKaKFqiUCZxrlohyK6zELYUQ1JYmiQ+N3PA72lx
         cQgWw20iM6ZC1vxVVyaLcOxzxaZJkmFxqDkkaKvv1Lm0q/ht3yaGvVJUwVJEFo/Ygtsa
         QbcnoNTr2DbdBS8x6iBuYzhasVsKs6EjFWTxD4RTY4QTJ3yM3AXv1S1hqsottdSTTr+D
         d8RyuKnM3uPN9ztuho2m8MnVx2pLogGGkEp85iUw6qIMX3v6pBsnBwnKGSHAnWNP5Lch
         0cKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IbkWyHpTil5Vluy4ET88nT33hqg2kUPldnzNz+Wucw8=;
        b=UO9vR3hPSCloPp/hp4zuuF2QG3++bRttGv7otJnGc/eJUI62cKLPHrqazqk4LdIFDR
         2tTqGDz1hAwEPy9zXno99klgXYr9qpKdW16Wj0inapLxFifNTcQ1ka1I/CfU2o7d9eXR
         MWeBSl0ZgFd1tvQ7/Ad6Qj83HHa53ndVQLgdK//sqtzl2d7Yjlgc9HxSjJjYowg8a4tk
         d9cVcXhOAo9hwPO0w/v+ctPsjO1xCOKIO9+yJSK/W8dZKhvBcZpfyvhHXXyPrT7DEZsy
         ddCcLwv29dum6BJk4wTgDpXCHrr/TZk+iV+C9qu8SJhTbLVRYG8/0ia/YP436DRQ6QMH
         tjOw==
X-Gm-Message-State: AJcUukcMHd+lfzXaYa7EqqS0otScxFatKuVpQUx2sqhcxtw2KS5Q+sdU
        mnvEKAnh79bMVkN8hqSqFDE8wQ==
X-Google-Smtp-Source: ALg8bN6gkCrheGgHX73DQ7wTT8lxPShgYnnFvASqs6aBuQzj6C3BXNp0GksNuI9UsfbrPgwBBMbL4A==
X-Received: by 2002:a63:e051:: with SMTP id n17mr7848083pgj.258.1547328623477;
        Sat, 12 Jan 2019 13:30:23 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y6sm151629818pfd.104.2019.01.12.13.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 13:30:22 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/16] block: wire up block device iopoll method
Date:   Sat, 12 Jan 2019 14:29:57 -0700
Message-Id: <20190112213011.1439-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190112213011.1439-1-axboe@kernel.dk>
References: <20190112213011.1439-1-axboe@kernel.dk>
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

