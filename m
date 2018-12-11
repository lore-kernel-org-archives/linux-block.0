Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC38C5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6707420870
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="noj+jUV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6707420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbeLKAQF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33766 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbeLKAQF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so6214104pfb.0
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eJ3aWzBT4gm4FwYHYUV1JBWUWsiFyJVaotzVIFD6bng=;
        b=noj+jUV60sMVyz45bMaOJmzoUuOgpnvS18GVfOib9Id5a7/erovUYfyTFU3e9Jz0MA
         17UbNnQfbEpr55GMT5KZhLdGGFuUzaeokC7USoMlVGgVDCEYga6ZMXXVFNEpvmYlLGXd
         eq1V5dp65w/78+IU81Jhg+Bh5g32uOPl0YrWaINQ5yob63/0/IIJM07ThRJ50ak3FQb9
         bBe5REPo0hA7fXcb8y/cZfkNni/bmEMZ33vTeOm6eX3dO7131sUiLLTUyFJ+ivQikniZ
         VUqATdSJVmn3FSkgWtR/GBF3hvcM782tPmGj8w3QuAUEmrAnSisYqNxg6tuGBrRhCOsU
         TWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eJ3aWzBT4gm4FwYHYUV1JBWUWsiFyJVaotzVIFD6bng=;
        b=ILIf8acXfQO6PAzHeIgwnd7Cs7zrEIP9WJQcYwK0YgEkUZABStyUspd44P7SFcFTrZ
         jFD0+9sbU8jzKMSWDzpY6Gfj6zL6AsdJrMsthSQ8Akt5rylVBK9bQU7evPuSB+1r3nl5
         /CYDDUc8GMwk1coH6dwPtN1s3i3HzmwicM0Hxa9yZx5LBARK8hXaHcbbaafAFmpJpZjt
         QrUD5pJG7FxyHx23a7D5kd9cwymRyirUGQKkHtLcxpfnH08vXm+/UkeKqIXksNu4JqRa
         pYEZ3h8lQ1GwPbDUC7FA+jude9Jbmd6Kk2sEnGDsSguyEVQPdCoQ8hj3P50jxzxfSi5N
         luHg==
X-Gm-Message-State: AA+aEWb0BX+vT+Thks9vTJ4WOr4vBn9njlKY5ahMI4z5Gz/8vX+dbvg7
        WnTQf0ZUq8MVj+mjp0pU6089wxCUHiLQrg==
X-Google-Smtp-Source: AFSGD/XxPglJqmFawVA6QATB0/3ON5e3GvdZFChFasZ2cJ6PwiRjkS3eZbKonyduQYlagwv51HGwew==
X-Received: by 2002:a63:6704:: with SMTP id b4mr12798183pgc.100.1544487363719;
        Mon, 10 Dec 2018 16:16:03 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:16:02 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/27] block: wire up block device iopoll method
Date:   Mon, 10 Dec 2018 17:15:25 -0700
Message-Id: <20181211001549.30085-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
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

