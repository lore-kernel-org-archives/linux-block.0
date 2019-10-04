Return-Path: <SRS0=jhC6=X5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C0DC4360C
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 14:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B012084D
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 14:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="saSozOFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389131AbfJDOw4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:52:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39936 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389087AbfJDOw4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Oct 2019 10:52:56 -0400
Received: by mail-io1-f65.google.com with SMTP id h144so14092345iof.7
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2019 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=PkJQfQcmdExXDv3KtliEGskQNB/GIuUZe4NI8uZnM5I=;
        b=saSozOFch78yM+mzqyZk3hKgNKNAAvSK3cp4Z3RSNk9yeVNQNjrv3fSkLNzOqIokd6
         dS0m7uaT8ewid/ZWeGGN14lKiBJmdarD2si1A8m6xc62xb3LQvaDwqdNRV9ZiDGalWbQ
         w5P2XTJRUrakMRnO6nb1vsxYC9PrDgfor8jyzR/LHlFxJXwtt6k+DZAwwpi+8K933MM2
         /6XMQbcnQz06vDRWRWrndtc6arstVA/LbGj3XGY3u8gIF6S6gFHf3hAJbdtbcd1AcHsZ
         Yn/zpiClz6LP1GCSpwFpDHN16Gt3u2DP6XVnEU0OQ2E7+OG5E/U3XZwibnWP1XuqpnuY
         n0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=PkJQfQcmdExXDv3KtliEGskQNB/GIuUZe4NI8uZnM5I=;
        b=iMOGuX+Cbrqo79MAQ5sRCG/dp3ta/zRwvnlWrpRnouhYheJTFygSuTdMRDXxqJsiAW
         KBODq1zqR/CKmYux23NjjkzWU0uGuizERYTaBcI4k8nL7YxKF9p7iuhyRPguQsZprJQc
         xa4A5vNM2lhALHaZ7HMro2C8rrE8+d1W9/EPzwRYfWFOWKYcpYglELFw/Pdc93kSHRSn
         pN8oa0JhRqDIhx6+2tsIVGDp8JH+m1zGRjrQG6WfgSkaify2okpYdtOCgKPWlwYinq7Z
         VZHcw6u0GJ4SQvEmsDhhD9MjVdtdJ8a0/09Z6drQO678QcLTv+a1NL9ppD7u3dVDBYTk
         8wHw==
X-Gm-Message-State: APjAAAU+CR2PpY/TfhiNC7P6QXFJ75CKeEmp+k1sq7FmgHzQdAzUwi+d
        HsKV9ALBhTnMa921x5IZAG2CgItyDP67rQ==
X-Google-Smtp-Source: APXvYqxLDwQ7ETov5TlAMYlz1xolxdKKK0nk7p0n6iD/U/9XbDCQsvksNE3sR1PKhMArOgRBH2+Lgw==
X-Received: by 2002:a05:6638:3:: with SMTP id z3mr15190887jao.54.1570200774709;
        Fri, 04 Oct 2019 07:52:54 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v3sm2149383ioh.51.2019.10.04.07.52.53
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 07:52:53 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: add support for IORING_REGISTER_FILES_UPDATE
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <a7bc8d7f-2379-7492-93af-6ca0353c5eab@kernel.dk>
Date:   Fri, 4 Oct 2019 08:52:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Allows the application to remove/replace/add files to/from a file set.
Passes in a struct:

struct io_uring_files_update {
        __u32 offset;
        __s32 *fds;
};

that holds an array of fds, size of array passed in through the usual
nr_args part of the io_uring_register() system call. The logic is as
follows:

1) If ->fds[i] is -1, the existing file at i + ->offset is removed from
   the set.
2) If ->fds[i] is a valid fd, the existing file at i + ->offset is
   replaced with ->fds[i].

For case #2, is the existing file is currently empty (fd == -1), the
new fd is simply added to the array.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

liburing has a test case for this, test/file-register.c

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6d4f1394cfca..8afb0b689523 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3155,6 +3155,171 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 	return ret;
 }
 
