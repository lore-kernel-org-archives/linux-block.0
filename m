Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F336FC4161D
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F669206BA
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 17:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mxdLYtiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F669206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbeKUDuR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:50:17 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55280 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730415AbeKUDuQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 22:50:16 -0500
Received: by mail-it1-f195.google.com with SMTP id a205-v6so4485252itd.4
        for <linux-block@vger.kernel.org>; Tue, 20 Nov 2018 09:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rB3MVuM6w3WCAUAjcVZ4Da11wfbFSvSVLatFDmKZI40=;
        b=mxdLYtiX2fk9VMfstCWW4891FMhFEcah17xFR4QfoDQqmRnBvtuYlH/2SMuUCRzNxn
         3FOexzf8p5V7gf6G2P2jGNTtZPOUMNbX7uUrZVozc5LYeX4OAyeoim5UIBLrJrbnVEYP
         skme+jQyBzDETWqEDpphp2pndZPJgtJJ3mvu3tM2SwvKhBJhmi8Of/aozPCoCrds8sdn
         vHIFjWTmSI3GD9MvRQZdWlcZ3BIChbOGvgRr8sNLmGpDrjEYinVXcYcAOEArhVrTbOs0
         PA0HYMe35TPkq2i9CqNhoYZVj9r9mZ0Sy8Uh+9XF/y9dWGv2CJUU2FMdYdaoWEB3eYJV
         wkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rB3MVuM6w3WCAUAjcVZ4Da11wfbFSvSVLatFDmKZI40=;
        b=kMwiI1lSSBfTA97XefcG52J8vylUhOgTD3WWDOLwjT5F78nteXsQVwcvJvPBQriH/3
         n0BvfCVKAdsHxR4Wp+A+sMzFvzH/x89Bz0hYgAQaNFqw/sWnb0lk4HS+Z16uSWYGC0vg
         JjdPVa/HCtQU+l+pKVUUxZAg0o9lDLIeNI1bjTluoRbcRJ3SM+8sigOK/qpDk9ccgZsE
         4GwwXS4e8vI8DiTez1EBA2/w335wGqRHk2S28gB0pyi+JEvkuNsELmxOW2RDLHpBbTxT
         z7G61awGEPWtyMKGxvsMz6VDPkZNiTwLorYUps3I5utzf8kxIjIMLvR5Eybj8BcJvbf9
         SJAg==
X-Gm-Message-State: AGRZ1gKjyz5B7ZdNXaVdHT4KNbwfszQO6p7GPJYpzEcZEuLjU0UBT4/R
        1WpVIOVTKE+IgEzzzsmRD0NEEPAuL+g=
X-Google-Smtp-Source: AJdET5dtEz/95TlBDbxOFKbtvUTkpNwTV/d71r0Ry0VVVTlL3HLavTGsLKnPSaprpncDQbkE99HPiw==
X-Received: by 2002:a02:1b1d:: with SMTP id l29mr2562147jad.98.1542734402144;
        Tue, 20 Nov 2018 09:20:02 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 186-v6sm15751530itf.11.2018.11.20.09.20.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 09:20:01 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/8] iomap/xfs: wire up file_operations ->iopoll()
