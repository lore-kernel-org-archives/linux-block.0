Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFA1C67872
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1A720851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aYhq76Ge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1A720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbeLMR47 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:56:59 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36993 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbeLMR47 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:56:59 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so5189566iti.2
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eJ3aWzBT4gm4FwYHYUV1JBWUWsiFyJVaotzVIFD6bng=;
        b=aYhq76Ge5prZYqChiex1lZztm76hm+rMRCnSJwPw/BL/gfiTqybZaEcTcLSIt53IIC
         mFsu9ZcjVKm8/achwSdU+Cf7fCKUgpFDSq+sU2iGHsR9rx2bbR/taunZ61uEdJkWtU4H
         t+/P8agSEvse4G3a8b4WZvDnLaozf/zBc9FTLVK7vdzztCMfwxhxsJnkYI/GnyaMlIGn
         1XD+a/l0H6fZdfswK33eVHkyj76HkVTsK2JJacQpqOPpz2lUuGkahFGeq25jKkcCU7LX
         21vyoSlgEDkT0K9AQBGsc+30nesat1Yq3KuyLT20Ag6zAVdCON4SLbswttNCursrZaQ/
         cNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eJ3aWzBT4gm4FwYHYUV1JBWUWsiFyJVaotzVIFD6bng=;
        b=KV2ih0/MoEokL4kjCZn4YVPcSfwALCwyfHcOgUhw8Pb80bqxKU4Gzk2pf4QbzjhBaT
         +KX2SM9KcDGcKeRuZDZyGiVELdNZzua19uhMODI/nimjV3gNV4KYK/4lsufS0X+hxQlO
         KKcdBnaYqHfrkWG6DwngwrhhQB+89H1G0gztOQomaFQp1+crIl42Bhxs6YNCBwuEyzYn
         ddjzihnrttbS+BswMoPRL2pRPdyhAvftDsenn9uqyX4BJpAW4WkIQt6wiDxNvBYMH1CD
         uE45txcLIpkvpni4nVdwVpPOpw5rMMdjTscvXcm8ifrI8Am6/GXWRC0AOx+gQM/nxQmv
         MYMA==
X-Gm-Message-State: AA+aEWbgkkycIaLJF2NH4xyDhaPTE6oawZUkyDbFozWd4crDjwsVutyQ
        dX2eVPjotNp6rzS7gRvl9vS55sGeQ5iTcg==
X-Google-Smtp-Source: AFSGD/XV3Y2ozuZi7DvSj71bnLVb/DLZBHTMRYyfr+4wBcSZtZlHhzPYciM60GtD3CBTR7QAjuRmLw==
X-Received: by 2002:a24:af0a:: with SMTP id t10mr277907ite.159.1544723817444;
        Thu, 13 Dec 2018 09:56:57 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:56:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/26] block: wire up block device iopoll method
Date:   Thu, 13 Dec 2018 10:56:22 -0700
Message-Id: <20181213175645.22181-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
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

