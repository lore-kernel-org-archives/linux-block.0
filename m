Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089933385A3
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 03:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818634; cv=none; b=JQ8+5FbyrssdLe9ieZz8kQsDBjYMFCp67h/USoXu3Qxm3riaS4+yb7ljKmPw9I5L/8UkJkl2aASDqWggbsQP6mcHCREMYaRPiACha89JjMv74WQGs1yrHbzg/8bAYQupkWFT9MOviXTBLS8jZ/MwVomv9I4aa8djsWSEeUbefzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818634; c=relaxed/simple;
	bh=p6o81+4nOXs9PCFt65NlCvkfcI5ag3wBP18ohrU9qdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AW1rANnkhokLMY9xcL8CvuGpp/85hsgoDaaA627FtSYvZCG1aOp1gYC3HDJDpiTNOELQvNPEaRRV388cdLugJ0jQ//AN5ZqJ9p1YPcteD2FlMtsTWW8EzxjjE3NKjNaZDK6iRWOcB9T+0Pr9JgtQj8MdUjZBStwpQelDrOKuSf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jG20b4Kb; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jG20b4Kb"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771818632; x=1803354632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p6o81+4nOXs9PCFt65NlCvkfcI5ag3wBP18ohrU9qdg=;
  b=jG20b4KbXb0qB5rqUX4LRVNfEPMr5mMtn+zeCh0m1esQOIN+sp+MMAqP
   bSvpaWZ7PfYZVvWzNVhFsxjOb+fdWMMORus5QkiFTHY2/M/5Y01byI63L
   mW6I7f4/CBMa/P/zE43Q38/3IupyH2PzBwtmv5kPp1EyhfDeXv3a3prqF
   yRu8+ad422as/PwLGZ0wVmrpp5ffS5RLHsTfr8p7N4WNaPbjqQ1FTh6Ex
   tcktzH/jEMXjINpbkD97mJhR8uvnS9ChlX1McQ8SQg0WFmhhOskCF7n5v
   HAiEXNVZK959jpjnd2lRtge57ItGRGyw7PD9rlLtg9qjKnXTIBGaRZo5B
   w==;
X-CSE-ConnectionGUID: if1oKiXDT3CnijP2Q8blGQ==
X-CSE-MsgGUID: MY0tprp+QYaTCR8FngRdug==
X-IronPort-AV: E=Sophos;i="6.21,305,1763395200"; 
   d="scan'208";a="141205348"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2026 11:50:26 +0800
IronPort-SDR: 699bce83_rwaLxxVH+Jp2+uBazHNtnHMQlWv54a/dr3raVQxMYLaMMzB
 1wnee86CJSy3dFPJX1IqXXdqTgaSWmOsfzedBFw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2026 19:50:26 -0800
WDCIronportException: Internal
Received: from 5cg217417w.ad.shared (HELO shinmob.wdc.com) ([10.224.109.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Feb 2026 19:50:26 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/3] check: call _unload_modules for each test run
Date: Mon, 23 Feb 2026 12:50:21 +0900
Message-ID: <20260223035023.21902-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223035023.21902-1-shinichiro.kawasaki@wdc.com>
References: <20260223035023.21902-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the check script calls _unload_modules() once per test case.
However, when a test case has set_conditions(), the test case is
executed multiple times, once for each specified condition. Despite
these multiple execution, _unload_modules() is called only once after
all the runs for various conditions have been completed.

This behavior causes module unload problems. When a run leaves some
modules loaded, subsequent runs can be affected by the loaded modules.
To prevent such problems, call _unload_modules() for each test case run
for every condition.

Fixes: fb3ba926da7d ("check: support test case repeat by different conditions")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/check b/check
index a2c19a2..9622030 100755
--- a/check
+++ b/check
@@ -416,7 +416,7 @@ _cleanup() {
 	_exit_cgroup2
 }
 
-_call_test() {
+__call_test() {
 	local test_func="$1"
 	local seqres="${RESULTS_DIR}/${TEST_NAME}"
 	# shellcheck disable=SC2034
@@ -536,6 +536,17 @@ _call_test() {
 	fi
 }
 
+_call_test() {
+	local ret
+
+	__call_test "$@"
+	ret=$?
+
+	_unload_modules
+
+	return $ret
+}
+
 _test_dev_is_zoned() {
 	[[ -e "${TEST_DEV_SYSFS}/queue/zoned" &&
 	   $(cat "${TEST_DEV_SYSFS}/queue/zoned") != none ]]
@@ -887,8 +898,6 @@ _run_test() {
 		ret=$?
 	fi
 
-	_unload_modules
-
 	return $ret
 }
 
-- 
2.53.0

