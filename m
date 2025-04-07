Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD31253F30
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031810; cv=none; b=ZzkaxU72PwIXljeZV8RSZFeLUcX1KqkcJos8w5niulMuUC9FWcCDi5O+v0X2rs2DhevSTKi4NGEmSNyTbcGxFRq8nXbs1mhVSM6G3HhGjJIRhfvE+Fl+KZwksba/nQMbtNP2DVkoiKyOJt1yglcHNAoxWxOV+1ieaN/1RkvbS9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031810; c=relaxed/simple;
	bh=y+INYGaY7eRlftALmsGI6KDeG8psb/ODLKuDm7EhXrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kA6vCGPSxnOGz3Zqq2S4UlZ2ZTFVLWwaoFXXsEDg6TEPtg9o8lHvIqOeA+M0ZkNznIiI87E8lijjJnMo59qOx9ZOSKgDc1uMD8JMZaJXvmYWkrbKAbcAQO874/Gzbuk+vNmhhV7R3CBJbrvfDOb+h3AQDJ6C+rOa37HRg8IDqhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bihlq4r7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bihlq4r7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744031807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SR9WADw+KQLct1hA1kd/FlvNmOVOftqlnh1ztFTro5s=;
	b=bihlq4r7qn7CGae/Au69EpdClHqOdv+QwqUsJ0N5LH7RCwAkCPU1EYYjHmVyOEc/CFPVc/
	yvlaA025EnfHSS58gmKd36YTbs/YWVW3SZA1D+Mbjenzui7cMLAX/59p0OjfMSOg2HXJaQ
	DYt6Ct5F+vniQ2jMy/leYarQaGAa+Cs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-_QHtEddWMoirH4bJfl4rtA-1; Mon,
 07 Apr 2025 09:16:46 -0400
X-MC-Unique: _QHtEddWMoirH4bJfl4rtA-1
X-Mimecast-MFC-AGG-ID: _QHtEddWMoirH4bJfl4rtA_1744031805
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5311B1956087;
	Mon,  7 Apr 2025 13:16:45 +0000 (UTC)
Received: from localhost (unknown [10.72.120.16])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 24C7E1801A6D;
	Mon,  7 Apr 2025 13:16:43 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 12/13] selftests: ublk: support user recovery
Date: Mon,  7 Apr 2025 21:15:23 +0800
Message-ID: <20250407131526.1927073-13-ming.lei@redhat.com>
In-Reply-To: <20250407131526.1927073-1-ming.lei@redhat.com>
References: <20250407131526.1927073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
index 2e1963bee21c..677a0ba79f09 100644
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
@@ -1203,12 +1231,14 @@ static int cmd_dev_get_features(void)
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
 
@@ -1218,7 +1248,25 @@ static int cmd_dev_help(char *exe)
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
@@ -1240,6 +1288,10 @@ int main(int argc, char *argv[])
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
@@ -1254,13 +1306,14 @@ int main(int argc, char *argv[])
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
@@ -1282,6 +1335,25 @@ int main(int argc, char *argv[])
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
@@ -1327,7 +1399,15 @@ int main(int argc, char *argv[])
 
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
index 96a5eff436b3..f5bf38d1da36 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -77,6 +77,7 @@ struct dev_ctx {
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

