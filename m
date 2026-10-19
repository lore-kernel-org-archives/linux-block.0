Received: from mta1.migadu.com (out-48.mta1.migadu.com [95.215.58.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A520C339395
	for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 08:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399391; cv=none; b=b+gqIoLahC7HNrGWasJc3fZv4bOJ/csbc5vyhG59Fn+7POdsnez+e2SYKT2HALe+R5jffuO31AYMDOAjMeYyp7ajXb2hEJfN0QAskV9c5BEkiusftNXhyxDS70BSr2GhwaIGX61JLxzfQJYJhWdb7n0EJxYBi5luersatOn0t6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399391; c=relaxed/simple;
	bh=SkseMn7fPuRum4KiC10PAEDJWAlNIXhfvD1jIKxAIkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Po0Q3Z9oSmvi49vk8MXDGZ8ycw6FH3O094p+2MrbyTx6uqxBb95VOTAkKKWdkxuRjKlajHpvFSZCaRfOnPjE0IBciAx3do7h7e9Wqr7ylEVQ4saYJz8GKICAyktWRNMz+MBJl7US+GgnMPhc3/MilP2IDGXetJXB5HeoICeQGuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hwcCABqA; arc=none smtp.client-ip=95.215.58.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hwcCABqA"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SkseMn7fPuRum4KiC10PAEDJWAlNIXhfvD1jIKxAIkQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792399386; v=1; x=1793004186;
 b=hwcCABqAgltYQmaTSbczVNLVDTH5gpdSXcW6zD/q8hCJkow7DrzJxMAebc9Z0BDnbGEVDsn5
 XhzVuOkIlrByE9q0nTatoARYcr+BXjNiLa32nPfRpyDkQoAAWq22dexN66XRawAV2Rk7Lgj+zZG
 Jj3MljRgdTxIZrRNBYN1xxQA=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 65f89b9575891237;
	Mon, 19 Oct 2026 08:43:06 +0000
X-Mizu-Trace-ID: 65f89b9575891237
X-Migadu-Flow: FLOW_OUT
From: Jackie Liu <liu.yun@linux.dev>
To: josef@toxicpanda.com
Cc: axboe@kernel.dk,
	shuah@kernel.org,
	tom.leiming@gmail.com,
	yukuai@fygo.io,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 4/4] selftests: nbd: test multi-connection startup races
Date: Mon, 19 Oct 2026 16:42:27 +0800
Message-ID: <1e23512b7d6701f53fdec82e08ee480cd9b27712.1792399226.git.liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1792399225.git.liuyun01@kylinos.cn>
References: <cover.1792399225.git.liuyun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jackie Liu <liuyun01@kylinos.cn>

Extend the NBD startup selftests to race NBD_DO_IT against adding a
second socket without NBD_FLAG_CAN_MULTI_CONN, and against clearing the
flag on a device that already has two sockets. Prime the queue count
before each attempt to exercise the unlocked hardware queue update.

Check for EINVAL or a valid single-connection start. Detect an invalid
multi-connection start by checking whether a receive worker consumes a
byte from the second socket. Keep the reply incomplete so that the check
does not inject a malformed reply into request completion.

Exclude flag changes observed after PID publication, since changing
flags on an already running device is outside the startup race being
tested. As with the concurrent-start test, this is scheduling stress and
a passing run does not prove that every race window was exercised.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 tools/testing/selftests/nbd/.gitignore       |   1 +
 tools/testing/selftests/nbd/Makefile         |   2 +-
 tools/testing/selftests/nbd/nbd_multi_conn.c | 147 +++++++++++++++++++
 3 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/nbd/nbd_multi_conn.c

diff --git a/tools/testing/selftests/nbd/.gitignore b/tools/testing/selftests/nbd/.gitignore
index 5516e34b30f2..5920071f30ee 100644
--- a/tools/testing/selftests/nbd/.gitignore
+++ b/tools/testing/selftests/nbd/.gitignore
@@ -1 +1,2 @@
 /nbd_pid_race
+/nbd_multi_conn
diff --git a/tools/testing/selftests/nbd/Makefile b/tools/testing/selftests/nbd/Makefile
index e49ee6cfc82e..7c3e5e6ea1b0 100644
--- a/tools/testing/selftests/nbd/Makefile
+++ b/tools/testing/selftests/nbd/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -O2 -Wall -Wextra $(KHDR_INCLUDES)
-TEST_GEN_PROGS := nbd_pid_race
+TEST_GEN_PROGS := nbd_pid_race nbd_multi_conn
 LOCAL_HDRS += nbd_common.h
 
 include ../lib.mk
diff --git a/tools/testing/selftests/nbd/nbd_multi_conn.c b/tools/testing/selftests/nbd/nbd_multi_conn.c
new file mode 100644
index 000000000000..a032b36bb89d
--- /dev/null
+++ b/tools/testing/selftests/nbd/nbd_multi_conn.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 KylinSoft Co., Ltd. All rights reserved.
+ *
+ * Startup must revalidate CAN_MULTI_CONN after an unlocked queue update.
+ */
+#include <errno.h>
+#include <linux/nbd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+#include "nbd_common.h"
+
+struct stats {
+	int rounds;
+	int rejected;
+	int missed;
+	int hits;
+	int errors;
+};
+
+/*
+ * A byte cannot disappear from this UNIX socket unless a receiver reads it.
+ * Only recv_work() reads the client endpoint. Keep the reply incomplete so
+ * observing a second receiver does not depend on hardware queue counts or
+ * inject a malformed NBD reply into request completion.
+ */
+static int second_receiver(struct session *s)
+{
+	long long end = nbd_now_ms() + 50;
+
+	if (send(s->sockets[1][1], "x", 1, MSG_NOSIGNAL) != 1)
+		return -errno;
+	for (;;) {
+		int pending;
+
+		if (ioctl(s->sockets[1][0], FIONREAD, &pending))
+			return -errno;
+		if (!pending)
+			return 1;
+		if (pending != 1)
+			return -EIO;
+		if (nbd_now_ms() >= end)
+			return 0;
+		usleep(1000);
+	}
+}
+
+static int multi_connection(int index, struct options *o, struct stats *st,
+			    bool flags_only)
+{
+	struct session s;
+	int ret, state = -1, cleanup;
+	bool eligible = true;
+
+	ret = nbd_prime(index, flags_only ? 1 : 2, o);
+	if (ret)
+		return ret;
+	ret = nbd_session_open(&s, index, flags_only ? 2 : 1,
+			       flags_only ? NBD_FLAG_CAN_MULTI_CONN : 0);
+	if (!ret)
+		ret = nbd_launch(&s, 1, o);
+	if (!ret) {
+		if (o->spread_b)
+			usleep(rand_r(&o->seed) % o->spread_b);
+		if (flags_only) {
+			if (ioctl(s.fd, NBD_SET_FLAGS, 0))
+				ret = -errno;
+			/* A flags change after startup is a separate, older behavior. */
+			state = nbd_device_pid(index);
+			if (state < 0)
+				ret = state;
+			eligible = state == 0;
+		} else if (ioctl(s.fd, NBD_SET_SOCK, s.sockets[1][0])) {
+			if (errno == EBUSY)
+				eligible = false;
+			else
+				ret = -errno;
+		}
+	}
+	if (!ret) {
+		state = nbd_wait_state(&s);
+		st->rounds++;
+		if (!state && s.results[0].error == EINVAL) {
+			st->rejected++;
+		} else if (state == 1) {
+			int receiving = eligible ? second_receiver(&s) : 0;
+
+			if (receiving < 0) {
+				ret = receiving;
+			} else if (receiving) {
+				st->hits++;
+				ksft_print_msg("nbd%d: invalid second receiver (%s)\n",
+					       index,
+					       flags_only ? "flags changed" : "socket added");
+			} else {
+				st->missed++;
+			}
+		} else {
+			ret = state < 0 ? state : -EIO;
+		}
+	}
+	cleanup = nbd_session_close(&s);
+	if (!ret)
+		ret = cleanup;
+	if (!ret && state == 1 && (s.nr_results != 1 || s.results[0].error))
+		ret = -EIO;
+	return ret;
+}
+
+static void run_test(struct options *o, bool flags_only, const char *name)
+{
+	struct stats st = { 0 };
+	int i;
+
+	for (i = 0; i < o->rounds; i++) {
+		int ret = multi_connection(nbd_pick_device(i), o, &st, flags_only);
+
+		if (ret) {
+			ksft_print_msg("%s round %d: %s (%d)\n", name, i + 1,
+				       strerror(-ret), ret);
+			st.errors++;
+		}
+		if (st.errors || st.hits)
+			break;
+	}
+	ksft_test_result(!st.errors && !st.hits && st.rounds == o->rounds,
+			 "%s: rounds=%d rejected=%d missed=%d regressions=%d errors=%d\n",
+			 name, st.rounds, st.rejected, st.missed, st.hits, st.errors);
+}
+
+int main(int argc, char **argv)
+{
+	struct options o;
+
+	nbd_parse_options(argc, argv, &o);
+	ksft_print_header();
+	nbd_init_test(&o);
+	ksft_set_plan(2);
+	run_test(&o, false, "socket-count retry rechecks CAN_MULTI_CONN");
+	run_test(&o, true, "flags-only change rechecks CAN_MULTI_CONN");
+	ksft_finished();
+}
