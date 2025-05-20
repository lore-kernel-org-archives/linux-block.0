Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841CF25D8FD
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 07:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747725623; cv=none; b=lmGIgh5Wg64hBk8KgMpjrnV/dkZW1Mw3l0N92YQxwyxwjf+r49wE/UJWwrU9hgDGI6YqfToN0necj3f94KgMkNvyoPwR/vYWOGgA7KsRbzCT+erU4HMl1lpfP07ObeOQA/aRn8av3lYSDpKFCNWGCB49rKLbG1dTvsWVRamY5HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747725623; c=relaxed/simple;
	bh=4hDilj8MhDcXQZT2pFealzXeKdZpsS7EAUCTJXhvPhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EhyGPeJk3AFjPMdynQO+PFPY3/cpldO1aVZGHP0APS9bRizbrK971+Fkm4KIcogpitgfxqYqq1GYM7eF1gNKXk0VKoufh+pLtB5EsKUhnnkvt1AtGX9Ex7YufKvYesZx838B94gCo9/RyxhHXFaMk75A8fs9IzzHhQtqJHXc3hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TOZEGMlh; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TOZEGMlh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747725621; x=1779261621;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4hDilj8MhDcXQZT2pFealzXeKdZpsS7EAUCTJXhvPhA=;
  b=TOZEGMlhwtKTzA9Y8MYAwyzicjGhA9fp+hDD+KLQK21zR1HGe8zMrusS
   XFemCREuwXqXO8X9Jucxv96DcYghl7H26OQDWOzQ6vUjXE7tRGW0CVj/T
   nlCe6lVw0Ki0R+tk5guniIYvJFbT2FwzOAyDmnDEiHU15biRmKteON9Q+
   Dq08etdFzmah/IhTm3KXGS/R9oJ26I5aj5ljg7yIjv1EcAFUsgdArS7sm
   GNSNzX9vcce/1wiBnOLUIjOfLHkkweWtNqWoxNo5NM7g8rYJtRe10PPQ0
   cMWwBRw6acFxcJc492hSJRBvzShTaVr1bj5tsGA/N6RZKMRVLMqH2Dfv5
   A==;
X-CSE-ConnectionGUID: V3i6F4z/RwywXA2pTpe99w==
X-CSE-MsgGUID: +m4fGMMrQhiQGQXk9UvbbA==
X-IronPort-AV: E=Sophos;i="6.15,302,1739808000"; 
   d="scan'208";a="83371852"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2025 15:20:20 +0800
IronPort-SDR: 682c1ef0_Qx/rcfFVb39PQ5BCFkCG1IDmbGyPFqj62bX3MJznWnJoj70
 /9PQu6LCXq1OaP/F6Jsx82iwkJ+QAHu01mSEgfQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 May 2025 23:19:28 -0700
WDCIronportException: Internal
Received: from 5cg21741nf.ad.shared (HELO shinmob.wdc.com) ([10.224.163.39])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 May 2025 00:20:19 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] zbd/006: reset only the test target zone
Date: Tue, 20 May 2025 16:20:18 +0900
Message-ID: <20250520072018.1151924-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test case zbd/006 performs random writes to the first sequential
write required zone of the test target zoned block device. To prepare
for this operation, it invokes the blkzone reset command, specifying the
offset of the test target zone. However, the zone count option is not
specified to the command. This resulted in reset of all sequential write
required zones on the device. This zone reset operation is unnecessary
for zones other than the first one and significantly increases the
operation time.

To address this issue, add the zone count option to the blkzone reset
command. Additionally, use long option names for better readability and
clarity.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/006 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/zbd/006 b/tests/zbd/006
index 2db0e9b..c47f81e 100755
--- a/tests/zbd/006
+++ b/tests/zbd/006
@@ -36,7 +36,8 @@ test_device() {
 	offset=$((ZONE_STARTS[zone_idx] * 512))
 	size=$((ZONE_LENGTHS[zone_idx] * 512))
 
-	blkzone reset -o "${ZONE_STARTS[zone_idx]}" "${TEST_DEV}"
+	blkzone reset --offset "${ZONE_STARTS[zone_idx]}" --count 1 \
+		"${TEST_DEV}"
 
 	_test_dev_set_scheduler deadline
 
-- 
2.49.0

