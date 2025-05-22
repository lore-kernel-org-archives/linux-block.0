Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFED299AB9
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931754; cv=none; b=ZGfDazR2uZjJPJxQ/4ghd7JGmQrmFYlxjmyDaSK/nrO+aGpjC6AMu59qBjhTP9+D60qI4koDrpLJAv9yKxEGseVqs1QrfOplDb6Ho3mNUSHjL38vDk+335l1W9DuyOqq8xDapGDPQX5BHF31JsRVLOizNXJFJsDKtc/tzT1MK7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931754; c=relaxed/simple;
	bh=VOduJy/mJGTGdr4/5EMGRipO636sw339Dd5FXYeWWZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxxDgZjB2fgZ3kr4p0pk6XPWxWD2D8abn8XcfcMea1ova2ZH5a75dxJk2PWfO/7bwHOXnrteXaCauebsyimOR71YqqoHI2Th/bGVMG+rQN7idc64kbY3jVP05STNgkbt61G/bWwj4ByAeLD5a9G87I/Iadsw59sQ0HwY2q4p/p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7qOZ0mV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7qOZ0mV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747931751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HLXIcIN+7R645Bsgyq6FtS2K9WmxvtR3I1lhgyHxK4Y=;
	b=L7qOZ0mVwynx3j3rK577GEUnitSge0cL5Vl6tiwUktrk+h5/n5Zfkol3n0+YXCpotU9lxW
	o6KyxAaJwal/yEvsHHhT7mhNUw9OjEn6ebnhOP72HXK3iMErFHFPLd7IZ5TTqLBIF/Bz4T
	ksmdE5GCtT8G4eTBIV1IkPEXmeXS1vI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-PGNbhKhhM86z5t6QVItzMQ-1; Thu,
 22 May 2025 12:35:45 -0400
X-MC-Unique: PGNbhKhhM86z5t6QVItzMQ-1
X-Mimecast-MFC-AGG-ID: PGNbhKhhM86z5t6QVItzMQ_1747931744
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 323011954239;
	Thu, 22 May 2025 16:35:44 +0000 (UTC)
Received: from localhost (unknown [10.72.116.39])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1005330001B5;
	Thu, 22 May 2025 16:35:42 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Yoav Cohen <yoav@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/3] selftests: ublk: add test for UBLK_F_QUIESCE
Date: Fri, 23 May 2025 00:35:21 +0800
Message-ID: <20250522163523.406289-4-ming.lei@redhat.com>
In-Reply-To: <20250522163523.406289-1-ming.lei@redhat.com>
References: <20250522163523.406289-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add test generic_11 for covering new control command of
UBLK_U_CMD_QUIESCE_DEV.

Add 'quiesce -n dev_id' sub-command on ublk utility for transitioning
device state to quiesce states, then verify the feature via generic_10
by doing quiesce and recovery.

Cc: Yoav Cohen <yoav@nvidia.com>
Link: https://lore.kernel.org/linux-block/DM4PR12MB632807AB7CDCE77D1E5AB7D0A9B92@DM4PR12MB6328.namprd12.prod.outlook.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  1 +
 tools/testing/selftests/ublk/kublk.c          | 39 ++++++++++++++++
 tools/testing/selftests/ublk/test_common.sh   | 32 ++++++++++++--
 .../testing/selftests/ublk/test_generic_04.sh |  2 +-
 .../testing/selftests/ublk/test_generic_05.sh |  2 +-
 .../testing/selftests/ublk/test_generic_11.sh | 44 +++++++++++++++++++
 6 files changed, 115 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_11.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 81b8ed6b92e2..4dde8838261d 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -18,6 +18,7 @@ TEST_PROGS += test_generic_07.sh
 TEST_PROGS += test_generic_08.sh
 TEST_PROGS += test_generic_09.sh
 TEST_PROGS += test_generic_10.sh
