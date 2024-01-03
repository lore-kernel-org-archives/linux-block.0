Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0ED18EA2
	for <linux-block@vger.kernel.org>; Wed,  3 Jan 2024 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cx3nH3Xf"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704282588; x=1735818588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dqd6LPhTRmVa5Riz+5UDit2qkTES2NYbxD5ROxv2jGU=;
  b=cx3nH3Xf7i5YDPtkufJW0nqWJ5uwBXavVN8pr7qEamlyLuTKeDKZD30L
   Nj9k60bjvVyiUVAFY2+1YZyvrmQEILgGj7KG51KG0PceHupdAEcSRV9+j
   B+wcg+XRPZ4gfk8kEVy8sX3L9Sx8dO1LhJPKYGkQEU1+cdpEFboo79Fj8
   neIGfV5N6BDEfiDZPLN9t2eM2nDogQrxOjNOVBaXnXUEJan5obV3PBdPi
   MqPBsDFX3mxRd8fbBgJa30UjpiTpbbOWbBEjppsOgKJycqoTirOimKZ/m
   IClRHbsUXlFImzPv319aZes5y8opAEXeM8qrevDPW/oqY7CCkjsFRn38u
   Q==;
X-CSE-ConnectionGUID: ysKuvNjWTj20HtRogUthPw==
X-CSE-MsgGUID: 3yZwsr74TqiLHgUPks1TpQ==
X-IronPort-AV: E=Sophos;i="6.04,327,1695657600"; 
   d="scan'208";a="6081452"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2024 19:49:41 +0800
IronPort-SDR: /9QOj9+OxfrDv+8fVCk268vFGyxs/aQtx8iq0yJZ2z2ht4QK80/3vU+QD/23CkUiI5HloiyUWp
 5/EEYsPoN4vQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jan 2024 03:00:08 -0800
IronPort-SDR: cYxzeQJpxkqNCr3w1fBGfN/k2FxreZCkcpX50BdY9/p8ugJqZyFXz7CXkvfo+V5Y4eWPCMt87R
 V6/ykpYNoezA==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Jan 2024 03:49:42 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/2] common/null_blk: introduce _have_null_blk_feature
Date: Wed,  3 Jan 2024 20:49:39 +0900
Message-ID: <20240103114940.3000366-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103114940.3000366-1-shinichiro.kawasaki@wdc.com>
References: <20240103114940.3000366-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a helper function _have_null_blk_feature which checks
/sys/kernel/config/features. It allows test cases to adapt to null_blk
feature support status.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/null_blk | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/null_blk b/common/null_blk
index 91b78d4..d2f9e88 100644
--- a/common/null_blk
+++ b/common/null_blk
@@ -10,6 +10,10 @@ _have_null_blk() {
 	_have_driver null_blk
 }
 
+_have_null_blk_feature() {
+	grep -qe "$1" /sys/kernel/config/nullb/features
+}
+
 _remove_null_blk_devices() {
 	if [[ -d /sys/kernel/config/nullb ]]; then
 		find /sys/kernel/config/nullb -mindepth 1 -maxdepth 1 \
-- 
2.43.0

