Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5AA277CAB
	for <linux-block@vger.kernel.org>; Sat, 10 Jan 2026 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768040276; cv=none; b=uxCRfDQDFQFKhvPrZFIeNIlhlIdyUmJzrgaO2P2PNgPpTuwftaqWryLmns+1WEC0JsWcVgULa4sUAkBeWsxV3QE1tEskShQB43nedPn99qMN6/+EWc/tkPfnNJJ4Ylnh52Yvk68awoodo5udYJkqSiRKfKIQfULV8MtiStpVjmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768040276; c=relaxed/simple;
	bh=QENMUvpsnH8L/aBJ8YKUHbskyDgp7xC1sjd2Ve/mHIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJsjU5MOgVrPQV0/c9vN4zynLQduDXQEFBvE1oc5tTgZU/iuY5RLRultH4yj4+TszQt5cL0ujbd8kz3sfkB0TetKABrEmWPCjMSbLppFzy3mhs4wnDSh+4p2gBq4E8CJOL8ilBAJ4VH2DVXVvRtijj+47yII4xtjsVvpEMjoqMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ebHhd4YG; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ebHhd4YG"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768040275; x=1799576275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QENMUvpsnH8L/aBJ8YKUHbskyDgp7xC1sjd2Ve/mHIc=;
  b=ebHhd4YGaebYXKuiTMRo4XV5BSG3qBPZdri8sbUBn8/gVNbDwu9+tCDo
   mf6P+jOiM6g9Bfz04r0Wpmmi6QHOjmF5siUIZFeVWMJPvUW48tgynSaV+
   D6d9uS8ZigHH+Go0SoKcyV0CfFuPpaJQPYm1OSH9P9dnRn6tAk+hPsfcT
   FvpLEXk1XGvWWUVVV4vq/LRfmFknv4McV8lRB6NBfnu7ppGA77GyK0ld5
   haxLHPuNMcUPdJ9q+w6OaHI7uF3aKancZ4xrEa52rukswajIBhe8xltED
   zlbhEeE9W8lD9e3Huio0bm18gJ6Nps1b5p5qzjdo/tPOA1o0eCoVaTSG7
   w==;
X-CSE-ConnectionGUID: 2nyhfIRRR6GiZoadALTX+w==
X-CSE-MsgGUID: ybcSU2t2S2m2wGnqSWU8Wg==
X-IronPort-AV: E=Sophos;i="6.21,215,1763395200"; 
   d="scan'208";a="139716040"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2026 18:16:49 +0800
IronPort-SDR: 69622711_0NK4tgTOFVkjzGcDVPJfUMEd0JBfEWL6Atb89pG49CBy9AW
 7nHbABlG2SYvrOAYqgt+4l7E5fGY9AS0+o5OsnQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2026 02:16:49 -0800
WDCIronportException: Internal
Received: from 5cg21741b1.ad.shared (HELO shinmob.wdc.com) ([10.224.109.20])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jan 2026 02:16:47 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: mcgrof@kernel.org,
	sw.prabhu6@gmail.com,
	bvanassche@acm.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v6 2/3] check: reimplement _unload_modules() with _patient_rmmod()
Date: Sat, 10 Jan 2026 19:16:41 +0900
Message-ID: <20260110101642.174133-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110101642.174133-1-shinichiro.kawasaki@wdc.com>
References: <20260110101642.174133-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous patch dropped most of the calls to the helper function
_unload_module(). The last left caller is _unload_modules(). Reimplement
it to call _patient_rmmod() instead. Then remove _unload_module().

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/check b/check
index 6a156b3..cd247a0 100755
--- a/check
+++ b/check
@@ -581,25 +581,14 @@ _patient_rmmod()
 	return $mod_ret
 }
 
-# Arguments: module to unload ($1) and retry count ($2).
-_unload_module() {
-	local i m=$1 rc=${2:-1} reason
-
-	[ ! -e "/sys/module/$m" ] && return 0
-	for ((i=rc;i>0;i--)); do
-		reason=$(modprobe -r "$m" 2>&1)
-		[ ! -e "/sys/module/$m" ] && return 0
-		sleep .1
-	done
-	echo "${reason}" >&2
-	return 1
-}
-
 _unload_modules() {
-	local i
+	local i reason
 
 	for ((i=${#MODULES_TO_UNLOAD[@]}; i > 0; i--)); do
-		_unload_module "${MODULES_TO_UNLOAD[i-1]}" 10
+		if ! reason=$(_patient_rmmod "${MODULES_TO_UNLOAD[i-1]}" \
+					     2>&1); then
+			echo "${reason}" >&2
+		fi
 	done
 
 	unset MODULES_TO_UNLOAD
-- 
2.52.0

