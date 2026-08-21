Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CC243B6F3
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309635; cv=none; b=IqS/XUHSeNc6i8E8wbTC/GC+YBbhPvjea/qhQ1ClZ3UTPO6d18YgHJJfcbPg1EF9rlNjaweXhSdll4UtQCnj9T6BzXrAK/hK4bUIp+LypMlYEIrtBYX1UjgnuhX6BLlHaRRknWy2u1xr9n6Z5i8vcTVxQaSzwIalcPs3WauB7Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309635; c=relaxed/simple;
	bh=OVe3o3fO916hsVPiCbual7MoCCvK+cz+A23HB25NPmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+jP1dMsnyEXCbHogfg1leClAMaxH2pBI6bNMwRWms8p6fIwsEvTdkXVtSH287Fv/iXwrBnjUAMpc9GNRYJpkCbsIj/vPBSTy3ImXUYmsKB/nV5AkImFjmAasshpLxQBoz6evO5jI+2OQ1BqTB1ou0L5JX6zz0/YBd4qMCDzYhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=K1oF3dkg; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K1oF3dkg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1787309634; x=1818845634;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OVe3o3fO916hsVPiCbual7MoCCvK+cz+A23HB25NPmM=;
  b=K1oF3dkgkzFRnZlD5PHqwrAG8afysU0AfRTk4g0dkhWoS7hBwZ67cR9I
   t8QFCLJpLXOnmR5mR8vnliEFlq/fQHFcwTZHXqyQlZ7KkQmdtsKehfpPY
   vU2BxGlBNYK2pSbQq/YxgsfiyrId30RU9fcgJpSS6xdiMbCseDYFxHOOP
   RrK4/YOdY1vUn0GcEYqdnmJ8HNgYsQkMxcgqVvkeGJJ5vyLQBfDURK7iR
   WanMjRcoBqMbeYfX86nz/XWjJ+VTDYPV+sG6v9R5VC5nfVkz06eGBlEv1
   uVZC+4ysvDaHXQ8yvEZeuAancEwlAiLw6v7ExJ3523UyOb0scXrH9MzsH
   g==;
X-CSE-ConnectionGUID: o4uGKDnBT+SDUlJynU+TmQ==
X-CSE-MsgGUID: qz0x69kGQOq3sqBU3Ty47Q==
X-IronPort-AV: E=Sophos;i="6.25,235,1779120000"; 
   d="scan'208";a="149797493"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2026 18:53:47 +0800
X-CSE-ConnectionGUID: dBpnQZZiQUa7MxOCiMLrXA==
X-CSE-MsgGUID: +von5suDRpmoED3atoCcYw==
IronPort-SDR: 6a882e31_X8Mi8eTZ2Ijj3bg7d0iLkid+TQr49HnjU4daiSjIaAImt/M
 3Qa1ZPmcExO1U4PkECa4ytqkSMcNVX8aWmkIxCQ==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Aug 2026 03:53:37 -0700
X-CSE-ConnectionGUID: G1UGV45DQ8qceFDHUbHlmA==
X-CSE-MsgGUID: 4sk+yArsT+e3FR4SD0IZRQ==
WDCIronportException: Internal
Received: from 5cg2075g88.ad.shared (HELO shinhome.wdc.com) ([10.224.105.106])
  by uls-op-esai1-o.wdc.com with ESMTP; 21 Aug 2026 03:53:36 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Li Zhijian <lizhijian@fujitsu.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] block/{029,030,031}: relicense from GPL-2.0 to GPL-3.0+
Date: Fri, 21 Aug 2026 19:53:35 +0900
Message-ID: <20260821105335.794406-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most blktests code, including check and common/rc, is licensed under
GPL-3.0+. However, tests/block/029, 030 and 031 are licensed under
GPL-2.0 only. These test scripts source GPL-3.0+ shell code, but
GPL-2.0-only code is incompatible with GPL-3.0 code [1].

Relicense these test scripts under GPL-3.0 or later to resolve this
incompatibility.

The script files were authored by Bart Van Assche <bvanassche@acm.org>,
and subsequently modified by five contributors:

 Yi Zhang <yi.zhang@redhat.com>
 Christoph Hellwig <hch@lst.de>
 Li Zhijian <lizhijian@fujitsu.com>
 Akinobu Mita <akinobu.mita@gmail.com>
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Bart and all of the listed contributors except Yi Zhang agreed to the
relicensing. Yi Zhang did not respond to requests sent to his Red Hat
e-mail address and the address associated with his GitHub account. His
changes are considered de minimis, so his consent is not required [2].

[1] https://www.gnu.org/licenses/gpl-faq.html#v2v3Compatibility
[2] https://lore.kernel.org/linux-block/ama1svBbdVfyEKz1@shinmob/

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/029 | 2 +-
 tests/block/030 | 2 +-
 tests/block/031 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/block/029 b/tests/block/029
index c00bdeb..e180703 100755
--- a/tests/block/029
+++ b/tests/block/029
@@ -1,5 +1,5 @@
 #!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-3.0+
 # Copyright 2019 Google LLC
 #
 # Trigger blk_mq_update_nr_hw_queues().
diff --git a/tests/block/030 b/tests/block/030
index 82330c2..0d63b3f 100755
--- a/tests/block/030
+++ b/tests/block/030
@@ -1,5 +1,5 @@
 #!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-3.0+
 # Copyright 2020 Google LLC
 #
 # Trigger the blk_mq_realloc_hw_ctxs() error path. Regression test for commit
diff --git a/tests/block/031 b/tests/block/031
index 99615ec..1748466 100755
--- a/tests/block/031
+++ b/tests/block/031
@@ -1,5 +1,5 @@
 #!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-3.0+
 # Copyright 2021 Google LLC
 #
 # Test support for sharing a tag set across hardware queues ("host tag set").
-- 
2.55.0

