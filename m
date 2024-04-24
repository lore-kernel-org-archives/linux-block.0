Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074BD158A21
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945613; cv=none; b=gYxuigMt6w9+rD88pvtRuSwpKJfZDgwRGjJqQtAIR+09tIzwBQukZ+fDjQ2idxBkVFW9lcF8SqHzJId77gcBB2p15SKB2lnXZ64Ytudn9IqdXqM6++FR59o3UmejLeMOCSrcybrLrfnBZip3JcqNQjGGy2VykIQ7xsfLxWBfih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945613; c=relaxed/simple;
	bh=IUIBD9g/6z1tK+pWEKQXbrEXQF5v0iVXjPf8Nl14PXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvIr9pEuCHoWCJiHvB8apAwQTRnE4dqThLiyI5tneqCxkzOL3v7wOmBWQd8QmecOYTD/tk5so1QJCaWyw1MrLNkselkSmULp9FWIwh0ew3ABncVXI7/LIcvI955c/I5Ongov2RmKSGoM7/L/gxneHTZTN+cIV//3MRNYNPLD460=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TZRjOpvT; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TZRjOpvT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945611; x=1745481611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IUIBD9g/6z1tK+pWEKQXbrEXQF5v0iVXjPf8Nl14PXI=;
  b=TZRjOpvTgRRHiTOsP6Qt7Cun/3ISCxLg7uuo9xLOASf5zndXCQwixw5S
   /ZBp+7gWQgfmg2NNdkAkgCDkGF8OvCdC8bq5oey69iTqdDLun4Ezt+SNo
   5pA3JFeSVWTh7tIodPGON6MpFpylISaO3UGADG8MU2wYmCIs37BrJXn/5
   Zdt0MnKX/ktjSs6jI7vE7Ijc0EuqCEvzM9z54Qf1ksdPpGKXXEAXqQnxX
   iOLbN+PAcSA0HRI5Q9ox72VVbbmRpm0J7ZgkHHYBu1hzJtrG2e5bBgPi1
   S3xHiOowNfx34qPe5msJ3UwZzYERB1qJ2q7YgzccQpI+3YxTq3+O2X2X/
   A==;
X-CSE-ConnectionGUID: 1UnKSCM4RaqGQE0MUUjjfg==
X-CSE-MsgGUID: 46w2WjGRTa6YeOzA/yMlMg==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14515711"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:08 +0800
IronPort-SDR: +eFUMMdgWDpjSWUPjChdx/cWJ5+LJr51n+UK84kc45OeTVQiBwZoklbmYsGWMhovtIFStbJxBB
 Fav8hwdsnbi+alnJL2vjiFVLwX7A6NQAuZYzEyZaLFSMWrVu2sMmCr11Ro/5NMdioFDEGhMSfv
 bZmjK4s6XQdxPBZPTY2NOQDjjZKE/wmlrcYOgrvNW6sQwR/OgCZbTXnPXiyvgRRVGkZkdcSvRl
 +FoWtAqTgf4g6iQlIkeHWpReDaq9M8BzRyJIEJbOKBeZ0BiGoDaZQY0OjqmhSDRVsbWOZPaAwO
 8ZY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:18 -0700
IronPort-SDR: RbdhU4trjlLp62PDqj3K9aSk+oPtYkuqU8XF2AZLzr0o6BLN6ZAWWJLzGDf39dWfw3yLwssOS4
 DC0mU3Pxvw9Su5AZsAKKwqF6rQqruK+sqeHntlLRm5/fU/Dy8XeBqokSPB1AyG0ea4rOFt1UDW
 NJknRXe43PqD0HgTBzhFJ6NHRnUDul0PoHrMeO47y4956tqqwUTLxKM3bj0NYmPIEwKebtG06M
 oln7pNwvIw918+xJJsof19lb+hfkkr3gq9zLKVjo7h4HHotx/EILEORHrcK7Fw58BmOmlx+Gfi
 m8Y=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 01:00:07 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 11/15] nvme/{007,009,011,013,015,020,024}: drop duplicate nvmet blkdev type tests
Date: Wed, 24 Apr 2024 16:59:51 +0900
Message-ID: <20240424075955.3604997-12-shinichiro.kawasaki@wdc.com>
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

From: Daniel Wagner <dwagner@suse.de>

There are various tests which only differ on the blkdev type of the
target. With the newly added feature which allows to control the target
blkdev type via the environment, these duplicate tests are not necessary
anymore and reduces the maintenance overhead.

