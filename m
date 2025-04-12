Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FF138385
	for <linux-block@vger.kernel.org>; Sat, 12 Apr 2025 02:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744425097; cv=none; b=tMCeEp6t67YZzOKrPMi93kDTEPd38ZsdvWFAhMNJnjNJdCyqToZc01xhL3kNeT4DR+2CDJmpgybeMuIcbwi+iW0CC3cbLJWyXO1hxtSSz/NJDw4/hy0R4p87qYf+ddKBVHc0itwVmz/H1Ipmysz/2xooqYXVSn3kFZyl4L72J6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744425097; c=relaxed/simple;
	bh=pPy07qcvtaDZQd8yw/HX9pfPaUR43iq7KlSsZ7lalow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1pyhiilL0ZiZS7uOoiW37Lj+s2kDZdIjRGpib92+U6X+bKGW2emL/I4rVp3Bvlgu+RKihnb2eoSb1e6Z/nkcw5gTReYAQfla4cx01+E4IEWnrv9rgemAIwvJBD8FLV5mgDoOXOIto/EIx/3qpIpcuZnfv7xvO1qfWvqVnJmnn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d74Foi7Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d74Foi7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744425094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6NWTDdO/VKUQfF5PZFZUHSU22h0RvCRPsyIyRhwjgF8=;
	b=d74Foi7QyGaX8PlUimYUumNNnlUGNwZFdBsFlk6CXadoVjojI1yChfV7/arXe4hjNmYFay
	KonO31p4WEDOQ1TiXf5QZw3CBdhf0AwjhW4eEHX6Iot5PcFuKG+Av25aji1D1w+q0kxNXj
	haB0V/a0mStAhWwTUJEiMkIAfpdAiDU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-czvz3xj0PgKnnpqb3oVUFg-1; Fri,
 11 Apr 2025 22:31:30 -0400
X-MC-Unique: czvz3xj0PgKnnpqb3oVUFg-1
X-Mimecast-MFC-AGG-ID: czvz3xj0PgKnnpqb3oVUFg_1744425090
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E48DC195609E;
	Sat, 12 Apr 2025 02:31:29 +0000 (UTC)
Received: from localhost (unknown [10.72.116.41])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3DF61956094;
	Sat, 12 Apr 2025 02:31:28 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 11/13] selftests: ublk: support user recovery
Date: Sat, 12 Apr 2025 10:30:27 +0800
Message-ID: <20250412023035.2649275-12-ming.lei@redhat.com>
In-Reply-To: <20250412023035.2649275-1-ming.lei@redhat.com>
References: <20250412023035.2649275-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add user recovery feature.

Meantime add user recovery test: generic_04 and generic_05(zero copy)

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  2 +
 tools/testing/selftests/ublk/kublk.c          | 96 +++++++++++++++++--
 tools/testing/selftests/ublk/kublk.h          |  1 +
 tools/testing/selftests/ublk/test_common.sh   | 57 ++++++++++-
 .../testing/selftests/ublk/test_generic_04.sh | 40 ++++++++
 .../testing/selftests/ublk/test_generic_05.sh | 44 +++++++++
 6 files changed, 230 insertions(+), 10 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_04.sh
 create mode 100755 tools/testing/selftests/ublk/test_generic_05.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 7311e8f6bee7..d93373384e93 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -6,6 +6,8 @@ LDLIBS += -lpthread -lm -luring
 TEST_PROGS := test_generic_01.sh
 TEST_PROGS += test_generic_02.sh
 TEST_PROGS += test_generic_03.sh
+TEST_PROGS += test_generic_04.sh
+TEST_PROGS += test_generic_05.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 03b3d6427775..0cd6dce3f303 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -119,6 +119,27 @@ static int ublk_ctrl_start_dev(struct ublk_dev *dev,
 	return __ublk_ctrl_cmd(dev, &data);
 }
 
