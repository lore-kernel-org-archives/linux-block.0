Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05531158DA4
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945615; cv=none; b=pvH8af5BDb0RWrKrBsVDQEYgz1frZUUjyffRwa/NvvWsSnshlfAUevi/Pw7H9ZqjcuEnvDxiFxpLdFG4zGBIxdFNVweasIQURlghh63Lu+zQ+6msmifMIpy1rwx6qmSSiNc8FBg6uec5aQtS6Z3YgJereFc2kqV6bR2srIOI+xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945615; c=relaxed/simple;
	bh=wEETruXenXXhFB3ZAUX4lMN5f17bmvYtqaqOJwjBWaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIJFlojsGhHIJfeAXYiXBwFt2PoWkbsM/pIROVCWEYkAqixFMh1kBnEpTZC5gB3LWHaZosExi1PN7/PJgI1KyO+HB6QPvJuywEBKid7AFpPr5xMHrTqvpWU+93QpIKUOPx3Y5Q22bdZpULQVwKFL3j3oPboOO/HdTvpZWvaZQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IjdluCOy; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IjdluCOy"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945613; x=1745481613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wEETruXenXXhFB3ZAUX4lMN5f17bmvYtqaqOJwjBWaU=;
  b=IjdluCOyKdZ3+U0KzdcA1taN9y7D30xkwVnOtxSE03xFwhnAQv9hiQRN
   /JNio+sPeEVeWh3PIiRe+nXUUZA/doILijVBClfXbIezk/50jiAYXuWPe
   j7NBLc27jkzN6rljfvbpQyqFbc3wVCUSkZtOLoaXocN/jwOSk3fZz+O8j
   D9dx9fGLH5M7Y35ktKZcsdahTO37+IQHuOQKPAB5iAzOTjbYvMEykzR08
   Gr7kWdHgPz+DZW+FqVRSOKr5YeKYyJGh6lURBgKyNcY2/lUBh/vnGGTQo
   IgtDo58LVrI9wsZjdYRUsnSIScXi0e887GO2aEOkLuy/7kbp0CBOHQdWI
   g==;
X-CSE-ConnectionGUID: RjtxjSCZTuy7v0DKgxasCw==
X-CSE-MsgGUID: LKzjQYnbRyuR9kFwOSANhA==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="15465320"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:11 +0800
IronPort-SDR: 2Pn4QhDTn2NjbsLHGgavQV/4G3mslQ7Xb+HallPsLFdaxTc0WN1nmfJRs+een3r006LOrH1djp
 IU4UPIixYxltBrHWYFP1bxN2URhybgOeHjpiRIUfOgdpDSiReyR0HfPo8np7mDFJ3PYK1ZqWht
 c53DyRDBf8F9rXdJxrrchvLQzUb4qsgmLPRTuJIl7Wif/LBsmv0sQ+1a9hdM8xN6IhjmgTc9I5
 /TVp+B8m3KhCYjuRiZIKV3uXlOIFCB7aM9g4J4ZDFGSwlg1mkNjo7s+7zpW1jY6s5SgVbxV7Ot
 NS0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:02:41 -0700
IronPort-SDR: GAVsd/wV3laXdCWYehhnAAsAtGEkkIXAGIRDibzbicOA019uihWuMZDXpGFqAk666VQLCvH6bf
 bImMlth5HdUwcWsvQynflBAwz5IORorxAS6K+ZVS3ep/wonY6WSgDGV3syf5XFLJBHynsCyxVP
 8ibwMfL/VmQfJc/cW2ltEtBXxQ76nRhMEoc3QChCiTcmCFJNMdDnFJ5aAeBeeCfahLXvD28W9m
 KGkHl603Xr+ZMRyBp4wQ4dpe7pEnDl+1Z4tyUupuvu37P3ejOZH7zWIgnwihI2VUUC1EW7x+9Y
 6WM=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 01:00:11 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 14/15] nvme/{rc,016,017}: rename nvme_num_iter to NVME_NUM_ITER
Date: Wed, 24 Apr 2024 16:59:54 +0900
Message-ID: <20240424075955.3604997-15-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To follow uppercase letter guide of environment variables, rename
nvme_num_iter to NVME_NUM_ITER.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md | 5 +++--
 tests/nvme/016                 | 2 +-
 tests/nvme/017                 | 2 +-
 tests/nvme/rc                  | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 736ab48..7bd0885 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -117,8 +117,9 @@ The NVMe tests can be additionally parameterized via environment variables.
   Run the tests with given image size in bytes. 'm', 'M', 'g' and 'G' postfix
   are supported. This parameter had an old name 'nvme_img_size'. The old name
   is still usable, but not recommended.
-- nvme_num_iter: 1000 (default)
-  The number of iterations a test should do.
+- NVME_NUM_ITER: 1000 (default)
+  The number of iterations a test should do. This parameter had an old name
+  'nvme_num_iter'. The old name is still usable, but not recommended.
 
 ### Running nvme-rdma and SRP tests
 
diff --git a/tests/nvme/016 b/tests/nvme/016
index a65cffd..d1fdb35 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -23,7 +23,7 @@ test() {
 	_setup_nvmet
 
 	local port
-	local iterations="${nvme_num_iter}"
+	local iterations="${NVME_NUM_ITER}"
 	local loop_dev
 
 	loop_dev="$(losetup -f)"
diff --git a/tests/nvme/017 b/tests/nvme/017
index 4f14471..114be60 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -23,7 +23,7 @@ test() {
 	_setup_nvmet
 
 	local port
-	local iterations="${nvme_num_iter}"
+	local iterations="${NVME_NUM_ITER}"
 
 	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index c018f7f..8762a56 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -20,7 +20,7 @@ export def_subsysnqn="blktests-subsystem-1"
 export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 _check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
 _check_conflict_and_set_default NVME_IMG_SIZE nvme_img_size 1G
-nvme_num_iter=${nvme_num_iter:-"1000"}
+_check_conflict_and_set_default NVME_NUM_ITER nvme_num_iter 1000
 nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
 NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
 
-- 
2.44.0

