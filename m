Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB862C00454
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 15:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A050124671
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 15:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mRirhKAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387925AbfLKP34 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:29:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34221 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387576AbfLKP3x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 10:29:53 -0500
Received: by mail-pf1-f194.google.com with SMTP id l127so699098pfl.1
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 07:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2SQjS8rVUv97zNNTlgrJhbpMsmZd4fG/GoKGJP3eAKE=;
        b=mRirhKAWFljYMiRUx194SXEFEtebKFxO5ZD0NK7T1mtl+xUBGQ0Yst6hneUUfMFIM4
         CJHbOUUL+TVItwq3msVkfmRDrIS9KiqYgo2pNJJbrxDuK8F/gG/+yjfC8g7Psp/LVVnu
         myC59YfNOnR6SVVu7c6EDfdojaNua5fvpx4rj4fe07ntRzZFwGGBF3ERckadrGtL+6lw
         9/cmBdu5Lle5khBqRxuFR4w8QZDVienwJjKpMPXGvei+PZCY5rtWrPZ+bf6sr/rgrYx3
         W+9MN296zoxWbl0Fw2HGYe5l30oDTQtOkwoyyR2k9l3iBbeMx/iDPfDQ6H6ySMx/jIry
         0I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2SQjS8rVUv97zNNTlgrJhbpMsmZd4fG/GoKGJP3eAKE=;
        b=rLbn9HPBPfnOXotcoqvKPMfs8bO/tm8+j1777U4i3excqFnTg+2i5hPxTsZkqvfBil
         as9a3rTW/L7TvAIujKZckeDUF11ABPAaBj1WYFGm4q5DKsKCmgruN+W250ntjzIn6wIi
         XtiddMIcReiiSkbNjMGjTrB76KqYhCj8ng2rKnhhuoaeq0vi8KXbawZ5cGJIyDW/mvEW
         ozAm3JlI1NO5XNL1J8TSl4uNtLgUZxQqKrdJqWvCBIg9y3gbeiCzllceIIpFsKZYhh2U
         pej1akaNznbXEOzx/mngu7dKdK6FYYTg/a0JABCIbW+RC06l8KlbuQkHa4R35VgHP90a
         jLjA==
X-Gm-Message-State: APjAAAXSwWyVLBEwpeXZJFyboHTXQ00RYZFZE9TNyoxQjSMrlKV3BwHR
        11XG0Rz4/CroWjqThpQ3ajTUyQ==
X-Google-Smtp-Source: APXvYqxfuUbnRf2Sjrpa01+W+GiMj+MkirsJ7dKPdEmqQOm6hBolB0IKP27YH+ADkKThXrnkx7OuJw==
X-Received: by 2002:a63:1d1a:: with SMTP id d26mr4544893pgd.98.1576078191917;
        Wed, 11 Dec 2019 07:29:51 -0800 (PST)
Received: from x1.thefacebook.com ([2620:10d:c090:180::50da])
        by smtp.gmail.com with ESMTPSA id n26sm3661882pgd.46.2019.12.11.07.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:29:50 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, torvalds@linux-foundation.org,
        david@fromorbit.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/5] mm: make generic_perform_write() take a struct kiocb
Date:   Wed, 11 Dec 2019 08:29:40 -0700
Message-Id: <20191211152943.2933-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211152943.2933-1-axboe@kernel.dk>
References: <20191211152943.2933-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now all callers pass in iocb->ki_pos, just pass in the iocb. This
is in preparation for using the iocb flags in generic_perform_write().

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/ceph/file.c     | 2 +-
 fs/ext4/file.c     | 2 +-
 fs/nfs/file.c      | 2 +-
 include/linux/fs.h | 3 ++-
 mm/filemap.c       | 8 +++++---
 5 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 11929d2bb594..096c009f188f 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1538,7 +1538,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		 * are pending vmtruncate. So write and vmtruncate
 		 * can not run at the same time
 		 */
-		written = generic_perform_write(file, from, pos);
+		written = generic_perform_write(file, from, iocb);
 		if (likely(written >= 0))
 			iocb->ki_pos = pos + written;
 		ceph_end_io_write(inode);
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 6a7293a5cda2..9ffb857765d5 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -249,7 +249,7 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
 		goto out;
 
 	current->backing_dev_info = inode_to_bdi(inode);
-	ret = generic_perform_write(iocb->ki_filp, from, iocb->ki_pos);
+	ret = generic_perform_write(iocb->ki_filp, from, iocb);
 	current->backing_dev_info = NULL;
 
 out:
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 8eb731d9be3e..d8f51a702a4e 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -624,7 +624,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	result = generic_write_checks(iocb, from);
 	if (result > 0) {
 		current->backing_dev_info = inode_to_bdi(inode);
-		result = generic_perform_write(file, from, iocb->ki_pos);
+		result = generic_perform_write(file, from, iocb);
 		current->backing_dev_info = NULL;
 	}
 	nfs_end_io_write(inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 092ea2a4319b..bf58db1bc032 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3103,7 +3103,8 @@ extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_direct_write(struct kiocb *, struct iov_iter *);
-extern ssize_t generic_perform_write(struct file *, struct iov_iter *, loff_t);
+extern ssize_t generic_perform_write(struct file *, struct iov_iter *,
+				     struct kiocb *);
 
 ssize_t vfs_iter_read(struct file *file, struct iov_iter *iter, loff_t *ppos,
 		rwf_t flags);
diff --git a/mm/filemap.c b/mm/filemap.c
index ed23a11b3e34..fe37bd2b2630 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3302,10 +3302,11 @@ struct page *grab_cache_page_write_begin(struct address_space *mapping,
 EXPORT_SYMBOL(grab_cache_page_write_begin);
 
 ssize_t generic_perform_write(struct file *file,
-				struct iov_iter *i, loff_t pos)
+				struct iov_iter *i, struct kiocb *iocb)
 {
 	struct address_space *mapping = file->f_mapping;
 	const struct address_space_operations *a_ops = mapping->a_ops;
+	loff_t pos = iocb->ki_pos;
 	long status = 0;
 	ssize_t written = 0;
 	unsigned int flags = 0;
@@ -3439,7 +3440,8 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		if (written < 0 || !iov_iter_count(from) || IS_DAX(inode))
 			goto out;
 
-		status = generic_perform_write(file, from, pos = iocb->ki_pos);
+		pos = iocb->ki_pos;
+		status = generic_perform_write(file, from, iocb);
 		/*
 		 * If generic_perform_write() returned a synchronous error
 		 * then we want to return the number of bytes which were
@@ -3471,7 +3473,7 @@ ssize_t __generic_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			 */
 		}
 	} else {
-		written = generic_perform_write(file, from, iocb->ki_pos);
+		written = generic_perform_write(file, from, iocb);
 		if (likely(written > 0))
 			iocb->ki_pos += written;
 	}
-- 
2.24.0

