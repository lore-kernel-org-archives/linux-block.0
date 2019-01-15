Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BD8C43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 02:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018DC206B7
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 02:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1Cwkp42p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfAOCzm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:55:42 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45937 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfAOCzl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 21:55:41 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so558061plm.12
        for <linux-block@vger.kernel.org>; Mon, 14 Jan 2019 18:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IbkWyHpTil5Vluy4ET88nT33hqg2kUPldnzNz+Wucw8=;
        b=1Cwkp42pzc3TzLpFjXri5KnMaqYwKiBgOTq0zmwo8xgPZAdG50EEO8wcpb1oUYKpp4
         2gtJiJAHu1CEEY41ldqr52/s9EtLU5a3wrlk69XdPf9MRm3cnrh9Lom4tv3eifFFcF7m
         ZuriRU5KN/NlwaiXYgqa0RgRX+CN/IJBGoyjQIIkr53H+6BW3+syTSebGtnRslOGUm6h
         6P7usXboSByNTHRRbpCencI6EIpE60JFHZyqrTjTnV3kB2LH3LuQ8XJpfE9N7K2VnhyQ
         m7eVEEz1xcIzq42nWdfPTTIifaeH4vrrtO8Lva35r6noqjjtClQP9z2S5eggZoB5Wg1+
         7gYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IbkWyHpTil5Vluy4ET88nT33hqg2kUPldnzNz+Wucw8=;
        b=njk64iQLx2F2igP9X4pj4bf7+D4R0sL8hKXC76OlYxHgMopG5xs2WTblOnuytW4YF1
         s98eOY1bZDmW+uXxvyUZ6ynlild2caYFNSvoJto4PyCW0NoeAOAI+Zpixsh7U0W6hHEG
         dMhBgC8jKgLp6KMyCZrKdX4e9dy/fOcS9JlJYJL5SHFZTT14oDNomVyAXlHJAHaePs9d
         2w4hTMjwqQhWfLR7gXLQcX2qdSAv5zSpb2fjkJUPdBw6gkDXoIrpmbvAFVjVNLVK8/BU
         ye+JVIjwpj0J2ULIDslsoKto//0z07zZV/nj8ODgYrVEZrj1ttIXD8MfEuhwak0yOiqq
         jajA==
X-Gm-Message-State: AJcUukd40sI/R1IsqKaNF1d+DCTuUAE53E3s2XVbLJMeMT08TvLwK0di
        DvqPkrcpDjV5Ss7fU8qCYwOqVQ==
X-Google-Smtp-Source: ALg8bN5dQy/eJUh933iBx5FO5OYoV3hAKueWRM3ZcQzQ4o7O1onoFCEW+tUl0uSEdzbj+zvmVsO9ZA==
X-Received: by 2002:a17:902:43e4:: with SMTP id j91mr1721514pld.147.1547520941206;
        Mon, 14 Jan 2019 18:55:41 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c23sm2415544pfi.83.2019.01.14.18.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 18:55:40 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/16] block: wire up block device iopoll method
Date:   Mon, 14 Jan 2019 19:55:17 -0700
Message-Id: <20190115025531.13985-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115025531.13985-1-axboe@kernel.dk>
References: <20190115025531.13985-1-axboe@kernel.dk>
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

