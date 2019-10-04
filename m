Return-Path: <SRS0=jhC6=X5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D464C4360C
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 16:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266F321D81
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 16:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="18Ksa2L2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfJDQWf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:22:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43346 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJDQWf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Oct 2019 12:22:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id a2so4178320pfo.10
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2019 09:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4AUJ4p6RmGuEEEDRwYnzEqE2rDh7QFx9cSdfYOJAWTU=;
        b=18Ksa2L2aEeTfoSeKmAvNj+d6JUqdYEEf22iP6G3/bfPgn2kdN4NYwEMUIrRL2V40v
         U958NIrKLkK6O2hN+6OiahwuXuiJEZpyRv81rmeWamuuQJpHNbqPwe4nUrsAdB8Retfe
         vaOvs89VGGIqcGygfSgyhEZXRL7Nw+s6e9sbIeWGJMZjYITVjVRuuapZiVYVQZdb5QYm
         Gq9pTfLz+CvCaNdl2rLZVYkZScO5PVXq6uosC3G23AehDYBw5rRSvBdQH6IWMc1d05MW
         XuFzfKFjYfYWDKICLdwgISAEnVb2Kmk3z/Uu1xLoQRTc8uq7gZ6FBpT0p7KS1p3emPU0
         dcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4AUJ4p6RmGuEEEDRwYnzEqE2rDh7QFx9cSdfYOJAWTU=;
        b=lNaRRy0N9TvKe8f8TNU9oqsffvEKnyBjTfp8U0ftI1rvAq5+p784Fx++itHJ1KBXEo
         wuBPFCeIMgPPt1Z2jpj469gILDTY928/L4ZNyU1Huwo+trlylsA3Q2iVaXelMqiyBmoI
         P0yzE5dEBJBc57FbbSL30srmuspFJL9xc+mGEx991l0s4U7qEgModDzJrAcKp0N6ddcg
         VVAIj+aZ5KVenk38egBKjC7r/pcyFP3O3DkOL+fjSPI8ZXFOtAglybuh7NRKftDqYx3P
         cd7RpE7KBcMVQpFbMrofJFvEGYA09E/ovopgcoyc1FfkkAJkFgpnBM/KWudiVzcYWzw+
         QKDQ==
X-Gm-Message-State: APjAAAWDaubA6eRo0hZLbNbo+QcS3qI5EeL2fBB51guaz1rjSintH2i/
        wlZgO4qPMFHADdZdgroUnfUcMMmG7DxRqg==
X-Google-Smtp-Source: APXvYqxZoyUfpcgFOFG7Y/L2RbkiUzaEhDqPpax5qMfFg7iqe8D7k21XxOF7/p2/eg4+4Svylc1HBg==
X-Received: by 2002:a65:6150:: with SMTP id o16mr1299354pgv.387.1570206153256;
        Fri, 04 Oct 2019 09:22:33 -0700 (PDT)
Received: from localhost.localdomain ([2600:380:7548:69cb:e476:ab55:1c76:9921])
        by smtp.gmail.com with ESMTPSA id v20sm994054pgh.89.2019.10.04.09.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 09:22:32 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] io_uring: add support for IORING_REGISTER_FILES_UPDATE
Date:   Fri,  4 Oct 2019 10:22:22 -0600
Message-Id: <20191004162222.10390-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004162222.10390-1-axboe@kernel.dk>
References: <20191004162222.10390-1-axboe@kernel.dk>
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
 fs/io_uring.c                 | 168 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/io_uring.h |   6 ++
 2 files changed, 174 insertions(+)

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
2.17.1

