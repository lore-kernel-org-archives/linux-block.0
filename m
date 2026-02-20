Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2148E344030
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771593843; cv=none; b=EfR0qIXnVW9SmWW9nOmxkgxfkGdYd1JE7J97vF+KPIupYx28nzbY61/yIwVp3MQItuR+gq9x99z/BorsL2nAegunfPoNPXGjYDUL28IF1syLSwtrRvRH7FHiYJ2lLdd2bdx5wlLAGxXw+CxbRsa7Zkc4GJQiEwZIN4v3herOy/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771593843; c=relaxed/simple;
	bh=WsEle54cltu5igbDB3CnT5jG9ZelS35BRa0dHJM7f5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiSeH/HtkU5Og8k9S78jhVD9MqXpa5Aq4ni/8I/QLd8x9/fM707r2uijrCXa8BUwvyTeSivDeHfjgtP6IHA7VhvQGgQMuTdrNgrcwWjrlEztvjdwIQHeUlibbmGUEVU1L+ThmtqwN5HlZuBiZU3r0ppFuBOX6fGlLtUQBnTiUC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Qry9dtyF; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Qry9dtyF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771593841; x=1803129841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WsEle54cltu5igbDB3CnT5jG9ZelS35BRa0dHJM7f5o=;
  b=Qry9dtyFQmlY9e1Lu/2t29Rr+xw98uxJtFsRBfUonaz5HMs2//K2pGXV
   6s16Vaf7yXn4Rt9ao86CT3OZ8TWo8FhU4XliZRpY7z5a5gvK7DmmeRMwZ
   5rQ7hZFWLyQWH7wfkN5Sa+itZujdH3wpjgUGBLJBdbjwjNKm7XpZDwXZ8
   GLM04E/X47iKFIXvaFOdST5t2oreBkcxHfifnRm4qfLaWkJzp4Ki6ep0k
   OQxV0edNuL8RqQS9QTLu7jGC8+ZDcZ1yNi7++CgAU1afK0sbBv69KlhNu
   27vOB19vnc3kVmDXH7d44yX0+NNrWuFjEr65DpP7lmTjnTXf7K80txSBU
   Q==;
X-CSE-ConnectionGUID: YFR9ZAPwSDaoRkK2xmW9/Q==
X-CSE-MsgGUID: rCZDnAQWQV6hVJqIsvSQwQ==
X-IronPort-AV: E=Sophos;i="6.21,302,1763395200"; 
   d="scan'208";a="141089913"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2026 21:23:55 +0800
IronPort-SDR: 6998606b_EsdVqQcoVpVMnAZ952zYRkPeUfdL3lMy+qqHXKBJwUo7aU9
 eJaoT+6+t/gyFn0ByeQqyhAoi9iLqIxUlJJH1yA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Feb 2026 05:23:55 -0800
WDCIronportException: Internal
Received: from wdap-y8axpm7exs.ad.shared (HELO shinmob.wdc.com) ([10.224.99.2])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Feb 2026 05:23:54 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 1/2] zbd/rc: do not use invalid write pointer values by blkzone report
Date: Fri, 20 Feb 2026 22:23:50 +0900
Message-ID: <20260220132351.273758-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220132351.273758-1-shinichiro.kawasaki@wdc.com>
References: <20260220132351.273758-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the recent change in util-linux [1], the 'blkzone report' command
no longer reports numeric values for write pointers when the write
pointers are invalid. Instead, it reports the sting 'N/A'. Currently,
_get_blkzone_report() assumes that the write pointer values are numeric
even when the values are invalid. Then it evaluates 'N/A' as numeric and
triggers arithmetic operation failures.

To avoid the failures, check zone type and zone condition. If the zone
type and condition indicate that the write pointer is invalid, do not
use the blkzone report string. Instead, use -1 as the write pointer
value to indicate the value is invalid.

Link: [1] https://github.com/util-linux/util-linux/commit/b032247f48d8b6a13bf8541eb663c779e448f568
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/rc | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tests/zbd/rc b/tests/zbd/rc
index 570928b..32a80a7 100644
--- a/tests/zbd/rc
+++ b/tests/zbd/rc
@@ -141,16 +141,27 @@ _get_blkzone_report() {
 	fi
 
 	local _IFS=$IFS
-	local -i loop=0
+	local -i loop=0 cond type
 	IFS=$' ,:'
 	while read -r -a _tokens
 	do
 		ZONE_STARTS+=($((_tokens[1])))
 		ZONE_LENGTHS+=($((_tokens[3])))
 		ZONE_CAPS+=($((_tokens[cap_idx])))
-		ZONE_WPTRS+=($((_tokens[wptr_idx])))
-		ZONE_CONDS+=($((${_tokens[conds_idx]%\(*})))
-		ZONE_TYPES+=($((${_tokens[type_idx]%\(*})))
+		# The latest blkzone reports 'N/A' as write pointers for full
+		# zones. In that case, do not handle it as numeric.
+		cond=$((${_tokens[conds_idx]%\(*}))
+		type=$((${_tokens[type_idx]%\(*}))
+		if ((type == ZONE_TYPE_CONVENTIONAL ||
+			(cond == ZONE_COND_READ_ONLY ||
+			 cond == ZONE_COND_FULL ||
+			 cond == ZONE_COND_OFFLINE))); then
+			ZONE_WPTRS+=(-1)
+		else
+			ZONE_WPTRS+=($((_tokens[wptr_idx])))
+		fi
+		ZONE_CONDS+=("${cond}")
+		ZONE_TYPES+=("${type}")
 		if [[ ${ZONE_TYPES[-1]} -eq ${ZONE_TYPE_CONVENTIONAL} ]]; then
 			(( NR_CONV_ZONES++ ))
 		fi
-- 
2.53.0

