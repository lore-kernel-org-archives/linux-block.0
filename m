Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9DEC77B78
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 16:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjDSQIL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 12:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjDSQIJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 12:08:09 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9FD7D8E
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 09:08:08 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-517f1d5645aso701101a12.0
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 09:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681920487; x=1684512487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Um+nb2+lFo5MMa4n2nYjynvYaU31qYFb1VpiGZ7Cvgw=;
        b=2PzymuSYk4PPc+s50xK30gm0bV3bqh1EJlQbCFi8Rc8LFgqujrwTJl6t8M7l8flvVH
         8OrNt0HVNeOjC49LnPmYemeY8UaOLFTxOXuougxBZv2eIXlhR+nwywWAH6bC1bDbGlIu
         lJc9GqbO9uoZ9yUf8SezN6OSLB26xcpqKiLvQwIh86t2PxUxIAShoiP0qoZMyB5WtAkt
         JzATZVz2QOm7GnjOKxQ8RauQL30sU4j6O2K90GONqsecOf3JOkhr6p3klTVG06F52JZ9
         KZvAr+LvkQ6S80pM/0GLSb5+rrPLhA+UD2K1mTXTU1Nr+EPwd79tbdUINeU8TaJ3r7Jf
         qQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681920487; x=1684512487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Um+nb2+lFo5MMa4n2nYjynvYaU31qYFb1VpiGZ7Cvgw=;
        b=JE5Iz4QkJVM9RkF40kUgZERf7bYDCejOi9xQIf/Cb4G0yBd6oM2dCBRNEBvdieVwpt
         4/u+221g4Rlk5awtE8spaRNrSNBPl+ichwtaPaew3Ylqlh7XRvDDaUdS67/JUXLvRZo1
         mH242ZfgpFOCcJt71a59g+zTVjuwhd9Jii1O+RqVZ/CYL2o/jHZAs879qwEZ9hXUKxkH
         1MksFEeQvu314GW4fWyicEJ7W5aXbflyvWf91XhX/NFjU97aEIfzlAivbo1/NOwGec7o
         5y6dKmlTCYYiY8Cxk+KjZbcSXJYVYmDhyM1ESUdR99oO1RyPMv7CilIQW4rPZHvLmjc9
         91AQ==
X-Gm-Message-State: AAQBX9ehO8iKHtOy59OvGw2A/esOWTtoY0IPKR1aNzxvmBnBiMaAWde8
        QEgRnF314O7ODUKRFqEq8vX4Ve6K0K/BsavQ4V4=
X-Google-Smtp-Source: AKy350Y1Z+GLs9OKWKYz7wdebqCXjVajV79W2LJbM/QWQm7IcP046Qx/VOptc17bSaOXQwXhoaumDQ==
X-Received: by 2002:a17:90a:199b:b0:249:78db:2635 with SMTP id 27-20020a17090a199b00b0024978db2635mr3557160pji.0.1681920487534;
        Wed, 19 Apr 2023 09:08:07 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ik14-20020a17090b428e00b00246f9725ffcsm1566258pjb.33.2023.04.19.09.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 09:08:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     luhongfei@vivo.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/6] Revert "io_uring: for requests that require async, force it"
Date:   Wed, 19 Apr 2023 10:07:58 -0600
Message-Id: <20230419160759.568904-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230419160759.568904-1-axboe@kernel.dk>
References: <20230419160759.568904-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This reverts commit aebb224fd4fc7352cd839ad90414c548387142fd.

In preparation for handling this a bit differently, revert this
cleanup.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/advise.c |  4 ++--
 io_uring/fs.c     | 20 ++++++++++----------
 io_uring/net.c    |  4 ++--
 io_uring/splice.c |  7 ++++---
 io_uring/statx.c  |  4 ++--
 io_uring/sync.c   | 14 ++++++--------
 io_uring/xattr.c  | 14 ++++++++------
 7 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/io_uring/advise.c b/io_uring/advise.c
index cf600579bffe..449c6f14649f 100644
--- a/io_uring/advise.c
+++ b/io_uring/advise.c
@@ -39,7 +39,6 @@ int io_madvise_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	ma->addr = READ_ONCE(sqe->addr);
 	ma->len = READ_ONCE(sqe->len);
 	ma->advice = READ_ONCE(sqe->fadvise_advice);
-	req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;
 #else
 	return -EOPNOTSUPP;
