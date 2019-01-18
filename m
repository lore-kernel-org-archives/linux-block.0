Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C517C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D15420850
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wXOyearj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfARQMi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:12:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34912 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfARQMi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 11:12:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so6829582pfi.2
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 08:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IbkWyHpTil5Vluy4ET88nT33hqg2kUPldnzNz+Wucw8=;
        b=wXOyearj2mP7U9VmTbWOONl0HmQKu/ENcDZMwE+/0blLQ1c6IbRaTQLWTCAgkiHT1j
         0KMIcVHNgsaOwx29gm7Osqf2hB/cKpB88MdlVEZqmjdDtwXuuTWTHeOxPpTAuFLTfZM5
         TmU+ZxewfGGUiqdN6o/IH6IVn3O7SLo/L8bMSUncPdukeQXl7mfTiQtB4en3sNec65tF
         QSBJdaVa8IiGs6ixCRFN9ysjBozR2ad7S78JI0lfr5+jebRCO1TgjK26OHYbxA6U17j+
         2WnLDY5lfagB6ZCCG3FHkF+arQJOi1+yMyffh42Syyx+jvOH/s8B7TOb2lQmHJf1SdpE
         BPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IbkWyHpTil5Vluy4ET88nT33hqg2kUPldnzNz+Wucw8=;
        b=hnWShRECJurccaHaN0kUc1egAZmQFJ9RWSqdIX28Knvln/mkdQUh6V2ECR5QwDda83
         OGrnsdPa3Se7kaHzHoPf1jBPaQiFxdS2qIl0+uZPGMLJPuckBt9Y1+EGzHFh3Bo1XCf2
         fSmg69Fiaflf/uhzNlkuC2HUJfWSP5RfrvjkGZEgd80F7FOusqPX/reumzC9OLxHmMmI
         vvuRbv5EGGDMbCCJevm/3tHUI+t2gM+7CRSlUJ/TeizHu2Dp/1xAyB1CDrLuuDFfvqvc
         MJGBDnDZAqzxaaaR8SUFPdxwrI/Vuei336yKc/caH7lI2cyp39NgCOsBUOh8rvzWD/lI
         7C6w==
X-Gm-Message-State: AJcUukftfgKz8bAW0h+HOyX3FAHs6AGNvgy1R/yNaBqOqcYlr0PHkGKF
        ctcoeqoeuORccdjpOYeP/AKClA==
X-Google-Smtp-Source: ALg8bN6Yz3Up/0axxhnVvTlvP7bc+l8vmNdlnaY86tKPutLhoeyKnqi+W6qtHT8SlmIAfwqTFauVyw==
X-Received: by 2002:a63:6506:: with SMTP id z6mr18297332pgb.334.1547827957707;
        Fri, 18 Jan 2019 08:12:37 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m20sm5317804pgv.93.2019.01.18.08.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:12:36 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/17] block: wire up block device iopoll method
Date:   Fri, 18 Jan 2019 09:12:10 -0700
Message-Id: <20190118161225.4545-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190118161225.4545-1-axboe@kernel.dk>
References: <20190118161225.4545-1-axboe@kernel.dk>
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

