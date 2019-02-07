Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FDAC282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D58421908
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FEwoQ4OT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfBGT4E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:56:04 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36919 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfBGT4D (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 14:56:03 -0500
Received: by mail-it1-f194.google.com with SMTP id b5so2956831iti.2
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 11:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/hv74R61uSx6qH8M6q4G3Wff9psoZdekyLR18O4KJGE=;
        b=FEwoQ4OTprnXluiO2P8jM3R70Gva5DXyEcAjq6wYJQrYnltgLdFhkN8s7fIWyg1ftL
         ma6wsFgdniqSyc6+IetEZZikWsPJEtIeW0AaJrFWNIpErDqDcz1X4Iv+DUSKc75Th76M
         AyN5lMYYa4vz4hg34mbvYKi8N3qik92Qp/GnD8Gg51tbhb77IFpp8wlDhLu+c9U4+itV
         UKrihepfvs7aS6czLn5C7ohdaRbMp3LRcq8d4fdb2fjuhZnCfz6FUbJVkhA0gcIQ/ZUG
         8raHEv62WCQVnyHMIi0hK+DNQ73wVTg+nJJkUl6SwznCMrFqpn6JrhPPBvMWbeOYS15/
         hT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/hv74R61uSx6qH8M6q4G3Wff9psoZdekyLR18O4KJGE=;
        b=DMslUFl6FUTWzbPTYpUdDMyK07qXLkM9XXLxsOpqR4vRVhfA88ZK85cPDUhVYLdMGe
         1Kq0pmAXGz8fXQwoBAuhttxrw0gN+plzzui3w3paYnGKZBmta2W/SapiyMs3aeL6H9J5
         I3bt8enIae9KbKsotUUGfBAHsvjszvgJi0FMva69uCIy6VOmkZlSpjzJSyci7KMbPEja
         ZVM9a2WxxPeVwWn5JkVue8ISD65Xp5qVZR8X4D++dWqHZVezLe9xGfJDBehNH4VYMpMA
         O0TQEBtfgZnu/Hjz6EO+NKj1KOWIUdiA7JUeyxkDBiUF/Xlr9jiEZ8Fcfh13GMu1570i
         +IVw==
X-Gm-Message-State: AHQUAub3ckKiQEEx91JUyVVH5QtAPAbcFwKVRtPPdybyRJXm2hoQO5FJ
        yuFbGc363l2qoscwVDxa0YuaHw==
X-Google-Smtp-Source: AHgI3IbuQIceMm/Etn1gt6B/vvUoK2hX4yhPMxljJrmwdXRQXFlCVOx70EYMnI4LosLUT/D0XCG5KQ==
X-Received: by 2002:a24:7c58:: with SMTP id a85mr6612759itd.9.1549569362412;
        Thu, 07 Feb 2019 11:56:02 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y26sm5092782iob.16.2019.02.07.11.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 11:56:01 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/18] block: wire up block device iopoll method
Date:   Thu,  7 Feb 2019 12:55:36 -0700
Message-Id: <20190207195552.22770-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207195552.22770-1-axboe@kernel.dk>
References: <20190207195552.22770-1-axboe@kernel.dk>
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

