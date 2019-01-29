Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD96C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA2C2175B
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MZbvoPtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfA2T1L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:27:11 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40350 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbfA2T1L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 14:27:11 -0500
Received: by mail-it1-f196.google.com with SMTP id h193so6384477ita.5
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 11:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/hv74R61uSx6qH8M6q4G3Wff9psoZdekyLR18O4KJGE=;
        b=MZbvoPtB2bcbttONoeQKxQVEN7t8jVthm3jbpY9O2bYRzRp58OTq74LydaXEUgg4zv
         Q8w24dbkQMIECjrpK8nI8QYyHD2krqI716u0sn3epWnOT2YSEyQkz6Vtc67zqIN7lpHz
         mVlXFg67G0mr7qS8FziQ0CB9IJfmpidlexUVK/rIAikJBNuLFaJS+lBitN+/PD0mSP+q
         MVZPBIF/UW6VUR3DlOlVst2A5Jpn3NvyM5lgNi2JUzNnFYdubBXu+UdSBshJ7FE7xKbp
         r7V477EEUXZQyNHXW9+ULWNAce6J4CNJNDppnWR5CK24OShAyHX/tHmdkyrgA6DEeoK1
         gxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/hv74R61uSx6qH8M6q4G3Wff9psoZdekyLR18O4KJGE=;
        b=Iz24Uwom+8sAiu/COEEKu7jvI7iluDgrdl0RDpzUggTl8ivXGIRXA89G9yxuMIF3a0
         jeVDE/O6YDwPuZ8roka/8/pHZHJkK2UciRuWAU+43oBsdKePXHEO1ao0Msd0fEVch448
         hTL+0oMXLDwANqfDPyrxgTQO0VxmvK37piLa/u+WmONCWbrxYmiBNF1r67SFLFRjSMVl
         KWW6WjDHqpg/ILsa/a66wnInKt6LXk76F2kja8TP8ApojRVKMhAYNlgYzS4frnS7kvS+
         aTU9Rqm8amHiJoPTJE+yfEdGk95ODwrSsSNGqunMxJFNzE04LNBYnpVrxxu3zwu6OTA1
         RKfA==
X-Gm-Message-State: AJcUuke7pypWLO78yALH8uglt0Msr6lZpSpkwgLFtmsQISwsY8WTieOV
        PP5gR3w1gXFGh4yk+Y6CFa6zUw==
X-Google-Smtp-Source: ALg8bN7wnEi0TbL00ZUzLZuVG/9OC2Yq+2VWvtCvnMyEf8swTqPJe4vO0BgSfs4fBF9htjDOIOjvZg==
X-Received: by 2002:a02:9b74:: with SMTP id g49mr16787273jal.76.1548790030192;
        Tue, 29 Jan 2019 11:27:10 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y3sm15223203iol.55.2019.01.29.11.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 11:27:09 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/18] block: wire up block device iopoll method
Date:   Tue, 29 Jan 2019 12:26:46 -0700
Message-Id: <20190129192702.3605-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190129192702.3605-1-axboe@kernel.dk>
References: <20190129192702.3605-1-axboe@kernel.dk>
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

