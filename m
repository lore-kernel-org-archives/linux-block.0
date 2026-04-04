Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA32D2D949C
	for <linux-block@vger.kernel.org>; Sat,  4 Apr 2026 03:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775273040; cv=none; b=D8/EQ65W+hQi+ZVzdyC1D4/WQxER8y4s3tisavugJRUkHhlkyIxgKo5k5y6czdWis/K7jxH12UoS4ydqUTb+tLdX9WAPT8Z6EG4TQIBeI/i77mayViUi3VqW7C9sF0mhNJLPpbXS79+OctM09KyUe1tkcefUxeQvtKYHHLU1QcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775273040; c=relaxed/simple;
	bh=EtIon0eFvVS3O6Xdg0WbBq1qhCViHvnzFkQSYVO/8H8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VN4zsWw99MDX35g/he1Pa1qL4YHS+3D61/1gb2Lw0ObWryicJ8FJU1Wxu9etxD5q/+0cBI3DXdvgeiuQGXuLJIOg9ZFzkYWVapAjEHCIvlktGp9O/2pmZpr/DtAa4+z6dotZuVGeH663ZdMbaHwFrCZ1vwxbTZc0U0tVTdAuQ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IKxg+0yK; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IKxg+0yK"
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8cfd44fa075so332102085a.0
        for <linux-block@vger.kernel.org>; Fri, 03 Apr 2026 20:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775273037; x=1775877837; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zX/5TzotSq2dC2MEEK2IilrTISaWwcCASj/MEFDm/KQ=;
        b=IKxg+0yKYnRx0xrQxTq2BUklL4qslZDAxzyBoX2Te+WSySbT7pTy+txia0A6iw/iPn
         c1OkBFmjyrR610TIPp+x5GSyoD5VgVbgCLOqLunLumW3FSQeHeANHMLEJVwK/JyfEwyP
         SpcW/yfTRwq72ozOt0FQ2wIyvbA0jBEVzxmP1o57nAKM0fvhMfGlWyqgEHp4wLN3exMB
         p20SLbxMmYAEQAnJHSGUYP8etn4qV66Tb8qyCV4cf2sZu1Z33lM2YtxWL2E/7NooCU7M
         iPvbfN9tYzIsc4JTs6cQ49qjONijWXZEa7bR9BOtWlJvT7Ow2WKwCjhYLDbOE4xn26Zu
         IAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775273037; x=1775877837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zX/5TzotSq2dC2MEEK2IilrTISaWwcCASj/MEFDm/KQ=;
        b=Jp4qIbmfh7Rf6T+e0dR0Z4p18D6cM3tAl9vZzGO5f9+xtoyMtpQ0gKt+7L4V29Zp64
         6NQqiJ4hzWKhk6fc4tRs6d1ap9nShye9vT3Ye39+wJzt3w5mZToBcTV1IQeycTBlRjge
         GwD2I6a5O0bCXnC58sbjdx9EQ5rnJHUnlGIPsnIgzf/bs+Y7HL6obRDjVNcMyWWbVHEO
         zscsirFIYUsvNVarSZTTHxniyPb9upjcTOQIYxeP6PfZ8tK8qK15xXGMNnMdahoU9Pqg
         95JdKyqn4ZM1w+ThGrw7Iqbc5l0ckp5vV7fCj1XBgWX/imNUvA9uTcwlQP0Bn5upFSkN
         cbSg==
X-Gm-Message-State: AOJu0Yw7noMpic6/9saTDWlaI/sPJ+fAC41ctTJOLVG9rwe+aLVY/RFW
	5EhYHYA1HcsGfYTrcDxIHDE46wGM9QR5n3orKxhaQdIFBPtYRQGBglwwMarBEX9Rk9TUfwWIvtX
	TsLvWGuo+ZqukP9o912NGQCEoUrGHb8Xf1jJj