@@ -52,7 +51,8 @@ int io_madvise(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_madvise *ma = io_kiocb_to_cmd(req, struct io_madvise);
 	int ret;
 
-	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
 
 	ret = do_madvise(current->mm, ma->addr, ma->len, ma->advice);
 	io_req_set_res(req, ret, 0);
diff --git a/io_uring/fs.c b/io_uring/fs.c
index f6a69a549fd4..7100c293c13a 100644
--- a/io_uring/fs.c
+++ b/io_uring/fs.c
@@ -74,7 +74,6 @@ int io_renameat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	}
 
 	req->flags |= REQ_F_NEED_CLEANUP;
-	req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;
 }
 
@@ -83,7 +82,8 @@ int io_renameat(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_rename *ren = io_kiocb_to_cmd(req, struct io_rename);
 	int ret;
 
-	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
 
 	ret = do_renameat2(ren->old_dfd, ren->oldpath, ren->new_dfd,
 				ren->newpath, ren->flags);
@@ -123,7 +123,6 @@ int io_unlinkat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return PTR_ERR(un->filename);
 
 	req->flags |= REQ_F_NEED_CLEANUP;
-	req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;
 }
 
@@ -132,7 +131,8 @@ int io_unlinkat(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_unlink *un = io_kiocb_to_cmd(req, struct io_unlink);
 	int ret;
 
-	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
 
 	if (un->flags & AT_REMOVEDIR)
 		ret = do_rmdir(un->dfd, un->filename);
@@ -170,7 +170,6 @@ int io_mkdirat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return PTR_ERR(mkd->filename);
 
 	req->flags |= REQ_F_NEED_CLEANUP;
-	req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;
 }
 
@@ -179,7 +178,8 @@ int io_mkdirat(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_mkdir *mkd = io_kiocb_to_cmd(req, struct io_mkdir);
 	int ret;
 
-	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
 
 	ret = do_mkdirat(mkd->dfd, mkd->filename, mkd->mode);
 
@@ -220,7 +220,6 @@ int io_symlinkat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	}
 
 	req->flags |= REQ_F_NEED_CLEANUP;
-	req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;
 }
 
@@ -229,7 +228,8 @@ int io_symlinkat(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_link *sl = io_kiocb_to_cmd(req, struct io_link);
 	int ret;
 
-	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
 
 	ret = do_symlinkat(sl->oldpath, sl->new_dfd, sl->newpath);
 
@@ -265,7 +265,6 @@ int io_linkat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	}
 
 	req->flags |= REQ_F_NEED_CLEANUP;
-	req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;
 }
 
@@ -274,7 +273,8 @@ int io_linkat(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_link *lnk = io_kiocb_to_cmd(req, struct io_link);
 	int ret;
 
-	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
 
 	ret = do_linkat(lnk->old_dfd, lnk->oldpath, lnk->new_dfd,
 				lnk->newpath, lnk->flags);
diff --git a/io_uring/net.c b/io_uring/net.c
index 89e839013837..e85a868290ec 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -91,7 +91,6 @@ int io_shutdown_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return -EINVAL;
 
 	shutdown->how = READ_ONCE(sqe->len);
-	req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;
 }
 
@@ -101,7 +100,8 @@ int io_shutdown(struct io_kiocb *req, unsigned int issue_flags)
 	struct socket *sock;
 	int ret;
 
-	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
 
 	sock = sock_from_file(req->file);
 	if (unlikely(!sock))
diff --git a/io_uring/splice.c b/io_uring/splice.c
index 2a4bbb719531..53e4232d0866 100644
--- a/io_uring/splice.c
+++ b/io_uring/splice.c
@@ -34,7 +34,6 @@ static int __io_splice_prep(struct io_kiocb *req,
 	if (unlikely(sp->flags & ~valid_flags))
 		return -EINVAL;
 	sp->splice_fd_in = READ_ONCE(sqe->splice_fd_in);
-	req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;
 }
 
@@ -53,7 +52,8 @@ int io_tee(struct io_kiocb *req, unsigned int issue_flags)
 	struct file *in;
 	long ret = 0;
 
-	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
 
 	if (sp->flags & SPLICE_F_FD_IN_FIXED)
 		in = io_file_get_fixed(req, sp->splice_fd_in, issue_flags);
@@ -94,7 +94,8 @@ int io_splice(struct io_kiocb *req, unsigned int issue_flags)
 	struct file *in;
 	long ret = 0;
 
-	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
 
 	if (sp->flags & SPLICE_F_FD_IN_FIXED)
 		in = io_file_get_fixed(req, sp->splice_fd_in, issue_flags);
