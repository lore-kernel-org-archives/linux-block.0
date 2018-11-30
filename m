Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9D9C64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E5D20867
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nX/PmpLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E5D20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeLAEGw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:06:52 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36844 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbeLAEGw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:06:52 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so10242664itj.1
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eJ3aWzBT4gm4FwYHYUV1JBWUWsiFyJVaotzVIFD6bng=;
        b=nX/PmpLduSA9mqR4VBb8drcGkVO1AAo0v/hZLs4NUHO/7xChEotTLFjbVTUCVzTmIK
         twcSpUMQ3hmX/PJI3Xq4m4wnFazExi/erEvpBFviQ59XUFCa9xC8oV3TWJBPPUUPn578
         pqOuNF7nkRF/hz6eLoQiAYwOeLcvVjqfDEhzlf55LuwxRIW/FMspJPIAAjmNdYByYVEx
         mfNokArAJaK6hAMgYKmwjXoj2nMayHi9f3zSUXOfJ6OnLjq7dOchyevxx5ZK5SXuihm+
         OMuZBL70rOIPxP04JPyd/7BLCssgmitbA4qq8LlbH2Pimv/azJ4TjiwQ1Ov0lB67nDYI
         kZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eJ3aWzBT4gm4FwYHYUV1JBWUWsiFyJVaotzVIFD6bng=;
        b=qWp7EqX+nVNPBgzZCU2pVSd01z9Zs9IfVdH4iCPjmibb9wWmLFM0kGorqfUEGrXXtO
         /1DvzrydrE6ck3Pdg0xSJ4J1CgVtpYrHIbvGScJy810wmR5rqEdTg8oa0lwWkKlXqzP8
         YakBgx2KwGR3+oJyZG1SQIHpl6EKAhSrDQhCEVIrRfxddF9dXcnC2ZVsGolv8b+icX03
         rpVDADBdELO+SFM0KVx4pW8SNWR9IDSMaM7+foW2HMVXY+udyeubjhRx0qyJulMx8QWT
         1aEeyZYgMXXxIzry6KxCkzwV1lxgH1qE6T+uKO0QDC6DVIhZP0lrehTB2sgzVpHNfgJi
         Rb8A==
X-Gm-Message-State: AA+aEWZ7oNk0PFuUOCD4+YKV2KdaOvfLe4yYGkTfaklcatBdDz9MPqB0
        GHwGoe8f50iVtQou/2YZ6YydZxc2zY0=
X-Google-Smtp-Source: AFSGD/UsLoqORr4GKEZsDyGUoXn5f2YvD82zm7qVTDqunQCW+JkUlxngTEpw9ivPa2HUUdQ7LhwZ/A==
X-Received: by 2002:a02:1e88:: with SMTP id 8mr5670956jat.108.1543597016459;
        Fri, 30 Nov 2018 08:56:56 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:56:55 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/27] block: wire up block device iopoll method
Date:   Fri, 30 Nov 2018 09:56:23 -0700
Message-Id: <20181130165646.27341-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
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

