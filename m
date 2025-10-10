Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A7625228F
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760084404; cv=none; b=qHacSy0DsRzAbOrJUlRIvjQni5l6VhXDWqiosJ2LeEgfGAN9yunt+VNpb5cvrUO+fTMlJOHUfL4qujpbi9T2OWMwcHW3q4dGpKQ+FtOfcKgw9Byk8VAN35UVdnGJDUsiQS1tDV6KCK+LEJhhmZ/1PxoaYUe91ufhP22WNMABepQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760084404; c=relaxed/simple;
	bh=udiZ9rqZ0NY/IItwrNqIh/JKudakdAnM6eEtKQcxPA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8RilbQ2QEOYsRxfHGcrm6tVwo5PuZchdJ0txdN7Bg2LJrImWgTJzSYtl4Nya7gk75wnFfh8Mc2pTOleGwhkDF5eB7tq7G/X3pQco2Bv863WWVUOyP9bHs3qSmceR0cvHM6g9nB7X2e2sWWvDJZh5FGs6MsU8lF1KZeYvnKcMnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=o9VI6gpr; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o9VI6gpr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760084402; x=1791620402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=udiZ9rqZ0NY/IItwrNqIh/JKudakdAnM6eEtKQcxPA0=;
  b=o9VI6gprjkktH3EfjdxH0kBs1EbbcBC5ZR6JFrPwf7eTUEN0kk50o3Rm
   2OzwrpZol4hcDzb8XZs15Z8dMmUA2f1SooRGkmjZbe1yuVeAOBc/KxYDb
   5GIpjWuswk2+y4HW1k3uxB+G0KcAAId8gv+DVG4jz725BZAQXORTdzzFr
   3QMVBckhfIEh+E7rswTaH/BLQMZkNfCxzMMfZSotfuw1btVEncRYv5q4w
   SmMiOYYhc1iPyknLk1VPRLhVNw1HVVSDZl7TmqgnOihk3xhzUYLvqFfas
   ivLGGzl0Bw/AB5HHhKBvH3OleJnOL1or25ISTwKfNC/7PavwoZGlrSkCl
   w==;
X-CSE-ConnectionGUID: u2Zi06MLR6uXngRkqgSN7Q==
X-CSE-MsgGUID: WrFys4I0R3KXvo1kgurbag==
X-IronPort-AV: E=Sophos;i="6.19,218,1754928000"; 
   d="scan'208";a="132653543"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2025 16:19:54 +0800
IronPort-SDR: 68e8c1aa_URaJ1VQQY+C7J1cqc3zjgWmOxWcNWywO9DRwsv47GN6qR+S
 ibZbmAS2cWGNSPvFwFyMp3nLTfEGxKax8QR2E5A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2025 01:19:55 -0700
WDCIronportException: Internal
Received: from 5cg2148fq4.ad.shared (HELO shinmob.wdc.com) ([10.224.163.88])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Oct 2025 01:19:54 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/4] throtl: introduce helper functions to manage test target block devices
Date: Fri, 10 Oct 2025 17:19:49 +0900
Message-ID: <20251010081952.187064-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010081952.187064-1-shinichiro.kawasaki@wdc.com>
References: <20251010081952.187064-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The throtl test group uses null_blk devices as test target in its test
cases. To prepare for supporting scsi_debug device as the additional
test target, introduce three helper functions below to abstract null_blk
specific operations:

 _configure_throtl_blkdev() : Sets up the null_blk device
 _delete_throtl_blkdev()    : Removes the null_blk device for testing
 _exit_throtl_blkdev()      : Cleans up the null_blk device

Support two options of _configure_throtl_blkdev(), --sector_size and
--memory_backed so that each test case can tailor the setup according to
specific requirements.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/throtl/002 |  5 ++---
 tests/throtl/003 |  5 ++---
 tests/throtl/004 |  2 +-
 tests/throtl/006 |  2 +-
 tests/throtl/007 |  5 ++---
 tests/throtl/rc  | 45 ++++++++++++++++++++++++++++++++++++++++++---
 6 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/tests/throtl/002 b/tests/throtl/002
