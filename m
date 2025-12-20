Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1F23009DA
	for <linux-block@vger.kernel.org>; Sat, 20 Dec 2025 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766224441; cv=none; b=KjyG/0Hl8D1d6/i+PcitZHf9Z9YAZ1kY3usNQz9VCToAx+hGaWElxAGXZpcgYugT8/BGPKrwcuk6e6aE38SzFPeaOQhI50EGBdbX3WpEDIGnfVdLprm+6LraA8q7FDEFmMBpr+oggIFpqv3s/RmhKut5zv/VxrpigWpItSmFB6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766224441; c=relaxed/simple;
	bh=79sb8TH5P8qBy7TUz1L1yPFgmEk/fR1I0hLhVekRmZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLkXXn5rwL6qg09wNeiGHWTIT8lMY9SMBdVlzRKQpPdm5ilp+l+lJPea7QdC1YN79aMZlPDB67t/ElnWAjIzuZqqrGPsKURvCKP3ICO0UHW7EwhciOB7N9SOb67cvw5He/JIcN66VGcLyiiyZCBU/zMX5CvjTU+zTXxXSd3fg1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f/zZrik+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/zZrik+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766224438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBildM1LyJS3dkJNjsn1jtS8i1txLuL27RHUMvL9bDA=;
	b=f/zZrik+3rR4op7YtOpz0yHs68Lv7iqejvouIz1F6i0mOCvP1swDXMcH8DtHrV8Ls3X6KS
	38rgGOy6Xr9b2e75Q5pqFB7r7JK/T71Ge2MF6O5ze8886+VGc1UrcsGMRbdkohPHh9ZiCC
	WKIuly1oJYqAXPo+VsjK3kf1k+iIQts=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-DpwboZzlOpeZlJRP0NPcKA-1; Sat,
 20 Dec 2025 04:53:51 -0500
X-MC-Unique: DpwboZzlOpeZlJRP0NPcKA-1
X-Mimecast-MFC-AGG-ID: DpwboZzlOpeZlJRP0NPcKA_1766224430
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4AF01956046;
	Sat, 20 Dec 2025 09:53:50 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CC911800367;
	Sat, 20 Dec 2025 09:53:48 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Yoav Cohen <yoav@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] ublk: add selftest for UBLK_F_NO_AUTO_PART_SCAN
Date: Sat, 20 Dec 2025 17:53:22 +0800
Message-ID: <20251220095322.1527664-3-ming.lei@redhat.com>
In-Reply-To: <20251220095322.1527664-1-ming.lei@redhat.com>
References: <20251220095322.1527664-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add test_generic_14.sh to test the UBLK_F_NO_AUTO_PART_SCAN feature
flag which allows suppressing automatic partition scanning during
device startup while still allowing manual partition probing.

The test verifies:
- Normal behavior: partitions are auto-detected without the flag
- With flag: partitions are not auto-detected during START_DEV
- Manual scan: blockdev --rereadpt works with the flag

Also update kublk tool to support --no_auto_part_scan option and
recognize the feature flag.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |   1 +
 tools/testing/selftests/ublk/kublk.c          |   6 +-
 tools/testing/selftests/ublk/kublk.h          |   1 +
 .../testing/selftests/ublk/test_generic_14.sh | 105 ++++++++++++++++++
 4 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_14.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 770269efe42a..95831509fa45 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -21,6 +21,7 @@ TEST_PROGS += test_generic_10.sh
 TEST_PROGS += test_generic_11.sh
 TEST_PROGS += test_generic_12.sh
 TEST_PROGS += test_generic_13.sh
+TEST_PROGS += test_generic_14.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index f8fa102a627f..46a9019299d3 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1415,6 +1415,7 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_QUIESCE),
 		FEAT_NAME(UBLK_F_PER_IO_DAEMON),
 		FEAT_NAME(UBLK_F_BUF_REG_OFF_DAEMON),
+		FEAT_NAME(UBLK_F_NO_AUTO_PART_SCAN),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
@@ -1509,7 +1510,7 @@ static void __cmd_create_help(char *exe, bool recovery)
 			exe, recovery ? "recover" : "add");
 	printf("\t[--foreground] [--quiet] [-z] [--auto_zc] [--auto_zc_fallback] [--debug_mask mask] [-r 0|1 ] [-g]\n");
 	printf("\t[-e 0|1 ] [-i 0|1] [--no_ublk_fixed_fd]\n");
-	printf("\t[--nthreads threads] [--per_io_tasks]\n");
+	printf("\t[--nthreads threads] [--per_io_tasks] [--no_auto_part_scan]\n");
 	printf("\t[target options] [backfile1] [backfile2] ...\n");
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
 	printf("\tdefault: nthreads=nr_queues");
