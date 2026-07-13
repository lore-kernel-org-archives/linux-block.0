Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346661A6834
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 00:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783903172; cv=none; b=omy+EPSVV4S7OxrwSRVNMLAImWTyj3xWzyjgGjAIEQDMfjIm5rVCzGr1q85Hd9O2yABzzaDhLONJZN7sepeR49qCWpnrDbVjIlMRrFaaASFy3n4oYiGcy5eQJ3ifgcvZpZraibytrxt3VgJ84oZAPFQRJWmnfF6dAkpsYXaQQYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783903172; c=relaxed/simple;
	bh=8H/0mCTkJMkPzcYD4o3sbbf7LqUYAMx8I4+2cKQ7wTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWy/tGPSRkqwJwtecdki1SAA0PVsoniyS6rH8SJnE1haW6LLRuAiY4f24snPU8aEkm3nO3YUMJLpX7kkIIuYe+Jb3yF+ZZbDd9faxH8nG9rHXMi5MksHY/erEZOUXMRPrE94yMtVykhUA+p28O1vrgU05gyEX0ZWlg8eC9Ft6GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=THm9Bd4C; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="THm9Bd4C"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783903170; x=1815439170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8H/0mCTkJMkPzcYD4o3sbbf7LqUYAMx8I4+2cKQ7wTo=;
  b=THm9Bd4C4Bs5FcW95qVXyLczznYnMuuFKebag6zsfe6pN6shZJNwZo7x
   32UJS1pagjSJLHDam2oyGT3SAMTeGcc/SZeWuC3gLdyZVsjW4zLdAqG4M
   /fZEGiYMWt7R8FcsLJJdZCJ57LNpGacmw/1ekBQZbupxIjgWVsz7PJ43+
   rYR+zKIpBeVvxlGrHpLj8waUoYG9ePs/l/GEY2de8KL1I9DwlfXjLNvqk
   7Up6KBoO1708naTZ2UVvCH8DYftxqTlCfMzJyLdPPcRwUJbPmlap+r+AX
   KrCdHezWaMWDU/alkJdFprtSy0RgAmsA3c2lRN20UG/HOD5gdZzzwFweK
   g==;
X-CSE-ConnectionGUID: EAD42pIjSWCvzbQf/SlZ+Q==
X-CSE-MsgGUID: dDbyawviQ4GfDfoJwGRKzg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779120000"; 
   d="scan'208";a="150596164"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2026 08:39:29 +0800
X-CSE-ConnectionGUID: vxFDvRYHR8iO92rJew4Zgw==
X-CSE-MsgGUID: M3IGkOU8SdavXTuew+Oksg==
IronPort-SDR: 6a5433ac_Qx3mk6noq9wOSuecePNuvRMm43VWQrUwrPX0KdfDegesemV
 MVepXnXiV18VesJBDGWRRmAkvnFNwrtGYXQtYIw==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jul 2026 17:39:08 -0700
X-CSE-ConnectionGUID: 2UKQtayZR6O4DW4tGCr6wg==
X-CSE-MsgGUID: MT2XTl1YT8mPM4IUoCYjkw==
WDCIronportException: Internal
Received: from unknown (HELO shinmob.iptvf.jp) ([10.224.106.2])
  by uls-op-esai1-o.wdc.com with ESMTP; 12 Jul 2026 17:39:08 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/4] check: fix exit status code handling
Date: Mon, 13 Jul 2026 09:39:03 +0900
Message-ID: <20260713003906.21153-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
References: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e50a5ff644f3 ("check: call _unload_module() after
fallback_device_cleanup()") added a _unload_module() call to
_check_and_call(). However, after this commit, _check_and_call() no
longer returns the exit status of _call_test(). Then, the check script
does not return non-zero exit status even when any test case fails. Fix
this by adding a local variable to keep the exit status of _call_test().

Fixes: e50a5ff644f3 ("check: call _unload_module() after fallback_device_cleanup()")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/check b/check
index bc2dde9..61524a5 100755
--- a/check
+++ b/check
@@ -701,7 +701,7 @@ _unload_modules() {
 }
 
 _check_and_call_test() {
-	local postfix
+	local postfix ret
 
 	if declare -fF requires >/dev/null; then
 		requires
@@ -710,7 +710,9 @@ _check_and_call_test() {
 	[[ -n $COND_DESC ]] && postfix=_${COND_DESC//[ =]/_}
 	RESULTS_DIR="$OUTPUT/nodev${postfix}"
 	_call_test test
+	ret=$?
 	_unload_modules
+	return $ret
 }
 
 _check_and_call_test_device() {
-- 
2.55.0