Date:   Tue, 20 Nov 2018 10:19:48 -0700
Message-Id: <20181120171953.1258-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120171953.1258-1-axboe@kernel.dk>
References: <20181120171953.1258-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add an iomap implementation of fops->iopoll() and wire it up for
XFS.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/iomap.c            | 50 +++++++++++++++++++++++++++++--------------
 fs/xfs/xfs_file.c     |  1 +
 include/linux/iomap.h |  1 +
 3 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index 74c1f37f0fd6..faf96198f99a 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1419,14 +1419,14 @@ struct iomap_dio {
 	unsigned		flags;
 	int			error;
 	bool			wait_for_completion;
+	blk_qc_t		cookie;
+	struct request_queue	*last_queue;
 
 	union {
 		/* used during submission and for synchronous completion: */
 		struct {
 			struct iov_iter		*iter;
 			struct task_struct	*waiter;
-			struct request_queue	*last_queue;
-			blk_qc_t		cookie;
 		} submit;
 
 		/* used for aio completion: */
@@ -1436,6 +1436,30 @@ struct iomap_dio {
 	};
 };
 
+int iomap_dio_iopoll(struct kiocb *kiocb, bool spin)
+{
+	struct iomap_dio *dio = kiocb->private;
+	struct request_queue *q = READ_ONCE(dio->last_queue);
+
+	if (!q || dio->cookie == BLK_QC_T_NONE)
+		return 0;
+	return blk_poll(q, READ_ONCE(dio->cookie), spin);
+}
+EXPORT_SYMBOL_GPL(iomap_dio_iopoll);
+
+static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
+		struct bio *bio)
+{
+	atomic_inc(&dio->ref);
+
+	/*
+	 * iomap_dio_iopoll can race with us.  A non-zero last_queue marks that
+	 * we are ready to poll.
+	 */
+	WRITE_ONCE(dio->cookie, submit_bio(bio));
+	WRITE_ONCE(dio->last_queue, bdev_get_queue(iomap->bdev));
+}
+
 static ssize_t iomap_dio_complete(struct iomap_dio *dio)
 {
 	struct kiocb *iocb = dio->iocb;
@@ -1548,7 +1572,7 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 	}
 }
 
-static blk_qc_t
+static void
 iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 		unsigned len)
 {
@@ -1568,9 +1592,7 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 	get_page(page);
 	__bio_add_page(bio, page, len, 0);
 	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
-
-	atomic_inc(&dio->ref);
-	return submit_bio(bio);
+	iomap_dio_submit_bio(dio, iomap, bio);
 }
 
 static loff_t
@@ -1676,11 +1698,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		copied += n;
 
 		nr_pages = iov_iter_npages(&iter, BIO_MAX_PAGES);
-
-		atomic_inc(&dio->ref);
-
-		dio->submit.last_queue = bdev_get_queue(iomap->bdev);
-		dio->submit.cookie = submit_bio(bio);
+		iomap_dio_submit_bio(dio, iomap, bio);
 	} while (nr_pages);
 
 	if (need_zeroout) {
@@ -1782,6 +1800,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
 	if (!dio)
 		return -ENOMEM;
+	iocb->private = dio;
 
 	dio->iocb = iocb;
 	atomic_set(&dio->ref, 1);
@@ -1791,11 +1810,11 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->error = 0;
 	dio->flags = 0;
 	dio->wait_for_completion = is_sync_kiocb(iocb);
+	dio->cookie = BLK_QC_T_NONE;
+	dio->last_queue = NULL;
 
 	dio->submit.iter = iter;
 	dio->submit.waiter = current;
-	dio->submit.cookie = BLK_QC_T_NONE;
-	dio->submit.last_queue = NULL;
 
 	if (iov_iter_rw(iter) == READ) {
 		if (pos >= dio->i_size)
@@ -1894,9 +1913,8 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 				break;
 
 			if (!(iocb->ki_flags & IOCB_HIPRI) ||
-			    !dio->submit.last_queue ||
-			    !blk_poll(dio->submit.last_queue,
-					 dio->submit.cookie, true))
+			    !dio->last_queue ||
+			    !blk_poll(dio->last_queue, dio->cookie, true))
 				io_schedule();
 		}
 		__set_current_state(TASK_RUNNING);
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 53c9ab8fb777..603e705781a4 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1203,6 +1203,7 @@ const struct file_operations xfs_file_operations = {
 	.write_iter	= xfs_file_write_iter,
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
+	.iopoll		= iomap_dio_iopoll,
 	.unlocked_ioctl	= xfs_file_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= xfs_file_compat_ioctl,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 9a4258154b25..0fefb5455bda 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -162,6 +162,7 @@ typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t ret,
 		unsigned flags);
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, iomap_dio_end_io_t end_io);
+int iomap_dio_iopoll(struct kiocb *kiocb, bool spin);
 
 #ifdef CONFIG_SWAP
 struct file;
-- 
2.17.1