diff --git a/io_uring/statx.c b/io_uring/statx.c
index abb874209caa..d8fc933d3f59 100644
--- a/io_uring/statx.c
+++ b/io_uring/statx.c
@@ -48,7 +48,6 @@ int io_statx_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	}
 
 	req->flags |= REQ_F_NEED_CLEANUP;
-	req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;
 }
 
@@ -57,7 +56,8 @@ int io_statx(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_statx *sx = io_kiocb_to_cmd(req, struct io_statx);
 	int ret;
 
-	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
 
 	ret = do_statx(sx->dfd, sx->filename, sx->flags, sx->mask, sx->buffer);
 	io_req_set_res(req, ret, 0);
diff --git a/io_uring/sync.c b/io_uring/sync.c
index 255f68c37e55..64e87ea2b8fb 100644
--- a/io_uring/sync.c
+++ b/io_uring/sync.c
@@ -32,8 +32,6 @@ int io_sfr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	sync->off = READ_ONCE(sqe->off);
 	sync->len = READ_ONCE(sqe->len);
 	sync->flags = READ_ONCE(sqe->sync_range_flags);
-	req->flags |= REQ_F_FORCE_ASYNC;
-
 	return 0;
 }
 
@@ -43,7 +41,8 @@ int io_sync_file_range(struct io_kiocb *req, unsigned int issue_flags)
 	int ret;
 
 	/* sync_file_range always requires a blocking context */
-	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
 
 	ret = sync_file_range(req->file, sync->off, sync->len, sync->flags);
 	io_req_set_res(req, ret, 0);
@@ -63,7 +62,6 @@ int io_fsync_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 
 	sync->off = READ_ONCE(sqe->off);
 	sync->len = READ_ONCE(sqe->len);
-	req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;
 }
 
@@ -74,7 +72,8 @@ int io_fsync(struct io_kiocb *req, unsigned int issue_flags)
 	int ret;
 
 	/* fsync always requires a blocking context */
-	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
 
 	ret = vfs_fsync_range(req->file, sync->off, end > 0 ? end : LLONG_MAX,
 				sync->flags & IORING_FSYNC_DATASYNC);
@@ -92,7 +91,6 @@ int io_fallocate_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	sync->off = READ_ONCE(sqe->off);
 	sync->len = READ_ONCE(sqe->addr);
 	sync->mode = READ_ONCE(sqe->len);
-	req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;
 }
 
@@ -102,8 +100,8 @@ int io_fallocate(struct io_kiocb *req, unsigned int issue_flags)
 	int ret;
 
 	/* fallocate always requiring blocking context */
-	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
-
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
 	ret = vfs_fallocate(req->file, sync->mode, sync->off, sync->len);
 	if (ret >= 0)
 		fsnotify_modify(req->file);
diff --git a/io_uring/xattr.c b/io_uring/xattr.c
index e1c810e0b85a..6201a9f442c6 100644
--- a/io_uring/xattr.c
+++ b/io_uring/xattr.c
@@ -75,7 +75,6 @@ static int __io_getxattr_prep(struct io_kiocb *req,
 	}
 
 	req->flags |= REQ_F_NEED_CLEANUP;
-	req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;
 }
 
@@ -110,7 +109,8 @@ int io_fgetxattr(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_xattr *ix = io_kiocb_to_cmd(req, struct io_xattr);
 	int ret;
 
-	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
 
 	ret = do_getxattr(mnt_idmap(req->file->f_path.mnt),
 			req->file->f_path.dentry,
@@ -127,7 +127,8 @@ int io_getxattr(struct io_kiocb *req, unsigned int issue_flags)
 	struct path path;
 	int ret;
 
-	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
 
 retry:
 	ret = filename_lookup(AT_FDCWD, ix->filename, lookup_flags, &path, NULL);
@@ -173,7 +174,6 @@ static int __io_setxattr_prep(struct io_kiocb *req,
 	}
 
 	req->flags |= REQ_F_NEED_CLEANUP;
-	req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;
 }
 
@@ -222,7 +222,8 @@ int io_fsetxattr(struct io_kiocb *req, unsigned int issue_flags)
 {
 	int ret;
 
-	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
 
 	ret = __io_setxattr(req, issue_flags, &req->file->f_path);
 	io_xattr_finish(req, ret);
@@ -236,7 +237,8 @@ int io_setxattr(struct io_kiocb *req, unsigned int issue_flags)
 	struct path path;
 	int ret;
 
-	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
 
 retry:
 	ret = filename_lookup(AT_FDCWD, ix->filename, lookup_flags, &path, NULL);
-- 
2.39.2

