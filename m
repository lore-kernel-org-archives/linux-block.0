Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D8B29A32E
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931744; cv=none; b=CVXl4vIo2WNJWwpn+ahxAyOZQsBagu1RtcbbG9JWS2eQNfDOonjBBkaY/wJlk7htkhlSTEBwnRCTAODgyysHRqHvlAI7DZGef3EHNlK11Y776kLvXCVJN9d2J5fE3BNfH4MyhG0VbSBORuVYdaSplLdq6nXmYM3BFuLn6j5b0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931744; c=relaxed/simple;
	bh=IDrE/Z3Ul0P24V3q4lOxjIl1cpZBVDojrG5Zklfltm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcZNkVycaPDb43sC+2E/iw31p60GfhrYK42gUBnvON2LGJqGGdX5/yNkW6nIoFJ5WUSnmWMC4BkTNDr5WPGJpSHEgsszA6T25cM26qBFHGo3q1O2MMdtRoa7JAvb7xQwY2tk5EIxdVx8ACEaxSWYWeaepa5e2HQI3RuPjKW0ndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dq4S0hUC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dq4S0hUC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747931741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7tQhrmjlGEowPbIdjNpTqXGg5Vm2aqZOTe9euExae2Y=;
	b=dq4S0hUCSy5E3ffuHci+qJNzSa/jO7qJx7o0cQTT/vfrFIWzRb2vpX8p64RTIZKlNr9XF2
	6kBtGMA62ZCJsIkPpz4MgyfPNrUpVBaesNo6/HxUXuvod4UUHlrwf3SCm97NTkAI9zSd4+
	HplUvS6GKGC+g/J78TY8RHoIJJkGNC8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-QqqyFK_1NKC-ZDz1aqJReg-1; Thu,
 22 May 2025 12:35:37 -0400
X-MC-Unique: QqqyFK_1NKC-ZDz1aqJReg-1
X-Mimecast-MFC-AGG-ID: QqqyFK_1NKC-ZDz1aqJReg_1747931736
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AF431955DB3;
	Thu, 22 May 2025 16:35:36 +0000 (UTC)
Received: from localhost (unknown [10.72.116.39])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E0A6119560AB;
	Thu, 22 May 2025 16:35:34 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Yoav Cohen <yoav@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>,
	Omri Mann <omri@nvidia.com>,
	Jared Holzman <jholzman@nvidia.com>
Subject: [PATCH 1/3] selftests: ublk: add test case for UBLK_U_CMD_UPDATE_SIZE
Date: Fri, 23 May 2025 00:35:19 +0800
Message-ID: <20250522163523.406289-2-ming.lei@redhat.com>
In-Reply-To: <20250522163523.406289-1-ming.lei@redhat.com>
References: <20250522163523.406289-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add test generic_10 for covering new control command of UBLK_U_CMD_UPDATE_SIZE.

Add 'update_size -s|--size size_in_bytes' sub-command on ublk utility for
supporting this feature, then verify the feature via generic_10.

Cc: Omri Mann <omri@nvidia.com>
Cc: Jared Holzman <jholzman@nvidia.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  1 +
 tools/testing/selftests/ublk/kublk.c          | 55 ++++++++++++++++++-
 tools/testing/selftests/ublk/kublk.h          |  3 +
 tools/testing/selftests/ublk/test_common.sh   |  5 ++
 .../testing/selftests/ublk/test_generic_10.sh | 30 ++++++++++
 5 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_10.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 2a2ef0cb54bc..81b8ed6b92e2 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -17,6 +17,7 @@ TEST_PROGS += test_generic_07.sh
 
 TEST_PROGS += test_generic_08.sh
 TEST_PROGS += test_generic_09.sh
+TEST_PROGS += test_generic_10.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index c429a20ab51e..683a23078f43 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -216,6 +216,18 @@ static int ublk_ctrl_get_features(struct ublk_dev *dev,
 	return __ublk_ctrl_cmd(dev, &data);
 }
 
+static int ublk_ctrl_update_size(struct ublk_dev *dev,
+		__u64 nr_sects)
+{
+	struct ublk_ctrl_cmd_data data = {
+		.cmd_op	= UBLK_U_CMD_UPDATE_SIZE,
+		.flags	= CTRL_CMD_HAS_DATA,
+	};
+
+	data.data[0] = nr_sects;
+	return __ublk_ctrl_cmd(dev, &data);
+}
+
 static const char *ublk_dev_state_desc(struct ublk_dev *dev)
 {
 	switch (dev->dev_info.state) {
@@ -1236,6 +1248,7 @@ static int cmd_dev_get_features(void)
 		[const_ilog2(UBLK_F_USER_COPY)] = "USER_COPY",
 		[const_ilog2(UBLK_F_ZONED)] = "ZONED",
 		[const_ilog2(UBLK_F_USER_RECOVERY_FAIL_IO)] = "RECOVERY_FAIL_IO",
+		[const_ilog2(UBLK_F_UPDATE_SIZE)] = "UPDATE_SIZE",
 		[const_ilog2(UBLK_F_AUTO_BUF_REG)] = "AUTO_BUF_REG",
 	};
 	struct ublk_dev *dev;
@@ -1270,6 +1283,39 @@ static int cmd_dev_get_features(void)
 	return ret;
 }
 
