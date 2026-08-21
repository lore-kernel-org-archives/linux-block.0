Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51190472557
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309682; cv=none; b=Yx18dbtr7ilquETQS0AfPGLcdE/yn4gpz7cA/1eOInKvrZu/neDEC75JLr8Mi/GYou2opBzTIvjo5sj9JpWcLfPjxTkDcHXq9y6caXSn2i++yPCVdNSbFxLF5gEZO4jgogQiUBB1/gkTpbDOScmXHqCForeIfenA+Zywum94tOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309682; c=relaxed/simple;
	bh=EzrAtWjV9RmGHQRhMQjiXcpRLXR3voD9L3WIvrCerCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pv/YvHu2eGS8eVVFryOMcfylvdW30r5tIMVJPoRHnPzeP1UvV/d2DEpwWj+cXUjqweGHlqDiPDpU4eUtn6SlczzZyAFl0Se/NYsnse/0tkZOZrmkgDwBadNwbFgXwMrkhsP07QJhVE+AZoOFGbrTbxKcjOsVsdGaewsoYyjZxOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gp6LJ0q3; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gp6LJ0q3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1787309681; x=1818845681;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EzrAtWjV9RmGHQRhMQjiXcpRLXR3voD9L3WIvrCerCU=;
  b=gp6LJ0q3u7IRp95J91nnD4/c40rvWsV7h8yx2pY2WqUBhunq92gEhWaw
   i3fDdL4NL0/jbid8y0myTJhRm6I01dZdYRVcgJ1fdg458iC4Z65sBshJR
   bhs3fJ+mZoPxmGtVK+NdBlUf6vhU89/zeb0UW8LUlqSCYNYEsCzWJ/J7o
   ZoCyRpIu7JQGkH0iS17JTEOxs7pUB5UQHn38nrSa/PlCrBhM3DUjsB0Ii
   2LJudBUHoC36Ovtk0SVt+dEObzkon4YliyMrIFsixAyELQ6lRJ7ok3gEg
   yScnPu5AfXW6eOlSVwKKUeV0osp3fUTfQOWGNqQiExuHRsV6oxB1WF1Dk
   g==;
X-CSE-ConnectionGUID: x9LDr8t2Q/CNpRXeI2NBuQ==
X-CSE-MsgGUID: eiYIBBdZQE2Wh+A0XXcGhg==
X-IronPort-AV: E=Sophos;i="6.25,235,1779120000"; 
   d="scan'208";a="153759682"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2026 18:54:40 +0800
X-CSE-ConnectionGUID: w47SJScASe2ks4sgRIh5+g==
X-CSE-MsgGUID: Fu7mzStAQfmcSCL0H2Yulg==
IronPort-SDR: 6a882e5c_pcbmJMgZx5HAuHsWVBawXbxqhV4GUlH1RUVT+6aPQyfqO7T
 xKSxVFNDkxvvwenF8QgTaIIxQJNMjy/0J8c6SxQ==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Aug 2026 03:54:20 -0700
X-CSE-ConnectionGUID: fc3IRBvUQeu6nKWm37mUyg==
X-CSE-MsgGUID: j/g0hMZUSa+AKrQYNQk12Q==
WDCIronportException: Internal
Received: from 5cg2075g88.ad.shared (HELO shinhome.wdc.com) ([10.224.105.106])
  by uls-op-esai1-o.wdc.com with ESMTP; 21 Aug 2026 03:54:20 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Ming Lei <tom.leiming@gmail.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] block/040: relicense from GPL-2.0 to GPL-3.0+
Date: Fri, 21 Aug 2026 19:54:19 +0900
Message-ID: <20260821105419.794516-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most blktests code, including check and common/rc, is licensed under
GPL-3.0+. However, tests/block/040 is licensed under GPL-2.0 only. This
test script sources GPL-3.0+ shell code, but GPL-2.0-only code is
incompatible with GPL-3.0 code [1].

Relicense this test script under GPL-3.0 or later to resolve this
incompatibility. The script file was authored by Ming Lei, and he agreed
to the relicensing [2]. Shin'ichiro Kawasaki subsequently modified the
test and also agrees to the relicensing.

[1] https://www.gnu.org/licenses/gpl-faq.html#v2v3Compatibility
[2] https://lore.kernel.org/linux-block/CACVXFVMio4pcYVrnd6LzYffymFUOLsSY6Oo3C31Yzb7sEcOGAQ@mail.gmail.com/

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/040 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/block/040 b/tests/block/040
index 32e54f0..b9d0441 100755
--- a/tests/block/040
+++ b/tests/block/040
@@ -1,5 +1,5 @@
 #!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-3.0+
 # Copyright 2025 Ming Lei <ming.lei@redhat.com>
 #
 # Most of code is copied from block/029.
-- 
2.55.0