X-Gm-Gg: AeBDievNqLnZo7rh+y5jeRVaSJVCAelkSTlc3EKIPdz3m7j3M/F2mut5DEohXv2bfTI
	rEyXb9Aoh1dVKItLlvByett0JDHqdR4ApT1cAdsBMaxf4qY5nNS9NYp4Y0qmPIjP0aRlH34mQxw
	UBcuNH3dyxSV+of2weZIK/xitLX4gM8QHQQldC07/AQfoQcHPRh9K0Q6ateS6gYssCVREg7RPAO
	S83sPslXZQ1F5lMSr90exCiV9Ecn9x70Zsd7EK1Kr2SmqKttNcWkp6sk7Qhlf6It2eCSN9Yg0Kq
	Whn6r7GNTrS5Cy8qkzowGEB8607KAj2vQNd+ZoHTC3TpTIfzKCanHpVaGWVQyc4c2sGrhnzWWeX
	BSHv/ZAPU3h7rH75cpx2Y37Wsf8nQGmjg/16AwBFeCvlKsolzJTJH3zE=
X-Received: by 2002:a05:620a:171f:b0:8c6:ff8f:58af with SMTP id af79cd13be357-8d41e244447mr749101685a.51.1775273037502;
        Fri, 03 Apr 2026 20:23:57 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8d2a6de9b33sm28188485a.5.2026.04.03.20.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 20:23:57 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A2F783405FB;
	Fri,  3 Apr 2026 21:23:55 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id BFA81E54F5B; Fri,  3 Apr 2026 21:23:55 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Fri, 03 Apr 2026 21:23:56 -0600
Subject: [PATCH 2/2] selftests: ublk: test that teardown after incomplete
 recovery completes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-cancel-v1-2-86e5a6b3d3af@purestorage.com>
References: <20260403-cancel-v1-0-86e5a6b3d3af@purestorage.com>
In-Reply-To: <20260403-cancel-v1-0-86e5a6b3d3af@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>, Jens Axboe <axboe@kernel.dk>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Before the fix, teardown of a ublk server that was attempting to recover
a device, but died when it had submitted a nonempty proper subset of the
fetch commands to any queue would loop forever. Add a test to verify
that, after the fix, teardown completes. This is done by:

- Adding a new argument to the fault_inject target that causes it die
  after fetching a nonempty proper subset of the IOs to a queue
- Using that argument in a new test while trying to recover an
  already-created device
- Attempting to delete the ublk device at the end of the test; this
  hangs forever if teardown from the fault-injected ublk server never
  completed.

It was manually verified that the test passes with the fix and hangs
without it.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile           |  1 +
 tools/testing/selftests/ublk/fault_inject.c     | 51 +++++++++++++++++++++++--
 tools/testing/selftests/ublk/kublk.c            |  4 ++
 tools/testing/selftests/ublk/kublk.h            |  3 ++
 tools/testing/selftests/ublk/test_generic_17.sh | 35 +++++++++++++++++
 5 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 8ac2d4a682a1768fb1eb9d2dd2a5d01294a67a03..d338668c5a5fbd73f6d70165455a3551ab13e894 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -18,6 +18,7 @@ TEST_PROGS += test_generic_10.sh
 TEST_PROGS += test_generic_12.sh
 TEST_PROGS += test_generic_13.sh
 TEST_PROGS += test_generic_16.sh
+TEST_PROGS += test_generic_17.sh
 
 TEST_PROGS += test_batch_01.sh
 TEST_PROGS += test_batch_02.sh
diff --git a/tools/testing/selftests/ublk/fault_inject.c b/tools/testing/selftests/ublk/fault_inject.c
index 3b897f69c014cc73b4b469d816e80284dd21b577..228a9605053409c84baaf255f97c4abc271a8bfd 100644
--- a/tools/testing/selftests/ublk/fault_inject.c
+++ b/tools/testing/selftests/ublk/fault_inject.c
@@ -10,11 +10,17 @@
 
 #include "kublk.h"
 