The removed tests are covered by the other test cases nvme/006 ,008,
010, 012, 014, 019 and 023 using 'file' blkdev type.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/006     |  4 ++--
 tests/nvme/007     | 31 ---------------------------
 tests/nvme/007.out |  2 --
 tests/nvme/008     |  4 ++--
 tests/nvme/009     | 40 -----------------------------------
 tests/nvme/009.out |  3 ---
 tests/nvme/010     |  4 ++--
 tests/nvme/011     | 43 --------------------------------------
 tests/nvme/011.out |  3 ---
 tests/nvme/012     |  4 ++--
 tests/nvme/013     | 47 -----------------------------------------
 tests/nvme/013.out |  3 ---
 tests/nvme/014     |  4 ++--
 tests/nvme/015     | 52 ----------------------------------------------
 tests/nvme/015.out |  4 ----
 tests/nvme/019     |  4 ++--
 tests/nvme/020     | 44 ---------------------------------------
 tests/nvme/020.out |  4 ----
 tests/nvme/023     |  4 ++--
 tests/nvme/024     | 44 ---------------------------------------
 tests/nvme/024.out |  2 --
 21 files changed, 14 insertions(+), 336 deletions(-)
 delete mode 100755 tests/nvme/007
 delete mode 100644 tests/nvme/007.out
 delete mode 100755 tests/nvme/009
 delete mode 100644 tests/nvme/009.out
 delete mode 100755 tests/nvme/011
 delete mode 100644 tests/nvme/011.out
 delete mode 100755 tests/nvme/013
 delete mode 100644 tests/nvme/013.out
 delete mode 100755 tests/nvme/015
 delete mode 100644 tests/nvme/015.out
 delete mode 100755 tests/nvme/020
 delete mode 100644 tests/nvme/020.out
 delete mode 100755 tests/nvme/024
 delete mode 100644 tests/nvme/024.out

diff --git a/tests/nvme/006 b/tests/nvme/006
index c543b40..0ea679b 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMeOF target creation with a block device backed ns.
+# Test NVMeOF target creation.
 
 . tests/nvme/rc
 
