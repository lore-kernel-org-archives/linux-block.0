Received: from mail-dy1-f227.google.com (mail-dy1-f227.google.com [74.125.82.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37495302742
	for <linux-block@vger.kernel.org>; Mon,  6 Apr 2026 04:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775449534; cv=none; b=mIy+m1XLDx7+Is8B51m5rK9CNHDRvYos2UL5GTaTE4zi4+y+3iy4kyh5ewHk+htAmTNipCyoitGRudeLhE4uVIMF5cbnb+xow2G0DwJY+OxXe7jI2eNa0KvQeCG3AEl34vdHw4ATjueXtgRZSKG53Yo8wdHCP/4I/FsQD/67PbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775449534; c=relaxed/simple;
	bh=4Qw2gMeRx2AwaH5OyI9OCWjDsJMpE8dc6yGufGFDpD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=urTfxngoaMBQ25wDxD0uo9g3jaU+N5aLqGB1KERwo4PTQcuTC6Uerewnh4btUftzXKzfjTx0cubKRrdSuTfp7/lGuT/ynOZwRWnAAG3ix1YRvJsQWi33tMWmalfMTrpfl8QwC67cUNSlz5yOZ/017rbkRVhR1ePcx9E7FF/PciY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=S5XYWaVS; arc=none smtp.client-ip=74.125.82.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="S5XYWaVS"
Received: by mail-dy1-f227.google.com with SMTP id 5a478bee46e88-2ce102afb0aso1360497eec.1
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2026 21:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775449532; x=1776054332; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GiFmGsi1trg+sTzWDFmt984w926rq6bzCWbYruVriRw=;
        b=S5XYWaVSQPvQeSMuruO/POf8I164ZiwHsRUIUBTf27zGePUhHDJBMu49RXbZ6V59l/
         Z5Qzzve4vFXNHXr6CcJJ6LYscNuvkFshQ7IDaTV6yTWGnYyfFMh7C1ddldrinHjTwtRp
         VUwMHz8rJTVs2X4JaPjgueWRpRYmlsguJsiOGSbFl57x77nxl9er8w9GpZL7M0xl7a2k
         7WiHK9k4HTvn5aIjRZIXgB3255Rn/tlruDW1vEKh3nQYJN0gybrELtZLfjP0QGDabr4l
         AVmxtSLDXb8QvzFG/HzeShYql/pzXXdwOawphLRcKplrR9lCKxYh+ZmA1sDcIrlCF/NA
         kWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775449532; x=1776054332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GiFmGsi1trg+sTzWDFmt984w926rq6bzCWbYruVriRw=;
        b=F4RtY9qyk/TKBGkqjui8gciHZwqS4pqa3bgLg07gl/VNNjhwN81lNFYGrbGSh/Y52h
         KDKzvJvErjiKjfY174IpK0DlyxzodhFOs6luvse33f2mhZBSwdhPQEdJKdMe947hoPsZ
         Nc/ZMW20lGLHZkVaYKL8gQtJXxCyWBD+Sm/b3wZZwO/rmcPnjHgUUmsE8hspuO+QM6wn
         gyC/v5hS6DccAuvqSoRRfowH8vC55g1VJfUo0XOfQ6wRV6isb8Td5KxXKAh8HfhR2guZ
         xo6/sAtQpHXnwhOSaVJUI06iYiBuYZjvZcaR7SsgH0rLD6UdGh7tCgCxPT7CjyuoWmlg
         j6BA==
X-Gm-Message-State: AOJu0YyP5x0xU9StovWSbQo6b13aiWwyUF0DthhXYXJ/c04CTdeppzLu
	dcoHqGC63+TJliXyX785lsXFdH3sfPcST/ox8lXwXiKbeoUfzykdgq8rbFINfMotVgqBgBzfqrd
	NeX42nA0h8ZVc+x7bnwefwIovbvQ4icsluYWMQKURZ35W5nPXToz0
X-Gm-Gg: AeBDieuN10LwfBm306Eisc1anHqBOXiqioJSxaPd6c1E9ywjDKh4/u350lkEDg16EVp
	vNEVwjSPqBQZx87Jf/e3LZ/r+SlbBI7HUDIxFsC6gqxXY8LlNO0TKJ/TPTdUvuHfc4cevouIwUW
	ow8gWOEzWBgen8NrhohGJ/CqurdRKkuv4fsCxlINDUH379u3ln75kuPxoDNssYAXnr1p3ed4rqP
	oxw4cCTuN68Fh9LrBs8gHS6TnzV7ePfTGTGpa2oQhJMPYPK5LFZOTqCK4DXGiTO7m2yPPB+bkP9
	8+xuF0ESpxOTUuT9GgohKxahP8sNVeiu2yzoOlNagFAAdvl0SfTvS5xqc/bb4SYmACPxo1O5fXg
	Qa7ZmB+s2sap4eKV/cYvUqS2r/q0eJ4oeR0Z3wt4B
X-Received: by 2002:a05:7301:c011:b0:2cc:afce:bc01 with SMTP id 5a478bee46e88-2ccafcec728mr3400757eec.29.1775449532244;
        Sun, 05 Apr 2026 21:25:32 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2ca793f4e90sm897979eec.10.2026.04.05.21.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 21:25:32 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 730FC340775;
	Sun,  5 Apr 2026 22:25:31 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 5AB80E54F31; Sun,  5 Apr 2026 22:25:31 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Sun, 05 Apr 2026 22:25:31 -0600
Subject: [PATCH v2 2/2] selftests: ublk: test that teardown after
 incomplete recovery completes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-cancel-v2-2-02d711e643c2@purestorage.com>
References: <20260405-cancel-v2-0-02d711e643c2@purestorage.com>
In-Reply-To: <20260405-cancel-v2-0-02d711e643c2@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, 
 "zhang, the-essence-of-life" <zhangweize9@gmail.com>, 
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
 tools/testing/selftests/ublk/fault_inject.c     | 52 +++++++++++++++++++++++--
 tools/testing/selftests/ublk/kublk.c            |  7 ++++
 tools/testing/selftests/ublk/kublk.h            |  3 ++
 tools/testing/selftests/ublk/test_generic_17.sh | 35 +++++++++++++++++
 5 files changed, 95 insertions(+), 3 deletions(-)

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
index 3b897f69c014cc73b4b469d816e80284dd21b577..150896e02ff8b3747fdc45eb2a6df7b52e134485 100644
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
@@ -35,17 +41,52 @@ static int ublk_fault_inject_tgt_init(const struct dev_ctx *ctx,
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
+					   struct ublk_queue *q, int tag,
+					   bool batch)
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
@@ -77,29 +118,34 @@ static void ublk_fault_inject_cmd_line(struct dev_ctx *ctx, int argc, char *argv
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
index e1c3b3c55e565c8cad6b6fe9b9b764cd244818c0..e5b787ba21754719247bb17e1874313f52c35ed1 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -796,6 +796,8 @@ static void ublk_submit_fetch_commands(struct ublk_thread *t)
 			q = &t->dev->q[q_id];
 			io = &q->ios[tag];
 			io->buf_index = j++;
+			if (q->tgt_ops->pre_fetch_io)
+				q->tgt_ops->pre_fetch_io(t, q, tag, false);
 			ublk_queue_io_cmd(t, io);
 		}
 	} else {
@@ -807,6 +809,8 @@ static void ublk_submit_fetch_commands(struct ublk_thread *t)
 		for (i = 0; i < q->q_depth; i++) {
 			io = &q->ios[i];
 			io->buf_index = i;
+			if (q->tgt_ops->pre_fetch_io)
+				q->tgt_ops->pre_fetch_io(t, q, i, false);
 			ublk_queue_io_cmd(t, io);
 		}
 	}
@@ -983,6 +987,9 @@ static void ublk_batch_setup_queues(struct ublk_thread *t)
 		if (t->q_map[i] == 0)
 			continue;
 
+		if (q->tgt_ops->pre_fetch_io)
+			q->tgt_ops->pre_fetch_io(t, q, 0, true);
+
 		ret = ublk_batch_queue_prep_io_cmds(t, q);
 		ublk_assert(ret >= 0);
 	}
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 02f0c55d006b4c791fea4456687d0d8757be7be2..6d1762aa30dfc8e72ff92aa86c8faba12169f644 100644
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
+			     int tag, bool batch);
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

