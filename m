Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB23C282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09BB218EA
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hjfy/RNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfBAPYY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:24:24 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38765 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfBAPYY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 10:24:24 -0500
Received: by mail-io1-f66.google.com with SMTP id l14so5977602ioj.5
        for <linux-block@vger.kernel.org>; Fri, 01 Feb 2019 07:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/hv74R61uSx6qH8M6q4G3Wff9psoZdekyLR18O4KJGE=;
        b=hjfy/RNljyrSxjerk8HMLVgQK6jQrl3tTOgu7DWIB4dC6VrBwFy2XfQStcj+rNAHlx
         8h8geYLDEwSfwYA33NYc8ypT73lCD4V6D8iF1og8Xyn+kIehiHicHXUr0nUJgD7ZI5Ol
         O2ql3LDRhSJaPw+37l8RM6KYNNiPdNwiIiuVbfFO5gNu53o5eJZViAHorDAlScMP3Gn9
         JwyFT25TIe7Fj7YoVsBuEYwYMJtN3pvcmDLnc3NmXjifPbAwKF725YhHVf4L4WwkOyrD
         ZH+r0wSMEjm/5g5qVj8RizM1MC7CGVBHERLFl1Q3nWX8x6lWaDFddIVNvjz0lpS+ITTZ
         jXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/hv74R61uSx6qH8M6q4G3Wff9psoZdekyLR18O4KJGE=;
        b=T/X/uQCM40f9EW1ZTXhfSaj50UC5N2eGJzQkZWeyCjERTQ+2R9vtkqmWNN+5PCKq36
         Jk5alKf7gvlEntxY+6iG0nP3F6gXgmqSqoWouzVNTzblggCok8pEwQJbckNIrDdJrBTU
         2gwpjB7maE4wa6uPlKtTkDIjonXkz3KwejQQksBkiR9P5d9GdRQ0RY5st3dm49De4FEf
         PYHzLcOVArgbZEvdPkVLOZqQAYOg+wsRDHZCIsKIj1tPW0n7cp/yrLkCwImY6L48QSwe
         8N7Ciu/Z/W2ipkCg5EnBLocqi4nCgFv7zhZaeOfb0LEvaP2Hv7C09PAz9JUmHEgKeeqa
         eeBQ==
X-Gm-Message-State: AHQUAuayGAARCxa1YLbgX5tgbFa7D29700A0jsToL3gq2whhW9tlwtm6
        igVVuy/NknFsOiiFjfhizvO4pw==
X-Google-Smtp-Source: AHgI3IbQuWHlMt1tiDgJh5LFicOzgRojgNF/Qz8oeW4SN0ZNF75aGCbb6s/CnkrnmiBTNLprC/JuhA==
X-Received: by 2002:a5d:954e:: with SMTP id a14mr9040592ios.176.1549034662928;
        Fri, 01 Feb 2019 07:24:22 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t6sm3388898ioc.87.2019.02.01.07.24.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:24:21 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/18] block: wire up block device iopoll method
Date:   Fri,  1 Feb 2019 08:23:58 -0700
Message-Id: <20190201152414.23296-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201152414.23296-1-axboe@kernel.dk>
References: <20190201152414.23296-1-axboe@kernel.dk>
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