+static int cmd_dev_update_size(struct dev_ctx *ctx)
+{
+	struct ublk_dev *dev = ublk_ctrl_init();
+	struct ublk_params p;
+	int ret = -EINVAL;
+
+	if (!dev)
+		return -ENODEV;
+
+	if (ctx->dev_id < 0) {
+		fprintf(stderr, "device id isn't provided\n");
+		goto out;
+	}
+
+	dev->dev_info.dev_id = ctx->dev_id;
+	ret = ublk_ctrl_get_params(dev, &p);
+	if (ret < 0) {
+		ublk_err("failed to get params %d %s\n", ret, strerror(-ret));
+		goto out;
+	}
+
+	if (ctx->size & ((1 << p.basic.logical_bs_shift) - 1)) {
+		ublk_err("size isn't aligned with logical block size\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = ublk_ctrl_update_size(dev, ctx->size >> 9);
+out:
+	ublk_ctrl_deinit(dev);
+	return ret;
+}
+
 static void __cmd_create_help(char *exe, bool recovery)
 {
 	int i;
@@ -1312,6 +1358,7 @@ static int cmd_dev_help(char *exe)
 	printf("%s list [-n dev_id] -a \n", exe);
 	printf("\t -a list all devices, -n list specified device, default -a \n\n");
 	printf("%s features\n", exe);
+	printf("%s update_size -n dev_id -s|--size size_in_bytes \n", exe);
 	return 0;
 }
 
@@ -1333,6 +1380,7 @@ int main(int argc, char *argv[])
 		{ "get_data",		1,	NULL, 'g'},
 		{ "auto_zc",		0,	NULL,  0 },
 		{ "auto_zc_fallback", 	0,	NULL,  0 },
+		{ "size",		1,	NULL, 's'},
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
@@ -1354,7 +1402,7 @@ int main(int argc, char *argv[])
 
 	opterr = 0;
 	optind = 2;
-	while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:gaz",
+	while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:s:gaz",
 				  longopts, &option_idx)) != -1) {
 		switch (opt) {
 		case 'a':
@@ -1394,6 +1442,9 @@ int main(int argc, char *argv[])
 		case 'g':
 			ctx.flags |= UBLK_F_NEED_GET_DATA;
 			break;
+		case 's':
+			ctx.size = strtoull(optarg, NULL, 10);
+			break;
 		case 0:
 			if (!strcmp(longopts[option_idx].name, "debug_mask"))
 				ublk_dbg_mask = strtol(optarg, NULL, 16);
@@ -1470,6 +1521,8 @@ int main(int argc, char *argv[])
 		ret = cmd_dev_help(argv[0]);
 	else if (!strcmp(cmd, "features"))
 		ret = cmd_dev_get_features();
+	else if (!strcmp(cmd, "update_size"))
+		ret = cmd_dev_update_size(&ctx);
 	else
 		cmd_dev_help(argv[0]);
 
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 9af930e951a3..e34508bf5798 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -92,6 +92,9 @@ struct dev_ctx {
 	/* built from shmem, only for ublk_dump_dev() */
 	struct ublk_dev *shadow_dev;
 
+	/* for 'update_size' command */
+	unsigned long long size;
+
 	union {
 		struct stripe_ctx 	stripe;
 		struct fault_inject_ctx fault_inject;
diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index c17fd66b73ac..244d886b7eae 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -23,6 +23,11 @@ _get_disk_dev_t() {
 	echo $(( (major & 0xfff) << 20 | (minor & 0xfffff) ))
 }
 
+_get_disk_size()
+{
+	lsblk -b -o SIZE -n "$1"
+}
+
 _run_fio_verify_io() {
 	fio --name=verify --rw=randwrite --direct=1 --ioengine=libaio \
 		--bs=8k --iodepth=32 --verify=crc32c --do_verify=1 \
diff --git a/tools/testing/selftests/ublk/test_generic_10.sh b/tools/testing/selftests/ublk/test_generic_10.sh
new file mode 100755
index 000000000000..abc11c3d416b
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_10.sh
@@ -0,0 +1,30 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_10"
+ERR_CODE=0
+
+if ! _have_feature "UPDATE_SIZE"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "null" "check update size"
+
+dev_id=$(_add_ublk_dev -t null)
+_check_add_dev $TID $?
+
+size=$(_get_disk_size /dev/ublkb"${dev_id}")
+size=$(( size / 2 ))
+if ! "$UBLK_PROG" update_size -n "$dev_id" -s "$size"; then
+	ERR_CODE=255
+fi
+
+new_size=$(_get_disk_size /dev/ublkb"${dev_id}")
+if [ "$new_size" != "$size" ]; then
+	ERR_CODE=255
+fi
+
+_cleanup_test "null"
+_show_result $TID $ERR_CODE
-- 
2.47.0

