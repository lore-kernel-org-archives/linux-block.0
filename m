Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E619CC04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A727820878
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wPBjiib/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A727820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbeLDXho (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:37:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41240 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbeLDXho (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:37:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so9064943plm.8
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eJ3aWzBT4gm4FwYHYUV1JBWUWsiFyJVaotzVIFD6bng=;
        b=wPBjiib/AjwVUwGJ8Lj5+r5OfUcoMGHUL3c3C2u3/Vn3Vducqv3jAJEiEW8fIUU6R+
         2iTHG1CSQSlEMtijEzm9YarsbbSdzsn/KtPXXzOBMrRXHAzw03cMwxcGaNMmUbKmQCMr
         TgS+An6DJrpU2gTFLW2AZS3aw3tWZJAWAEnVCAoEiIEZc/s5qlQZF4Q2FMjTDjTJnyWd
         hzABWFT78uNa+cwEzAE/5EsSU1Tz3jBZr/GYFYFCdZoU6cH9pegXWYdND9wp+0A9s0rD
         A6nDu0B07HWgQdLFsOO/+UKAFsQ9GKQBx5ExC2gcdQPKgm5+GWrLBzioapfM5tJCT0H/
         Jx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eJ3aWzBT4gm4FwYHYUV1JBWUWsiFyJVaotzVIFD6bng=;
        b=XHTf+GL9iIHJzZ2Gxxi/Sj9HucW1uCBnnwqmF0uQ2QkdjWP2uL44QlqTp1u+MF2oty
         pMwPLIg9Hh7idZWbMeYdeSPtkygYW3e7cD4wzARVnxwH1EqnOXJyQBN3ctJmyUIJXgex
         GK5rot7Z0i7yblnw5M23WZPd/X7GL1sdmOo6GvZMDYedmBn8Us0SYEcYqY/0uMU8A5BH
         EdNyATr1GpOu3BXjkF8J4I82Ry+iAXrUzC/TdV5vwACh2GcrQfj5RgP61qyQO7p+bcBT
         hmyNDIAZfPY/qjxlqYvBLM1Qys8plGB1Pz4hOVLAWILlqPWl8SXYl1qv8kf4evilQ0ZK
         F89g==
X-Gm-Message-State: AA+aEWbSCHJE/YBvSjTmieGPGmqjpj6buJdv+UK3w5k6701Na9vR/Mpn
        7S82p17qeGmp9iiEobYvZA5Lp9bvhYU=
X-Google-Smtp-Source: AFSGD/V86QrCPgAdBchJQQz7hOU1x9SJhRs1OCI9da1EDCeCoh6DTnTxrl+TeHAZGced5LMzX9kt7g==
X-Received: by 2002:a17:902:1008:: with SMTP id b8mr21275265pla.252.1543966663256;
        Tue, 04 Dec 2018 15:37:43 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:37:42 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/26] block: wire up block device iopoll method
Date:   Tue,  4 Dec 2018 16:37:06 -0700
Message-Id: <20181204233729.26776-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
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
index e1886cc7048f..6de8d35f6e41 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -281,6 +281,14 @@ struct blkdev_dio {
 
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
@@ -398,6 +406,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 				bio->bi_opf |= REQ_HIPRI;
 
 			qc = submit_bio(bio);
+			WRITE_ONCE(iocb->ki_cookie, qc);
 			break;
 		}
 
@@ -2070,6 +2079,7 @@ const struct file_operations def_blk_fops = {
 	.llseek		= block_llseek,
 	.read_iter	= blkdev_read_iter,
 	.write_iter	= blkdev_write_iter,
+	.iopoll		= blkdev_iopoll,
 	.mmap		= generic_file_mmap,
 	.fsync		= blkdev_fsync,
 	.unlocked_ioctl	= block_ioctl,
-- 
2.17.1

