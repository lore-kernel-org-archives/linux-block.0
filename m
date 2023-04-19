Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC73C6FD18
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 16:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjDSQIM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 12:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjDSQIK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 12:08:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5018846B9
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 09:08:09 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-24b276ee13bso106725a91.1
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 09:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681920488; x=1684512488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jnh79NqHUAliOqaj/jfm7JDhwlum7MQ336y4gZPZSHY=;
        b=Wbfles3TmPajiZfieH3+BfAh0FXOhCPE60gNG+87++FUSGkhJ0MH6pZfDIycOdbLWg
         B+983B/vIu/Nk4bkE6BzEcdGgwSEbVLgTKwdOh+TwMNc06Juf2bwLrglG7aVe0S3XmV6
         yQDmbX8HUsjwMLI3jPtByC0d/yvKZ9OnRSld+dk1q5GN96m6oyD/OYqWCbavBHERkSg4
         2fx/GueQL0SIBua/kntrTYbT8dOv0nAU3vi3eMOmeg2vuIs05hOJu4MxR6+p+/e5509z
         sTnfin673K0nNZ2qXu3W4yEeIRqEt5wUFXEs+h+uA7eFa4V7GjZ/TnAT44sQw82vbvCc
         j/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681920488; x=1684512488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jnh79NqHUAliOqaj/jfm7JDhwlum7MQ336y4gZPZSHY=;
        b=PUZRDBSXRCvZ+GB30uShoLd7AXZjUrSdNK647RrAO97IlEw6yyt/5Ij7VOLFb8UAjB
         Uf2qK/+NgSV1AFiv3yFRyMss7dFaUpCsh9G5SIp9SborXQqYb0FrOmEXvM6Rd2NbEmLH
         UrOqr7CqhewYJQp789VEOM/4su5KjmaM9H2U7wCKDiIxJEvfAMP+HiuApOiK+H421sbH
         PgGy9YMdpS5VSqFKDN2UxM+DziuIQtfZQ3ScYhWQCWNx7DdaJj4V60FMcPBDZb1sbX8z
         AnP9z9WWojtNxzL5ji0V5rvBGh5eXAB6BfhyP0NJxzh/cgPoL8HFEsAn9/SCzmkrrXzV
         3dRg==
X-Gm-Message-State: AAQBX9c/nA6ewK98g8rkw6fpDJ0M9TDh8jrHtiknDXbCIDUrOfD4lGg+
        h6vjmQ+ehZ70txYh4aySDH0rkvnK1jFSMJqbC3w=
X-Google-Smtp-Source: AKy350YWc/uWeD9XLRa15hVWqXxme0dhhXLvGCt+eEVe1ReCPOZ4qfayUp17lkwbR498SLPwykcWQQ==
X-Received: by 2002:a17:90a:1de:b0:240:cf04:c997 with SMTP id 30-20020a17090a01de00b00240cf04c997mr16459798pjd.2.1681920488519;
        Wed, 19 Apr 2023 09:08:08 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ik14-20020a17090b428e00b00246f9725ffcsm1566258pjb.33.2023.04.19.09.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 09:08:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     luhongfei@vivo.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/6] io_uring: mark opcodes that always need io-wq punt
