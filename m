Return-Path: <SRS0=WMYH=YK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C776FA372A
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 15:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B7F20872
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 15:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tYwqAP3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407465AbfJQPYN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Oct 2019 11:24:13 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:46243 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404842AbfJQPYN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Oct 2019 11:24:13 -0400
Received: by mail-il1-f195.google.com with SMTP id c4so2385430ilq.13
        for <linux-block@vger.kernel.org>; Thu, 17 Oct 2019 08:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=0PGoakoyCtkMC91XTS/lY5xzkGWU9ZA5C/xx4nC5uoY=;
        b=tYwqAP3oRkc6l3+yzfNzFqvAxx/amlNGgzuEZP8BgotuXLO6qkSxz9o1/AJwNJ6S1k
         jBzw/l09O56Y7/tazpOVO/oeHF/TUlTP9RzFzQt+8TM/1t6ko8xL4pvwBd/XEzbNeLU1
         rcDUVVWLuF2RQ5IBsOgZIeFhlDDqNg6whIL7vDjJBTyvtikTCUrg/Gr5Alg8NDP4ARBL
         kJpwKSu0a3jNu/TYGEh9Lv2h3dkHqTAZEmedcNJbeOTnjX2kT8uIz7Zk7t+Ck3x4KXPI
         khPy3SVnaLy2ZS6SMJAOl/8KiD82y8AJbxIhs6NTHo6Yl63nmjyBzSv/IiSEf3/fDu95
         ip2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=0PGoakoyCtkMC91XTS/lY5xzkGWU9ZA5C/xx4nC5uoY=;
        b=uLVhBBTZPbkYA0JLyT+JX5ersKv5kEbb6DphZCe13/r/rN9lG+VmxXnEDMDa8CAIPX
         93nW9CSbzYlUKt/QPwE7lI8r1gr6Yz5cnLjCjVnlniNtA46DiySgU7oqTBz8BJWDcJ0a
         NqtVpy4ZrVFM2T2cMMsCZL8pdcSwfca+JIZXn6pQo5e32YGLdwobw1yJae+iF3EJR4/B
         uO4hCfjpKYUUnS0m6hDzY70jZ9cVhdhueVmzHEGIj06N2Vcw8s/vRjyIIwRj22eW+b8l
         OsXkt/F1V9W4ivBQiOb7aOzH25WvVMTsN+CNyL3kPQmz+0X/7lPR+QUWKYLyW0RJUeNc
         dyUQ==
X-Gm-Message-State: APjAAAVQ4PviO70MmpyZC4fJdsEOwTUkVkfUUQl7DUqArb0U+P/RANPy
        KgLHqKOoTu6bAUkj0xS94X+CvIYD18IheQ==
X-Google-Smtp-Source: APXvYqzKrvwSxcGbAq4bmTCiZDJ4wtYxC5Z2n8eOPtGmLvZRu9s0Q2rMGpa6vwS9FniT1973yXXRjQ==
X-Received: by 2002:a92:d5d1:: with SMTP id d17mr4417698ilq.55.1571325850863;
        Thu, 17 Oct 2019 08:24:10 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x2sm760112iob.74.2019.10.17.08.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 08:24:10 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Hrvoje Zeba <zeba.hrvoje@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: fix up O_NONBLOCK handling for sockets
Message-ID: <f999615b-205c-49b7-b272-c4e42e45e09d@kernel.dk>
Date:   Thu, 17 Oct 2019 09:24:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We've got two issues with the non-regular file handling for non-blocking
IO:

1) We don't want to re-do a short read in full for a non-regular file,
   as we can't just read the data again.
2) For non-regular files that don't support non-blocking IO attempts,
   we need to punt to async context even if the file is opened as
   non-blocking. Otherwise the caller always gets -EAGAIN.

Add two new request flags to handle these cases. One is just a cache
of the inode S_ISREG() status, the other tells io_uring that we always
need to punt this request to async context, even if REQ_F_NOWAIT is set.

Cc: stable@vger.kernel.org
Reported-by: Hrvoje Zeba <zeba.hrvoje@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 55 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index d2cb277da2f4..a4ee5436cb61 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -322,6 +322,8 @@ struct io_kiocb {
 #define REQ_F_FAIL_LINK		256	/* fail rest of links */
 #define REQ_F_SHADOW_DRAIN	512	/* link-drain shadow req */
 #define REQ_F_TIMEOUT		1024	/* timeout request */
+#define REQ_F_ISREG		2048	/* regular file */
+#define REQ_F_MUST_PUNT		4096	/* must be punted even for NONBLOCK */
 	u64			user_data;
 	u32			result;
 	u32			sequence;
@@ -914,26 +916,26 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned *nr_events,
 	return ret;
 }
 
