Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7C8CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 09:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F0921D7F
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 09:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuS9QpWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393432AbfJYJso (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:48:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34443 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391988AbfJYJso (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 05:48:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id v3so3876885wmh.1;
        Fri, 25 Oct 2019 02:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PbZJjJkcDbRa2jyiqXRye8Uft6NF4gJ4dI1yRNucC5g=;
        b=XuS9QpWt54AiMiADRoUMWu/nk1TqL/V8Fa04f9OcNcWQyl64sMQ2Vh3VQ2EKrDRUh3
         5jsyB6DcCsIzUryN8LxiVThvCaHWvPuC7U27FOTqgZsc5IdYky3dw2iOICg4Ww7Zto4g
         U4abpkhkl/lCfazbRVNDACcEKmSkBGBxVSFDiT+yQK5zSLn2TsJMx6Dw+xFmjZpTolcT
         6iOQaCT8Hkoeyto8C0tXzDB8J/dvyPlo1B8I93b58eexbt70bLH6j0ecfalN8BD61Y4W
         KpZ+NbJGnnYv68NAS5EvPZnvy4gXWHo/n4EzuVWXvx8umc1cwrfH/PMep2GTCvfbyYq7
         xsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PbZJjJkcDbRa2jyiqXRye8Uft6NF4gJ4dI1yRNucC5g=;
        b=HIF4X0bINPxvP4UjyfYJDyhkQEItOX1FDVpGGbcvYM+uUmuX9golKO71WZS+JPMXnF
         3BnpLREw2nUoZDlL/mf3vNfgMZImpZpVWXtoUAiUg0ZlPdB+Idf1vj9uk6/2pdpv9vmO
         /3a9wvhPwfzc+Byao6XlEL60Gd4eSEDF0bY0A2i4TXVpZpsUbCrsaGi8gU2vgt6LvR69
         fWuWnuTnnwHHgKa6yIyFUFNjBND8g96kNWS6bQPkKdRmErnkGfjciZvGQzzJUsTbRIyj
         7YSGbdc5wkQwWBSK0dEJ02gGXL6jYH0EMXCv71WCsoFQRnUu+eClt2YE5ODH7tW3+GaN
         TSaw==
X-Gm-Message-State: APjAAAUrWPxHx6VpbAfhG0T4aCyJMQy+aE37smovT/Waj+xDsgNr93HW
        wAx6bb8UOX20lfu5sbdHgdM=
X-Google-Smtp-Source: APXvYqxmHc3b2X2s9OqWhaR0GvGvllUHGzTh/nr7k1j4PGKoDGZNZEQGZzgS882JzOeDyGjNyjesig==
X-Received: by 2002:a1c:9d13:: with SMTP id g19mr1640770wme.159.1571996920893;
        Fri, 25 Oct 2019 02:48:40 -0700 (PDT)
Received: from localhost.localdomain ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id j14sm2018659wrj.35.2019.10.25.02.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 02:48:40 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH liburing 1/1] test/defer: Test deferring with drain and links
Date:   Fri, 25 Oct 2019 12:48:30 +0300
Message-Id: <b9509294fde6425b000d71613bd352059334c60d.1571995330.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

1. test user_data integrity with cancelled links
2. test the whole link is cancelled by sq_thread
3. hunging io_uring based on koverflow and kdropped

Be aware, that this test may leave unkillable user process, or
unstopped actively polling kthread.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 test/Makefile |   4 +-
 test/defer.c  | 257 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 259 insertions(+), 2 deletions(-)
 create mode 100644 test/defer.c

diff --git a/test/Makefile b/test/Makefile
index 3ab5f81..250fb0f 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -7,7 +7,7 @@ all_targets += poll poll-cancel ring-leak fsync io_uring_setup io_uring_register
 		917257daa0fe-test b19062a56726-test eeed8b54e0df-test link \
 		send_recvmsg a4c0b3decb33-test 500f9fbadef8-test timeout \
 		sq-space_left stdout cq-ready cq-peek-batch file-register \
-		cq-size 8a9973408177-test a0908ae19763-test
+		cq-size 8a9973408177-test a0908ae19763-test defer
 
 include ../Makefile.quiet
 
@@ -22,7 +22,7 @@ test_srcs := poll.c poll-cancel.c ring-leak.c fsync.c io_uring_setup.c \
 	eeed8b54e0df-test.c link.c send_recvmsg.c a4c0b3decb33-test.c \
 	500f9fbadef8-test.c timeout.c sq-space_left.c stdout.c cq-ready.c\
 	cq-peek-batch.c file-register.c cq-size.c 8a9973408177-test.c \
-	a0908ae19763-test.c
+	a0908ae19763-test.c defer.c
 
 test_objs := $(patsubst %.c,%.ol,$(test_srcs))
 
diff --git a/test/defer.c b/test/defer.c
new file mode 100644
index 0000000..db0d904
--- /dev/null
+++ b/test/defer.c
@@ -0,0 +1,257 @@
+#include <errno.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <sys/uio.h>
+#include <stdbool.h>
+
+#include "liburing.h"
+
+struct test_context {
+	struct io_uring *ring;
+	struct io_uring_sqe **sqes;
+	struct io_uring_cqe *cqes;
+	int nr;
+};
+
+static void free_context(struct test_context *ctx)
+{
+	free(ctx->sqes);
+	free(ctx->cqes);
+	memset(ctx, 0, sizeof(*ctx));
+}
+
+static int init_context(struct test_context *ctx, struct io_uring *ring, int nr)
+{
+	struct io_uring_sqe *sqe;
+	int i;
+
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->nr = nr;
+	ctx->ring = ring;
+	ctx->sqes = malloc(nr * sizeof(*ctx->sqes));
+	ctx->cqes = malloc(nr * sizeof(*ctx->cqes));
+
+	if (!ctx->sqes || !ctx->cqes)
+		goto err;
+
+	for (i = 0; i < nr; i++) {
+		sqe = io_uring_get_sqe(ring);
+		if (!sqe)
+			goto err;
+		io_uring_prep_nop(sqe);
+		sqe->user_data = i;
+		ctx->sqes[i] = sqe;
+	}
+
+	return 0;
+err:
+	free_context(ctx);
+	printf("init context failed\n");
+	return 1;
+}
+
+static int wait_cqes(struct test_context *ctx)
+{
+	int ret, i;
+	struct io_uring_cqe *cqe;
+
+	for (i = 0; i < ctx->nr; i++) {
+		ret = io_uring_wait_cqe(ctx->ring, &cqe);
+
+		if (ret < 0) {
+			printf("wait_cqes: wait completion %d\n", ret);
+			return 1;
+		}
+		memcpy(&ctx->cqes[i], cqe, sizeof(*cqe));
+		io_uring_cqe_seen(ctx->ring, cqe);
+	}
+
+	return 0;
+}
+
+static int test_cancelled_userdata(struct io_uring *ring)
+{
+	struct test_context ctx;
+	int ret, i, nr = 100;
+
+	if (init_context(&ctx, ring, nr))
+		return 1;
+
+	for (i = 0; i < nr; i++)
+		ctx.sqes[i]->flags |= IOSQE_IO_LINK;
+
+	ret = io_uring_submit(ring);
+	if (ret <= 0) {
+		printf("sqe submit failed: %d\n", ret);
+		goto err;
+	}
+
+	if (wait_cqes(&ctx))
+		goto err;
+
+	for (int i = 0; i < nr; i++) {
+		if (i != ctx.cqes[i].user_data) {
+			printf("invalid user data\n");
+			goto err;
+		}
+	}
+
+	free_context(&ctx);
+	return 0;
+err:
+	free_context(&ctx);
+	return 1;
+}
+
+static int test_thread_link_cancel(struct io_uring *ring)
+{
+	struct test_context ctx;
+	int ret, i, nr = 100;
+
+	if (init_context(&ctx, ring, nr))
+		return 1;
+
+	for (i = 0; i < nr; i++)
+		ctx.sqes[i]->flags |= IOSQE_IO_LINK;
+
+	ret = io_uring_submit(ring);
+	if (ret <= 0) {
+		printf("sqe submit failed: %d\n", ret);
+		goto err;
+	}
+
+	if (wait_cqes(&ctx))
+		goto err;
+
+	for (int i = 0; i < nr; i++) {
+		bool fail = false;
+
+		if (i == 0)
+			fail = (ctx.cqes[i].res != -EINVAL);
+		else
+			fail = (ctx.cqes[i].res != -ECANCELED);
+
+		if (fail) {
+			printf("invalid status\n");
+			goto err;
+		}
+	}
+
+	free_context(&ctx);
+	return 0;
+err:
+	free_context(&ctx);
+	return 1;
+}
+
+static int run_drained(struct io_uring *ring, int nr)
+{
+	struct test_context ctx;
+	int ret, i;
+
+	if (init_context(&ctx, ring, nr))
+		return 1;
+
+	for (i = 0; i < nr; i++)
+		ctx.sqes[i]->flags |= IOSQE_IO_DRAIN;
+
+	ret = io_uring_submit(ring);
+	if (ret <= 0) {
+		printf("sqe submit failed: %d\n", ret);
+		goto err;
+	}
+
+	if (wait_cqes(&ctx))
+		goto err;
+
+	free_context(&ctx);
+	return 0;
+err:
+	free_context(&ctx);
+	return 1;
+}
+
+static int test_overflow_hung(struct io_uring *ring)
+{
+	struct io_uring_sqe *sqe;
+	int ret, nr = 10;
+
+	while (*ring->cq.koverflow !=  1000) {
+		sqe = io_uring_get_sqe(ring);
+		if (!sqe) {
+			printf("get sqe failed\n");
+			return 1;
+		}
+
+		io_uring_prep_nop(sqe);
+		ret = io_uring_submit(ring);
+		if (ret <= 0) {
+			printf("sqe submit failed: %d\n", ret);
+			return 1;
+		}
+	}
+
+	return run_drained(ring, nr);
+}
+
+static int test_dropped_hung(struct io_uring *ring)
+{
+	int nr = 10;
+
+	*ring->sq.kdropped = 1000;
+	return run_drained(ring, nr);
+}
+
+int main(int argc, char *argv[])
+{
+	struct io_uring ring, poll_ring, sqthread_ring;
+	int ret;
+
+	ret = io_uring_queue_init(1000, &ring, 0);
+	if (ret) {
+		printf("ring setup failed\n");
+		return 1;
+	}
+
+	ret = io_uring_queue_init(1000, &poll_ring, IORING_SETUP_IOPOLL);
+	if (ret) {
+		printf("poll_ring setup failed\n");
+		return 1;
+	}
+
+	ret = io_uring_queue_init(1000, &sqthread_ring,
+				IORING_SETUP_SQPOLL | IORING_SETUP_IOPOLL);
+	if (ret) {
+		printf("poll_ring setup failed\n");
+		return 1;
+	}
+
+	ret = test_cancelled_userdata(&poll_ring);
+	if (ret) {
+		printf("test_cancelled_userdata failed\n");
+		return ret;
+	}
+
+	ret = test_thread_link_cancel(&sqthread_ring);
+	if (ret) {
+		printf("test_thread_link_cancel failed\n");
+		return ret;
+	}
+
+	ret = test_overflow_hung(&ring);
+	if (ret) {
+		printf("test_overflow_hung failed\n");
+		return ret;
+	}
+
+	ret = test_dropped_hung(&ring);
+	if (ret) {
+		printf("test_dropped_hung failed\n");
+		return ret;
+	}
+
+	return 0;
+}
-- 
2.23.0