+struct fi_opts {
+	long long delay_ns;
+	bool die_during_fetch;
+};
+
 static int ublk_fault_inject_tgt_init(const struct dev_ctx *ctx,
 				      struct ublk_dev *dev)
 {
 	const struct ublksrv_ctrl_dev_info *info = &dev->dev_info;
 	unsigned long dev_size = 250UL << 30;
+	struct fi_opts *opts = NULL;
 
 	if (ctx->auto_zc_fallback) {
 		ublk_err("%s: not support auto_zc_fallback\n", __func__);
@@ -35,17 +41,51 @@ static int ublk_fault_inject_tgt_init(const struct dev_ctx *ctx,
 	};
 	ublk_set_integrity_params(ctx, &dev->tgt.params);
 
-	dev->private_data = (void *)(unsigned long)(ctx->fault_inject.delay_us * 1000);
+	opts = calloc(1, sizeof(*opts));
+	if (!opts) {
+		ublk_err("%s: couldn't allocate memory for opts\n", __func__);
+		return -ENOMEM;
+	}
+
+	opts->delay_ns = ctx->fault_inject.delay_us * 1000;
+	opts->die_during_fetch = ctx->fault_inject.die_during_fetch;
+	dev->private_data = opts;
+
 	return 0;
 }
 
+static void ublk_fault_inject_pre_fetch_io(struct ublk_thread *t,
+					   struct ublk_queue *q, int tag)
+{
+	struct fi_opts *opts = q->dev->private_data;
+
+	if (!opts->die_during_fetch)
+		return;
+
+	/*
+	 * Each queue fetches its IOs in increasing order of tags, so
+	 * dying just before we're about to fetch tag 1 (regardless of
+	 * what queue we're on) guarantees that we've fetched a nonempty
+	 * proper subset of the tags on that queue.
+	 */
+	if (tag == 1) {
+		/*
+		 * Ensure our commands are actually live in the kernel
+		 * before we die.
+		 */
+		io_uring_submit(&t->ring);
+		raise(SIGKILL);
+	}
+}
+
 static int ublk_fault_inject_queue_io(struct ublk_thread *t,
 				      struct ublk_queue *q, int tag)
 {
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
 	struct io_uring_sqe *sqe;
+	struct fi_opts *opts = q->dev->private_data;
 	struct __kernel_timespec ts = {
-		.tv_nsec = (long long)q->dev->private_data,
+		.tv_nsec = opts->delay_ns,
 	};
 
 	ublk_io_alloc_sqes(t, &sqe, 1);
@@ -77,29 +117,34 @@ static void ublk_fault_inject_cmd_line(struct dev_ctx *ctx, int argc, char *argv
 {
 	static const struct option longopts[] = {
 		{ "delay_us", 	1,	NULL,  0  },
+		{ "die_during_fetch", 1, NULL, 0  },
 		{ 0, 0, 0, 0 }
 	};
 	int option_idx, opt;
 
 	ctx->fault_inject.delay_us = 0;
+	ctx->fault_inject.die_during_fetch = false;
 	while ((opt = getopt_long(argc, argv, "",
 				  longopts, &option_idx)) != -1) {
 		switch (opt) {
 		case 0:
 			if (!strcmp(longopts[option_idx].name, "delay_us"))
 				ctx->fault_inject.delay_us = strtoll(optarg, NULL, 10);
+			if (!strcmp(longopts[option_idx].name, "die_during_fetch"))
+				ctx->fault_inject.die_during_fetch = strtoll(optarg, NULL, 10);
 		}
 	}
 }
 
 static void ublk_fault_inject_usage(const struct ublk_tgt_ops *ops)
 {
-	printf("\tfault_inject: [--delay_us us (default 0)]\n");
+	printf("\tfault_inject: [--delay_us us (default 0)] [--die_during_fetch 1]\n");
 }
 
 const struct ublk_tgt_ops fault_inject_tgt_ops = {
 	.name = "fault_inject",
 	.init_tgt = ublk_fault_inject_tgt_init,
+	.pre_fetch_io = ublk_fault_inject_pre_fetch_io,
 	.queue_io = ublk_fault_inject_queue_io,
 	.tgt_io_done = ublk_fault_inject_tgt_io_done,
 	.parse_cmd_line = ublk_fault_inject_cmd_line,
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index e1c3b3c55e565c8cad6b6fe9b9b764cd244818c0..8260c96a39c05584065f41a52f3d9050614454c6 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -796,6 +796,8 @@ static void ublk_submit_fetch_commands(struct ublk_thread *t)
 			q = &t->dev->q[q_id];
 			io = &q->ios[tag];
 			io->buf_index = j++;
+			if (q->tgt_ops->pre_fetch_io)
+				q->tgt_ops->pre_fetch_io(t, q, tag);
 			ublk_queue_io_cmd(t, io);
 		}
 	} else {
@@ -807,6 +809,8 @@ static void ublk_submit_fetch_commands(struct ublk_thread *t)
 		for (i = 0; i < q->q_depth; i++) {
 			io = &q->ios[i];
 			io->buf_index = i;
+			if (q->tgt_ops->pre_fetch_io)
+				q->tgt_ops->pre_fetch_io(t, q, i);
 			ublk_queue_io_cmd(t, io);
 		}
 	}
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 02f0c55d006b4c791fea4456687d0d8757be7be2..f784946144ad3d6e347a867fb1389a8e057766a0 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -60,6 +60,7 @@ struct stripe_ctx {
 struct fault_inject_ctx {
 	/* fault_inject */
 	unsigned long   delay_us;
+	bool die_during_fetch;
 };
 
 struct dev_ctx {
@@ -138,6 +139,8 @@ struct ublk_tgt_ops {
 	int (*init_tgt)(const struct dev_ctx *ctx, struct ublk_dev *);
 	void (*deinit_tgt)(struct ublk_dev *);
 
+	void (*pre_fetch_io)(struct ublk_thread *t, struct ublk_queue *q,
+			     int tag);
 	int (*queue_io)(struct ublk_thread *, struct ublk_queue *, int tag);
 	void (*tgt_io_done)(struct ublk_thread *, struct ublk_queue *,
 			    const struct io_uring_cqe *);
diff --git a/tools/testing/selftests/ublk/test_generic_17.sh b/tools/testing/selftests/ublk/test_generic_17.sh
new file mode 100755
index 0000000000000000000000000000000000000000..2278b5fc9dba523bb1bf8411d22f4f95a28da905
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_17.sh
@@ -0,0 +1,35 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+ERR_CODE=0
+
+_prep_test "fault_inject" "teardown after incomplete recovery"
+
+# First start and stop a ublk server with device configured for recovery
+dev_id=$(_add_ublk_dev -t fault_inject -r 1)
+_check_add_dev $TID $?
+state=$(__ublk_kill_daemon "${dev_id}" "QUIESCED")
+if [ "$state" != "QUIESCED" ]; then
+        echo "device isn't quiesced($state) after $action"
+        ERR_CODE=255
+fi
+
+# Then recover the device, but use --die_during_fetch to have the ublk
+# server die while a queue has some (but not all) I/Os fetched
+${UBLK_PROG} recover -n "${dev_id}" --foreground -t fault_inject --die_during_fetch 1
+RECOVER_RES=$?
+# 137 is the result when dying of SIGKILL
+if (( RECOVER_RES != 137 )); then
+        echo "recover command exited with unexpected code ${RECOVER_RES}!"
+        ERR_CODE=255
+fi
+
+# Clean up the device. This can only succeed once teardown of the above
+# exited ublk server completes. So if teardown never completes, we will
+# time out here
+_ublk_del_dev "${dev_id}"
+
+_cleanup_test "fault_inject"
+_show_result $TID $ERR_CODE

-- 
2.34.1

