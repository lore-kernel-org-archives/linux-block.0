Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7E2158D9F
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945614; cv=none; b=plnC8CDW+L6bpL9UYD+aObCUiN1eqxMXuHebtB4Fh6P5vcp1RFBrCrw3CNBiiMcoN+SlOMPgSwkhQs2GZzR/+3r4mVygkWJO8zud93ehETglBQgY340oSUwJLkpEZRGsUiUHV0nI0o6760xOf9nXkSLPlUun5ddCKnIwxFXv0ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945614; c=relaxed/simple;
	bh=IIzLHZ0xDcoXvdTGBnbL9BdlXaLVUODqXivyreG6OI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BU29whOMP3pmf6ouHWR18l00bCewEvcGY5ierM4XtGCdeudcG+XSfByK+ug3yrXemepUxw+tO5DjVMCUgOHxxauUfT6RT5iBxUMkF3q/reNufexFGEnivmlPsfyqh2t94KWNaxBBco0MJ+O0CtxTQDrRmhADXU0q/DeT1Xo2NtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mihci5OP; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mihci5OP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945612; x=1745481612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IIzLHZ0xDcoXvdTGBnbL9BdlXaLVUODqXivyreG6OI8=;
  b=mihci5OPeyyDJKt7WoKDOfcjHqb1FzLVBDGAm8nfKz9PrZ1Vtab+KsnJ
   Dp0RDF0vyKtZ3xJjAhxJ09CazgFLceiCscB5smBzIwwmmAsWTRamEqiVf
   4V7YcElSWi88m9QlNWUFQnrNK/uxM8TFFRTtZBCbtKESoDqB53fQ1x4X8
   c5AlHQ7t29cRgJKBd08xA3nFcz9VCYmo6PJsDoyaJrQJAt3bHL4qulM2e
   P083baD+JKSqHb2TpKVyYslA1q66Yv6JmTbqAMQAEpkFIVARQFVgprsNE
   NENAVNEl92dBvVx2SwhqTqs3IfoONOrIf/MpICgCv78jtorwlEsW8UF/a
   w==;
X-CSE-ConnectionGUID: I3nlnyBpTRKSKfHY7oXRlQ==
X-CSE-MsgGUID: pqEzyPo1Q+S7e1MSoKcdNQ==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14515728"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:11 +0800
IronPort-SDR: +obAjQXrWwZGMB7TsdWSom/VQhEtc2CiB633t4Jfiq9zOjxvIam5UxBTMjwoCGGTvAYr8tnAC2
 APfNNX3bilu7l/Z8rvmDM9lFvK9ogfz1KMlcrBRlZ1ASluwiiiZtjbqM8yL8t9kOi8wtCTYQue
 nm4pm6sC6H6GgkeaeT80PdcI8j010PDphL8AG9FriSrBrK/mJD2N+TprUDDmBwrqv3Tmmw1Sf9
 CR7FsRj9Me7F0J8iFGLVxSR5fkNdPjlsQdsb70Ai3tutx79T0WPnPlqJfYYs3uR7ciwUKGeUA1
 WpA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:21 -0700
IronPort-SDR: drLCxtdu3hJwEHv0XteFNIZlY1I6rN2e2b597kyjjIysvolujINHLNprofLK3WAJldGVKsP0BY
 ggrlJZWswyoMZwJNaySMCUxCHqDJygx7st0JWIZfzeLzoF5I9mqX4D/f7f5B/qYOG846fGd/5h
 wmIyJkgvmxXuL6ox8gpKnZzhHLd30N88bhB2i6fsH5NDb9EljUAOz+lJdtu8EPH/Z6BC5DHCd+
 zPBK6l7xX6dfU+iDYBvwI4MQsR+lAGVv/QXeU1xIezc8jrIDtlJJuuAwajVnjru+ZYq7ukcp/M
 DAQ=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 01:00:09 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 13/15] nvme/{rc,010,017,031,034,035}: rename nvme_img_size to NVME_IMG_SIZE
Date: Wed, 24 Apr 2024 16:59:53 +0900
Message-ID: <20240424075955.3604997-14-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To follow uppercase letter guide of environment variables, rename
nvme_img_size to NVME_IMG_SIZE.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md | 7 ++++---
 tests/nvme/010                 | 2 +-
 tests/nvme/017                 | 2 +-
 tests/nvme/031                 | 2 +-
 tests/nvme/034                 | 2 +-
 tests/nvme/035                 | 4 ++--
 tests/nvme/rc                  | 8 ++++----
 7 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 64aff7c..736ab48 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -113,9 +113,10 @@ The NVMe tests can be additionally parameterized via environment variables.
   block device types can be listed with separating spaces. In this case, the
   tests are repeated to cover all of the block device types specified. Default
   value is "device file".