Date:   Wed, 19 Apr 2023 10:07:59 -0600
Message-Id: <20230419160759.568904-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230419160759.568904-1-axboe@kernel.dk>
References: <20230419160759.568904-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add an opdef bit for them, and set it for the opcodes where we always
need io-wq punt. With that done, exclude them from the file_can_poll()
check in terms of whether or not we need to punt them if any of the
NO_OFFLOAD flags are set.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io_uring.c |  2 +-
 io_uring/opdef.c    | 22 ++++++++++++++++++++--
 io_uring/opdef.h    |  2 ++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 04770b06de16..91045270b665 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1948,7 +1948,7 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 		return -EBADF;
 
 	if (req->flags & REQ_F_NO_OFFLOAD &&
-	    (!req->file || !file_can_poll(req->file)))
+	    (!req->file || !file_can_poll(req->file) || def->always_iowq))
 		issue_flags &= ~IO_URING_F_NONBLOCK;
 
 	if (unlikely((req->flags & REQ_F_CREDS) && req->creds != current_cred()))
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index cca7c5b55208..686d46001622 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -82,6 +82,7 @@ const struct io_issue_def io_issue_defs[] = {
 	[IORING_OP_FSYNC] = {
 		.needs_file		= 1,
 		.audit_skip		= 1,
+		.always_iowq		= 1,
 		.prep			= io_fsync_prep,
 		.issue			= io_fsync,
 	},
@@ -125,6 +126,7 @@ const struct io_issue_def io_issue_defs[] = {
 	[IORING_OP_SYNC_FILE_RANGE] = {
 		.needs_file		= 1,
 		.audit_skip		= 1,
+		.always_iowq		= 1,
 		.prep			= io_sfr_prep,
 		.issue			= io_sync_file_range,
 	},
@@ -202,6 +204,7 @@ const struct io_issue_def io_issue_defs[] = {
 	},
 	[IORING_OP_FALLOCATE] = {
 		.needs_file		= 1,
+		.always_iowq		= 1,
 		.prep			= io_fallocate_prep,
 		.issue			= io_fallocate,
 	},
@@ -221,6 +224,7 @@ const struct io_issue_def io_issue_defs[] = {
 	},
 	[IORING_OP_STATX] = {
 		.audit_skip		= 1,
+		.always_iowq		= 1,
 		.prep			= io_statx_prep,
 		.issue			= io_statx,
 	},
@@ -253,11 +257,13 @@ const struct io_issue_def io_issue_defs[] = {
 	[IORING_OP_FADVISE] = {
 		.needs_file		= 1,
 		.audit_skip		= 1,
+		.always_iowq		= 1,
 		.prep			= io_fadvise_prep,
 		.issue			= io_fadvise,
 	},
 	[IORING_OP_MADVISE] = {
 		.audit_skip		= 1,
+		.always_iowq		= 1,
 		.prep			= io_madvise_prep,
 		.issue			= io_madvise,
 	},
@@ -308,6 +314,7 @@ const struct io_issue_def io_issue_defs[] = {
 		.hash_reg_file		= 1,
 		.unbound_nonreg_file	= 1,
 		.audit_skip		= 1,
+		.always_iowq		= 1,
 		.prep			= io_splice_prep,
 		.issue			= io_splice,
 	},
@@ -328,11 +335,13 @@ const struct io_issue_def io_issue_defs[] = {
 		.hash_reg_file		= 1,
 		.unbound_nonreg_file	= 1,
 		.audit_skip		= 1,
+		.always_iowq		= 1,
 		.prep			= io_tee_prep,
 		.issue			= io_tee,
 	},
 	[IORING_OP_SHUTDOWN] = {
 		.needs_file		= 1,
+		.always_iowq		= 1,
 #if defined(CONFIG_NET)
 		.prep			= io_shutdown_prep,
 		.issue			= io_shutdown,
@@ -343,22 +352,27 @@ const struct io_issue_def io_issue_defs[] = {
 	[IORING_OP_RENAMEAT] = {
 		.prep			= io_renameat_prep,
 		.issue			= io_renameat,
+		.always_iowq		= 1,
 	},
 	[IORING_OP_UNLINKAT] = {
 		.prep			= io_unlinkat_prep,
 		.issue			= io_unlinkat,
+		.always_iowq		= 1,
 	},
 	[IORING_OP_MKDIRAT] = {
 		.prep			= io_mkdirat_prep,
 		.issue			= io_mkdirat,
+		.always_iowq		= 1,
 	},
 	[IORING_OP_SYMLINKAT] = {
 		.prep			= io_symlinkat_prep,
 		.issue			= io_symlinkat,
+		.always_iowq		= 1,
 	},
 	[IORING_OP_LINKAT] = {
 		.prep			= io_linkat_prep,
 		.issue			= io_linkat,
+		.always_iowq		= 1,
 	},
 	[IORING_OP_MSG_RING] = {
 		.needs_file		= 1,
@@ -367,20 +381,24 @@ const struct io_issue_def io_issue_defs[] = {
 		.issue			= io_msg_ring,
 	},
 	[IORING_OP_FSETXATTR] = {
-		.needs_file = 1,
+		.needs_file		= 1,
+		.always_iowq		= 1,
 		.prep			= io_fsetxattr_prep,
 		.issue			= io_fsetxattr,
 	},
 	[IORING_OP_SETXATTR] = {
+		.always_iowq		= 1,
 		.prep			= io_setxattr_prep,
 		.issue			= io_setxattr,
 	},
 	[IORING_OP_FGETXATTR] = {
-		.needs_file = 1,
+		.needs_file		= 1,
+		.always_iowq		= 1,
 		.prep			= io_fgetxattr_prep,
 		.issue			= io_fgetxattr,
 	},
 	[IORING_OP_GETXATTR] = {
+		.always_iowq		= 1,
 		.prep			= io_getxattr_prep,
 		.issue			= io_getxattr,
 	},
diff --git a/io_uring/opdef.h b/io_uring/opdef.h
index c22c8696e749..657a831249ff 100644
--- a/io_uring/opdef.h
+++ b/io_uring/opdef.h
@@ -29,6 +29,8 @@ struct io_issue_def {
 	unsigned		iopoll_queue : 1;
 	/* opcode specific path will handle ->async_data allocation if needed */
 	unsigned		manual_alloc : 1;
+	/* op always needs io-wq offload */
+	unsigned		always_iowq : 1;
 
 	int (*issue)(struct io_kiocb *, unsigned int);
 	int (*prep)(struct io_kiocb *, const struct io_uring_sqe *);
-- 
2.39.2

