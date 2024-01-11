Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF40615EAB
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Il6UOcrG"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704963645; x=1736499645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tJYeGvZsW8tl4dw+GoOWEzRWnu0f/5rU1GLxOAhsZiw=;
  b=Il6UOcrGmYgs65Axw+Zcl8tl2aEhOm8oGd07zgL+ZJwL9u3jPkNmckWZ
   ksnI1Sl9LLJYc1zAz11A9Dz+AHiv/WB+bOnLR9A7+ORwOiEBcHEjdy+vk
   opA3xrYjvMZldzxaeH7snR2mJ0d43d/3hahG1vdOes2rGPYUrRAvjI1GX
   qJQkwPmzlM/w4PxbE4PR3Zm8LhdUVPOboJCH8o6KgTs6HmA1BrgFP3S3f
   QxcH9abm2bJN8rJ+sZijf3LyqF7l3DPcO8DMp70/ygGsvM+ybqKiS/kOr
   3sgltkqW2NY5HxaM0oByHY37ctsYfjSPZASIaWWPmau+N9qEJdEpnXb19
   A==;
X-CSE-ConnectionGUID: Ew6DGcifRtiArNz8Fgk5fw==
X-CSE-MsgGUID: xTbPdtF7Q7asLV4/a6ljqA==
X-IronPort-AV: E=Sophos;i="6.04,185,1695657600"; 
   d="scan'208";a="6622108"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2024 17:00:41 +0800
IronPort-SDR: mJED7utA3krJWKrmMf9cdpgCVGtC9XlC7dVEL2wGuev5cj5CDC6jEl3/b+TEasQkixVn7/eeXl
 w6DpHousOozA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jan 2024 00:10:58 -0800
IronPort-SDR: QCzc9gPsV5onRvnrFeNh6k8A1dIky9GMS2z5E+0WAYlx4WDUQBvgQVwc1nMpjhZeKqR24CYW4Q
 DPDIVQqaJ7ag==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2024 01:00:40 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v3 1/2] common/null_blk: introduce _have_null_blk_feature
Date: Thu, 11 Jan 2024 18:00:37 +0900
Message-ID: <20240111090038.4045250-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111090038.4045250-1-shinichiro.kawasaki@wdc.com>
References: <20240111090038.4045250-1-shinichiro.kawasaki@wdc.com>
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

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
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

