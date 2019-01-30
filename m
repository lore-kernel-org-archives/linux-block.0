Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411B7C282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 22:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE17218AF
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 22:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Dyt7ThuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfA3WzB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 17:55:01 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38183 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbfA3WzA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 17:55:00 -0500
Received: by mail-it1-f194.google.com with SMTP id z20so1020801itc.3
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 14:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/hv74R61uSx6qH8M6q4G3Wff9psoZdekyLR18O4KJGE=;
        b=Dyt7ThuCVWs+ZfHqyBvKGjvzrH69XWcoYwgW53FbPBRyX96bq4s777cN22x+yaObub
         tZod/9Xs9CemAwaT2i/0Fjr5dawTYr60U4iKHLcuZQb8N4N7i9lWRBIPdRAaSDsLu6/X
         PaBHWb5aJAilWyeKMG7CYBvqU+5sEFotHpGkdiUS2Qbd/3zm70doO5cC7L2TMjQ749+z
         c69GF+lmsZS/kGeszfGRXbxmhnl31UvOvu832YKvVk+3+GAcuopykyJwYx3HL+iP8Jnw
         0cmJK53YWdbsMtt9ygQR7U4l+arf2Mv+HhRWB8WoozxDMFsWJBgtDiEesLk4uZByw1/g
         i4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/hv74R61uSx6qH8M6q4G3Wff9psoZdekyLR18O4KJGE=;
        b=TWmgYAoBcuefMZ2FDCY9GsN1Gcpooquq/rVjQgYISDW6GRg/UmdnbvhHhXRmH8FSBW
         RFYJcaCBx2DjbQ3cCSr4kYkZ+agvH/HnnpKzx5/mvVhcV5ndsZIBc68GiDNsABxnuM45
         BJnEtEJgyDvpn4k32GjWUHvQu+gjbvixZPyhD7Kie/Xb4ZYAUyWlKdMjp6szdrT16rFk
         G7BwS3rZP3VYdEs4GZcZ+VRyx9+LO8zHpbXLIUhXGiottc7wiMgljqnbCQ+BpXwo6lAc
         tZTwErY8BY9JdUV8dQo4QfiPonpjzqvAFcq91RDybXCQHYOuq+3rYBf1XWiNK/np+Y5f
         FfXA==
X-Gm-Message-State: AJcUukckNOzK3VmnhiWYvr5azmRFTPcJp2rEBmBq4BwTnq6BjpNspeDP
        z3Q6kmx9lFDqSIc8C8m8rbi2jFFfFAw=
X-Google-Smtp-Source: ALg8bN41aPEZXdxqYBg5xQBx2UXm3DA7cdNSvteuzMd9kCrKjPdbaI6r05NWy4Q7T4HkEklZKG/7bQ==
X-Received: by 2002:a24:3391:: with SMTP id k139mr16651906itk.25.1548885348180;
        Wed, 30 Jan 2019 13:55:48 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 189sm1805081itw.33.2019.01.30.13.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 13:55:47 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/18] block: wire up block device iopoll method
Date:   Wed, 30 Jan 2019 14:55:24 -0700
Message-Id: <20190130215540.20871-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190130215540.20871-1-axboe@kernel.dk>
References: <20190130215540.20871-1-axboe@kernel.dk>
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

