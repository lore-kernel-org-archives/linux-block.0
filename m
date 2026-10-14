Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24EA3BCD3A
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997269; cv=none; b=ABQptHL1er00YNOu/7O30AEQmkZmKINebA5p+isai5Ww3T9nX8X4Fr65g7s2esATSODJSYbnAZMaHNX0GAMIVqIzncG4dcQ1GxuyODXYhgALIepehbIEkrcimgWkbjr0qX4A4G2l3b7iHJ030Zbrve/c2fUlySfSy8v2YGdJ8Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997269; c=relaxed/simple;
	bh=rV6sowayICs+hBck2urRahO6qK6U37Xj99KfdAA5oZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ik12R4Sgc1X5kFEOF/jRFPJxGbrJ5ZfwfZLm30gaww3a/Rbn0TJcKuWsBs6LmXS+38lFs3e64Cfy7KkIrc3G4wqZ2dDm1QyRpKXuzyZdwTVh1mXbtyVjgpSgV2NOqosWu5otTCTvua2GTBG6p58pG+CuFvxZ2vuNEmOKmZdcRZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXaIeQha; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXaIeQha"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so15613325e9.0
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791997266; x=1792602066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H5/SDgy5hTu2CD41XjtuGv88dGiFiZhvmfIjx1BZnns=;
        b=AXaIeQhaYTpeDumVhpumxuHd7bk8FbU+yb2URHX324bJtO1HsNTUvvfrnAuCUMhZ6Y
         r208dBv1XPCswJOA1lqhPj3soitB+GFdG4YKSGdnLutrENwAlK0GutIaWBOif+QQCr3J
         f9h4EQ23UgREyh+JQJve+3eXJz033g2M2EZ42buy/u+OBFwB2GsF8ZpT0rIkYfdENMyE
         mA3SAxMAOBhOWDT7mJb7YljA5IAexK8Kq0bVW/R2AuyLaKBxowwnaLR4j7bEMzTtbCsa
         F0ZytaryDU9RbVaYcdr2876l6D/phQ/jAPLRcNHFDfhxOcyIsyQZyaKy/9/6ZfzOJI3d
         eCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997266; x=1792602066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H5/SDgy5hTu2CD41XjtuGv88dGiFiZhvmfIjx1BZnns=;
        b=jTkogQ3ycAo9+uKGyUAuzB7bz/910DZKzqcP6Vq/cafqma413aOaRLpTrOJDaM+Psy
         GTPkyL+irVoKZcNoxMnyRlWOi1I8tYOkU1SF+AlnX12QLzaF+ddx4oGpfJ1pfLbVIa44
         tW2qf69cRPwW/8NFSwROaFDErSTd2E06zXTz8x6eFaHD4sRscEnDc/UqZl52rm8Vr1/L
         A+3sjwfUjLm0tATbpUden5LxhyenbHdOgLMIkGmOGYGLNphTDoakqChex6kQfoD63/L4
         RsnH5kJ7cewWiZICBbifvJTXYKn6KxkLwCRidB4KanGnCTprfMOIiXY8s4ZxbTwU9D6q
         eXlQ==
X-Forwarded-Encrypted: i=1; AKwUvBwWo/ms/ZB2R01qsktMMJRtiLK54lHk0nu+X7WOYjR4ZNALyBOgQCCzKKFtt0fg9hwsslGwG5tu1tgQOw==@vger.kernel.org
X-Gm-Message-State: AFq9FYK2uliNk80WJMLr7EYk0xA48xy8MESDrxypm+sjLTPJgYihXfep
	nPHnm62ZvyT/xsBT0TEaqCgn28LTKxgtY2bSL8Kv6K1C4TNTwTcYHbc7
X-Gm-Gg: AYBFou2Zsgf9ieDqx11+zpgycd0LqzGgSY+xcFjg+KPJ1oEVBw7ha9LlXmJESCIe5aS
	6catpfbIkgE3BA7bvW/U8JxEm5wTAnbAo7nRLxqKVpEeSBoD6edh3DSY1li8IyGUlaHOtg2cS9W
	vQyPOCuL87TyfD/XbTr3Mw2dChouPO1co2d3ILQPn7ZuqgFXXFLw7NC4UZUdiWWjVuycdu4Z0BP
	iYDFm85tUNRcCSrKAeG7u2osbuqKLX0ShfML/cxTMDRndQlx2UMxhrS8G/aIugTfTdK7+JeSUYO
	3lVNVC4dr4L+QsQbEe++VIP/BhzDc4tr1RGb959H2nEvqTkn2X4CI5WP27UZzxXpOKBsSv3D6Uh
	ALEKZyCBCuenYZ3q6Zbb12/ZnEs1dhhdP4XUHhTWn/ACENNtruuPhtpM2C9P/ELUVbQ8yg6RaLU
	oU8qx5qbIRcdRWe636SPupxyNqO9FIHKkQVKzdrjEk11f/uTMLwOkh0R5jbG8k4XBKQHO74m7Z9
	HBiWmHxb1xKSsfDLnOOZipAlNfCUHCiABQ6yquYTzAiyA==
X-Received: by 2002:a05:600c:620e:b0:4a1:7c56:d4e2 with SMTP id 5b1f17b1804b1-4a18e4b2aebmr348258765e9.16.1791997265682;
        Wed, 14 Oct 2026 10:01:05 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9a8a22sm5349415e9.5.2026.10.14.10.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:01:05 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests 4/4] nvme/073: test that nvmet rejects a zone report NUMD that wraps
Date: Wed, 14 Oct 2026 19:00:41 +0200
Message-ID: <20261014170046.2516-5-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014170046.2516-1-parri.andrea@gmail.com>
References: <20261014170046.2516-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that Zone Management Receive rejects a NUMD whose byte count
wraps a 32-bit calculation, while accepting an ordinary request. The
test runs on every configured transport.

The test fails on the unpatched kernel and passes with the fix applied.

Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 tests/nvme/073     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/073.out |  2 ++
 2 files changed, 48 insertions(+)
 create mode 100755 tests/nvme/073
 create mode 100644 tests/nvme/073.out

diff --git a/tests/nvme/073 b/tests/nvme/073
new file mode 100755
index 0000000000000..c6d3d29f4b906
--- /dev/null
+++ b/tests/nvme/073
@@ -0,0 +1,46 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Andrea Parri
+#
+# Check that the NVMe target rejects a zone report NUMD whose byte count
+# overflows a 32-bit value.
+#
+# Regression test for patch "nvmet: zns: reject a NUMD whose byte count wraps".
+
+. tests/nvme/rc
+. common/null_blk
+
+DESCRIPTION="reject an NVMe target zone report NUMD that wraps"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_kernel_nvme_target
+	_have_module null_blk
+	_have_kernel_options BLK_DEV_ZONED
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local dev
+
+	_setup_nvmet
+	_register_test_cleanup _cleanup_nvmet_zoned_target
+	if ! _nvmet_zoned_target_setup; then
+		return 1
+	fi
+	dev="/dev/$(_find_nvme_ns "$def_subsys_uuid")"
+
+	_check_zone_report "$dev" 64 15 0
+	_check_zone_report "$dev" 64 0x4000000f 2
+
+	_nvmet_zoned_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/073.out b/tests/nvme/073.out
new file mode 100644
index 0000000000000..ed6690e578688
--- /dev/null
+++ b/tests/nvme/073.out
@@ -0,0 +1,2 @@
+Running nvme/073
+Test complete
-- 
2.53.0