+static int ublk_ctrl_start_user_recovery(struct ublk_dev *dev)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_START_USER_RECOVERY,
+	};
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
+static int ublk_ctrl_end_user_recovery(struct ublk_dev *dev, int daemon_pid)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_END_USER_RECOVERY,
+		.flags	= CTRL_CMD_HAS_DATA,
+	};
+
+	dev->dev_info.ublksrv_pid = data.data[0] = daemon_pid;
+
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
 static int ublk_ctrl_add_dev(struct ublk_dev *dev)
 {
 	struct ublk_ctrl_cmd_data data = {
@@ -812,8 +833,12 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 	free(affinity_buf);
 
 	/* everything is fine now, start us */
-	ublk_set_parameters(dev);
-	ret = ublk_ctrl_start_dev(dev, getpid());
+	if (ctx->recovery)
+		ret = ublk_ctrl_end_user_recovery(dev, getpid());
+	else {
+		ublk_set_parameters(dev);
+		ret = ublk_ctrl_start_dev(dev, getpid());
+	}
 	if (ret < 0) {
 		ublk_err("%s: ublk_ctrl_start_dev failed: %d\n", __func__, ret);
 		goto fail;
@@ -988,7 +1013,10 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 		}
 	}
 
-	ret = ublk_ctrl_add_dev(dev);
+	if (ctx->recovery)
+		ret = ublk_ctrl_start_user_recovery(dev);
+	else
+		ret = ublk_ctrl_add_dev(dev);
 	if (ret < 0) {
 		ublk_err("%s: can't add dev id %d, type %s ret %d\n",
 				__func__, dev_id, tgt_type, ret);
@@ -1202,12 +1230,14 @@ static int cmd_dev_get_features(void)
 	return ret;
 }
 
-static int cmd_dev_help(char *exe)
+static void __cmd_create_help(char *exe, bool recovery)
 {
 	int i;
 
-	printf("%s add -t [null|loop|stripe] [-q nr_queues] [-d depth] [-n dev_id]\n", exe);
-	printf("\t[--foreground] [--quiet] [-z] [--debug_mask mask]\n");
+	printf("%s %s -t [null|loop|stripe] [-q nr_queues] [-d depth] [-n dev_id]\n",
+			exe, recovery ? "recover" : "add");
+	printf("\t[--foreground] [--quiet] [-z] [--debug_mask mask] [-r 0|1 ] [-g 0|1]\n");
+	printf("\t[-e 0|1 ] [-i 0|1]\n");
 	printf("\t[target options] [backfile1] [backfile2] ...\n");
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
 
@@ -1217,7 +1247,25 @@ static int cmd_dev_help(char *exe)
 		if (ops->usage)
 			ops->usage(ops);
 	}
+}
+
+static void cmd_add_help(char *exe)
+{
+	__cmd_create_help(exe, false);
+	printf("\n");
+}
+
+static void cmd_recover_help(char *exe)
+{
+	__cmd_create_help(exe, true);
+	printf("\tPlease provide exact command line for creating this device with real dev_id\n");
 	printf("\n");
+}
+
+static int cmd_dev_help(char *exe)
+{
+	cmd_add_help(exe);
+	cmd_recover_help(exe);
 
 	printf("%s del [-n dev_id] -a \n", exe);
 	printf("\t -a delete all devices -n delete specified device\n\n");
@@ -1239,6 +1287,10 @@ int main(int argc, char *argv[])
 		{ "quiet",		0,	NULL,  0  },
 		{ "zero_copy",          0,      NULL, 'z' },
 		{ "foreground",		0,	NULL,  0  },
+		{ "recovery", 		1,      NULL, 'r' },
+		{ "recovery_fail_io",	1,	NULL, 'e'},
+		{ "recovery_reissue",	1,	NULL, 'i'},
+		{ "get_data",		1,	NULL, 'g'},
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
@@ -1253,13 +1305,14 @@ int main(int argc, char *argv[])
 	int ret = -EINVAL, i;
 	int tgt_argc = 1;
 	char *tgt_argv[MAX_NR_TGT_ARG] = { NULL };
+	int value;
 
 	if (argc == 1)
 		return ret;
 
 	opterr = 0;
 	optind = 2;
-	while ((opt = getopt_long(argc, argv, "t:n:d:q:az",
+	while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:az",
 				  longopts, &option_idx)) != -1) {
 		switch (opt) {
 		case 'a':
@@ -1281,6 +1334,25 @@ int main(int argc, char *argv[])
 		case 'z':
 			ctx.flags |= UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_USER_COPY;
 			break;
+		case 'r':
+			value = strtol(optarg, NULL, 10);
+			if (value)
+				ctx.flags |= UBLK_F_USER_RECOVERY;
+			break;
+		case 'e':
+			value = strtol(optarg, NULL, 10);
+			if (value)
+				ctx.flags |= UBLK_F_USER_RECOVERY | UBLK_F_USER_RECOVERY_FAIL_IO;
+			break;
+		case 'i':
+			value = strtol(optarg, NULL, 10);
+			if (value)
+				ctx.flags |= UBLK_F_USER_RECOVERY | UBLK_F_USER_RECOVERY_REISSUE;
+			break;
+		case 'g':
+			value = strtol(optarg, NULL, 10);
+			if (value)
+				ctx.flags |= UBLK_F_NEED_GET_DATA;
 		case 0:
 			if (!strcmp(longopts[option_idx].name, "debug_mask"))
 				ublk_dbg_mask = strtol(optarg, NULL, 16);
@@ -1326,7 +1398,15 @@ int main(int argc, char *argv[])
 
 	if (!strcmp(cmd, "add"))
 		ret = cmd_dev_add(&ctx);
-	else if (!strcmp(cmd, "del"))
+	else if (!strcmp(cmd, "recover")) {
+		if (ctx.dev_id < 0) {
+			fprintf(stderr, "device id isn't provided for recovering\n");
+			ret = -EINVAL;
+		} else {
+			ctx.recovery = 1;
+			ret = cmd_dev_add(&ctx);
+		}
+	} else if (!strcmp(cmd, "del"))
 		ret = cmd_dev_del(&ctx);
 	else if (!strcmp(cmd, "list")) {
 		ctx.all = 1;
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 7b7446359c8f..3d2b9f14491c 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -79,6 +79,7 @@ struct dev_ctx {
 	unsigned int	logging:1;
 	unsigned int	all:1;
 	unsigned int	fg:1;
+	unsigned int	recovery:1;
 
 	int _evtfd;
 	int _shmid;
diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 87fd0c824b77..e822b2a2729a 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -169,8 +169,11 @@ _have_feature()
 	return 1
 }
 
-_add_ublk_dev() {
+_create_ublk_dev() {
 	local dev_id;
+	local cmd=$1
+
+	shift 1
 
 	if [ ! -c /dev/ublk-control ]; then
 		return ${UBLK_SKIP_CODE}
@@ -181,7 +184,7 @@ _add_ublk_dev() {
 		fi
 	fi
 
-	if ! dev_id=$("${UBLK_PROG}" add "$@" | grep "dev id" | awk -F '[ :]' '{print $3}'); then
+	if ! dev_id=$("${UBLK_PROG}" "$cmd" "$@" | grep "dev id" | awk -F '[ :]' '{print $3}'); then
 		echo "fail to add ublk dev $*"
 		return 255
 	fi
@@ -194,6 +197,23 @@ _add_ublk_dev() {
 	fi
 }
 
+_add_ublk_dev() {
+	_create_ublk_dev "add" "$@"
+}
+
+_recover_ublk_dev() {
+	local dev_id
+	local state
+
+	dev_id=$(_create_ublk_dev "recover" "$@")
+	for ((j=0;j<20;j++)); do
+		state=$(_get_ublk_dev_state "${dev_id}")
+		[ "$state" == "LIVE" ] && break
+		sleep 1
+	done
+	echo "$state"
+}
+
 # kill the ublk daemon and return ublk device state
 __ublk_kill_daemon()
 {
@@ -280,6 +300,39 @@ run_io_and_kill_daemon()
 	fi
 }
 
+run_io_and_recover()
+{
+	local state
+	local dev_id
+
+	dev_id=$(_add_ublk_dev "$@")
+	_check_add_dev "$TID" $?
+
+	fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio \
+		--rw=readwrite --iodepth=256 --size="${size}" --numjobs=4 \
+		--runtime=20 --time_based > /dev/null 2>&1 &
+	sleep 4
+
+	state=$(__ublk_kill_daemon "${dev_id}" "QUIESCED")
+	if [ "$state" != "QUIESCED" ]; then
+		echo "device isn't quiesced($state) after killing daemon"
+		return 255
+	fi
+
+	state=$(_recover_ublk_dev -n "$dev_id" "$@")
+	if [ "$state" != "LIVE" ]; then
+		echo "faile to recover to LIVE($state)"
+		return 255
+	fi
+
+	if ! __remove_ublk_dev_return "${dev_id}"; then
+		echo "delete dev ${dev_id} failed"
+		return 255
+	fi
+	wait
+}
+
+
 _ublk_test_top_dir()
 {
 	cd "$(dirname "$0")" && pwd
diff --git a/tools/testing/selftests/ublk/test_generic_04.sh b/tools/testing/selftests/ublk/test_generic_04.sh
new file mode 100755
index 000000000000..8a3bc080c577
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_04.sh
@@ -0,0 +1,40 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_04"
+ERR_CODE=0
+
+ublk_run_recover_test()
+{
+	run_io_and_recover "$@"
+	ERR_CODE=$?
+	if [ ${ERR_CODE} -ne 0 ]; then
+		echo "$TID failure: $*"
+		_show_result $TID $ERR_CODE
+	fi
+}
+
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "recover" "basic recover function verification"
+
+_create_backfile 0 256M
+_create_backfile 1 128M
+_create_backfile 2 128M
+
+ublk_run_recover_test -t null -q 2 -r 1 &
+ublk_run_recover_test -t loop -q 2 -r 1 "${UBLK_BACKFILES[0]}" &
+ublk_run_recover_test -t stripe -q 2 -r 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
+
+ublk_run_recover_test -t null -q 2 -r 1 -i 1 &
+ublk_run_recover_test -t loop -q 2 -r 1 -i 1 "${UBLK_BACKFILES[0]}" &
+ublk_run_recover_test -t stripe -q 2 -r 1 -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
+
+_cleanup_test "recover"
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_generic_05.sh b/tools/testing/selftests/ublk/test_generic_05.sh
new file mode 100755
index 000000000000..714630b4b329
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_05.sh
@@ -0,0 +1,44 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_04"
+ERR_CODE=0
+
+ublk_run_recover_test()
+{
+	run_io_and_recover "$@"
+	ERR_CODE=$?
+	if [ ${ERR_CODE} -ne 0 ]; then
+		echo "$TID failure: $*"
+		_show_result $TID $ERR_CODE
+	fi
+}
+
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+if ! _have_feature "ZERO_COPY"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "recover" "basic recover function verification (zero copy)"
+
+_create_backfile 0 256M
+_create_backfile 1 128M
+_create_backfile 2 128M
+
+ublk_run_recover_test -t null -q 2 -r 1 -z &
+ublk_run_recover_test -t loop -q 2 -r 1 -z "${UBLK_BACKFILES[0]}" &
+ublk_run_recover_test -t stripe -q 2 -r 1 -z "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
+
+ublk_run_recover_test -t null -q 2 -r 1 -z -i 1 &
+ublk_run_recover_test -t loop -q 2 -r 1 -z -i 1 "${UBLK_BACKFILES[0]}" &
+ublk_run_recover_test -t stripe -q 2 -r 1 -z -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
+
+_cleanup_test "recover"
+_show_result $TID $ERR_CODE
-- 
2.47.0