-DESCRIPTION="create an NVMeOF target with a block device-backed ns"
+DESCRIPTION="create an NVMeOF target"
 QUICK=1
 
 requires() {
diff --git a/tests/nvme/007 b/tests/nvme/007
deleted file mode 100755
index cb2637e..0000000
--- a/tests/nvme/007
+++ /dev/null
@@ -1,31 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
-#
-# Test NVMeOF target creation with a file backed ns.
-
-. tests/nvme/rc
-
-DESCRIPTION="create an NVMeOF target with a file-backed ns"
-QUICK=1
-
-requires() {
-	_nvme_requires
-	_require_nvme_trtype_is_fabrics
-}
-
-set_conditions() {
-	_set_nvme_trtype "$@"
-}
-
-test() {
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
-
-	_nvmet_target_setup --blkdev file
-
-	_nvmet_target_cleanup
-
-	echo "Test complete"
-}
diff --git a/tests/nvme/007.out b/tests/nvme/007.out
deleted file mode 100644
index fdb3472..0000000
--- a/tests/nvme/007.out
+++ /dev/null
@@ -1,2 +0,0 @@
-Running nvme/007
-Test complete
diff --git a/tests/nvme/008 b/tests/nvme/008
index b53ecdb..838eb07 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMeOF host creation with a block device backed ns.
+# Test NVMeOF host creation.
 
 . tests/nvme/rc
 
-DESCRIPTION="create an NVMeOF host with a block device-backed ns"
+DESCRIPTION="create an NVMeOF host"
 QUICK=1
 
 requires() {
diff --git a/tests/nvme/009 b/tests/nvme/009
deleted file mode 100755
index d7b1307..0000000
--- a/tests/nvme/009
+++ /dev/null
@@ -1,40 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
-#
-# Test NVMeOF host creation with a file backed ns.
-
-. tests/nvme/rc
-
-DESCRIPTION="create an NVMeOF host with a file-backed ns"
-QUICK=1
-
-requires() {
-	_nvme_requires
-	_require_nvme_trtype_is_fabrics
-}
-
-set_conditions() {
-	_set_nvme_trtype "$@"
-}
-
-test() {
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
-
-	local nvmedev
-
-	_nvmet_target_setup --blkdev file
-
-	_nvme_connect_subsys
-
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
-
-	_nvme_disconnect_subsys
-
-	_nvmet_target_cleanup
-
-	echo "Test complete"
-}
diff --git a/tests/nvme/009.out b/tests/nvme/009.out
deleted file mode 100644
index 4d53a8e..0000000
--- a/tests/nvme/009.out
+++ /dev/null
@@ -1,3 +0,0 @@
-Running nvme/009
-disconnected 1 controller(s)
-Test complete
diff --git a/tests/nvme/010 b/tests/nvme/010
index 0417daf..9ea2561 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# This is a data verification test for block device backed ns.
+# This is a data verification test.
 
 . tests/nvme/rc
 
-DESCRIPTION="run data verification fio job on NVMeOF block device-backed ns"
+DESCRIPTION="run data verification fio job"
 TIMED=1
 
 requires() {
diff --git a/tests/nvme/011 b/tests/nvme/011
deleted file mode 100755
index bd29129..0000000
--- a/tests/nvme/011
+++ /dev/null
@@ -1,43 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
-#
-# This is a data verification test for file backed ns.
-
-. tests/nvme/rc
-
-DESCRIPTION="run data verification fio job on NVMeOF file-backed ns"
-TIMED=1
-
-requires() {
-	_nvme_requires
-	_have_fio
-	_require_nvme_trtype_is_fabrics
-}
-
-set_conditions() {
-	_set_nvme_trtype "$@"
-}
-
-test() {
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
-
-	local ns
-
-	_nvmet_target_setup --blkdev file
-
-	_nvme_connect_subsys
-
-	ns=$(_find_nvme_ns "${def_subsys_uuid}")
-
-	_run_fio_verify_io --size="${nvme_img_size}" \
-		--filename="/dev/${ns}"
-
-	_nvme_disconnect_subsys
-
-	_nvmet_target_cleanup
-
-	echo "Test complete"
-}
diff --git a/tests/nvme/011.out b/tests/nvme/011.out
deleted file mode 100644
index ebbb4f7..0000000
--- a/tests/nvme/011.out
+++ /dev/null
@@ -1,3 +0,0 @@
-Running nvme/011
-disconnected 1 controller(s)
-Test complete
diff --git a/tests/nvme/012 b/tests/nvme/012
index 37b9056..d0eb487 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -2,12 +2,12 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test mkfs with data verification for block device backed ns.
+# Test mkfs with data verification.
 
 . tests/nvme/rc
 . common/xfs
 
-DESCRIPTION="run mkfs and data verification fio job on NVMeOF block device-backed ns"
+DESCRIPTION="run mkfs and data verification fio"
 TIMED=1
 
 requires() {
diff --git a/tests/nvme/013 b/tests/nvme/013
deleted file mode 100755
index 91da498..0000000
--- a/tests/nvme/013
+++ /dev/null
@@ -1,47 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
-#
-# Test mkfs with data verification for file backed ns.
-
-. tests/nvme/rc
-. common/xfs
-
-DESCRIPTION="run mkfs and data verification fio job on NVMeOF file-backed ns"
-TIMED=1
-
-requires() {
-	_nvme_requires
-	_have_xfs
-	_have_fio
-	_require_nvme_trtype_is_fabrics
-	_require_nvme_test_img_size 350m
-}
-
-set_conditions() {
-	_set_nvme_trtype "$@"
-}
-
-test() {
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
-
-	local ns
-
-	_nvmet_target_setup --blkdev file
-
-	_nvme_connect_subsys
-
-	ns=$(_find_nvme_ns "${def_subsys_uuid}")
-
-	if ! _xfs_run_fio_verify_io "/dev/${ns}"; then
-		echo "FAIL: fio verify failed"
-	fi
-
-	_nvme_disconnect_subsys
-
-	_nvmet_target_cleanup
-
-	echo "Test complete"
-}
diff --git a/tests/nvme/013.out b/tests/nvme/013.out
deleted file mode 100644
index a727170..0000000
--- a/tests/nvme/013.out
+++ /dev/null
@@ -1,3 +0,0 @@
-Running nvme/013
-disconnected 1 controller(s)
-Test complete
diff --git a/tests/nvme/014 b/tests/nvme/014
index bcfbc87..1429180 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMeOF flush command from host with a block device backed ns.
+# Test NVMeOF flush command from host.
 
 . tests/nvme/rc
 
-DESCRIPTION="flush a NVMeOF block device-backed ns"
+DESCRIPTION="flush a command from host"
 QUICK=1
 
 requires() {
diff --git a/tests/nvme/015 b/tests/nvme/015
deleted file mode 100755
index b5ec10c..0000000
--- a/tests/nvme/015
+++ /dev/null
@@ -1,52 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
-#
-# Test NVMeOF flush command from host with a file backed ns.
-
-. tests/nvme/rc
-
-DESCRIPTION="unit test for NVMe flush for file backed ns"
-QUICK=1
-
-requires() {
-	_nvme_requires
-	_have_loop
-	_require_nvme_trtype_is_fabrics
-}
-
-set_conditions() {
-	_set_nvme_trtype "$@"
-}
-
-test() {
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
-
-	local ns
-	local size
-	local bs
-	local count
-
-	_nvmet_target_setup --blkdev file
-
-	_nvme_connect_subsys
-
-	ns=$(_find_nvme_ns "${def_subsys_uuid}")
-
-	size="$(blockdev --getsize64 "/dev/${ns}")"
-	bs="$(blockdev --getbsz "/dev/${ns}")"
-	count=$((size / bs))
-
-	dd if=/dev/urandom of="/dev/${ns}" \
-		count="${count}" bs="${bs}" status=none
-
-	nvme flush "/dev/${ns}"
-
-	_nvme_disconnect_subsys
-
-	_nvmet_target_cleanup
-
-	echo "Test complete"
-}
diff --git a/tests/nvme/015.out b/tests/nvme/015.out
deleted file mode 100644
index f854f0b..0000000
--- a/tests/nvme/015.out
+++ /dev/null
@@ -1,4 +0,0 @@
-Running nvme/015
-NVMe Flush: success
-disconnected 1 controller(s)
-Test complete
diff --git a/tests/nvme/019 b/tests/nvme/019
index fb11d41..d4cb926 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMe DSM Discard command on NVMeOF with a block-device ns.
+# Test NVMe DSM Discard command.
 
 . tests/nvme/rc
 
-DESCRIPTION="test NVMe DSM Discard command on NVMeOF block-device ns"
+DESCRIPTION="test NVMe DSM Discard command"
 QUICK=1
 
 requires() {
diff --git a/tests/nvme/020 b/tests/nvme/020
deleted file mode 100755
index 4993e36..0000000
--- a/tests/nvme/020
+++ /dev/null
@@ -1,44 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
-#
-# Test NVMe DSM Discard command on NVMeOF with a file-backed ns.
-
-. tests/nvme/rc
-
-DESCRIPTION="test NVMe DSM Discard command on NVMeOF file-backed ns"
-QUICK=1
-
-requires() {
-	_nvme_requires
-	_require_nvme_trtype_is_fabrics
-}
-
-set_conditions() {
-	_set_nvme_trtype "$@"
-}
-
-test() {
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
-
-	local ns
-	local nblk_range="10,10,10,10,10,10,10,10,10,10"
-	local sblk_range="100,200,300,400,500,600,700,800,900,1000"
-
-	_nvmet_target_setup --blkdev file
-
-	_nvme_connect_subsys
-
-	ns=$(_find_nvme_ns "${def_subsys_uuid}")
-
-	nvme dsm "/dev/${ns}" --ad \
-		--slbs "${sblk_range}" --blocks "${nblk_range}"
-
-	_nvme_disconnect_subsys
-
-	_nvmet_target_cleanup
-
-	echo "Test complete"
-}
diff --git a/tests/nvme/020.out b/tests/nvme/020.out
deleted file mode 100644
index 61be280..0000000
--- a/tests/nvme/020.out
+++ /dev/null
@@ -1,4 +0,0 @@
-Running nvme/020
-NVMe DSM: success
-disconnected 1 controller(s)
-Test complete
diff --git a/tests/nvme/023 b/tests/nvme/023
index a723b73..78dfb9e 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMe smart-log command on NVMeOF with a block-device ns.
+# Test NVMe smart-log command.
 
 . tests/nvme/rc
 
-DESCRIPTION="test NVMe smart-log command on NVMeOF block-device ns"
+DESCRIPTION="test NVMe smart-log command"
 QUICK=1
 
 requires() {
diff --git a/tests/nvme/024 b/tests/nvme/024
deleted file mode 100755
index cab1818..0000000
--- a/tests/nvme/024
+++ /dev/null
@@ -1,44 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
-#
-# Test NVMe smart-log command on NVMeOF with a file-backed ns.
-
-. tests/nvme/rc
-
-DESCRIPTION="test NVMe smart-log command on NVMeOF file-backed ns"
-QUICK=1
-
-requires() {
-	_nvme_requires
-	_have_loop
-	_require_nvme_trtype_is_fabrics
-}
-
-set_conditions() {
-	_set_nvme_trtype "$@"
-}
-
-test() {
-	echo "Running ${TEST_NAME}"
-
-	_setup_nvmet
-
-	local ns
-
-	_nvmet_target_setup --blkdev file
-
-	_nvme_connect_subsys
-
-	ns=$(_find_nvme_ns ${def_subsys_uuid})
-
-	if ! nvme smart-log "/dev/${ns}" >> "$FULL" 2>&1; then
-		echo "ERROR: smart-log file-ns failed"
-	fi
-
-	_nvme_disconnect_subsys >> "$FULL" 2>&1
-
-	_nvmet_target_cleanup
-
-	echo "Test complete"
-}
diff --git a/tests/nvme/024.out b/tests/nvme/024.out
deleted file mode 100644
index 76c3e29..0000000
--- a/tests/nvme/024.out
+++ /dev/null
@@ -1,2 +0,0 @@
-Running nvme/024
-Test complete
-- 
2.44.0

