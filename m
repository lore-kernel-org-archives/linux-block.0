Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA93A543F
	for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 05:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774331422; cv=none; b=r/ymE4P/ItIb6soMmlZO9oEjqmZ6RHL+s11JNUDcVVm/pSbBshtgXSl59uYZFugR6gU7ZLapvIlpTgDHW0LN705Vot7jlWtG/qm2KVhEwVDdn5vg0VfhZydcxu3q+6U2P0e6LUPfalzCaQ8/E4ucoUZ1NrZSMynYkoY9Oswghn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774331422; c=relaxed/simple;
	bh=6yITue6Hz0PLK+sCTvEVSh5KjhMw2QoFGZUexBkDLfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glejbwHguVKvDp1cyeOe1epB/5gjmXFWctwcxGBE4q9z/EPb+r43t826Nv7XnG4AgxVB8ZORTTHGNjPE0Bv6M8Kuhbs5SANMoGMREsQlOTDJJRkV6/igbOwoaPMuS7mEHRm8FcBylZ0+uPH9aObkUHE+tjJ64lraci66s2rThUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rO7Z3VUi; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rO7Z3VUi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1774331418; x=1805867418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6yITue6Hz0PLK+sCTvEVSh5KjhMw2QoFGZUexBkDLfA=;
  b=rO7Z3VUiFyFt3BNtup/fUl5CVs2VpW6slHGwSnGLBHwhGwvPPDbrItEA
   YGM5jT7oVbsde0I9w0Y3nHE7BAnPqUqo8gU6HTQ2deg07fpe/wH0jL8Ml
   P6B7TCCHjIVy8w6lpT1nRt2M4f3BN+BvHjv43+VB2RJzlqo9t1NnzuSDr
   0ZwZTJKWwDsSTq24q/7G4QgNU+M5WUe9ZwYkN8DC1rrgSX3HOIdaGHheg
   pfsEkkfXNtB2dZ0N7HSJucGj4wASw4OrVm+++wguNAVM6cM3EOTDhk0i0
   yu2Ee14WbiIkr4SYtAKULC/38vEn88H9PgoMy7xH+pZtp46g0ZInLEj7G
   w==;
X-CSE-ConnectionGUID: fGYP+MS3SF+DkiI2Z2gQ0A==
X-CSE-MsgGUID: kwqXft9sRVCruTva1vTkmQ==
X-IronPort-AV: E=Sophos;i="6.23,138,1770566400"; 
   d="scan'208";a="143614099"
Received: from unknown (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2026 13:50:07 +0800
IronPort-SDR: 69c22601_+4qatWiFp7BkkFBoGSF9qrkWY9EJk2f879tMFRiWQCu3SaC
 ZbOKQDR+D1lqqcBN3Nxlhp67ToXUlxI7mhHA0Cg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Mar 2026 22:49:53 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Mar 2026 22:49:54 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 4/7] check: call fallback_device() in the same bash context
Date: Tue, 24 Mar 2026 14:49:46 +0900
Message-ID: <20260324054949.3821569-5-shinichiro.kawasaki@wdc.com>
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

Currently, the callback function fallback_device() is called with bash
$() feature. This runs the function call in a new bash context. Then,
global variable changes in the function call are not reflected in the
caller context. This is not handy and does not allow checking
MODULES_TO_UNLOAD status change in the caller, which will be added in
the following commit.

To share the same bash context between the caller and the callee of
fallback_device(), do not use $(). Instead, use a temporary file to keep
the output of fallback_device().

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/check b/check
index fdc7ba7..00213cb 100755
--- a/check
+++ b/check
@@ -708,6 +708,7 @@ _check_and_call_test_device() {
 	local unset_skip_reason
 	local ret=0
 	local fallback=0
+	local fb_dev_file
 
 	if declare -fF requires >/dev/null; then
 		requires
@@ -726,10 +727,14 @@ _check_and_call_test_device() {
 				return 0
 			fi
 
-			if ! TEST_DEV=$(fallback_device); then
+			# Use a tmp file to keep bash context in fallback_device
+			fb_dev_file="${OUTPUT}/${TEST_NAME/\//_}_fallback_dev"
+			if ! fallback_device > "$fb_dev_file"; then
 				_warning "$TEST_NAME: fallback_device call failure"
 				return 0
 			fi
+			TEST_DEV=$(<"$fb_dev_file")
+			rm -f "$fb_dev_file"
 
 			if ! _find_sysfs_dirs "$TEST_DEV"; then
 				_warning "$TEST_NAME: could not find sysfs directory for ${TEST_DEV}"
-- 
2.49.0

