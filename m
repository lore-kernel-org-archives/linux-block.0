Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723970;
	b=pf211vge04XWzCp62K9iR2gI3OqVdNTWpSfEgtXBe6yIDpWsLXEhAS4rBXTbEmMAzwVC
	 wCjnC+UmKJgA9S/8PbcoraQ1rhgn0OS8mbbbgUCcYq0sedzmUq3NWjp/CYSaW47WDg/O1
	 DLSOFIXJhZpsVDRD7EMECvug5a4cV/UND0YQ3SefAiaeDM/gOKBXLe6YTsmLFXcKdW4/X
	 7mZ75MslkqX2LO2RgIskaBQF8rac+lj4Zz1jeMrnUElAjExxNERxx4MPuMS7ieENF57V3
	 Jx59FcqbUICsdKUo24ABrKtFBB8Te/LWkq7ugRWyWSCM2/dFc5p9f7tfpfk0uI2nc3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723970;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qOoIje5jHtxIQn/YDXfuubJ3iGogywNqcj+0PuCLQZ0=;
	b=PueV1X2G8I52YzlLzKfXb5YLmemtYdIHv8yBYThK+SFi+i4m4MclEWa1tGuIb5bzVI6y
	 kdexla5oOU4O7K/ne4pBBj0MQwYeHrymezUxvekjA6Xq3LrJUjfstXAtQ+3tXjR5bxdzo
	 4gbOJYK679rP3J2mq9QjtUt+TwuahOspKP5lqPXZNflkkt3JUsHNmVgm734d2UIY6hU65
	 XvURWAJ6UlAiCmxtJ4vEAbGHBgyXcY9fGJxpoAOFQ4Hmb8c6GwQGn4zzFlOObCmQaV5aX
	 Mo4FZ6kgAGNvFaLuuJkwTCB1yIxcIsvTLbZvYVB9qKpWNMTtInWDBkC9JK8LUpnMYPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FqkHNLfd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF9360A3825;
	Tue,  3 Nov 2026 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FqkHNLfd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE301F0093A;
	Tue,  3 Nov 2026 16:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723970;
	bh=qOoIje5jHtxIQn/YDXfuubJ3iGogywNqcj+0PuCLQZ0=;
	h=From:To:Cc:Subject:Date;
	b=FqkHNLfdbFKX0FzMG9/iv983v6FaiwnNA2KvfYVcxDnEoTvbSEAfLDnmoiCg9hbiG
	 EG1U7ZYFh+XSxbLJkO0F2+55GmEnfSDoZXNvSStHPYHGIAikZujWCKC2rum2AK/BDu
	 JWLT18AQ9vHcwm1zuQHmyROULZfWBi/EKOQLbbJufA+yR0+AyW181Pi0BR5zvf6Jhz
	 0iviukfdVB7PT/8bjD+I66aVKxHdyqm32crliZXlUFrN2DONDcTosOcgj21JChJxpS
	 SRTvS4kjU1OO37xQJatpNemWTbhgznfKMD/yeDO7/BGG8IYHTakeGTWtFglv8XPNJ6
	 KDa7Gx3Pf1euw==
From: Sasha Levin <sashal@kernel.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: ublk: fix the build and file offsets on 32-bit
Date: Tue,  3 Nov 2026 11:39:28 -0500
Message-ID: <20261103163928.641519-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kublk puts pointers into 64-bit UAPI and SQE fields with a plain (__u64)
cast. ublk builds with -Werror, so it fails to build on 32-bit
architectures:

  batch.c:379:42: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]

Cast through uintptr_t. kublk also passes 64-bit user copy offsets,
which start at UBLKSRV_IO_BUF_OFFSET (2 GB), to pread() and pwrite(),
and with glibc those are truncated to a 32-bit off_t there. Build with
-D_FILE_OFFSET_BITS=64 as well.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Found with 32-bit builds of the selftests (gcc 16 and clang 21 with
-m32, with and without -D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64);
KernelCI's 32-bit arm builds show the same warnings. The changed files
build without them now, and the x86_64 builds don't change.

 tools/testing/selftests/ublk/Makefile | 1 +
 tools/testing/selftests/ublk/batch.c  | 6 +++---
 tools/testing/selftests/ublk/ctrl.c   | 2 +-
 tools/testing/selftests/ublk/kublk.c  | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index fc64b8f028332..1a50d4695c9fa 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += -O3 -Wl,-no-as-needed -Wall -I $(top_srcdir)/usr/include
+CFLAGS += -D_FILE_OFFSET_BITS=64
 ifneq ($(WERROR),0)
 	CFLAGS += -Werror
 endif
diff --git a/tools/testing/selftests/ublk/batch.c b/tools/testing/selftests/ublk/batch.c
index dfc81ee17d076..625a9c32a80b1 100644
--- a/tools/testing/selftests/ublk/batch.c
+++ b/tools/testing/selftests/ublk/batch.c
@@ -376,10 +376,10 @@ static int __ublk_batch_queue_prep_io_cmds(struct ublk_thread *t, struct ublk_qu
 		if (ublk_queue_use_auto_zc(q))
 			elem->buf_index = ublk_batch_io_buf_idx(t, q, i);
 		else if (!ublk_queue_no_buf(q))
-			elem->buf_addr = (__u64)io->buf_addr;
+			elem->buf_addr = (__u64)(uintptr_t)io->buf_addr;
 	}
 
-	sqe->addr = (__u64)buf;
+	sqe->addr = (__u64)(uintptr_t)buf;
 	sqe->len = t->commit_buf_elem_size * nr_elem;
 
 	ublk_init_batch_cmd(t, q->q_id, sqe, UBLK_U_IO_PREP_IO_CMDS,
@@ -473,7 +473,7 @@ static void __ublk_batch_commit_io_cmds(struct ublk_thread *t,
 
 	ublk_io_alloc_sqes(t, &sqe, 1);
 	buf_idx = cb->buf_idx;
-	sqe->addr = (__u64)cb->elem;
+	sqe->addr = (__u64)(uintptr_t)cb->elem;
 	sqe->len = nr_elem * t->commit_buf_elem_size;
 
 	/* commit isn't per-queue command */
diff --git a/tools/testing/selftests/ublk/ctrl.c b/tools/testing/selftests/ublk/ctrl.c
index 53d54799f9097..5e0762cfc4eae 100644
--- a/tools/testing/selftests/ublk/ctrl.c
+++ b/tools/testing/selftests/ublk/ctrl.c
@@ -204,7 +204,7 @@ int ublk_ctrl_get_params(struct ublk_dev *dev,
 	struct ublk_ctrl_cmd_data data = {
 		.cmd_op	= UBLK_U_CMD_GET_PARAMS,
 		.flags	= CTRL_CMD_HAS_BUF,
-		.addr = (__u64)params,
+		.addr = (__u64)(uintptr_t)params,
 		.len = sizeof(*params),
 	};
 
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 5a4ff689c1f7a..115f25351d309 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -148,7 +148,7 @@ static int ublk_ctrl_get_affinity(struct ublk_dev *ctrl_dev, cpu_set_t **ptr_buf
 	for (i = 0; i < ctrl_dev->dev_info.nr_hw_queues; i++) {
 		data.data[0] = i;
 		data.len = sizeof(cpu_set_t);
-		data.addr = (__u64)&buf[i];
+		data.addr = (__u64)(uintptr_t)&buf[i];
 
 		ret = __ublk_ctrl_cmd(ctrl_dev, &data);
 		if (ret < 0) {
-- 
2.53.0

