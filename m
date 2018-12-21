Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D3EC43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524D621929
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 19:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UY985MZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389636AbeLUTWq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:22:46 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51186 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391642AbeLUTWp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Dec 2018 14:22:45 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so8463366iti.0
        for <linux-block@vger.kernel.org>; Fri, 21 Dec 2018 11:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eJ3aWzBT4gm4FwYHYUV1JBWUWsiFyJVaotzVIFD6bng=;
        b=UY985MZHK/3IInifx/lasC5imTIft+IY63HHvE8kWZU7fFcS18DIqMWZRRRPyAqKLW
         67s9eHi38jNAEZmP8fURojKcKcrp5OC54GqRhUCjWF93YMO5SNFHKUSh1tDTp6eP0VMP
         l2StwMerq2cET6B0Ls082H2rA9sTzddWptFfK/qfwcFzGLDMGB/q22B2y7wWg6HK1Q6n
         dbGGqLZS5/AwXRQA0UQd8/+AVHA89K006zaIFGaB461wtreUKezu2cJew/8zNK4h8xjH
         i059r2cyFYnWkmesxrGjsVNbDrQtTLGZTqVR+To5HYJrnmaTumfIyo8Ao8og6gMVHhr9
         dEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eJ3aWzBT4gm4FwYHYUV1JBWUWsiFyJVaotzVIFD6bng=;
        b=t80ZP9dG+AhK2t7m1f/6JfVRB7PMmqGuMMiKlONFSjVCKWwOV/Bsf02ZEw1MRjFO75
         p+v9JKdM+VKQ16RCJshE4cfG4/qxf52DP3+hLF7RKR7dWRJNpmm6ESR73QhNuMO74Qkd
         UiZbK7Hi9ms65gr5FYeNK3I6w+TIvdd7wIWdUiFFyTbE8Y0HZ49ZLWnQWR92XxtR8E7N
         nN51TdR3++wfClCPrsYm1ZyHZGTIWbYLO54l0AczgCWs/V3h1XYWcJIpaIQVQpeicsFA
         8rgQMbDMGaSDsWRxSJlFJqKpr3ZPQNVF8hmUXfEMympCZY6Rdr8tW2006Ij/Oxjn00Zj
         aSbQ==
X-Gm-Message-State: AA+aEWZlRyJnuKEcWvG/Lz8ufBQfZYMNOdkxwU/wjF4q954jwos+Lq3+
        D2ajy3563ri6Mj8pBR0v0BMcKw==
X-Google-Smtp-Source: AFSGD/VJOKeBAkTZXcHzCv7x/GmAZXEaBZe4CmYjaxLWrJK3WJ7aSaddNb1mtX4jdJWVePwSAEZAiA==
X-Received: by 2002:a24:a04:: with SMTP id 4mr2803875itw.122.1545420164535;
        Fri, 21 Dec 2018 11:22:44 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm12456290iol.85.2018.12.21.11.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:22:43 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/22] block: wire up block device iopoll method
Date:   Fri, 21 Dec 2018 12:22:17 -0700
Message-Id: <20181221192236.12866-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221192236.12866-1-axboe@kernel.dk>
References: <20181221192236.12866-1-axboe@kernel.dk>
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

