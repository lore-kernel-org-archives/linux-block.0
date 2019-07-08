Return-Path: <SRS0=8/B6=VF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E62BC606C7
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 19:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB842086D
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 19:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404763AbfGHT6B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:58:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40439 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbfGHT6B (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jul 2019 15:58:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so8099382pfp.7
        for <linux-block@vger.kernel.org>; Mon, 08 Jul 2019 12:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QairLB5Hv2Yhw5Yh+wUwQUjZMuGxJMFVnN+G6Rj5Dk=;
        b=oCeAPof6WjmSx8XIQlHRUUpNOq4lTHJ2NrgRvu0xfeWzCRgi4yiOqqMFWVrs7YygTq
         yQHFhakje33WL08MSlmzVWgvVyzNBfRZDr3nZ1BN8gL9Fpwob9Qs1nGTnU9gWoNwetgc
         gsF4UZ6eQeu/oNbIc8mymPsG9C1oU+lnyXr1UkjE9pYzx7z3vY15SB7upjuSq7Uak3de
         bDwjjJzbIvNolBkCp3pcMP91pJ5i6Ycilp/BdsCyQFAeXC8a708P6LOg4canRw2yAPgu
         g1iSlHCwiinM57ffWQlZ8kET2xC86rsmK8FoLEpAGZmnYyDarZcpSI7taKlVZSIII/YQ
         zkxg==
X-Gm-Message-State: APjAAAXjeeY3Hio17ft3UYTYDf1zL6H6mDME4qzIsSUn9izQuOEAkFDz
        b4XwT/OCeAZArZu05bgSnfEhvL+p
X-Google-Smtp-Source: APXvYqxfAVrHZi7stdiyQky7L5KZyXAGzA+CPbwS9YUmGHiZuuzEpt3c7D3HtUg68xnyj66Tov6OKw==
X-Received: by 2002:a17:90a:1785:: with SMTP id q5mr27741381pja.106.1562615880637;
        Mon, 08 Jul 2019 12:58:00 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t8sm298043pji.24.2019.07.08.12.57.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 12:57:59 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH liburing 2/4] Fix the 32-bit build
Date:   Mon,  8 Jul 2019 12:57:48 -0700
Message-Id: <20190708195750.223103-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190708195750.223103-1-bvanassche@acm.org>
References: <20190708195750.223103-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the warnings reported when building liburing as follows:

make CFLAGS=-m32

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 test/io_uring_register.c | 11 ++++++-----
 test/send_recvmsg.c      |  4 ++--
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/test/io_uring_register.c b/test/io_uring_register.c
index 070d0ff3d511..32e52179af29 100644
--- a/test/io_uring_register.c
+++ b/test/io_uring_register.c
@@ -140,7 +140,7 @@ test_max_fds(int uring_fd)
 		perror("mmap fd_as");
 		exit(1);
 	}
-	printf("allocated %lu bytes of address space\n", UINT_MAX * sizeof(int));
+	printf("allocated %zu bytes of address space\n", UINT_MAX * sizeof(int));
 
 	fdtable_fd = mkstemp(template);
 	if (fdtable_fd < 0) {
@@ -178,7 +178,8 @@ test_max_fds(int uring_fd)
 		fds = mmap(fds, 128*1024*1024, PROT_READ|PROT_WRITE,
 			   MAP_SHARED|MAP_FIXED, fdtable_fd, 0);
 		if (fds == MAP_FAILED) {
-			printf("mmap failed at offset %lu\n", (char *)fd_as - (char *)fds);
+			printf("mmap failed at offset %lu\n",
+			       (unsigned long)((char *)fd_as - (char *)fds));
 			exit(1);
 		}
 	}
@@ -217,7 +218,7 @@ test_max_fds(int uring_fd)
 	close(fdtable_fd);
 	ret = munmap(fd_as, UINT_MAX * sizeof(int));
 	if (ret != 0) {
-		printf("munmap(%lu) failed\n", UINT_MAX * sizeof(int));
+		printf("munmap(%zu) failed\n", UINT_MAX * sizeof(int));
 		exit(1);
 	}
 
@@ -244,7 +245,7 @@ test_memlock_exceeded(int fd)
 		ret = io_uring_register(fd, IORING_REGISTER_BUFFERS, &iov, 1);
 		if (ret < 0) {
 			if (errno == ENOMEM) {
-				printf("io_uring_register of %lu bytes failed "
+				printf("io_uring_register of %zu bytes failed "
 				       "with ENOMEM (expected).\n", iov.iov_len);
 				iov.iov_len /= 2;
 				continue;
@@ -253,7 +254,7 @@ test_memlock_exceeded(int fd)
 			free(buf);
 			return 1;
 		}
-		printf("successfully registered %lu bytes (%d).\n",
+		printf("successfully registered %zu bytes (%d).\n",
 		       iov.iov_len, ret);
 		ret = io_uring_register(fd, IORING_UNREGISTER_BUFFERS, NULL, 0);
 		if (ret != 0) {
diff --git a/test/send_recvmsg.c b/test/send_recvmsg.c
index e6cda69664a5..9187906d3dbf 100644
--- a/test/send_recvmsg.c
+++ b/test/send_recvmsg.c
@@ -64,7 +64,7 @@ static int do_recvmsg(void)
 	memset(sqe, 0, sizeof(*sqe));
 	sqe->opcode = IORING_OP_RECVMSG;
 	sqe->fd = sockfd;
-	sqe->addr = (uint64_t) &msg;
+	sqe->addr = (uintptr_t) &msg;
 	sqe->len = 1;
 
 	ret = io_uring_submit(&ring);
@@ -136,7 +136,7 @@ static int do_sendmsg(void)
 	memset(sqe, 0, sizeof(*sqe));
 	sqe->opcode = IORING_OP_SENDMSG;
 	sqe->fd = sockfd;
-	sqe->addr = (uint64_t) &msg;
+	sqe->addr = (uintptr_t) &msg;
 	sqe->len = 1;
 
 	ret = io_uring_submit(&ring);
-- 
2.22.0.410.gd8fdbe21b5-goog