-- nvme_img_size: '1G' (default)
-  Run the tests with given image size in bytes. 'm', 'M', 'g'
-	and 'G' postfix are supported.
+- NVME_IMG_SIZE: '1G' (default)
+  Run the tests with given image size in bytes. 'm', 'M', 'g' and 'G' postfix
+  are supported. This parameter had an old name 'nvme_img_size'. The old name
+  is still usable, but not recommended.
 - nvme_num_iter: 1000 (default)
   The number of iterations a test should do.
 
diff --git a/tests/nvme/010 b/tests/nvme/010
index 9ea2561..d99067a 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -32,7 +32,7 @@ test() {
 
 	ns=$(_find_nvme_ns "${def_subsys_uuid}")
 
-	_run_fio_verify_io --size="${nvme_img_size}" \
+	_run_fio_verify_io --size="${NVME_IMG_SIZE}" \
 		--filename="/dev/${ns}"
 
 	_nvme_disconnect_subsys
diff --git a/tests/nvme/017 b/tests/nvme/017
index 9410cdc..4f14471 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -25,7 +25,7 @@ test() {
 	local port
 	local iterations="${nvme_num_iter}"
 
-	truncate -s "${nvme_img_size}" "$(_nvme_def_file_path)"
+	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
 
 	local genctr=1
 
diff --git a/tests/nvme/031 b/tests/nvme/031
index b98630a..00d3d18 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -37,7 +37,7 @@ test() {
 	local loop_dev
 	local port
 
-	truncate -s "${nvme_img_size}" "$(_nvme_def_file_path)"
+	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
 
 	loop_dev="$(losetup -f --show "$(_nvme_def_file_path)")"
 
diff --git a/tests/nvme/034 b/tests/nvme/034
index 522ffe3..239757c 100755
--- a/tests/nvme/034
+++ b/tests/nvme/034
@@ -29,7 +29,7 @@ test_device() {
 	_nvmet_passthru_target_setup
 	nsdev=$(_nvmet_passthru_target_connect)
 
-	_run_fio_verify_io --size="${nvme_img_size}" --filename="${nsdev}"
+	_run_fio_verify_io --size="${NVME_IMG_SIZE}" --filename="${nsdev}"
 
 	_nvme_disconnect_subsys
 	_nvmet_passthru_target_cleanup
diff --git a/tests/nvme/035 b/tests/nvme/035
index cfca5fd..8286178 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -17,7 +17,7 @@ requires() {
 }
 
 device_requires() {
-	_require_test_dev_size "${nvme_img_size}"
+	_require_test_dev_size "${NVME_IMG_SIZE}"
 }
 
 set_conditions() {
@@ -35,7 +35,7 @@ test_device() {
 	_nvmet_passthru_target_setup
 	nsdev=$(_nvmet_passthru_target_connect)
 
-	if ! _xfs_run_fio_verify_io "${nsdev}" "${nvme_img_size}"; then
+	if ! _xfs_run_fio_verify_io "${nsdev}" "${NVME_IMG_SIZE}"; then
 		echo "FAIL: fio verify failed"
 	fi
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index a31690d..c018f7f 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -19,7 +19,7 @@ def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
 export def_subsysnqn="blktests-subsystem-1"
 export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 _check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
-nvme_img_size=${nvme_img_size:-"1G"}
+_check_conflict_and_set_default NVME_IMG_SIZE nvme_img_size 1G
 nvme_num_iter=${nvme_num_iter:-"1000"}
 nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
 NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
@@ -165,10 +165,10 @@ _require_nvme_test_img_size() {
 	local nvme_img_size_mb
 
 	require_sz_mb="$(convert_to_mb "$1")"
-	nvme_img_size_mb="$(convert_to_mb "${nvme_img_size}")"
+	nvme_img_size_mb="$(convert_to_mb "${NVME_IMG_SIZE}")"
 
 	if ((nvme_img_size_mb < require_sz_mb)); then
-		SKIP_REASONS+=("nvme_img_size must be at least ${require_sz_mb}m")
+		SKIP_REASONS+=("NVME_IMG_SIZE must be at least ${require_sz_mb}m")
 		return 1
 	fi
 	return 0
@@ -915,7 +915,7 @@ _nvmet_target_setup() {
 		esac
 	done
 
-	truncate -s "${nvme_img_size}" "$(_nvme_def_file_path)"
+	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
 	if [[ "${blkdev_type}" == "device" ]]; then
 		blkdev="$(losetup -f --show "$(_nvme_def_file_path)")"
 	else
-- 
2.44.0

