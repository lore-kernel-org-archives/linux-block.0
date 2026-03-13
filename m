Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8585F6F2F2
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773404345; cv=none; b=ObovCsa7QSSmA4ByMdrQarYQ3LUwsYxcYBMTI86t5vXtjVm/pVx9X6mEYkpXXstoJhOy3ShcYb3WinfdFjEg1mNWQ05lXxp6wNvLiFT4hCn0OM82Hq0zzgQBbO/2u0uQvRIPtciQtnonGBfy+fl2bi8SMIAgQD2QxNcRziKUVcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773404345; c=relaxed/simple;
	bh=LHmkgd6DeGU7yrcNy27Ek4yDAwpy3PZexxlDYeH8Q3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AUQTiy1Wrg7sKxa45zYOIZVI2BuIFmHonRDf0dK1Wv+JUBneMO5S13YTXcjzTvA20PqgC0jaQ85RIxQqCozMAXP7YJi3F+qKUegl8MUB/uRo6HbgEMX5IV5ELo6eDMnCO8z7FePuEAYjP43tdjjW7BDtk+1vwgvUEue4OMnJ6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=esBykbEi; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="esBykbEi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1773404343; x=1804940343;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LHmkgd6DeGU7yrcNy27Ek4yDAwpy3PZexxlDYeH8Q3Y=;
  b=esBykbEibA4flGsbUEMKQJrytJl+vd+sb8IuSa7p20Vq1AD2Dbk9a+LD
   rgg4irdn6Uo7iwISDECsnV+Fb3Xj4ZS0rFUO+64moqSD84wIYzAKQbsOp
   ddbOAXFN3jrHSPMqAGp+qtw18U7QKp03waogtALra95PQrK+UHm50+e8x
   HkDC5J5Qf8/PrZAv5IxdjjwrgXJqGbFlTidRYwQySXx+xUohOJTx80MoF
   ZlDbIgZt5OCsmJ5BC9R3c+vfpZ6tanEetgYAc4rdpPA6R/EBmUtuuMHdq
   cLkr+h1VK7Ht9ZS3D9fqnNGIUCfRds/P8cm8qYNTBlPry3Zc+p85vOkxi
   g==;
X-CSE-ConnectionGUID: ipzJblkgRvGoZ6wH1uSPag==
X-CSE-MsgGUID: 4uTNmqNeRzulC0pkE3369A==
X-IronPort-AV: E=Sophos;i="6.23,118,1770566400"; 
   d="scan'208";a="138823842"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2026 20:18:57 +0800
IronPort-SDR: 69b400b0_w9CFY4C0BjWFY/9C6BOUms3gRNH7droIht23t18SsvziP5s
 yrXw4U5D+E/DtEtTDJ40fPzRStsOdYXQI3Z9mBQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Mar 2026 05:18:57 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Mar 2026 05:18:56 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] check: check kmemleak before test run start
Date: Fri, 13 Mar 2026 21:18:55 +0900
Message-ID: <20260313121855.3666215-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the kernel enables kmemleak, the check script scans for memory
leaks at the end of every test case run. However, if memory has already
leaked before the blktests test run starts, the leak is detected at the
end of the first test case. This makes it look as if the leak happend
during the firest test case, which is confusing.

To avoid this, check for memory leaks once before staring blktests. If
any leaks are found, report them separately.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/check b/check
index 3b5738f..f170458 100755
--- a/check
+++ b/check
@@ -229,6 +229,7 @@ _setup_kmemleak() {
 
 _check_kmemleak() {
 	local kmemleak
+	local out=$1
 
 	((KMEMLEAK)) || return 0
 
@@ -240,7 +241,7 @@ _check_kmemleak() {
 		return 0
 	fi
 
-	printf '%s\n' "$kmemleak" > "${seqres}.kmemleak"
+	printf '%s\n' "$kmemleak" > "$out"
 	return 1
 }
 
@@ -477,7 +478,7 @@ __call_test() {
 		elif ! _check_dmesg "$dmesg_marker"; then
 			TEST_RUN["status"]=fail
 			TEST_RUN["reason"]=dmesg
-		elif ! _check_kmemleak; then
+		elif ! _check_kmemleak "${seqres}.kmemleak"; then
 			TEST_RUN["status"]=fail
 			TEST_RUN["reason"]=kmemleak
 		else
@@ -1022,6 +1023,7 @@ _check() {
 
 	local test_dev test_name
 	local -a all_test_devs_in_array
+	local km_log="${OUTPUT}/start.kmemleak"
 
 	for test_name in "${!TEST_CASE_DEV_ARRAY[@]}"; do
 		IFS=" " read -r -a all_test_devs_in_array <<< \
@@ -1050,6 +1052,14 @@ _check() {
 		done
 	done
 
+	if ((KMEMLEAK)); then
+		# check if memory is already leaked before blktests run
+		_setup_kmemleak
+		if ! _check_kmemleak "$km_log"; then
+			echo "Memory leak detected before test run start. See '${km_log}'."
+		fi
+	fi
+
 	local test_name group prev_group
 	local tests=()
 	local ret=0
-- 
2.49.0