-static void kiocb_end_write(struct kiocb *kiocb)
+static void kiocb_end_write(struct io_kiocb *req)
 {
-	if (kiocb->ki_flags & IOCB_WRITE) {
-		struct inode *inode = file_inode(kiocb->ki_filp);
+	/*
+	 * Tell lockdep we inherited freeze protection from submission
+	 * thread.
+	 */
+	if (req->flags & REQ_F_ISREG) {
+		struct inode *inode = file_inode(req->file);
 
-		/*
-		 * Tell lockdep we inherited freeze protection from submission
-		 * thread.
-		 */
-		if (S_ISREG(inode->i_mode))
-			__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
-		file_end_write(kiocb->ki_filp);
+		__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
 	}
+	file_end_write(req->file);
 }
 
 static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
 
-	kiocb_end_write(kiocb);
+	if (kiocb->ki_flags & IOCB_WRITE)
+		kiocb_end_write(req);
 
 	if ((req->flags & REQ_F_LINK) && res != req->result)
 		req->flags |= REQ_F_FAIL_LINK;
@@ -945,7 +947,8 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res, long res2)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
 
-	kiocb_end_write(kiocb);
+	if (kiocb->ki_flags & IOCB_WRITE)
+		kiocb_end_write(req);
 
 	if ((req->flags & REQ_F_LINK) && res != req->result)
 		req->flags |= REQ_F_FAIL_LINK;
@@ -1059,8 +1062,17 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
 	if (!req->file)
 		return -EBADF;
 
-	if (force_nonblock && !io_file_supports_async(req->file))
+	if (S_ISREG(file_inode(req->file)->i_mode))
+		req->flags |= REQ_F_ISREG;
+
+	/*
+	 * If the file doesn't support async, mark it as REQ_F_MUST_PUNT so
+	 * we know to async punt it even if it was opened O_NONBLOCK
+	 */
+	if (force_nonblock && !io_file_supports_async(req->file)) {
 		force_nonblock = false;
+		req->flags |= REQ_F_MUST_PUNT;
+	}
 
 	kiocb->ki_pos = READ_ONCE(sqe->off);
 	kiocb->ki_flags = iocb_flags(kiocb->ki_filp);
@@ -1081,7 +1093,8 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
 		return ret;
 
 	/* don't allow async punt if RWF_NOWAIT was requested */
-	if (kiocb->ki_flags & IOCB_NOWAIT)
+	if ((kiocb->ki_flags & IOCB_NOWAIT) ||
+	    (req->file->f_flags & O_NONBLOCK))
 		req->flags |= REQ_F_NOWAIT;
 
 	if (force_nonblock)
@@ -1382,7 +1395,9 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 		 * need async punt anyway, so it's more efficient to do it
 		 * here.
 		 */
-		if (force_nonblock && ret2 > 0 && ret2 < read_size)
+		if (force_nonblock && !(req->flags & REQ_F_NOWAIT) &&
+		    (req->flags & REQ_F_ISREG) &&
+		    ret2 > 0 && ret2 < read_size)
 			ret2 = -EAGAIN;
 		/* Catch -EAGAIN return for forced non-blocking submission */
 		if (!force_nonblock || ret2 != -EAGAIN) {
@@ -1447,7 +1462,7 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 		 * released so that it doesn't complain about the held lock when
 		 * we return to userspace.
 		 */
-		if (S_ISREG(file_inode(file)->i_mode)) {
+		if (req->flags & REQ_F_ISREG) {
 			__sb_start_write(file_inode(file)->i_sb,
 						SB_FREEZE_WRITE, true);
 			__sb_writers_release(file_inode(file)->i_sb,
@@ -2282,7 +2297,13 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	int ret;
 
 	ret = __io_submit_sqe(ctx, req, s, force_nonblock);
-	if (ret == -EAGAIN && !(req->flags & REQ_F_NOWAIT)) {
+
+	/*
+	 * We async punt it if the file wasn't marked NOWAIT, or if the file
+	 * doesn't support non-blocking read/write attempts
+	 */
+	if (ret == -EAGAIN && (!(req->flags & REQ_F_NOWAIT) ||
+	    (req->flags & REQ_F_MUST_PUNT))) {
 		struct io_uring_sqe *sqe_copy;
 
 		sqe_copy = kmemdup(s->sqe, sizeof(*sqe_copy), GFP_KERNEL);
-- 
2.17.1

-- 
Jens Axboe

