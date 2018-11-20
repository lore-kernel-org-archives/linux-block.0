Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01320C46462
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8DF2087E
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="B6tRJglz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8DF2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbeKUDuP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:50:15 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33812 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730381AbeKUDuO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 22:50:14 -0500
Received: by mail-io1-f67.google.com with SMTP id f6so1960385iob.1
        for <linux-block@vger.kernel.org>; Tue, 20 Nov 2018 09:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ubKXGzZN20TioLBNRFOAZwYfq7mQcy6VCcL/0ltMyYI=;
        b=B6tRJglzugIT3Wi0VCFahgnAjNDGABzlhAyqpTRrmWyyTVk4y5pxbidO3VcaRTnkS8
         oAWLxQhWdO2BgR2hgMI5uo3nx973g/PqNKbfInv3iGQAAkaYlnxDSPdgfXI/cbP7MVG2
         dXbLojAc4yxg4H09qYETUHSUNq8iV/padjcz8ljBBPNdmrIcy1YQsY6QMi/IQWptRbyB
         B17FOuqK2vsI8QLlweBTcGzfXB8H6/8LNRCiuw5qZRQCJ+xb9dev6TjpseDHng+hyEiL
         akAYXbqTx54DXNSIq2dJh5q95e/yFx7vXxNrIqlpv7/Q+BKt9MZ8LYZ9Gt4eO8V9+k//
         hEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ubKXGzZN20TioLBNRFOAZwYfq7mQcy6VCcL/0ltMyYI=;
        b=BlrKvKjiWXotm5AyxXY07ZYJ+yymJklNUO4gYwWsRa96NKSf+riwx0Y3Z9NZIoAruO
         PdfqBkDNoxne5TcOZHk2whtIuF2QFmRsh6iKsYpo2dtLDqUuZf3X5KD+RN9uMS6x1UKz
         XKT9b+P3zIxi5RDFpKQ83e3+e3qrKMHBcHeMMSgGgAuAhBEbnIYJaaoM4T1KC097kv/t
         GJQKSCeVut5oEO2+1GP21JsUbgFPbvyZMMwkw8S3Nny6ZPLuHe6Hoj/j2LF/bKtJe/u5
         /EZ7SfhfTp0WW4yTVxtbXlHh1+3410dwjPsxamYOklc8Qk2g3wXs0z46SbSQHXHPbe2s
         lR/g==
X-Gm-Message-State: AA+aEWZZV6hc5vq2sCvwNEGyDiX2ASxE9SH85r4ib/zpvBcREPhwxahV
        9Lz5+mqHLPIV56JIrfhlXDcOOAg4byg=
X-Google-Smtp-Source: AFSGD/Wrc/pQ8CKOx/0vfTb3KPvmbZ5ogZcJHqFv6FHwvUJDSCkv0SO0U9+EZDTSUns65OJFOx/B9A==
X-Received: by 2002:a6b:9383:: with SMTP id v125-v6mr1896758iod.282.1542734400355;
        Tue, 20 Nov 2018 09:20:00 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 186-v6sm15751530itf.11.2018.11.20.09.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 09:19:59 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/8] block: wire up block device ->iopoll()
Date:   Tue, 20 Nov 2018 10:19:47 -0700
Message-Id: <20181120171953.1258-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120171953.1258-1-axboe@kernel.dk>
References: <20181120171953.1258-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index d233a59ea364..711cd5a3469e 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -273,6 +273,7 @@ struct blkdev_dio {
 	};
 	size_t			size;
 	atomic_t		ref;
+	blk_qc_t		qc;
 	bool			multi_bio : 1;
 	bool			should_dirty : 1;
 	bool			is_sync : 1;
@@ -281,6 +282,21 @@ struct blkdev_dio {
 
 static struct bio_set blkdev_dio_pool;
 
+static int blkdev_iopoll(struct kiocb *kiocb, bool wait)
+{
+	struct blkdev_dio *dio = READ_ONCE(kiocb->private);
+
+	/* dio can be NULL here, if the IO hasn't been submitted yet */
+	if (dio) {
+		struct block_device *bdev;
+
+		bdev = I_BDEV(kiocb->ki_filp->f_mapping->host);
+		return blk_poll(bdev_get_queue(bdev), READ_ONCE(dio->qc), wait);
+	}
+
+	return 0;
+}
+
 static void blkdev_bio_end_io(struct bio *bio)
 {
 	struct blkdev_dio *dio = bio->bi_private;
@@ -335,7 +351,6 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	bool is_poll = (iocb->ki_flags & IOCB_HIPRI) != 0;
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
 	loff_t pos = iocb->ki_pos;
-	blk_qc_t qc = BLK_QC_T_NONE;
 	int ret = 0;
 
 	if ((pos | iov_iter_alignment(iter)) &
@@ -355,6 +370,9 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	dio->size = 0;
 	dio->multi_bio = false;
 	dio->should_dirty = is_read && iter_is_iovec(iter);
+	dio->qc = BLK_QC_T_NONE;
+
+	WRITE_ONCE(iocb->private, dio);
 
 	/*
 	 * Don't plug for HIPRI/polled IO, as those should go straight
@@ -395,7 +413,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 			if (iocb->ki_flags & IOCB_HIPRI)
 				bio->bi_opf |= REQ_HIPRI;
 
-			qc = submit_bio(bio);
+			dio->qc = submit_bio(bio);
 			break;
 		}
 
@@ -423,7 +441,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 			break;
 
 		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc, true))
+		    !blk_poll(bdev_get_queue(bdev), dio->qc, true))
 			io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
@@ -2061,6 +2079,7 @@ const struct file_operations def_blk_fops = {
 	.llseek		= block_llseek,
 	.read_iter	= blkdev_read_iter,
 	.write_iter	= blkdev_write_iter,
+	.iopoll		= blkdev_iopoll,
 	.mmap		= generic_file_mmap,
 	.fsync		= blkdev_fsync,
 	.unlocked_ioctl	= block_ioctl,
-- 
2.17.1