index 02b0969..bed876d 100755
--- a/tests/throtl/002
+++ b/tests/throtl/002
@@ -13,14 +13,13 @@ QUICK=1
 test() {
 	echo "Running ${TEST_NAME}"
 
-	local page_size max_secs
+	local page_size
 	local io_size_kb block_size
 	local iops=256
 
 	page_size=$(getconf PAGE_SIZE)
-	max_secs=$((page_size / 512))
 
-	if ! _set_up_throtl max_sectors="${max_secs}"; then
+	if ! _set_up_throtl --sector_size "${page_size}"; then
 		return 1;
 	fi
 
diff --git a/tests/throtl/003 b/tests/throtl/003
index 8276d87..d76a0d5 100755
--- a/tests/throtl/003
+++ b/tests/throtl/003
@@ -13,11 +13,10 @@ QUICK=1
 test() {
 	echo "Running ${TEST_NAME}"
 
-	local page_size max_secs
+	local page_size
 	page_size=$(getconf PAGE_SIZE)
-	max_secs=$((page_size / 512))
 
-	if ! _set_up_throtl max_sectors="${max_secs}"; then
+	if ! _set_up_throtl --sector_size "${page_size}"; then
 		return 1;
 	fi
 
diff --git a/tests/throtl/004 b/tests/throtl/004
index d1461b9..d623097 100755
--- a/tests/throtl/004
+++ b/tests/throtl/004
@@ -26,7 +26,7 @@ test() {
 	} &
 
 	sleep 0.6
-	echo 0 > "/sys/kernel/config/nullb/$THROTL_DEV/power"
+	_delete_throtl_blkdev
 	wait $!
 
 	_clean_up_throtl
diff --git a/tests/throtl/006 b/tests/throtl/006
index b6f47d1..263415f 100755
--- a/tests/throtl/006
+++ b/tests/throtl/006
@@ -34,7 +34,7 @@ test_meta_io() {
 test() {
 	echo "Running ${TEST_NAME}"
 
-	if ! _set_up_throtl memory_backed=1; then
+	if ! _set_up_throtl --memory_backed; then
 		return 1;
 	fi
 
diff --git a/tests/throtl/007 b/tests/throtl/007
index ae59c6f..83d8dc7 100755
--- a/tests/throtl/007
+++ b/tests/throtl/007
@@ -14,11 +14,10 @@ QUICK=1
 test() {
 	echo "Running ${TEST_NAME}"
 
-	local page_size max_secs
+	local page_size
 	page_size=$(getconf PAGE_SIZE)
-	max_secs=$((page_size / 512))
 
-	if ! _set_up_throtl max_sectors="${max_secs}"; then
+	if ! _set_up_throtl --sector_size "${page_size}"; then
 		return 1;
 	fi
 
diff --git a/tests/throtl/rc b/tests/throtl/rc
index 327084b..d20dc94 100644
--- a/tests/throtl/rc
+++ b/tests/throtl/rc
@@ -21,15 +21,54 @@ group_requires() {
 	_have_program bc
 }
 
+_configure_throtl_blkdev() {
+	local sector_size=0 memory_backed=0
+	local -a args
+
+	while [[ $# -gt 0 ]]; do
+		case $1 in
+			--sector_size)
+				sector_size="$2"
+				shift 2
+				;;
+			--memory_backed)
+				memory_backed=1
+				shift
+				;;
+			*)
+				echo "WARNING: unknown argument: $1"
+				shift
+				;;
+		esac
+	done
+
+	args=("$THROTL_DEV")
+	((sector_size)) && args+=(max_sectors="$((sector_size / 512))")
+	((memory_backed)) && args+=(memory_backed=1)
+	if _configure_null_blk "${args[@]}" power=1; then
+		return
+	fi
+	return 1
+}
+
+_delete_throtl_blkdev() {
+	echo 0 > "/sys/kernel/config/nullb/$THROTL_DEV/power"
+}
+
+_exit_throtl_blkdev() {
+	_exit_null_blk
+	unset THROTL_DEV
+}
+
 # Create a new null_blk device, and create a new blk-cgroup for test.
 _set_up_throtl() {
 
-	if ! _configure_null_blk $THROTL_DEV "$@" power=1; then
+	if ! _configure_throtl_blkdev "$@"; then
 		return 1
 	fi
 
 	if ! _init_cgroup2; then
-		_exit_null_blk
+		_exit_throtl_blkdev
 		return 1
 	fi
 
@@ -58,7 +97,7 @@ _clean_up_throtl() {
 	fi
 
 	_exit_cgroup2
-	_exit_null_blk
+	_exit_throtl_blkdev
 }
 
 _throtl_set_limits() {
-- 
2.51.0

