Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D918124A7E8
	for <linux-block@vger.kernel.org>; Thu, 16 Jan 2025 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737011883; cv=none; b=WMpwTFKICWzy0r+z5Id2/GDVCS54NVx362LQWMPDIe2AdWrOUNIwUTpwCRFRg8EzctDOy6Jf7+L+oyAKksgDkmYQcGK3nQ+/pyOJ7D2PIW+7vEJkJG6xY8Q/oD3YR93WvQoQkxKDN4FERi81vJNTZef3m9Rwdmeswu60lycePLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737011883; c=relaxed/simple;
	bh=pbD+DT7qqtb70lmFhSoqJ6+Jxdzx93WFHz9jDMO5/pU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CVQevPBtCm2tOVKJUzDcB7cRr0OhrU3xpEHYGZ7Exf+3TMfgcdOgolQuGNyVs9ilOEGHkaT9aBPhMalljgZL7iovuG1G9hregy2+uHxrQ+LJhujOvPPq3/RlMh5MSq+eUyyUXLJA1ZKli/jEd66d18edWf23cOZlLes0AJWik64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CELj/2Kh; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CELj/2Kh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737011881; x=1768547881;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pbD+DT7qqtb70lmFhSoqJ6+Jxdzx93WFHz9jDMO5/pU=;
  b=CELj/2KhKz9lpnF3kwVCF29ALZYi/t9w2/fJnxuYTLOl6Gwqae3YPRuK
   2CXzjYs6YxOC9vVLPQEQ8PunNPNquOje7Ear25V5xl4Fv/B9rbZz2f7gA
   LeMeJIdVOVEAKaWXIwusSnhkqCjUiIUUSY1lyFMvgNBzT6YvF5zooDo6a
   RKztiEL1JHQpEbpkZgoyO4f+mymHQbS7qCPPLlK37UR6+KgGEg6xYfr3F
   yUYNa9oe9N4K5qvesooBu3Fp1Cr1xdthCBHxxN3M9VbhcFbwpFOz6SabP
   F1JZhp+dxGL9X6h0FhI4WJWu4TZSNd4jFMlCDZx9vFffqUI42eA7CsDji
   g==;
X-CSE-ConnectionGUID: QjOyJL0sQgiG1vcDOdMmxA==
X-CSE-MsgGUID: Rml8XHATRSWXlfZ7R3jRTQ==
X-IronPort-AV: E=Sophos;i="6.13,208,1732550400"; 
   d="scan'208";a="37258313"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2025 15:17:55 +0800
IronPort-SDR: 6788a515_qSrZswt7nAQX3ISLZZ/Gzd1GqTxafqk+4Y1apQq6lLX0N1X
 5O7C84JtH0y3OtVkxjwUg2td24NaBOc5QaKag+A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jan 2025 22:20:05 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Jan 2025 23:17:55 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Martin Wilck <martin.wilck@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme/053: do not use awk
Date: Thu, 16 Jan 2025 16:17:54 +0900
Message-ID: <20250116071754.1161787-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Luis observed that the test case nvme/053 fails in his environment [1]
due to the following awk error message:

 awk: ...rescan.awk:2: warning: The time extension is obsolete.
 Use the timex extension from gawkextlib

To avoid the failure and reduce dependencies, do not use awk in the test
case. Instead, introduce the bash function get_sleep_time() to calculate
the sleep time. Also implement the controller rescan loop in bash,
following Martin's original patch [2].

[1] https://lore.kernel.org/linux-block/20241218111340.3912034-1-mcgrof@kernel.org/
[2] https://lore.kernel.org/linux-nvme/20240822193814.106111-3-mwilck@suse.com/

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/053 | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/tests/nvme/053 b/tests/nvme/053
index 3ade8d3..99dbd38 100755
--- a/tests/nvme/053
+++ b/tests/nvme/053
@@ -12,8 +12,15 @@ DESCRIPTION="test controller rescan under I/O load"
 TIMED=1
 : "${TIMEOUT:=60}"
 
+get_sleep_time() {
+	local duration=$((RANDOM % 50 + 1))
+
+	echo "$((duration / 10)).$((duration % 10))"
+}
+
 rescan_controller() {
-	local path
+	local path finish
+
 	path="$1/rescan_controller"
 
 	[[ -f "$path" ]] || {
@@ -21,24 +28,12 @@ rescan_controller() {
 		return 1
 	}
 
-	awk -f "$TMPDIR/rescan.awk" \
-	    -v path="$path" -v timeout="$TIMEOUT" -v seed="$2" &
-}
-
-create_rescan_script() {
-	cat >"$TMPDIR/rescan.awk" <<EOF
-@load "time"
-
-BEGIN {
-    srand(seed);
-    finish = gettimeofday() + strtonum(timeout);
-    while (gettimeofday() < finish) {
-	sleep(0.1 + 5 * rand());
-	printf("1\n") > path;
-	close(path);
-    }
-}
-EOF
+	finish=$(($(date +%s) + TIMEOUT))
+	while [[ $(date +%s) -le $finish ]]; do
+		# sleep interval between 0.1 and 5s
+		sleep "$(get_sleep_time)"
+		echo 1 >"$path"
+	done
 }
 
 test_device() {
@@ -46,7 +41,6 @@ test_device() {
 	local i st line
 
 	echo "Running ${TEST_NAME}"
-	create_rescan_script
 
 	while IFS= read -r line; do
 		ctrls+=("$line")
-- 
2.47.0

