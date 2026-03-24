Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDF93A545E
	for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 05:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774331419; cv=none; b=FSQ5Vmc/EPiWTQP91gMONPEfepbvK/WiuH6CXtTsYPrcRWNDcKqV7bsRhLVsAmpx1K3EThR+3gsP4Nr9Q2IlQEAUqeFxWuj22jpesVIj/YZZd5A+f0fWQVv+kqFvz1zil+gfNAnbU3grPH6rYKBhn74inw5hhruYY5kqNeStfPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774331419; c=relaxed/simple;
	bh=YsymeIF8ky8nPZd2cqtY55q6guXrhkUpdMWM0LR8S+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/L0iZGcFicGlsWrnn1B75VFXupAQQ57B5tkAN9BxRqDkLQiyTjlha3S0FBrIWOrjekpj1dibZ3n0BFSS52kss6iYtJbp1UH3MDbp01OZQKxT3vjpL4CnA56HPOLwYby2pIrrK66GeyZKg1Zzn9HnOAc0jv5SWifxtDJLj/9VeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=V6D01JaU; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V6D01JaU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1774331415; x=1805867415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YsymeIF8ky8nPZd2cqtY55q6guXrhkUpdMWM0LR8S+g=;
  b=V6D01JaUuKnjSQBB1ipPotYhutTKladu3nSD2Z4mBJRzfiuyytNLCslE
   NcFpse/otZro7jm6VqEOy2Ml1Lq/9iB4x11KkJqrwdpIaKJJyXMx7qcqZ
   nxUj1W1ZMB3P4ecrV/bYpcTB3+phiH/6U/3Apema1/+KuyP8kpJ8daSSm
   aSL2T1+prq/tC/oIeRertKlIILwjuxm0QY5ixTr+1IGzQyqaEptCk8ntu
   JcU3PTC85Z6cqX7zOUdAuNW5cBhmIdAQlT4loBFZlD/pYkMFaPq8h9K50
   GqckbanJehOQhaWeb0sTLJ3u/1nz72WU7Uq3oggiJXHW/p3UjzXpgUXxk
   g==;
X-CSE-ConnectionGUID: BOqlvDG9QFGOm2ik7WrRqw==
X-CSE-MsgGUID: BERudF2MQ/SloMrkb7towA==
X-IronPort-AV: E=Sophos;i="6.23,138,1770566400"; 
   d="scan'208";a="143614097"
Received: from unknown (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2026 13:50:07 +0800
IronPort-SDR: 69c22600_K1q2sWKI7vjHse6n99aGeIrxZrybhcZtClbx4f65rHCj8K4
 0Rv+fXhFFXCQx4xm9Y0+h7q3rkvPoBPaw1n9A0Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Mar 2026 22:49:52 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Mar 2026 22:49:52 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/7] check: call _unload_module() after fallback_device_cleanup()
Date: Tue, 24 Mar 2026 14:49:44 +0900
Message-ID: <20260324054949.3821569-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260324054949.3821569-1-shinichiro.kawasaki@wdc.com>
References: <20260324054949.3821569-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in the commit message of the previous commit,
_unload_module() is called before calling cleanup_fallback_device().
Then, modules that is not cleaned up can be unloaded by _unload_module()
and can cause unload failures.

To avoid the failures, move _unload_module() call into
_check_and_call_test_device() so that it is called after the
cleanup_fallback_device() call. After this change, the call chain
becomes as follows:

  _run_test
    _check_and_call_test_device
      fallback_device
      _call_test
      cleanup_fallback_device
      _unload_modules

This change requires to add _unload_modules() call to
_check_and_call_test() and _check_and_call_test_device_array() also.

Fixes: 756d18d5fef0 ("check: call _unload_modules for each test run")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/check b/check
index 3fa3e97..91064d7 100755
--- a/check
+++ b/check
@@ -417,7 +417,7 @@ _cleanup() {
 	_exit_cgroup2
 }
 
-__call_test() {
+_call_test() {
 	local test_func="$1"
 	local seqres="${RESULTS_DIR}/${TEST_NAME}"
 	# shellcheck disable=SC2034
@@ -537,17 +537,6 @@ __call_test() {
 	fi
 }
 
-_call_test() {
-	local ret
-
-	__call_test "$@"
-	ret=$?
-
-	_unload_modules
-
-	return $ret
-}
-
 _test_dev_is_zoned() {
 	[[ -e "${TEST_DEV_SYSFS}/queue/zoned" &&
 	   $(cat "${TEST_DEV_SYSFS}/queue/zoned") != none ]]
@@ -711,6 +700,7 @@ _check_and_call_test() {
 	[[ -n $COND_DESC ]] && postfix=_${COND_DESC//[ =]/_}
 	RESULTS_DIR="$OUTPUT/nodev${postfix}"
 	_call_test test
+	_unload_modules
 }
 
 _check_and_call_test_device() {
@@ -771,6 +761,8 @@ _check_and_call_test_device() {
 			unset "TEST_DEV_PART_SYSFS_DIRS[${TEST_DEV}]"
 			TEST_DEVS=()
 		fi
+
+		_unload_modules
 	done
 
 	return $ret
@@ -842,6 +834,7 @@ _check_and_call_test_device_array() {
 		unset "TEST_DEV_ARRAY_SYSFS_DIRS[${devs[i]}]"
 	done
 
+	_unload_modules
 	return $ret
 }
 
-- 
2.49.0

