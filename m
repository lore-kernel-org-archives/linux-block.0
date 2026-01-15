Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33054346AC6
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468268; cv=none; b=Agi8O6Nr95DFzVx3FU/vzzL2eOXex4v1ZZVU5spj/DzNc7dy2PNcRwRMXiL2fY1+qRf2ctTRZV0zxNgPiV1qapck2mCOcCaSy+l/nxsngd0/2mnKGTvMSkwt+Ee9p/spmeSZ/Y1Q415kEuu/uem9+Wx6NMRDRUboEQlKynwjqKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468268; c=relaxed/simple;
	bh=Aa306RuU+96x3/nvKIqPIvluqwUKewMlZZyzy6uzaJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlahG+GsATN1eFf+KpBFVSOL1q48/uBYV/pLRYwSX8sEINqY6Iz3hgDjSAHozauAIpStffx26jabkNhRVhzIB1l0OjCs+O4AezqMGEssOxwnVFNNenL3qs8LFIb2Vg1EqiqniQWftP+vWDFmrGGWEK6NiV26GYkLXeT0LGZy5Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rtzbC0Z+; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rtzbC0Z+"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768468267; x=1800004267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Aa306RuU+96x3/nvKIqPIvluqwUKewMlZZyzy6uzaJE=;
  b=rtzbC0Z+uY62598mpsWuNxq9vLGbUUh0ldyaZHg5JdfVSW6u7UNtBfXC
   pARSH/EOe//puyKs3MbQTgYhTnc93TapvPfa2u8BVuCor5vJQB81+alpR
   0eKrBpt/s+XYCC7c2WFZppxiC+fqCO+SrzIwC2J18DP/sX3Hl2cisUVle
   U1aoe/dFhjsfO8dOozCz3euYlZ2alEgGE02ig89iXN7+pETjaJfJfG1jQ
   Qbb6XOrODXao2oVj/bzAVg2CADh399jOgQLN3kL/1Un5R7cFSYpVlPMpb
   zAmTbOaWbFkGL1RJX8zheqgagd6BqNh49N4/MhfE5e/yJ994DiCbxcKF/
   Q==;
X-CSE-ConnectionGUID: LPl3jpqBR1CCtZjjFnnnWA==
X-CSE-MsgGUID: 4Vm3NdugSmGwISADz8Lh4Q==
X-IronPort-AV: E=Sophos;i="6.21,226,1763395200"; 
   d="scan'208";a="138836180"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2026 17:11:06 +0800
IronPort-SDR: 6968af2b_y6OBt0HsqGPJ+zAQsFNMeVyh7tEtRHnhKdML/ZlsBv+89eA
 RqFjIJelvGOtWG+cHbQ9xrcHDaFMj3dLYqbwvtA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jan 2026 01:11:07 -0800
WDCIronportException: Internal
Received: from 5cg217417w.ad.shared (HELO shinmob.wdc.com) ([10.224.109.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Jan 2026 01:11:06 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: mcgrof@kernel.org,
	sw.prabhu6@gmail.com,
	bvanassche@acm.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v7 2/3] check: reimplement _unload_modules() with _patient_rmmod()
Date: Thu, 15 Jan 2026 18:11:00 +0900
Message-ID: <20260115091101.70464-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115091101.70464-1-shinichiro.kawasaki@wdc.com>
References: <20260115091101.70464-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To make the helper function _unload_modules() more robust, reimplement
it to call _patient_rmmod(). Another function with the similar name
_unload_module() is left as it is.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/check b/check
index 6a156b3..a8b7611 100755
--- a/check
+++ b/check
@@ -596,10 +596,13 @@ _unload_module() {
 }
 
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

