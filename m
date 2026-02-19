Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F75D1A724C
	for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771503590; cv=none; b=irBZ6Vc3ODxwozH1a2wjlaG3abN+DgDtC/feJdpIyqyA5UUOGtvITpIt5GuRXWqM6FkdWBbIxkt1rh+oadTnB2ot1DrGIi98br+N3WtYQexE969zPtVutjuFVeaHCM3uB2h8QnrWkOZO1h/7niLbqvCLLfzoIny28jgDz6T8NkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771503590; c=relaxed/simple;
	bh=t1jxowCMRVnWXhCvu55X0Pr/SHNWETwgfFMnMqXS/9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XJCI+XSmXOCu6iRXUMo5l2BKm7nVwyi2yncwEDWJzzDqeucARkemFStjWbUfjzpcl31F2s0mo4QxujQ+mTsq7dzTg+grJRmqsLprvD2G1OyjxkYJPHMO5p8oN/KJyWtZmXTRvF5pAUOzBqCPLcbdyQMUNyvOyAFT7tzdD6Dpdms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iAQZGcUq; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iAQZGcUq"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771503589; x=1803039589;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t1jxowCMRVnWXhCvu55X0Pr/SHNWETwgfFMnMqXS/9o=;
  b=iAQZGcUqF2WPyYbWXwjXypBy06jCMEMWKD5bMjISEBNdG9zK2zF7nnvp
   s39Zb9owjd7YSzUq8TB1S31aziGpHbppe3YJNkC47J37s08DNV2TQjuba
   ndNVIk4ghFGg2MkkAQLcyHv6yOK21Y3vHkZoQbfQVS5MYrTvr1yWbXxML
   YFgtDge1DSmrxdnitvOdsjZqsyLd8SE8YJ+2RdbyMEula95fNjuZhX4MK
   C9TbGeh4pH8GaRUodQS6wUcntcLcHvQ0RGKJhwPyd7TI3dRLkBJrTKLtC
   7tbU9NOnUaj6RTYEKFA0dXk34AFO1flrtv03G/jitkMTRr6fNj+9ln3pI
   Q==;
X-CSE-ConnectionGUID: oS56FOl8TE2YjFZdU1oy6w==
X-CSE-MsgGUID: HF1fvDMgStS36DS+cVoRFg==
X-IronPort-AV: E=Sophos;i="6.21,299,1763395200"; 
   d="scan'208";a="141017472"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2026 20:19:42 +0800
IronPort-SDR: 6996ffde_7Ymu90mMhQFTEE0Hj1fpDrBKWplcjUAvDhafQRO+X6CEak4
 L85QPk8Vi8N/Q9lhZiJbhlYBdOxMS22DOU8lZDA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Feb 2026 04:19:42 -0800
WDCIronportException: Internal
Received: from 5cg21741tt.ad.shared (HELO shinmob.wdc.com) ([10.224.109.91])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Feb 2026 04:19:41 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] zbd: do not handle write pointer values as numeric for full zones
Date: Thu, 19 Feb 2026 21:19:40 +0900
Message-ID: <20260219121940.174239-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the recent change in util-linux [1], the 'blkzone report' command
no longer reports numeric values for write pointers when zones are in
full condition. Currently, zbd test scripts assume that the write
pointer values are numeric, then the blkzone change triggered failures.
To avoid the failures, check the zone condition and handle the write
pointer values as numeric only when zones are not in the full condition.
Also, drop the "-i" option of the local variable 'wptr' declaration in
zbd/002 so that it can hold non-numerical values.

Link: [1] https://github.com/util-linux/util-linux/commit/b032247f48d8b6a13bf8541eb663c779e448f568
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/002 |  2 +-
 tests/zbd/rc  | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tests/zbd/002 b/tests/zbd/002
index 39c2ad5..ac83c46 100755
--- a/tests/zbd/002
+++ b/tests/zbd/002
@@ -25,7 +25,7 @@ _check_blkzone_report() {
 	local -i next_start=0
 	local -i len=0
 	local -i cap=0
-	local -i wptr=0
+	local wptr=0
 	local -i cond=0
 	local -i zone_type=0
 
diff --git a/tests/zbd/rc b/tests/zbd/rc
index 570928b..921cf62 100644
--- a/tests/zbd/rc
+++ b/tests/zbd/rc
@@ -141,15 +141,22 @@ _get_blkzone_report() {
 	fi
 
 	local _IFS=$IFS
-	local -i loop=0
+	local -i loop=0 cond
 	IFS=$' ,:'
 	while read -r -a _tokens
 	do
 		ZONE_STARTS+=($((_tokens[1])))
 		ZONE_LENGTHS+=($((_tokens[3])))
 		ZONE_CAPS+=($((_tokens[cap_idx])))
-		ZONE_WPTRS+=($((_tokens[wptr_idx])))
-		ZONE_CONDS+=($((${_tokens[conds_idx]%\(*})))
+		# The latest blkzone reports 'N/A' as write pointers for full
+		# zones. In that case, do not handle it as numeric.
+		cond=$((${_tokens[conds_idx]%\(*}))
+		if ((cond == ZONE_COND_FULL)); then
+			ZONE_WPTRS+=("${_tokens[wptr_idx]}")
+		else
+			ZONE_WPTRS+=($((_tokens[wptr_idx])))
+		fi
+		ZONE_CONDS+=("${cond}")
 		ZONE_TYPES+=($((${_tokens[type_idx]%\(*})))
 		if [[ ${ZONE_TYPES[-1]} -eq ${ZONE_TYPE_CONVENTIONAL} ]]; then
 			(( NR_CONV_ZONES++ ))
-- 
2.53.0

