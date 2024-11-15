Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D063E18871E
	for <linux-block@vger.kernel.org>; Fri, 15 Nov 2024 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731672754; cv=none; b=OyXNxQpWfA88R9zVx75tnKM6LBqRcBCcL+LbEdNZ3yxpGpAlN4Gxtzq9DFkKm6ky5FEB1q1gA2TmmHOsnocF0uEpoHax2ZvDSkhgwO43O4Uk/5LjsEKCVibxlF+gN2BSQP87w/ymZsSqmPIGEVi5BDB3MHVv5Or+NdAvo+wTKyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731672754; c=relaxed/simple;
	bh=yyEM8nBBMbRlg1z4dNJPXAAQi0zc0U7vMkwbKgxhDsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZnLr6Ci1sLQconmDIYPxJhDqBi3VarhvtsNevE4IZY2u8lSF3owBtf7o+4XL2ZWpKelUPUalYeup78zi/GUdUkWYQumRLbn0LFYLrU/KpDYISg2JNTCm15O8/ZcQYHis/aSSpNS8/ylzlf0tkQP8WeBYbQ38sJsaF/JWwLa07CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qT1ooxY1; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qT1ooxY1"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731672752; x=1763208752;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yyEM8nBBMbRlg1z4dNJPXAAQi0zc0U7vMkwbKgxhDsY=;
  b=qT1ooxY1sRRqQVqu2nyeVVp7w2lp5xtiWvKoC7bW06yWqb3aS5oTW7rA
   PVkAlVb7vR9oTSY59zEl+wee9yfiZNADD74fBTuz/HJMiX5M8bTJJ6YUT
   g5ux1a4LdwMDwa59skfZBKIDJNIWp75AY6YcIWRx59bm039CN2tmHZQfC
   QaBIAurUgDEjmmRsG2ckU4fDLxWzG6mDlA7Fq+xqXOSotC9BhNSJt5XGx
   q2c1JSN5qnU8zbCS225f3lpTUKAHO/RY9O1rwx5L815AVL4kRb88+z/AV
   9a2Q2z15Gtz9EgCiSkGZtOQuDUaTI5RCYynDSHhETl6BlbqoOSKBzL5WP
   A==;
X-CSE-ConnectionGUID: I53gjIz0S6SnJLA2efd6mg==
X-CSE-MsgGUID: cdLB9fQwQOKaDRgpOOMydQ==
X-IronPort-AV: E=Sophos;i="6.12,156,1728921600"; 
   d="scan'208";a="32571395"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2024 20:12:26 +0800
IronPort-SDR: 67372c1c_sy5/GmesxoSsKpAXyxCSj1dI9yVljiP11zOi42bL2j3iMQG
 36tDg+rGTz0Ckma79w0ymD09gTa86TRaJ9YpokA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Nov 2024 03:10:21 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Nov 2024 04:12:25 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] throtl: set "io" to subtree_control only if required
Date: Fri, 15 Nov 2024 21:12:24 +0900
Message-ID: <20241115121224.173285-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was reported the thortl test cases fail on the systems, which already
sets "io" in cgourp2 subtree_control files. The fail happens when
writing "-io" to the subtree_control files at clean up.

To avoid the failure, check if the system already sets "io". If so, skip
writing "+io" at set up, and writing "-io" at clean up.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Link: https://github.com/osandov/blktests/issues/149
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/throtl/rc | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/tests/throtl/rc b/tests/throtl/rc
index 2e26fd2..9c264bd 100644
--- a/tests/throtl/rc
+++ b/tests/throtl/rc
@@ -10,6 +10,8 @@
 
 THROTL_DIR=$(echo "$TEST_NAME" | tr '/' '_')
 THROTL_DEV=dev_nullb
+declare THROTL_CLEAR_BASE_SUBTREE_CONTROL_IO
+declare THROTL_CLEAR_CGROUP2_DIR_CONTROL_IO
 
 group_requires() {
 	_have_root
@@ -31,8 +33,16 @@ _set_up_throtl() {
 		return 1
 	fi
 
-	echo "+io" > "$(_cgroup2_base_dir)/cgroup.subtree_control"
-	echo "+io" > "$CGROUP2_DIR/cgroup.subtree_control"
+	THROTL_CLEAR_BASE_SUBTREE_CONTROL_IO=
+	THROTL_CLEAR_CGROUP2_DIR_CONTROL_IO=
+	if ! grep -q io "$(_cgroup2_base_dir)/cgroup.subtree_control"; then
+		echo "+io" > "$(_cgroup2_base_dir)/cgroup.subtree_control"
+		THROTL_CLEAR_BASE_SUBTREE_CONTROL_IO=true
+	fi
+	if ! grep -q io "$CGROUP2_DIR/cgroup.subtree_control"; then
+		echo "+io" > "$CGROUP2_DIR/cgroup.subtree_control"
+		THROTL_CLEAR_CGROUP2_DIR_CONTROL_IO=true
+	fi
 
 	mkdir -p "$CGROUP2_DIR/$THROTL_DIR"
 	return 0;
@@ -40,8 +50,12 @@ _set_up_throtl() {
 
 _clean_up_throtl() {
 	rmdir "$CGROUP2_DIR/$THROTL_DIR"
-	echo "-io" > "$CGROUP2_DIR/cgroup.subtree_control"
-	echo "-io" > "$(_cgroup2_base_dir)/cgroup.subtree_control"
+	if [[ $THROTL_CLEAR_CGROUP2_DIR_CONTROL_IO == true ]]; then
+		echo "-io" > "$CGROUP2_DIR/cgroup.subtree_control"
+	fi
+	if [[ $THROTL_CLEAR_BASE_SUBTREE_CONTROL_IO == true ]]; then
+		echo "-io" > "$(_cgroup2_base_dir)/cgroup.subtree_control"
+	fi
 
 	_exit_cgroup2
 	_exit_null_blk
-- 
2.47.0

