Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFBCC282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 21:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B85621934
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 21:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dpv/tdvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfBIVN5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 16:13:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40383 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfBIVN4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Feb 2019 16:13:56 -0500
Received: by mail-pf1-f193.google.com with SMTP id h1so515190pfo.7
        for <linux-block@vger.kernel.org>; Sat, 09 Feb 2019 13:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g1khetRWDSOe+fsRbjBpFbSMReoIe0SnrK1N2gfwJWc=;
        b=dpv/tdvUJBvtgxhygAuaXko8YIOmw8px1eRcnSEFRxoJsEAUQhXdIJ/gOK66uQhDUn
         PprHNpJjMoqBlAe5utOVFum+o/HKYiq8EX0yWuvIP/kLgQWPpoysVvSJbz1+EDqnvtoG
         suHco2JrwpblF05ULVMcHHmk3/uSGjkUKoInrcZDRPaf2SJM65gU2A6uYLJMI8B5sq8z
         g7MBzvWzdgOwUn7f42RB+2VuwBVTmeXSD+UZf6299aTMzZPupUEQ1ctb/G2DGu586xw6
         e1CBV8htwDkx+H38fhpEtlM9XXEdXJLDwxJKt5pLUtsOyAUP+5mGD//zM6K9IvmMjq5h
         WO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g1khetRWDSOe+fsRbjBpFbSMReoIe0SnrK1N2gfwJWc=;
        b=JKBw4OsxkhDTyy7H/DRCc8UQdIAH9mGVWDAFGAds/Tl7ltgiw/RTZSlHg8GomO57KY
         3GLMyZvwS2a3ZfNW2DSObXOOMVQUr2buP8pYTKHHYQr/xAHuO2+hwjfgJNNTaqVfymKk
         GgnUgWDY9cT3HNmVe4WhBPbbbMrI+ABmUvPu1pcxmyfPrRffbK4RdjM5bonvOJSFGRAD
         BwVHJ0IYk5vmIoJiP9C6Wb8Y/POPvvRh0NEnkGaDpHH+4OIjVjqyXB0QV9+TQG0l4NDs
         iSdHNNwqJ8R/LKWkyFtNIc1sqdrGMVTDgdrT/fiG/3vlamN1QKH4xUaKNTvFhLO+F7ER
         A1uA==
X-Gm-Message-State: AHQUAuaOZsWCcS1YODmSFy+YjVfFmrtjcyPNX8VY4809xme9ETqyumoC
        YMFyCV3gUO1BBCJsBNs0OBnWgg==
X-Google-Smtp-Source: AHgI3IaeBMqh9ITifx2jf0Xg1HgiXw8Cut3E2ZsdlgGNZPtyUp1vL6KUbeB17aScv651XPoAO1cD9g==
X-Received: by 2002:a62:c302:: with SMTP id v2mr29582100pfg.155.1549746835613;
        Sat, 09 Feb 2019 13:13:55 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a17sm7004942pgm.26.2019.02.09.13.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 13:13:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/19] block: wire up block device iopoll method
Date:   Sat,  9 Feb 2019 14:13:29 -0700
Message-Id: <20190209211346.26060-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209211346.26060-1-axboe@kernel.dk>
References: <20190209211346.26060-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Just call blk_poll on the iocb cookie, we can derive the block device
from the inode trivially.

Reviewed-by: Hannes Reinecke <hare@suse.com>
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

