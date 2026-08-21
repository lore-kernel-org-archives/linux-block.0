Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6AD43B6C4
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 10:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309773; cv=none; b=EMijDKM3Ap3fKzhBViivr7SSRtvmXgkK379gmzauIQXNW45sRbSdL0HtyFKmXG6DqJNhuR3c1ffYX7Cf4ku0z/tIIkJu1ottoE5ShrwAjHVDpm4GE550t7hz5zzhqMNmxZPZvKO7NDpKhIx8liV2QiI+h79wJn8TrLWeHynR0zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309773; c=relaxed/simple;
	bh=FjjgoLGdZjXNTELItgoG9lH209DJMLmLfHvNjageC9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YgO5teRqrhiBPAwwQjv+ZeVs8ajq6iUyVCox8dhrn3BMjKyLy2tlOpCb0X+77F1bSNYa+G00O51TARPpPDDe/KdFNhmBtBc3nPzRyo5HaBgj6yWvoUSVCR/62MUs4FLmyDpvAf5CDx7Rt4aszg9gC9YynQ9NlpWbO8opTWCnER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XqpxJYoM; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XqpxJYoM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1787309772; x=1818845772;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FjjgoLGdZjXNTELItgoG9lH209DJMLmLfHvNjageC9U=;
  b=XqpxJYoM/ugGaAhirqnfhbvmnlzbBdPFadsdGigKvXPiFehez1nMl01r
   UpwWltzczoTMN41NtbB3G23GY0XHvHSfw3O6Wus81rfim6P68oqMYUOjC
   SS8m0+OUec44O4R0gNRowp5wA3RTLd7GUtCQ405ONerKKRhg+Pb6YvUuy
   VFlcPF1WG9vioJXliFG4F8dLJyBF4JCpK5c0MrWGu8Sb8SnblTVD/7aAX
   dLggXU8JgbCpW8dR0lWMvzsljJgIjaSCt4H6usXE8gjWSKzwGt5yHNcrM
   OCQXnfxYd4UF8CUlt3rThe+ANAH8GO7/0lbHQhDHT3TwZTdyBTUIzmZBV
   Q==;
X-CSE-ConnectionGUID: V5ZWW5tkTB6WVWjl48ha+A==
X-CSE-MsgGUID: vWn4T60WRcCpnQRwhvxJNA==
X-IronPort-AV: E=Sophos;i="6.25,235,1779120000"; 
   d="scan'208";a="153032022"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2026 18:56:11 +0800
X-CSE-ConnectionGUID: qv1+a+e4Sra2dtq0CClkiw==
X-CSE-MsgGUID: Qw8uCvpxSqeo+YOvqJx3qw==
IronPort-SDR: 6a882ead_bBeq24d+CpzGfclZDrzZaUWfNDFnaE335jAHcVqwsM3l/KR
 hcXCn6/zstBgQq7L9DLkwXKlgBvxkT0qceqf71w==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Aug 2026 03:55:41 -0700
X-CSE-ConnectionGUID: MpDNy2IlSZez9EeGQm7Bmg==
X-CSE-MsgGUID: 6kS/VCvAS0eLeuA/dYECsw==
WDCIronportException: Internal
Received: from 5cg2075g88.ad.shared (HELO shinhome.wdc.com) ([10.224.105.106])
  by uls-op-esai1-o.wdc.com with ESMTP; 21 Aug 2026 03:55:40 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>
Cc: John Pittman <jpittman@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] block/042,043, src/dio-offsets.c: relicense from GPL-2.0 to GPL-3.0+
Date: Fri, 21 Aug 2026 19:55:39 +0900
Message-ID: <20260821105539.794679-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most blktests code, including check and common/rc, is licensed under
GPL-3.0+. However, tests/block/042, 043 and src/dio-offsets.c are
licensed under GPL-2.0 only. These test scripts source GPL-3.0+ shell
code, but GPL-2.0-only code is incompatible with GPL-3.0 code [1]. The C
source file provides the helper executable used by block/042.

Relicense all three files under GPL-3.0 or later to resolve this
incompatibility.

The files were authored by Keith Busch <kbusch@kernel.org> and
subsequently modified by three contributors:

 John Pittman <jpittman@redhat.com>
 Bart Van Assche <bvanassche@acm.org>
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Keith and all of the listed contributors agreed to the relicensing [2].

[1] https://www.gnu.org/licenses/gpl-faq.html#v2v3Compatibility
[2] https://lore.kernel.org/linux-block/ak0vnlWkLq_RVnR_@kbusch-mbp/

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 src/dio-offsets.c | 2 +-
 tests/block/042   | 2 +-
 tests/block/043   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/dio-offsets.c b/src/dio-offsets.c
index 7ea4097..594665e 100644
--- a/src/dio-offsets.c
+++ b/src/dio-offsets.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-3.0+
 /*
  * Copyright (c) 2025 Meta Platforms, Inc.  All Rights Reserved.
  *
diff --git a/tests/block/042 b/tests/block/042
index c2f1b71..a28f676 100644
--- a/tests/block/042
+++ b/tests/block/042
@@ -1,5 +1,5 @@
 #!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-3.0+
 # Copyright 2025 Keith Busch <kbusch@kernel.org>
 #
 # Tests various direct IO memory and length alignments against the device's
diff --git a/tests/block/043 b/tests/block/043
index c7b7a90..4dc7e5f 100755
--- a/tests/block/043
+++ b/tests/block/043
@@ -1,5 +1,5 @@
 #!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: GPL-3.0+
 # Copyright 2025 Keith Busch <kbusch@kernel.org>
 #
 # Tests various user space metadata offsets with io_uring capabilities. If the
-- 
2.55.0

