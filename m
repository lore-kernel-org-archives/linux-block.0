Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C51539185A
	for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776339797; cv=none; b=OnK+xgeVF1Vn/wF3DXP0+PozpF40UEynpa8BEZG4GNiNFQx9MjzzUcEMm35uxC/VQrONj7umN57T56Yu9xqoUyM4QnAGbGThfOBGDPasLXAd7bnzNw38fxsWsprwKp9XRLOdUXiLMOA6JTVeIMWwbVcgOkDXV4+Y3wxdRMjlHnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776339797; c=relaxed/simple;
	bh=wcxgIrv60g7VGae8I7+SmzCigJQxLSO0FZ8CtfYLpmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/lvBuEEakNPyWNkU2Bqhj3JHDSsWx8xR2keqV+vLZuX3J+w2KcLm7dtg4/mRxy4Jxs6Li5U44PbGW3Qmq9MZYseSY2beGMM7GtIJBahqeCWm0lA1vjv24FL/K6Q/pf+IOx3xK9GKW39/n0o4tUQpTe7KHiNVeWYR8H9cpggRPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZoreddcH; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZoreddcH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1776339792; x=1807875792;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wcxgIrv60g7VGae8I7+SmzCigJQxLSO0FZ8CtfYLpmA=;
  b=ZoreddcHaDX9+lS9KkAfVvNF1yp0IjBBgIvIeA10x0JcXXJiTzwq10Sv
   zCDzMKn6Tv7bm9ZQ+m5A644jQTyi7q1JDkLItKE3xTGbQCvgJUtEtik+D
   lPDlZGc56Ay/xDjwlgzUxpB22iW8FBms09nwJL1Osc4sbgPyi7lmwPsJi
   2l8GsMnp0JRTvxKsWgTBkeuK3NmnJbfmfPeMlBijvHKE52NTNYDCt2ZjJ
   gaBA27ytlRF3pxQCJ8zW6N4Uen54OGNejCCh7UtRoqd/DYuW2F2ZDxE5+
   w4gMmqzbH2ZC0g8J8X30UoZjvhxW3D3XxKOEOlaQSN79z1wGGLDmoCKKD
   Q==;
X-CSE-ConnectionGUID: 1GxI3T3cT2eMaqJJjO0knQ==
X-CSE-MsgGUID: hcKmt2GVQhGOUSdtJ9wi1w==
X-IronPort-AV: E=Sophos;i="6.23,181,1770566400"; 
   d="scan'208";a="143536021"
Received: from unknown (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2026 19:43:05 +0800
X-CSE-ConnectionGUID: UPaEeuJsTB+3Mey1p2TxEA==
X-CSE-MsgGUID: +JekqHKdQ9quAzbw+zJy0Q==
IronPort-SDR: 69e0cb2c_b86wKs1i3pxZKqG30rHvezvq5sYVgSca5UVFQHfV2HT2cWY
 6RpHDAuOK//+STaAELqJSHje7NDrehROvTiXt/Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2026 04:42:36 -0700
X-CSE-ConnectionGUID: 9t3eia47RryfjeLWT1D1QA==
X-CSE-MsgGUID: IoXyKPu6Qg2MM47JkanZhQ==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2026 04:42:36 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] throtl/{002,003,007}, zbd/014: use _get_page_size to get PAGE_SIZE
Date: Thu, 16 Apr 2026 20:42:35 +0900
Message-ID: <20260416114235.4076679-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Zhang <yi.zhang@redhat.com>

Commit 8eca9fa369ee ("common/rc, scsi/011, zbd/010: introduce
_page_size_equals() helper") introduced the helper bash function
_get_page_size(). Replace "getconf PAGE_SIZE" with the helper to cut
dependency to the getconf tool.

Link: https://github.com/linux-blktests/blktests/pull/243
Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
[Shin'ichiro: removed getconf command check in zbd/014]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/throtl/002 | 2 +-
 tests/throtl/003 | 2 +-
 tests/throtl/007 | 2 +-
 tests/zbd/014    | 3 +--
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/throtl/002 b/tests/throtl/002
index 08e685f..275c900 100755
--- a/tests/throtl/002
+++ b/tests/throtl/002
@@ -21,7 +21,7 @@ test() {
 	local io_size_kb block_size
 	local iops=256
 
-	page_size=$(getconf PAGE_SIZE)
+	page_size=$(_get_page_size)
 
 	if ! _set_up_throtl --sector_size "${page_size}"; then
 		return 1;
diff --git a/tests/throtl/003 b/tests/throtl/003
index 700e9e6..b45123a 100755
--- a/tests/throtl/003
+++ b/tests/throtl/003
@@ -18,7 +18,7 @@ test() {
 	echo "Running ${TEST_NAME}"
 
 	local page_size
-	page_size=$(getconf PAGE_SIZE)
+	page_size=$(_get_page_size)
 
 	if ! _set_up_throtl --sector_size "${page_size}"; then
 		return 1;
diff --git a/tests/throtl/007 b/tests/throtl/007
index 97dece6..4292feb 100755
--- a/tests/throtl/007
+++ b/tests/throtl/007
@@ -19,7 +19,7 @@ test() {
 	echo "Running ${TEST_NAME}"
 
 	local page_size
-	page_size=$(getconf PAGE_SIZE)
+	page_size=$(_get_page_size)
 
 	if ! _set_up_throtl --sector_size "${page_size}"; then
 		return 1;
diff --git a/tests/zbd/014 b/tests/zbd/014
index 35ecc85..18e6fd9 100755
--- a/tests/zbd/014
+++ b/tests/zbd/014
@@ -23,7 +23,6 @@ requires() {
 	_have_driver f2fs
 	_have_driver null_blk
 	_have_program fscrypt
-	_have_program getconf
 	_have_program mkfs.f2fs
 	for o in BLK_INLINE_ENCRYPTION_FALLBACK FS_ENCRYPTION_INLINE_CRYPT; do
 		if ! _check_kernel_option "$o"; then
@@ -112,7 +111,7 @@ run_test() {
 	local bio_max_vecs=256
 
 	local page_size
-	page_size=$(getconf PAGE_SIZE)
+	page_size=$(_get_page_size)
 
 	# In bytes.
 	local max_inl_encr_bio_size=$((bio_max_vecs * page_size))
-- 
2.49.0