+static void io_sqe_file_unregister(struct io_ring_ctx *ctx, int index)
+{
+#if defined(CONFIG_UNIX)
+	struct file *file = ctx->user_files[index];
+	struct sock *sock = ctx->ring_sock->sk;
+	struct sk_buff_head list, *head = &sock->sk_receive_queue;
+	struct sk_buff *skb;
+	int i;
+
+	__skb_queue_head_init(&list);
+
+	/*
+	 * Find the skb that holds this file in its SCM_RIGHTS. When found,
+	 * remove this entry and rearrange the file array.
+	 */
+	skb = skb_dequeue(head);
+	while (skb) {
+		struct scm_fp_list *fp;
+
+		fp = UNIXCB(skb).fp;
+		for (i = 0; i < fp->count; i++) {
+			int left;
+
+			if (fp->fp[i] != file)
+				continue;
+
+			unix_notinflight(fp->user, fp->fp[i]);
+			left = fp->count - 1 - i;
+			if (left) {
+				memmove(&fp->fp[i], &fp->fp[i + 1],
+						left * sizeof(struct file *));
+			}
+			fp->count--;
+			if (!fp->count) {
+				kfree_skb(skb);
+				skb = NULL;
+			} else if (skb_peek(&list)) {
+				spin_lock_irq(&head->lock);
+				__skb_queue_tail(&list, skb);
+				while ((skb = __skb_dequeue(&list)) != NULL)
+					__skb_queue_tail(head, skb);
+				spin_unlock_irq(&head->lock);
+			}
+			file = NULL;
+			break;
+		}
+
+		if (!file)
+			break;
+
+		__skb_queue_tail(&list, skb);
+
+		skb = skb_dequeue(head);
+	}
+#else
+	fput(ctx->user_files[index]);
+#endif
+}
+
+static int io_sqe_file_register(struct io_ring_ctx *ctx, struct file *file,
+				int index)
+{
+#if defined(CONFIG_UNIX)
+	struct sock *sock = ctx->ring_sock->sk;
+	struct sk_buff_head *head = &sock->sk_receive_queue;
+	struct sk_buff *skb;
+
+	/*
+	 * See if we can merge this file into an existing skb SCM_RIGHTS
+	 * file set. If there's no room, fall back to allocating a new skb
+	 * and filling it in.
+	 */
+	spin_lock_irq(&head->lock);
+	skb = skb_peek(head);
+	if (skb) {
+		struct scm_fp_list *fpl = UNIXCB(skb).fp;
+
+		if (fpl->count < SCM_MAX_FD) {
+			__skb_unlink(skb, head);
+			spin_unlock_irq(&head->lock);
+			fpl->fp[fpl->count] = get_file(file);
+			unix_inflight(fpl->user, fpl->fp[fpl->count]);
+			fpl->count++;
+			spin_lock_irq(&head->lock);
+			__skb_queue_head(head, skb);
+		} else {
+			skb = NULL;
+		}
+	}
+	spin_unlock_irq(&head->lock);
+
+	if (skb) {
+		fput(file);
+		return 0;
+	}
+
+	return __io_sqe_files_scm(ctx, 1, index);
+#else
+	return 0;
+#endif
+}
+
+static int io_sqe_files_update(struct io_ring_ctx *ctx, void __user *arg,
+			       unsigned nr_args)
+{
+	struct io_uring_files_update up;
+	int fd, i, err, done;
+	__s32 __user *fds;
+
+	if (!ctx->user_files)
+		return -ENXIO;
+	if (!nr_args)
+		return -EINVAL;
+	if (copy_from_user(&up, arg, sizeof(up)))
+		return -EFAULT;
+	if (up.offset + nr_args > ctx->nr_user_files)
+		return -EINVAL;
+
+	done = 0;
+	i = up.offset;
+	fds = (__s32 __user *) up.fds;
+	while (nr_args) {
+		err = 0;
+		if (copy_from_user(&fd, &fds[done], sizeof(fd))) {
+			err = -EFAULT;
+			break;
+		}
+		if (ctx->user_files[i]) {
+			io_sqe_file_unregister(ctx, i);
+			ctx->user_files[i] = NULL;
+		}
+		if (fd != -1) {
+			struct file *file;
+
+			file = fget(fd);
+			if (!file) {
+				err = -EBADF;
+				break;
+			}
+			/*
+			 * Don't allow io_uring instances to be registered. If
+			 * UNIX isn't enabled, then this causes a reference
+			 * cycle and this instance can never get freed. If UNIX
+			 * is enabled we'll handle it just fine, but there's
+			 * still no point in allowing a ring fd as it doesn't
+			 * support regular read/write anyway.
+			 */
+			if (file->f_op == &io_uring_fops) {
+				fput(file);
+				err = -EBADF;
+				break;
+			}
+			ctx->user_files[i] = file;
+			err = io_sqe_file_register(ctx, file, i);
+			if (err)
+				break;
+		}
+		nr_args--;
+		done++;
+		i++;
+	}
+
+	return done ? done : err;
+}
+
 static int io_sq_offload_start(struct io_ring_ctx *ctx,
 			       struct io_uring_params *p)
 {
@@ -3969,6 +4134,9 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 			break;
 		ret = io_sqe_files_unregister(ctx);
 		break;
+	case IORING_REGISTER_FILES_UPDATE:
+		ret = io_sqe_files_update(ctx, arg, nr_args);
+		break;
 	case IORING_REGISTER_EVENTFD:
 		ret = -EINVAL;
 		if (nr_args != 1)
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index ea57526a5b89..4f532d9c0554 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -150,5 +150,11 @@ struct io_uring_params {
 #define IORING_UNREGISTER_FILES		3
 #define IORING_REGISTER_EVENTFD		4
 #define IORING_UNREGISTER_EVENTFD	5
+#define IORING_REGISTER_FILES_UPDATE	6
+
+struct io_uring_files_update {
+	__u32 offset;
+	__s32 *fds;
+};
 
 #endif
-- 
Jens Axboe

