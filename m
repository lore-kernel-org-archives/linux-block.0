Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DA94C956C
	for <linux-block@vger.kernel.org>; Thu,  4 Jun 2026 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595680; cv=none; b=CzdlY+ZjPAdOhlb3h+EqsONxxed59vBJ8gpKjXSs6IaOa+0YDmf9W7db3Je9btMKn5g5/Y7hd+EFZJET+60yllwLW5MJ2pCeayQU6crNnMdTRmvEEQXnik1vtIxgyLaZJIqukmHqFIhrTN6G5q0cni+cGRgqG6DdmEYgQMhMIoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595680; c=relaxed/simple;
	bh=xq+/fsHU5YTbNaarjqrhZbxsJsxwsijrLql6y6yYau0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bEUFThh6d2C4T6hMK7j7xCXgmBtQleKGqlQJlj8rOIVQrrQ84N39x47vabrtSkFXhQX+qKBt0rbKSjzC88BM048O9WARxdoObZxuiuFkXVpfd1kAaecxHBMCCtZ6UXNzAzDRTgP2baFpOLe/9+ofxPYfi+vp7aqEcS3nI52aHZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=V8Nfubdz; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="V8Nfubdz"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gWXJZ3NBRz1XM0pR;
	Thu,  4 Jun 2026 17:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1780595674; x=1783187675; bh=ax4D20sKknU84WP5ia4nhhhRyBqwDnoqdkR
	tF0XQ6P8=; b=V8Nfubdzgn+49W7sE5oaUtk/Xb794v0KaqTz667ZhIXItnKfiS+
	TIatfuRReQC7qoJK0WijonI+w9D2e0qSYpE1uE38WT860FJs1KJHyq+jU1TDRO5X
	+efVsHUHlSvXOvNs2HLO8Cw4C6RjDuqHdkRWBHPhUnja7zba1rU/yZOr0Zh0jgsi
	gRG7xHxlYLHg4sITplIRtQVAuUIizf1bdk0V7POLXYGrMgvhdqycNcY3Bp+0LAwp
	2QD2xVENw3Sz9bdDsKQFmuzj+TW4n1+ylD/1yP/ZrO7os2v+dkZYBDgjUGBX8Ilm
	Y08cFAEA7mRdHVkU2wPxr2mQ/qxtTenm52A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4tt7m77e6Cko; Thu,  4 Jun 2026 17:54:34 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gWXJT4M3Rz1XM6Jh;
	Thu,  4 Jun 2026 17:54:33 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH blktests v2] throtl/008: Add a test for the iocost cgroup controller
Date: Thu,  4 Jun 2026 10:54:23 -0700
Message-ID: <20260604175423.3809638-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a test for read and write IOPS throttling.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---

Changes compared to v1:
 - Changed ". tests/block/rc" into ". tests/throtl/rc".
 - Split test() into run_test() and test() to eliminate duplicate error h=
andling
   code.
 - Made the test whether the iocost controller is supported more robust.
 - Made the test easier to debug.

 tests/throtl/008     | 104 +++++++++++++++++++++++++++++++++++++++++++
 tests/throtl/008.out |   2 +
 2 files changed, 106 insertions(+)
 create mode 100755 tests/throtl/008
 create mode 100644 tests/throtl/008.out

