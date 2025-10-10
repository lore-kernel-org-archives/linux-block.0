Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152BE258EE0
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760084404; cv=none; b=ejMLR9oGOKoG3XpJqwRp8nsfu+/csHSXTp+UhAWfmySigXy9bxs4pIZ3a0AUw9c+AwwOzkcIBk53GTkylXX8lvk9MJmb8NlIiC4/Ysa7NY3jvWumuLaxaXvG1x/ICHID//0QpYNA1rHjtEkkjrPqrSLT0wneRrkK9DEetkp2YDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760084404; c=relaxed/simple;
	bh=/fa0kghQhm5O+O6AQn7vdzPhM20JsGoJq9btUGscqpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InFVLT+/CoGWiZt7RKoZX5rAS3nkOxPOfmsdzDYWMGccK4xuTJ2MwIrFwAZNzUa0TNnlcbPh3QuG/K7TNAlB22L1AaQKS5berQixmLC0yJmrL1YpLKjeu24LUWOCFQpglY7tGbH0B0OK42c6eCfvlZTpX4bYSun0uP07VALzFzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rpGB4HlB; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rpGB4HlB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760084402; x=1791620402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/fa0kghQhm5O+O6AQn7vdzPhM20JsGoJq9btUGscqpQ=;
  b=rpGB4HlBnSg9kUCaJD2MebQK5WODrWEBQoSFT5QvB7E5FJDOq6H/b4f4
   QFq5o30gS+YT9Cy/P8NHFt/qhngniB08ieDu+BWgfRh5HETVHkVLZJV22
   pp3i7BTPsFzqGX7B7+AamitdSvwCv/vak7GAZhASM8dJ3QqOtSFRrmCKw
   1j3HbIt+71PAIlvYwGslzAMaUZ6QUUwTbpi7pCZ0qXnUZrD/ji1SB0Naq
   FblUuQTssXZCaCL31EnxE9XBjhv8fipbXhvG3QK3cxqptA+EoU5dQai0e
   zMPZs9KuN9u62RZwzkhEwSbO8j09ox6ZTkU5dC34lCUtrLspP9q8+zzFw
   A==;
X-CSE-ConnectionGUID: 1rJZQEqoSbu49MDpEmeC8Q==
X-CSE-MsgGUID: MHWvw8GNQ1mJXLHSGnIr0Q==
X-IronPort-AV: E=Sophos;i="6.19,218,1754928000"; 
   d="scan'208";a="132653546"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2025 16:19:55 +0800
IronPort-SDR: 68e8c1ab_nep7LA5fgEqXanArQjGKnKF1mbOWExUSY8Lc2X4gCgmxxjx
 G/nsUFH/yc3xWGf0AGiD+Hizr28vxrGN+pI9TUw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2025 01:19:56 -0700
WDCIronportException: Internal
Received: from 5cg2148fq4.ad.shared (HELO shinmob.wdc.com) ([10.224.163.88])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Oct 2025 01:19:55 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/4] throtl/004: adjust to scsi_debug
Date: Fri, 10 Oct 2025 17:19:50 +0900
Message-ID: <20251010081952.187064-3-shinichiro.kawasaki@wdc.com>
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

Currently, the test case throtl/004 assumes that the test target device
is null_blk. When it verifies the dd command error message, it checks
the string "/dev/dev_nullb" also. However, this test will fail when the
test case is extended to support scsi_debug.

To avoid the failure, remove dependency on the specific device name.
Save the dd command error output to the FULL file, and check only the
error message part in the FULL file.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/throtl/004     | 4 +++-
 tests/throtl/004.out | 3 +--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/throtl/004 b/tests/throtl/004
index d623097..777afcf 100755
--- a/tests/throtl/004
+++ b/tests/throtl/004
@@ -22,7 +22,7 @@ test() {
 
 	{
 		echo "$BASHPID" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
-		_throtl_issue_io write 10M 1
+		_throtl_issue_io write 10M 1 &>> "$FULL"
 	} &
 
 	sleep 0.6
@@ -30,5 +30,7 @@ test() {
 	wait $!
 
 	_clean_up_throtl
+
+	grep --only-matching "Input/output error" "$FULL"
 	echo "Test complete"
 }
diff --git a/tests/throtl/004.out b/tests/throtl/004.out
index e76ec3a..3997531 100644
--- a/tests/throtl/004.out
+++ b/tests/throtl/004.out
@@ -1,4 +1,3 @@
 Running throtl/004
-dd: error writing '/dev/dev_nullb': Input/output error
-1
+Input/output error
 Test complete
-- 
2.51.0

