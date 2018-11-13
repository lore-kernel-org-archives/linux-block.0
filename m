Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DFBC43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5BC20896
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 15:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="k3XxIfu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5BC20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbeKNBl1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:41:27 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45767 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733221AbeKNBl1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 20:41:27 -0500
Received: by mail-io1-f67.google.com with SMTP id w7so1538900iom.12
        for <linux-block@vger.kernel.org>; Tue, 13 Nov 2018 07:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=22cgXaZEnMSuM0w9EE6vyRTYz+1ZdO+HfiYw/JrM9N8=;
        b=k3XxIfu04Q+zqKPVcAmvvgwRoYGROqxXjOJ8krRRBtOuw+6RGCKJVsZQaI8VYHeaUl
         oUJtRFb+0WygMcVOmqbr/Jp1f82MLM5914RaK7qU4vagKuCMWocoRC72jWhVjwW8XyM2
         0M3mSQRDv0jL5aOc/md42WVyabmmXFJoinVyLxpa4Sq1VkfAHOXNppsowfjuQb+vlRV7
         qccL7U8pRS5gz//jUvhEdBVziHAZi9nTfHPXFdzgFUkthdirMCAoDMog8THcgp7ZGcR4
         TWbKsDt/Y9evL9a4GtgHKabpg1cNFOf6jc8Y4ju03Bn/IjuUvqZQfonXAmFAzyT572s4
         tlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=22cgXaZEnMSuM0w9EE6vyRTYz+1ZdO+HfiYw/JrM9N8=;
        b=SZndbP7BtA8WfcEVyG3Rrk9b9CCXa5lcOnKyezorl9CL5WrLGMjzI3Z3Y4en5GC3o8
         /mSwmwd+lfdW673huuNR3N5Op4pNdRohu5xP/2DL0ZOH7ABjOkZpsiXBU7Zo8hzLyx4u
         AhER6vFSGOVSDhkn2MDvssGZLlkt78mDIPu1l4ff+6jiLIgCtpfszbR6WMvZMyAgxZm9
         U6SYfbCZS6iffTIrjzFURwesYeaNp7eoijodIsmfRB/8kGPhxT0Eo1KBYOUWFyj+jjKb
         Djb9OQeON1L4/H0a2B5MTRgLScig7bwj++jtC1NQfUYSHlsSZhkL/D0FkmV8qRa+W5/9
         n6sw==
X-Gm-Message-State: AGRZ1gKgehyjZr1uN8ph2HFLfWYXhO5/2oIFB7Ei8gaZqKY6/HB+c2vG
        hgZeebYbCWo+zwCp7K4rydCy7kaBotw=
X-Google-Smtp-Source: AFSGD/WvFT+meBwEJ6U+1CCiT2snW0PtoRfdfUt2L1Bf4NyROkPenaZvMBp9zudaZI5DWyrEbVGovQ==
X-Received: by 2002:a6b:c815:: with SMTP id y21mr502082iof.98.1542123767670;
        Tue, 13 Nov 2018 07:42:47 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o14-v6sm6721987ito.3.2018.11.13.07.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:42:46 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/11] block: avoid ordered task state change for polled IO
Date:   Tue, 13 Nov 2018 08:42:27 -0700
Message-Id: <20181113154233.15256-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113154233.15256-1-axboe@kernel.dk>
References: <20181113154233.15256-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ensure that writes to the dio/bio waiter field are ordered
correctly. With the smp_rmb() before the READ_ONCE() check,
we should be able to use a more relaxed ordering for the
task state setting.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c | 11 +++++++++--
 fs/iomap.c     |  6 +++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index c039abfb2052..2f920c03996e 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -181,6 +181,7 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
 	struct task_struct *waiter = bio->bi_private;
 
 	WRITE_ONCE(bio->bi_private, NULL);
+	smp_wmb();
 	wake_up_process(waiter);
 }
 
@@ -237,9 +238,12 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 
 	qc = submit_bio(&bio);
 	for (;;) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+
+		smp_rmb();
 		if (!READ_ONCE(bio.bi_private))
 			break;
+
 		if (!(iocb->ki_flags & IOCB_HIPRI) ||
 		    !blk_poll(bdev_get_queue(bdev), qc))
 			io_schedule();
@@ -305,6 +309,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 			struct task_struct *waiter = dio->waiter;
 
 			WRITE_ONCE(dio->waiter, NULL);
+			smp_wmb();
 			wake_up_process(waiter);
 		}
 	}
@@ -403,7 +408,9 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		return -EIOCBQUEUED;
 
 	for (;;) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+
+		smp_rmb();
 		if (!READ_ONCE(dio->waiter))
 			break;
 
diff --git a/fs/iomap.c b/fs/iomap.c
index f61d13dfdf09..7898927e758e 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1524,7 +1524,9 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 	if (atomic_dec_and_test(&dio->ref)) {
 		if (dio->wait_for_completion) {
 			struct task_struct *waiter = dio->submit.waiter;
+
 			WRITE_ONCE(dio->submit.waiter, NULL);
+			smp_wmb();
 			wake_up_process(waiter);
 		} else if (dio->flags & IOMAP_DIO_WRITE) {
 			struct inode *inode = file_inode(dio->iocb->ki_filp);
@@ -1888,7 +1890,9 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			return -EIOCBQUEUED;
 
 		for (;;) {
-			set_current_state(TASK_UNINTERRUPTIBLE);
+			__set_current_state(TASK_UNINTERRUPTIBLE);
+
+			smp_rmb();
 			if (!READ_ONCE(dio->submit.waiter))
 				break;
 
-- 
2.17.1