+TEST_PROGS += test_generic_11.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 683a23078f43..b5131a000795 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -228,6 +228,18 @@ static int ublk_ctrl_update_size(struct ublk_dev *dev,
 	return __ublk_ctrl_cmd(dev, &data);
 }
 
+static int ublk_ctrl_quiesce_dev(struct ublk_dev *dev,
+				 unsigned int timeout_ms)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_QUIESCE_DEV,
+		.flags	= CTRL_CMD_HAS_DATA,
+	};
+
+	data.data[0] = timeout_ms;
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
 static const char *ublk_dev_state_desc(struct ublk_dev *dev)
 {
 	switch (dev->dev_info.state) {
@@ -1053,6 +1065,9 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 	info->nr_hw_queues = nr_queues;
 	info->queue_depth = depth;
 	info->flags = ctx->flags;
+	if ((features & UBLK_F_QUIESCE) &&
+			(info->flags & UBLK_F_USER_RECOVERY))
+		info->flags |= UBLK_F_QUIESCE;
 	dev->tgt.ops = ops;
 	dev->tgt.sq_depth = depth;
 	dev->tgt.cq_depth = depth;
@@ -1250,6 +1265,7 @@ static int cmd_dev_get_features(void)
 		[const_ilog2(UBLK_F_USER_RECOVERY_FAIL_IO)] = "RECOVERY_FAIL_IO",
 		[const_ilog2(UBLK_F_UPDATE_SIZE)] = "UPDATE_SIZE",
 		[const_ilog2(UBLK_F_AUTO_BUF_REG)] = "AUTO_BUF_REG",
+		[const_ilog2(UBLK_F_QUIESCE)] = "QUIESCE",
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
@@ -1316,6 +1332,26 @@ static int cmd_dev_update_size(struct dev_ctx *ctx)
 	return ret;
 }
 
+static int cmd_dev_quiesce(struct dev_ctx *ctx)
+{
+	struct ublk_dev *dev = ublk_ctrl_init();
+	int ret = -EINVAL;
+
+	if (!dev)
+		return -ENODEV;
+
+	if (ctx->dev_id < 0) {
+		fprintf(stderr, "device id isn't provided for quiesce\n");
+		goto out;
+	}
+	dev->dev_info.dev_id = ctx->dev_id;
+	ret = ublk_ctrl_quiesce_dev(dev, 10000);
+
+out:
+	ublk_ctrl_deinit(dev);
+	return ret;
+}
+
 static void __cmd_create_help(char *exe, bool recovery)
 {
 	int i;
@@ -1359,6 +1395,7 @@ static int cmd_dev_help(char *exe)
 	printf("\t -a list all devices, -n list specified device, default -a \n\n");
 	printf("%s features\n", exe);
 	printf("%s update_size -n dev_id -s|--size size_in_bytes \n", exe);
+	printf("%s quiesce -n dev_id\n", exe);
 	return 0;
 }
 
@@ -1523,6 +1560,8 @@ int main(int argc, char *argv[])
 		ret = cmd_dev_get_features();
 	else if (!strcmp(cmd, "update_size"))
 		ret = cmd_dev_update_size(&ctx);
+	else if (!strcmp(cmd, "quiesce"))
+		ret = cmd_dev_quiesce(&ctx);
 	else
 		cmd_dev_help(argv[0]);
 
diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 244d886b7eae..0145569ee7e9 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -220,6 +220,26 @@ _recover_ublk_dev() {
 	echo "$state"
 }
 
+# quiesce device and return ublk device state
+__ublk_quiesce_dev()
+{
+	local dev_id=$1
+	local exp_state=$2
+	local state
+
+	if ! ${UBLK_PROG} quiesce -n "${dev_id}"; then
+		state=$(_get_ublk_dev_state "${dev_id}")
+		return "$state"
+	fi
+
+	for ((j=0;j<50;j++)); do
+		state=$(_get_ublk_dev_state "${dev_id}")
+		[ "$state" == "$exp_state" ] && break
+		sleep 1
+	done
+	echo "$state"
+}
+
 # kill the ublk daemon and return ublk device state
 __ublk_kill_daemon()
 {
@@ -308,20 +328,26 @@ run_io_and_kill_daemon()
 
 run_io_and_recover()
 {
+	local action=$1
 	local state
 	local dev_id
 
+	shift 1
 	dev_id=$(_add_ublk_dev "$@")
 	_check_add_dev "$TID" $?
 
 	fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio \
-		--rw=readwrite --iodepth=256 --size="${size}" --numjobs=4 \
+		--rw=randread --iodepth=256 --size="${size}" --numjobs=4 \
 		--runtime=20 --time_based > /dev/null 2>&1 &
 	sleep 4
 
-	state=$(__ublk_kill_daemon "${dev_id}" "QUIESCED")
+	if [ "$action" == "kill_daemon" ]; then
+		state=$(__ublk_kill_daemon "${dev_id}" "QUIESCED")
+	elif [ "$action" == "quiesce_dev" ]; then
+		state=$(__ublk_quiesce_dev "${dev_id}" "QUIESCED")
+	fi
 	if [ "$state" != "QUIESCED" ]; then
-		echo "device isn't quiesced($state) after killing daemon"
+		echo "device isn't quiesced($state) after $action"
 		return 255
 	fi
 
diff --git a/tools/testing/selftests/ublk/test_generic_04.sh b/tools/testing/selftests/ublk/test_generic_04.sh
index 8a3bc080c577..8b533217d4a1 100755
--- a/tools/testing/selftests/ublk/test_generic_04.sh
+++ b/tools/testing/selftests/ublk/test_generic_04.sh
@@ -8,7 +8,7 @@ ERR_CODE=0
 
 ublk_run_recover_test()
 {
-	run_io_and_recover "$@"
+	run_io_and_recover "kill_daemon" "$@"
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
diff --git a/tools/testing/selftests/ublk/test_generic_05.sh b/tools/testing/selftests/ublk/test_generic_05.sh
index 3bb00a347402..398e9e2b58e1 100755
--- a/tools/testing/selftests/ublk/test_generic_05.sh
+++ b/tools/testing/selftests/ublk/test_generic_05.sh
@@ -8,7 +8,7 @@ ERR_CODE=0
 
 ublk_run_recover_test()
 {
-	run_io_and_recover "$@"
+	run_io_and_recover "kill_daemon" "$@"
 	ERR_CODE=$?
 	if [ ${ERR_CODE} -ne 0 ]; then
 		echo "$TID failure: $*"
diff --git a/tools/testing/selftests/ublk/test_generic_11.sh b/tools/testing/selftests/ublk/test_generic_11.sh
new file mode 100755
index 000000000000..a00357a5ec6b
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_11.sh
@@ -0,0 +1,44 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_11"
+ERR_CODE=0
+
+ublk_run_quiesce_recover()
+{
+	run_io_and_recover "quiesce_dev" "$@"
+	ERR_CODE=$?
+	if [ ${ERR_CODE} -ne 0 ]; then
+		echo "$TID failure: $*"
+		_show_result $TID $ERR_CODE
+	fi
+}
+
+if ! _have_feature "QUIESCE"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "quiesce" "basic quiesce & recover function verification"
+
+_create_backfile 0 256M
+_create_backfile 1 128M
+_create_backfile 2 128M
+
+ublk_run_quiesce_recover -t null -q 2 -r 1 &
+ublk_run_quiesce_recover -t loop -q 2 -r 1 "${UBLK_BACKFILES[0]}" &
+ublk_run_quiesce_recover -t stripe -q 2 -r 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
+
+ublk_run_quiesce_recover -t null -q 2 -r 1 -i 1 &
+ublk_run_quiesce_recover -t loop -q 2 -r 1 -i 1 "${UBLK_BACKFILES[0]}" &
+ublk_run_quiesce_recover -t stripe -q 2 -r 1 -i 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
+
+_cleanup_test "quiesce"
+_show_result $TID $ERR_CODE
-- 
2.47.0

