Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA1E364BE
	for <linux-block@vger.kernel.org>; Tue,  9 Jan 2024 10:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jaScfN08"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704797123; x=1736333123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3+n/5iunjDcw+H57LCR7N2v/PH2Oba7PX5raXGyqV0A=;
  b=jaScfN08zLkdR8Kkzeotdkvx5mlpi8fWG0IH186pMrTIiBwdmzY74Qms
   WDLfA+RjVjsIVnknf/8XTtGoLWyfLindM4lFsMiyzzaQ3yz+Q70mn4jmC
   X4Y+uN5haaKpJeQuaIBc23jM7Q9izwpL92A7+UgXD18DgowapepxI+4Xj
   z9M9YAQD81Nqgx/6cznIUyk8xPRq5FCMdNCHwYfbbJJhD3dHzKYSBhlZs
   mpGFeXjfN68+wxX5ot0Ppz4lmA4ryDAPcDFYLziKZ3B68cXPkzf+HB/6j
   b2KjUIpLi1fg8A0Tu4uxnsFtGDGm1t+3OmTkhB5F/b+NG70/d/8RJpRjJ
   Q==;
X-CSE-ConnectionGUID: 5dzJ8ojpR4KrVS0YP14blQ==
X-CSE-MsgGUID: sm5+V8aLSgauWZFlDuntAw==
X-IronPort-AV: E=Sophos;i="6.04,182,1695657600"; 
   d="scan'208";a="6473954"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2024 18:44:54 +0800
IronPort-SDR: AR2rgmqOwUMhRHlw5xeHzKOocgx71SFkLyjqcr1dwx5DSYtRgaKUKUP6qyGIsjAVxfoC1WKM5B
 +TNNo/mEKcNQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2024 01:55:14 -0800
IronPort-SDR: bavCG5zWEx41I+xG7SCvnIgtQ8Wv7KNgrFjJpfsh27NRfwdIBJHCyqlvsT/YUoEMXONyC47DbD
 qN1qau+44BAw==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Jan 2024 02:44:54 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 1/2] common/null_blk: introduce _have_null_blk_feature
Date: Tue,  9 Jan 2024 19:44:52 +0900
Message-ID: <20240109104453.3764096-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109104453.3764096-1-shinichiro.kawasaki@wdc.com>
References: <20240109104453.3764096-1-shinichiro.kawasaki@wdc.com>
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
 common/null_blk | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/common/null_blk b/common/null_blk
index 91b78d4..164125d 100644
--- a/common/null_blk
+++ b/common/null_blk
@@ -10,6 +10,21 @@ _have_null_blk() {
 	_have_driver null_blk
 }
 
+_have_null_blk_feature() {
+	# Ensure that null_blk driver is built-in or loaded
+	if ! [[ -d /sys/module/null_blk ]]; then
+		if ! modprobe -q null_blk; then
+			return 1
+		fi
+		if [[ ! "${MODULES_TO_UNLOAD[*]}" =~ null_blk ]]; then
+			MODULES_TO_UNLOAD+=(null_blk)
+		fi
+	fi
+
+	# Check that null_blk has the specified feature
+	grep -qe "$1" /sys/kernel/config/nullb/features
+}
+
 _remove_null_blk_devices() {
 	if [[ -d /sys/kernel/config/nullb ]]; then
 		find /sys/kernel/config/nullb -mindepth 1 -maxdepth 1 \
-- 
2.43.0

