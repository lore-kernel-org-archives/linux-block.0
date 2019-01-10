Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F35C43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 02:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C392173B
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 02:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ON2LCZDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfAJCoS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:44:18 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37824 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfAJCoR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 21:44:17 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so4607065pfb.4
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 18:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IbkWyHpTil5Vluy4ET88nT33hqg2kUPldnzNz+Wucw8=;
        b=ON2LCZDf+FhqrSMU/mPaA0e8okl+JMjzrfIfkWRDv+z1ql2ZDeKwFX9RUuY2FsTBlE
         +Jpxk0LYI4zAyng1FALK3xuNDoqtDX74UAq6mKnlA0qwKKANMC7FnLDyeMrxsfj2I308
         a8c3zUiIi9QZjK4b2Qkg5yXOS4HVlg9jKHdIbTdSETM4qxTcDSAGBVP+mksBkkhsr2r1
         qz/0ntVJpn04l8+ckvgpWg4pET0OGXZb8209gn30+kdYup7I4V6VwlKdRddKgEedovZL
         5hZbLbWNMJqobLiBE9r5yr1PUQnc31Wtwy7rGF2amNpi07wpqo7H6m0kak6X0nbcMKKn
         BWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IbkWyHpTil5Vluy4ET88nT33hqg2kUPldnzNz+Wucw8=;
        b=m8sfVMzJ3z2FRqYwezeUM5a/XhVllDTWoReQDLeT4jhx31qPy4hBEw5hM4AVolVxRH
         k2jJa4yUm1LmPmY7VXYuLPA8VFtc1rdAXhOIwgI2X8upRLw4qX4tq5onJFLrcZE4x/Gi
         splJ/cugZZpzdPL1f3m4r5FRAW3PqYu1D41kniGP6zbcpfmoB6SWovxt15bIrDBDvBC8
         SBH1NSkVmB2gfRQSU3yayOH2gCwJJ6sbViVGG7Br5YbKPvcIdkAsEoBZ6zbo/FYrAUSD
         5c+Y28EiHp6l+pDm9bcKKFXHTyQitlxAulL/y4GyaJpqvRrlGAcwhwE6Woz9CMIkN2ul
         iqVA==
X-Gm-Message-State: AJcUukftXSv+JKfIx5wHJV2CxLsN0Y9umWPNa39bUGxBnishMMBRy0SQ
        MrjPvcoNpjxr8aTqH09S+kONLg==
X-Google-Smtp-Source: ALg8bN5dLSohnTTe1jwXROKs3eQ/MVzwnrM9Xp59Wh+JL6mWBlPGO+F5gV+EjnTr91A2sziO0yga8g==
X-Received: by 2002:a62:16d6:: with SMTP id 205mr8412416pfw.256.1547088257039;
        Wed, 09 Jan 2019 18:44:17 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v15sm105799631pfn.94.2019.01.09.18.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 18:44:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/15] block: wire up block device iopoll method
Date:   Wed,  9 Jan 2019 19:43:51 -0700
Message-Id: <20190110024404.25372-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110024404.25372-1-axboe@kernel.dk>
References: <20190110024404.25372-1-axboe@kernel.dk>
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

