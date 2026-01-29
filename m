Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFBB3314C4
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703635; cv=none; b=QbHMw4WCMYrD8GOsoC9osayZ9WnSK48gJmHebOuX2V2UdvKNSrGaHYR6EysDSRiFCb20GE222Xz1m8ClHMOkj07MYz2LU4HoN7oDUnifE+E04aFx2oq/3GWgdK0cqLeR8nYy8k2hYwdl1dlRFDikgaJ+xw2Or0uonlvPvQLNk5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703635; c=relaxed/simple;
	bh=p11XC3RMhIlK9uHs3sf6y8xQRn61SPseP9etH5rN7xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4lW6DvUJKOKngphkpgRnj+DajkjCNWUCyjrkQYtee/3ZZezsAmxbbANdYUkeiE46UBqoOWrHHb7p3xT5Pk9jha9ExY6YtAG5ndKbjkK6eJBcs6O8BWLP521T1b/mjlEo5OxdNfA55KTujcfx/fH4oN3iLilt51BpZA/CWffgAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SRmjuqfP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRmjuqfP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769703633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BeYxiTBvzzQaYv1bJ+/CmbHUEqyXeUkiho6egl6PNE=;
	b=SRmjuqfP2+sf4AiSTnE/j9jdpScrNHqW3odUmpiKuPLQfxSBHa6sXyh2YoEqqXVpJtRxul
	vq8M3IwxHLR3Sr3/H0cuIykdIrfveWDXMVOz+ObdQq2W5GZvYOGWz0LPtpLDLwFlEdIuYZ
	QBAWYmCCJP3RSzJkgfKtIh27NapS8ZM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-b4nidPEwOty1tL1wTJkU4A-1; Thu,
 29 Jan 2026 11:20:29 -0500
X-MC-Unique: b4nidPEwOty1tL1wTJkU4A-1
X-Mimecast-MFC-AGG-ID: b4nidPEwOty1tL1wTJkU4A_1769703625
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CAD918002CE;
	Thu, 29 Jan 2026 16:20:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.182])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46E2E19560A2;
	Thu, 29 Jan 2026 16:20:23 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 4/9] selftests: ublk: add selftest for UBLK_F_NO_AUTO_PART_SCAN
Date: Fri, 30 Jan 2026 00:19:53 +0800
Message-ID: <20260129162001.3532311-5-ming.lei@redhat.com>
In-Reply-To: <20260129162001.3532311-1-ming.lei@redhat.com>
References: <20260129162001.3532311-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add test_part_01.sh to test the UBLK_F_NO_AUTO_PART_SCAN feature
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
 tools/testing/selftests/ublk/Makefile        |   2 +
 tools/testing/selftests/ublk/kublk.c         |   6 +-
 tools/testing/selftests/ublk/kublk.h         |   3 +-
 tools/testing/selftests/ublk/test_part_01.sh | 104 +++++++++++++++++++
 4 files changed, 113 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_part_01.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index e39a6f871fcc..bc5bd7d1381d 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -48,6 +48,8 @@ TEST_PROGS += test_stripe_04.sh
 TEST_PROGS += test_stripe_05.sh
 TEST_PROGS += test_stripe_06.sh
 
+TEST_PROGS += test_part_01.sh
+
 TEST_PROGS += test_stress_01.sh
 TEST_PROGS += test_stress_02.sh
 TEST_PROGS += test_stress_03.sh
diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 2da37557e1a9..e8279c4acc40 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1615,6 +1615,7 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_INTEGRITY),
 		FEAT_NAME(UBLK_F_SAFE_STOP_DEV),
 		FEAT_NAME(UBLK_F_BATCH_IO),
+		FEAT_NAME(UBLK_F_NO_AUTO_PART_SCAN),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
@@ -1712,7 +1713,7 @@ static void __cmd_create_help(char *exe, bool recovery)
 	printf("\t[--nthreads threads] [--per_io_tasks]\n");
 	printf("\t[--integrity_capable] [--integrity_reftag] [--metadata_size SIZE] "
 		 "[--pi_offset OFFSET] [--csum_type ip|t10dif|nvme] [--tag_size SIZE]\n");
-	printf("\t[--batch|-b]\n");
+	printf("\t[--batch|-b] [--no_auto_part_scan]\n");
 	printf("\t[target options] [backfile1] [backfile2] ...\n");
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
 	printf("\tdefault: nthreads=nr_queues");
@@ -1786,6 +1787,7 @@ int main(int argc, char *argv[])
 		{ "tag_size",		1,	NULL,  0 },
 		{ "safe",		0,	NULL,  0 },
 		{ "batch",              0,      NULL, 'b'},
+		{ "no_auto_part_scan",	0,	NULL,  0 },
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
@@ -1898,6 +1900,8 @@ int main(int argc, char *argv[])
 				ctx.tag_size = strtoul(optarg, NULL, 0);
 			if (!strcmp(longopts[option_idx].name, "safe"))
 				ctx.safe_stop = 1;
+			if (!strcmp(longopts[option_idx].name, "no_auto_part_scan"))
+				ctx.flags |= UBLK_F_NO_AUTO_PART_SCAN;
 			break;
 		case '?':
 			/*
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index ca97deb5e208..1faeccaaecae 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -78,12 +78,13 @@ struct dev_ctx {
 	unsigned int	auto_zc_fallback:1;
 	unsigned int	per_io_tasks:1;
 	unsigned int	no_ublk_fixed_fd:1;
+	unsigned int	safe_stop:1;
+	unsigned int	no_auto_part_scan:1;
 	__u32 integrity_flags;
 	__u8 metadata_size;
 	__u8 pi_offset;
 	__u8 csum_type;
 	__u8 tag_size;
-	unsigned int	safe_stop:1;
 
 	int _evtfd;
 	int _shmid;
diff --git a/tools/testing/selftests/ublk/test_part_01.sh b/tools/testing/selftests/ublk/test_part_01.sh
new file mode 100755
index 000000000000..8028f6e4b3a5
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_part_01.sh
@@ -0,0 +1,104 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
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