diff --git a/tests/throtl/008 b/tests/throtl/008
new file mode 100755
index 000000000000..f4d3b080797a
--- /dev/null
+++ b/tests/throtl/008
@@ -0,0 +1,104 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Google LLC
+#
+# Test cgroup iocost IOPS limiting.
+
+. tests/throtl/rc
+. common/fio
+
+DESCRIPTION=3D"test cgroup iocost controller limits"
+
+requires() {
+	_have_fio
+	_have_program bc
+	_have_kernel_option BLK_CGROUP_IOCOST
+}
+
+run_test() {
+	# dev_t is global to make it available in the caller.
+	dev_t=3D$(<"/sys/block/${THROTL_DEV}/dev")
+	if [[ -z "$dev_t" ]]; then
+		echo "Failed to get major:minor for ${THROTL_DEV}"
+		return 1
+	fi
+
+	# Configure iocost controller globally for the device
+	# min=3D100.00 max=3D100.00 forces vrate to be fixed at 100%
+	if ! echo "$dev_t enable=3D1 min=3D100.00 max=3D100.00" > "$(_cgroup2_b=
ase_dir)/io.cost.qos"; then
+		echo "Failed to configure io.cost.qos"
+		return 1
+	fi
+
+	# Limit read iops to 100 and write iops to 10.
+	# Setting rbps/wbps to 0 means they are ignored (costs calculated purel=
y based on IOPS)
+	if ! echo "$dev_t ctrl=3Duser model=3Dlinear rbps=3D0 rseqiops=3D100 rr=
andiops=3D100 wbps=3D0 wseqiops=3D10 wrandiops=3D10" > "$(_cgroup2_base_d=
ir)/io.cost.model"; then
+		echo "Failed to configure io.cost.model"
+		return 1
+	fi
+
+	# 1. Run FIO read test
+	local -a FIO_PERF_FIELDS
+	FIO_PERF_FIELDS=3D("read iops")
+	if ! _fio_perf --bs=3D4k --rw=3Drandread --name=3Dread-test --filename=3D=
"/dev/${THROTL_DEV}" \
+			--ioengine=3Dlibaio --direct=3D1 --iodepth=3D64 --time_based --runtim=
e=3D10 \
+			--cgroup=3D"blktests/${THROTL_DIR}" &> "${FULL}"; then
+		echo "FIO read test failed"
+		return 1
+	fi
+	cat "$TMPDIR/fio_perf" >> "$FULL"
+	local read_iops=3D${TEST_RUN["read iops"]}
+	if [[ -z "$read_iops" ]]; then
+		echo "Read IOPS is empty"
+		return 1
+	elif (( "$(echo "$read_iops < 90 || $read_iops > 110" | bc -l)" )); the=
n
+		echo "Read IOPS $read_iops not in expected range [90, 110]"
+		return 1
+	fi
+
+	# 2. Run FIO write test
+	FIO_PERF_FIELDS=3D("write iops")
+	if ! _fio_perf --bs=3D4k --rw=3Drandwrite --name=3Dwrite-test --filenam=
e=3D"/dev/${THROTL_DEV}" \
+			--ioengine=3Dlibaio --direct=3D1 --iodepth=3D64 --time_based --runtim=
e=3D10 \
+			--cgroup=3D"blktests/${THROTL_DIR}" &> "${FULL}"; then
+		echo "FIO write test failed"
+		return 1
+	fi
+	cat "$TMPDIR/fio_perf" >> "$FULL"
+	local write_iops=3D${TEST_RUN["write iops"]}
+	if [[ -z "$write_iops" ]]; then
+		echo "Write IOPS is empty"
+		return 1
+	elif (( "$(echo "$write_iops < 8 || $write_iops > 12" | bc -l)" )); the=
n
+		echo "Write IOPS $write_iops not in expected range [8, 12]"
+		return 1
+	fi
+}
+
+test() {
+	local test_status
+
+	echo "Running ${TEST_NAME}"
+
+	if ! _set_up_throtl; then
+		echo "_set_up_throtl failed"
+		return 1
+	fi
+
+	run_test
+	test_status=3D$?
+
+	if [ -n "$dev_t" ]; then
+		echo "$dev_t enable=3D0" > "$(_cgroup2_base_dir)/io.cost.qos"
+		echo "$dev_t ctrl=3Dauto" > "$(_cgroup2_base_dir)/io.cost.model"
+	fi
+
+	_clean_up_throtl
+
+	if [ "$test_status" -eq 0 ]; then
+		echo "Test complete"
+	else
+		echo "Test failed"
+		return 1
+	fi
+}
diff --git a/tests/throtl/008.out b/tests/throtl/008.out
new file mode 100644
index 000000000000..890ff7f226d1
--- /dev/null
+++ b/tests/throtl/008.out
@@ -0,0 +1,2 @@
+Running throtl/008
+Test complete