@@ -1572,6 +1573,7 @@ int main(int argc, char *argv[])
 		{ "nthreads",		1,	NULL,  0 },
 		{ "per_io_tasks",	0,	NULL,  0 },
 		{ "no_ublk_fixed_fd",	0,	NULL,  0 },
+		{ "no_auto_part_scan",	0,	NULL,  0 },
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
@@ -1653,6 +1655,8 @@ int main(int argc, char *argv[])
 				ctx.per_io_tasks = 1;
 			if (!strcmp(longopts[option_idx].name, "no_ublk_fixed_fd"))
 				ctx.no_ublk_fixed_fd = 1;
+			if (!strcmp(longopts[option_idx].name, "no_auto_part_scan"))
+				ctx.flags |= UBLK_F_NO_AUTO_PART_SCAN;
 			break;
 		case '?':
 			/*
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index fe42705c6d42..68fc2017fb20 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -78,6 +78,7 @@ struct dev_ctx {
 	unsigned int	auto_zc_fallback:1;
 	unsigned int	per_io_tasks:1;
 	unsigned int	no_ublk_fixed_fd:1;
+	unsigned int	no_auto_part_scan:1;
 
 	int _evtfd;
 	int _shmid;
diff --git a/tools/testing/selftests/ublk/test_generic_14.sh b/tools/testing/selftests/ublk/test_generic_14.sh
new file mode 100755
index 000000000000..15e3f39611cd
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_14.sh
@@ -0,0 +1,105 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_14"
+ERR_CODE=0
+
+format_backing_file()
+{
+	local backing_file=$1
+
+	# Create ublk device to write partition table
+	local tmp_dev=$(_add_ublk_dev -t loop "${backing_file}")
+	[ $? -ne 0 ] && return 1
+
+	# Write partition table with sfdisk
+	sfdisk /dev/ublkb"${tmp_dev}" > /dev/null 2>&1 <<EOF
+label: dos
+start=2048, size=100MiB, type=83
+start=206848, size=100MiB, type=83
+EOF
+	local ret=$?
+
+	"${UBLK_PROG}" del -n "${tmp_dev}"
+
+	return $ret
+}
+
+test_auto_part_scan()
+{
+	local backing_file=$1
+
+	# Create device WITHOUT --no_auto_part_scan
+	local dev_id=$(_add_ublk_dev -t loop "${backing_file}")
+	[ $? -ne 0 ] && return 1
+
+	udevadm settle
+
+	# Partitions should be auto-detected
+	if [ ! -e /dev/ublkb"${dev_id}"p1 ] || [ ! -e /dev/ublkb"${dev_id}"p2 ]; then
+		"${UBLK_PROG}" del -n "${dev_id}"
+		return 1
+	fi
+
+	"${UBLK_PROG}" del -n "${dev_id}"
+	return 0
+}
+
+test_no_auto_part_scan()
+{
+	local backing_file=$1
+
+	# Create device WITH --no_auto_part_scan
+	local dev_id=$(_add_ublk_dev -t loop --no_auto_part_scan "${backing_file}")
+	[ $? -ne 0 ] && return 1
+
+	udevadm settle
+
+	# Partitions should NOT be auto-detected
+	if [ -e /dev/ublkb"${dev_id}"p1 ]; then
+		"${UBLK_PROG}" del -n "${dev_id}"
+		return 1
+	fi
+
+	# Manual scan should work
+	blockdev --rereadpt /dev/ublkb"${dev_id}" > /dev/null 2>&1
+	udevadm settle
+
+	if [ ! -e /dev/ublkb"${dev_id}"p1 ] || [ ! -e /dev/ublkb"${dev_id}"p2 ]; then
+		"${UBLK_PROG}" del -n "${dev_id}"
+		return 1
+	fi
+
+	"${UBLK_PROG}" del -n "${dev_id}"
+	return 0
+}
+
+if ! _have_program sfdisk || ! _have_program blockdev; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "generic" "test UBLK_F_NO_AUTO_PART_SCAN"
+
+if ! _have_feature "UBLK_F_NO_AUTO_PART_SCAN"; then
+	_cleanup_test "generic"
+	exit "$UBLK_SKIP_CODE"
+fi
+
+
+# Create and format backing file with partition table
+_create_backfile 0 256M
+format_backing_file "${UBLK_BACKFILES[0]}"
+[ $? -ne 0 ] && ERR_CODE=255
+
+# Test normal auto partition scan
+[ "$ERR_CODE" -eq 0 ] && test_auto_part_scan "${UBLK_BACKFILES[0]}"
+[ $? -ne 0 ] && ERR_CODE=255
+
+# Test no auto partition scan with manual scan
+[ "$ERR_CODE" -eq 0 ] && test_no_auto_part_scan "${UBLK_BACKFILES[0]}"
+[ $? -ne 0 ] && ERR_CODE=255
+
+_cleanup_test "generic"
+_show_result $TID $ERR_CODE
-- 
2.47.0

