Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66883C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5702083D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ASWBDrJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5702083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbeLGWUa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:20:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46751 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbeLGWUa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 17:20:30 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so2282302pgp.13
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 14:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eJ3aWzBT4gm4FwYHYUV1JBWUWsiFyJVaotzVIFD6bng=;
        b=ASWBDrJlAYIMXIY/ngfp+WB5zKJfKwYfKDW2yWUq0kQv6AeB2NPEw9bE2ivmcJx55O
         3EgbtvaZevMN8c8lsbUJonzIOGyFrDGkJO4ajLJXnon3HQeMS9Mzp6PRCV0G8g+bsmoD
         zb980OcDUGxMK70565TlDXMTsh4en/fk0Api4Y21d61FbVRZVqMuWI+QrWQT/nxsyOZY
         JF8dqEA3clRoWtY5cGliN4r2dAZnrDoMZKVo93Tik+kTAVhJDGuru/eexFbf5GfpeID1
         Ak5/OroiPXZvrMIw2tiLZCMcE5ag6bc9P4ERETJxy+csTPiAH+bzybbldx0fKifQhNbX
         /adA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eJ3aWzBT4gm4FwYHYUV1JBWUWsiFyJVaotzVIFD6bng=;
        b=IwzyM6ika4p91e7D0HHWb7mrjMf2pLEvOaz/z6hPf5NhbR+y3Wb2eLh20uIKb0hBpb
         7ltAD/4zl2j6NpbNvSgCuo1sPpGZRDnEq3IJd6sy1MsRZOAeVVYpSfmG9+mDwVw01yJ0
         cdlKP5Q2HipZTe2voMQunmVonEOm1E3iUHBAEr4Fm+YcNRIu1xgMw6T4eCqA8ofGdJlw
         792CQKFMDyonfCiglhcudyKRhxf1+du66S15Yg/hAMGMMqzs1CUXby27ecYffPrgt5ZK
         dxtIu299YgFsWeftl1E4UGnqnbkikgtMeupUF00LrYO2wbFo/jM9rX9xXFdlRECNozgq
         lMBA==
X-Gm-Message-State: AA+aEWbC67+BHHRHmjN0MTPV36JBgyKBEnqbHSCRY4bwV+5ZANgC2m42
        ut8pfYdH3dEk7mVgLWjd3eZ9LrFtCJs=
X-Google-Smtp-Source: AFSGD/XWeYRdClJsIVTm6TL8xVVIBkpVwJVBVPYtoNpPNhwVQelk1JOyWD2OKgyez+Y7XAuN85yWdw==
X-Received: by 2002:a63:6cc:: with SMTP id 195mr3545336pgg.52.1544221228891;
        Fri, 07 Dec 2018 14:20:28 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e9sm5282511pff.5.2018.12.07.14.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:20:28 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/26] block: wire up block device iopoll method
Date:   Fri,  7 Dec 2018 15:19:53 -0700
Message-Id: <20181207222016.29387-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207222016.29387-1-axboe@kernel.dk>
References: <20181207222016.29387-1-axboe@kernel.dk>
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

