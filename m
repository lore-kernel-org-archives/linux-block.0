Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B70C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A5220855
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TvGFxnMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A5220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbeK0Dkf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:40:35 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52734 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbeK0Dkf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:40:35 -0500
Received: by mail-it1-f195.google.com with SMTP id i7so29328339iti.2
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jl3/dynblu/agc3BZMjXxwYt9clu/5wSo7rh5aN5YNA=;
        b=TvGFxnMstmEfJMIOLMXNiOzTVykZyMUQqT16CwADuhfVYscHH+JyxL0s7oyCTiJotD
         8CTHzg3TPD5pKHlCHWxIo9zfZbiIJo+dG/ykf+imY+tT6byWhUwQRvo3Hf5qTKlsjgEM
         EGQmGYhuu1YSZj3OpKbA9K8/s1PGulibE8lHZxDZ9vniaoJh4g/id+oEed9XvMdy2GxJ
         mlSn+NRCCQLKcixy9SldCeaKVXQUhTG0crow7X70mFDeeB6VEA8QLQKsdqyTa4SARsp+
         JW9S/vIB8vBR3GswWalaOvWRAi3/oi9XHdyugCdHSrF6xXZM/HpHOB2lDvCxinCkKTZR
         a25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jl3/dynblu/agc3BZMjXxwYt9clu/5wSo7rh5aN5YNA=;
        b=MpsX40hQve/iNhFXqLYUOszm9OizOy6i2RzDb6icLnWSmWz6xlYLImV3U45wTm357L
         dk9pzBNyvlrP8Kn0tB5q/UJ66sS7Jxfu/d9wgQd/jO45c1mggfqSi9vOtNVdKEtHYH0/
         zyX0WMaiOqx+lF6LZP4YrQEmH6POAHhiMnJeqoGv0ZVFIPMcC55S8U44dNXrDQxlqvI4
         PPGbA/XrMLGNhHBa9U64k9qJQyT8ukvaTXpV0cUEA7h6NRiP8DvdB5D/0aumDNycAGOH
         C2kXluH+GcZhKzLcVECTqxZh6Pnxx6n6fBn/ua37OYngMIWVm5RDJLetV44hi8V6nN44
         8wKA==
X-Gm-Message-State: AA+aEWbPHfZJn2qcw+rcUTshkiYCHWREU5wLcRSyME88EIq1BeGAA5jn
        71kgFQ6oygbb+jGV08mt3YR1Kh97ZsQ=
X-Google-Smtp-Source: AFSGD/VAAgn1G80svAGS4/lcIM732CDMZ2l6nLLhCGz38+VmSG+zuSk90tu7NS5mds4SlFQCveLtqw==
X-Received: by 2002:a24:130a:: with SMTP id 10mr12425542itz.58.1543250755800;
        Mon, 26 Nov 2018 08:45:55 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t65-v6sm486801ita.9.2018.11.26.08.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:45:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/20] block: wire up block device iopoll method
Date:   Mon, 26 Nov 2018 09:45:28 -0700
Message-Id: <20181126164544.5699-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126164544.5699-1-axboe@kernel.dk>
References: <20181126164544.5699-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Just call blk_poll on the iocb cookie, we can derive the block device
from the inode trivially.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index d233a59ea364..9acb26f7c9ec 100644
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
@@ -396,6 +404,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 				bio->bi_opf |= REQ_HIPRI;
 
 			qc = submit_bio(bio);
+			WRITE_ONCE(iocb->ki_cookie, qc);
 			break;
 		}
 
@@ -2061,6 +2070,7 @@ const struct file_operations def_blk_fops = {
 	.llseek		= block_llseek,
 	.read_iter	= blkdev_read_iter,
 	.write_iter	= blkdev_write_iter,
+	.iopoll		= blkdev_iopoll,
 	.mmap		= generic_file_mmap,
 	.fsync		= blkdev_fsync,
 	.unlocked_ioctl	= block_ioctl,
-- 
2.17.1

