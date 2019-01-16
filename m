Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07DEC43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 17:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FAE2082F
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 17:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="03RZwsI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfAPRuQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:50:16 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44375 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfAPRuQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 12:50:16 -0500
Received: by mail-io1-f65.google.com with SMTP id r200so5546090iod.11
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 09:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IbkWyHpTil5Vluy4ET88nT33hqg2kUPldnzNz+Wucw8=;
        b=03RZwsI0VTaQeXxlG9riS8jLgHxxhudxawPtWLsHtkr/CrEp7k6g7/cpg8993DwxvH
         Jj2anr8bJUpa9pmbNlN8EoeSObWlcjk2AGbymOgrHkiyXYDDizVaj/gmoqarq90Av/PX
         1xxr05ki7S9lO4xfkdRA/l3EHSemq2eXf57PgmhsgRjmaNjJWZDHvnaZGKedXM/pSjtZ
         Znjn1f11qBCIn4grK0E4ES/DfxOfJWCAKkjvqVsJmc5slmW0+w4hnmB8Z1l2dCOSuHIO
         0p5mEzVcl9xz0JhGVApYuPEytd/oxCuQZXxqBGzhdYlFSF8zx/TWwY51zqLAzIScIHBx
         Ud5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IbkWyHpTil5Vluy4ET88nT33hqg2kUPldnzNz+Wucw8=;
        b=GuF2+y3Eh2Ch/i2rO6VqfumaXrHjdnbtKRQqMuyDxi9MVOLlo2zB1oHaZUeuZOn8aA
         0hmXgOe1ju2dGJfG3T6HqTvhGKt4nayoxa6DtVzJdXWhdBmmU0IMk8NsAxnrgbtFDjG9
         Dcm3yWh/PsPKdrVrSUljm0TOogv2iEjjAgK6L01VybluzMxAgY91usofkChV3yCDeyqo
         mSE5Km5IGg0PHzjGjqO6H7UuG5Wj8jyLPVR+zZwd5v5TyccUrVAptffrOuYjecMMKE8W
         SH2dPjWYGIB9PkJewNYuH+WCwWK677PPtylUM0SIwcy/WhtgcXjqtU3j1GVef1GjoDJ0
         N5uw==
X-Gm-Message-State: AJcUukfxi82xYGK4sYlY3p/6mNe0BuYVmilGJNjjdiKR1mLWIeKhi9pa
        jEzuOdrMpHQVGIVsOJQn/PkJtw==
X-Google-Smtp-Source: ALg8bN6pO7dzG78Pzm3NKM+9GzunYbvzqO9ld+2Gr/8d/1MnNsKhyBdXzr+/fa0xzAnFP5lCU9FspA==
X-Received: by 2002:a6b:7942:: with SMTP id j2mr5357166iop.71.1547661015097;
        Wed, 16 Jan 2019 09:50:15 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x128sm3705690itb.8.2019.01.16.09.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 09:50:14 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/15] block: wire up block device iopoll method
Date:   Wed, 16 Jan 2019 10:49:50 -0700
Message-Id: <20190116175003.17880-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190116175003.17880-1-axboe@kernel.dk>
References: <20190116175003.17880-1-axboe@kernel.dk>
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

