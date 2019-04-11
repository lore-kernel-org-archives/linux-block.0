Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06FEC10F14
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 15:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76B82173C
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 15:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SlEVa//9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDKPHJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:07:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42365 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfDKPHJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 11:07:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id w25so3584670pfi.9
        for <linux-block@vger.kernel.org>; Thu, 11 Apr 2019 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iuB1ApSmWHl1Z7hb4Y495EoDB4EP5Q2kVOYnRigTN3I=;
        b=SlEVa//97OWmKVs9xnnpYSS7rQ2+WmX+nCJb4yLi+O8vKTNfC5W6J96zXMCi8MbBDa
         E253pb5a+ykHn8mjioMidEbu/2K6V9DnYbdjHG9RmArvzTZzTh1EqSTMgVat51NeT3cf
         rYKLxs2MFnWtGDI2eCWQ92bt3RmZmbdS2CbH91b513uG3VUoqH2bshLRnlaxzXmkh4mv
         FPvPBN7ZXUbUSo6EHzkvC8Pt+t0tySsiiKvycJml+od22s04fuoOJZDm3T/Sw5ONTr62
         tupNOXq3cqwo38T5LWC4CXaHoleCITml8gnMh6oLsdImcuR9aDQNBHc16E9dJTO1NfeC
         IevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iuB1ApSmWHl1Z7hb4Y495EoDB4EP5Q2kVOYnRigTN3I=;
        b=A42K8rTH1hDbnBGxstbfZiSE/lWfdw/wnq5MAwjICVccL7hu6tUCQlJe+Rl0hn/52i
         3iLrxcPFLiJtVMCzO7JtAHLGMXlGfBVZRrEMfraf7gvVG/NiF8RkkBvfqnfbFUHF10y3
         Q8N7ILqsOMF7hqGdGMKdU0QZlOFJkczaw+OcFY3Iv0xzbXG2yAcNoevWTT8h7DgwzTU3
         9WC+6zp7uE4kdHh1IExAMP97lK75alL8xBrDstMvElXuTT6ZxhMW9tOe0z0lEs4zX7jO
         fIKLUxxVj34gUcE2+lImevgA4ImWh5PDvXtVNneBe+yoWxJ3P9aKEQ8hDbeZFstkKbLY
         X3cg==
X-Gm-Message-State: APjAAAUDJxfXRsw9+bpOBmUetZMGeX5w9c/Z2HN2LpI5O4lXmKo3dr2L
        oTMlJezPPDBgYenn3gRPvE2v+w==
X-Google-Smtp-Source: APXvYqwE/S9DcJ3Ov2vxwLgGTu3Fyx4a3uUzEw3ZO+w5Ci93K41ymVLjWAW/u5CbR5YU4FJyxWcGLQ==
X-Received: by 2002:a62:12c8:: with SMTP id 69mr50675200pfs.184.1554995228626;
        Thu, 11 Apr 2019 08:07:08 -0700 (PDT)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s12sm62905062pgc.28.2019.04.11.08.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:07:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     hch@infradead.org, clm@fb.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] io_uring: add support for IORING_OP_SYNC_FILE_RANGE
Date:   Thu, 11 Apr 2019 09:06:57 -0600
Message-Id: <20190411150657.18480-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411150657.18480-1-axboe@kernel.dk>
References: <20190411150657.18480-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This behaves just like sync_file_range(2) does.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 51 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/io_uring.h |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index a10fd5900a17..cc9854cd99f5 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1167,6 +1167,54 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	return 0;
 }
 
+static int io_prep_sfr(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+	int ret = 0;
+
+	if (!req->file)
+		return -EBADF;
+	/* Prep already done (EAGAIN retry) */
+	if (req->flags & REQ_F_PREPPED)
+		return 0;
+
+	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
+		return -EINVAL;
+	if (unlikely(sqe->addr || sqe->ioprio || sqe->buf_index))
+		return -EINVAL;
+
+	req->flags |= REQ_F_PREPPED;
+	return ret;
+}
+
+static int io_sync_file_range(struct io_kiocb *req,
+			      const struct io_uring_sqe *sqe,
+			      bool force_nonblock)
+{
+	loff_t sqe_off;
+	loff_t sqe_len;
+	unsigned flags;
+	int ret;
+
+	ret = io_prep_sfr(req, sqe);
+	if (ret)
+		return ret;
+
+	/* sync_file_range always requires a blocking context */
+	if (force_nonblock)
+		return -EAGAIN;
+
+	sqe_off = READ_ONCE(sqe->off);
+	sqe_len = READ_ONCE(sqe->len);
+	flags = READ_ONCE(sqe->sync_range_flags);
+
+	ret = sync_file_range(req->rw.ki_filp, sqe_off, sqe_len, flags);
+
+	io_cqring_add_event(req->ctx, sqe->user_data, ret, 0);
+	io_put_req(req);
+	return 0;
+}
+
 static void io_poll_remove_one(struct io_kiocb *req)
 {
 	struct io_poll_iocb *poll = &req->poll;
@@ -1450,6 +1498,9 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	case IORING_OP_POLL_REMOVE:
 		ret = io_poll_remove(req, s->sqe);
 		break;
+	case IORING_OP_SYNC_FILE_RANGE:
+		ret = io_sync_file_range(req, s->sqe, force_nonblock);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index a7a6384d0c70..e707a17c6908 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -26,6 +26,7 @@ struct io_uring_sqe {
 		__kernel_rwf_t	rw_flags;
 		__u32		fsync_flags;
 		__u16		poll_events;
+		__u32		sync_range_flags;
 	};
 	__u64	user_data;	/* data to be passed back at completion time */
 	union {
@@ -55,6 +56,7 @@ struct io_uring_sqe {
 #define IORING_OP_WRITE_FIXED	5
 #define IORING_OP_POLL_ADD	6
 #define IORING_OP_POLL_REMOVE	7
+#define IORING_OP_SYNC_FILE_RANGE	8
 
 /*
  * sqe->fsync_flags
-- 
2.17.1

