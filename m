Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E07236421
	for <linux-block@vger.kernel.org>; Wed,  2 Apr 2025 07:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577757; cv=none; b=qg01groBnQM8EdGEd8/A0UjJF6/gAPuAdRAPc6s9aYuwdKYIXWpoWTJ13XOabK08NmH6EQ8i9uEjYNNsbUgdYjMVKAUXRqhTIQ7+yLO4tH5k4TMPfCwz2VzviAUdHDeAIbc+T3mh82ZkSLJiA70GOrgf60cJIdH/ZUrIJrK4nG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577757; c=relaxed/simple;
	bh=J6/Hu2MKW11tsgpsq1VkvyADxkqS13Ky70HS3L0WoQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bq/uc2D83jQaE5ulAr38CtP2eRLEfw+E9npZ2Zosc4hGB+BMcBat2ikO/f9YK9g9iBz+WlBGfSfzLWfCnau7wUFTsfJZvgMA9wUNOsJOYY5CuTOIl/CKqbkLdLWh5U35kGxJ/XKoh6upXrkjjbpQ7nUFuhkJ+p+wO7uZ+8pbIFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JZVhytfU; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JZVhytfU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1743577755; x=1775113755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J6/Hu2MKW11tsgpsq1VkvyADxkqS13Ky70HS3L0WoQs=;
  b=JZVhytfUQhtbd3TpRI2meb0ToBwR6ey9xSBSX9x9gVaJsD7pzy8qBt+F
   01E4iglExIGnxa+2OEerBefs1/Zv5ESnhW57bM8shRdIQ4rrnik27JnsT
   O7nnVT9eN2AhgAqa0LZYCJOoeDp9IC/G4EFxHbEJMSdvEmTHG9K1hSo+u
   c8J5loRYkDWCJXOyeAnlFsea54mRqHqUmBzAPl6AiDPJLbqft9GmWZxeq
   IjCHRPye0olmkH9jltZ0YKUk4a0nlN07px+iN9SCP4sG1ZYH8PAuFRheI
   u18o0Y3upohFfuHRTA0HwXaccVXheTmBFxmvqxi3CU/FKXp1shHeXOQoJ
   g==;
X-CSE-ConnectionGUID: tswvNtugTGaJm4vKN0/hMA==
X-CSE-MsgGUID: GmJPiOmCTvWSN2JZrZlAZg==
X-IronPort-AV: E=Sophos;i="6.14,295,1736784000"; 
   d="scan'208";a="71367663"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2025 15:09:14 +0800
IronPort-SDR: 67ecd4a3_F6YkTHF8tnDaV6kSoNMWMU7EO5ibBdad8OwgwfadRnq7l8U
 RMBE403Fng4glQB+3q3qze1l/NNShssQ/xVR4oQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2025 23:09:39 -0700
WDCIronportException: Internal
Received: from 5cg2075fn7.ad.shared (HELO shinmob.wdc.com) ([10.224.102.114])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Apr 2025 00:09:14 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 05/10] nvme/rc: introduce _have_libnvme_ver()
Date: Wed,  2 Apr 2025 16:09:01 +0900
Message-ID: <20250402070906.393160-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
References: <20250402070906.393160-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A following patch is going to add a test case which depends on the
version of libnvme linked to nvme-cli. Introduce the helper function
_have_libnvme_ver() to check the version dependency.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/rc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 9584610..e52437f 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -617,3 +617,16 @@ _have_systemd_tlshd_service() {
 		SKIP_REASONS+=("Install ktls-utils for tlshd")
 	fi
 }
+
+_have_libnvme_ver() {
+	local ver
+
+	_have_program nvme || return $?
+	ver="$(nvme --version | grep libnvme | cut --delimiter ' ' --fields 3 | sed 's/-.*//')"
+
+	if _compare_three_version_numbers "$ver" "$1" "$2" "$3"; then
+		SKIP_REASONS+=("libnvme version is older than ${1}.${2}.${3:-0}")
+		return 1
+	fi
+	return 0
+}
-- 
2.49.0

