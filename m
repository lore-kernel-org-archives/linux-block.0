Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFBB344046
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 03:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818634; cv=none; b=GI7BFn84gNUqbN3MeT+c4uOQ1qkgVtfw+cU5xOlgcFRiYopZwQKJ/AUn+SdFjk3T2nahvHNG+XcsXzIw+ouxjAH7Zj4MRSZ4clJFtr3C32+ulNnxUgNpI8/esMEOkPAHFRcdYiNPlH2E3hNR+ah8eVqDUDJjI2ESQHlst/rSJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818634; c=relaxed/simple;
	bh=+BB0YuNKO58wQ3TD+GTLoLScimyw7bZcwG7UqLXjpQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/fU1XU3aUvg3AWfDEdK1KyzlhaiE9+v7sFBpQScSemTIk/Gh1255eKOoW+9uJrG56uF7IVi+4fKcDiVI+toaDUITt3GzWbq+96z/j0i99Fa+2sKah4DkR32tnWeL0tWvlN0fCTLi4vPq8kYOe5fTGKDROfrIhWfkZqA7xx3NAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hQjmSnBF; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hQjmSnBF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771818633; x=1803354633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+BB0YuNKO58wQ3TD+GTLoLScimyw7bZcwG7UqLXjpQQ=;
  b=hQjmSnBFxnUf0d+kXisiwITCaIRhtfBDBjP4lNxaPcWZCDoU/FWVToGc
   T2zqNNOhZtbCKmjodzZ3ns0CWp/nLDXAgXyX2ZphcweIY0t1gP/16tjDY
   FTh/ZQMkGrvKUjd30B2D8xG81ysEDWG34rhU3mCBGVKjpjML6fdjoEoSY
   yabt7AzE++N+Zq7/2O6GIe7YYRlh9KFU+cngQOvVTSIJ3JSsCOJbMLH+7
   DAydQSn/BAWKwyhy5D3nW2Z+HiozhFoisXbdDtxy+/zoyIN3jsJ4ciwQf
   89+yUq65lclIWFLdmFiUkN+Cqnf/P538iSpNf5WcFgZ++SEwIKsylGpOV
   w==;
X-CSE-ConnectionGUID: rOuXVFArSVaw7JK+HzcK5Q==
X-CSE-MsgGUID: WrZLow/6REmYsQnAuRsvHQ==
X-IronPort-AV: E=Sophos;i="6.21,305,1763395200"; 
   d="scan'208";a="141205349"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2026 11:50:27 +0800
IronPort-SDR: 699bce84_FVkA1B1Hil6k2F/vLu0kFsdoIBny+AEBV0mYN4AgcIq/t29
 JmOM5ZflOU8w52IBWSQMVx1vxCcPtVg8WC3ylDg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2026 19:50:28 -0800
WDCIronportException: Internal
Received: from 5cg217417w.ad.shared (HELO shinmob.wdc.com) ([10.224.109.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Feb 2026 19:50:28 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/3] common/rc: introduce _load_module()
Date: Mon, 23 Feb 2026 12:50:22 +0900
Message-ID: <20260223035023.21902-3-shinichiro.kawasaki@wdc.com>
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

When a test case requires specific modules for testing, it loads and
uses the modules. To maintain a clean environment, it is desired that
the test case unloads after execution. The modules should be unloaded
only when the module was not loaded before the test case run. However,
writing logic to determine the module load status and unload accordingly
can be cumbersome.

To simplify and standardize such module unload control, introduce the
helper function _load_module(). It attempts to load the specified
module and records it to the global array MODULES_TO_UNLOAD only when
the module was not already loaded. Modules listed in MODULES_TO_UNLOAD
are unloaded by _unload_modules() after each test case run.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/common/rc b/common/rc
index abf66a4..0a8caca 100644
--- a/common/rc
+++ b/common/rc
@@ -69,6 +69,18 @@ _have_driver()
 	return 0
 }
 
+# Load the specified module. Record the module to MODULES_TO_UNLOAD so that they
+# will be unloaded by _unload_modules() after each test case run.
+_load_module() {
+	local modname="${1/-/_}"
+
+	if ! modprobe --quiet --first-time "${modname}"; then
+		return 1
+	fi
+
+	MODULES_TO_UNLOAD+=("${modname}")
+}
+
 # Check that the specified crypto algorithm is present, regardless of whether
 # it's built-in or as module.
 _have_crypto_algorithm()
-- 
2.53.0

