Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8D717BD2
	for <linux-block@vger.kernel.org>; Sat,  4 May 2024 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714810509; cv=none; b=kuc1m2+qqhllB7tDoP5NP2cKt2FW/uGXAfU/wjyuQ+OHw0ZqpRU33lgPd/HODhL8R4ZeEC8F+DAd+zEKSj8wWREDATpWnIAinn9q7jiN6Okb2dWm3WD+5wUTDvPC0hKfThdYJaFwTA0WMp8HTnu5UFjrsNYj/wwBgLxAPaYNjJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714810509; c=relaxed/simple;
	bh=XYvDNN1Sux58Wm3P/1FIy8hcWCk38ZaWmhT5eJfDlFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CK7HYSaw7XquOSuxk/UUbAVuIo1EcglJ8HQRm3nCYnfO+oAWxrzhgM8FsnqXxm3wwoqcbNYHoZVGit0dOx1QgnG77Q2+EXqYuhjUN9ehkrnMITXG4iTD39UZ1vup2iHIwipVntD/AmPS6UbVwozEiW0ffYzlpSn4QkteaaQ4X88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mYT2m5Xl; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mYT2m5Xl"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810507; x=1746346507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XYvDNN1Sux58Wm3P/1FIy8hcWCk38ZaWmhT5eJfDlFE=;
  b=mYT2m5Xl2QuakQ2zA9wZXDS9MlqffkefhJ35cGh4ptlX2rDWSyAGR5SV
   T5wPEibjS9PV8bFtb/zvwZ3aoMCQ3DXxgLfo49czNgvoLpohvM4PaEnaa
   lx9FeCWkZ53AyQFeBZS1HGis/OQm9FFrx2nhFy9t7SqKZtH4OUvCLHZSO
   K8oWuV1veVmzQ4uJVDWFptzsLg+cQyZXn+3HYBn9R5/jQ+6fmo0+ieZCr
   MmzsX8rIlUmpvt+C/7+mCh6WdxzXfV0FwFCGI5ULDf9vik/YOCNKo/QQI
   Aklty0CkYM1vdOYkiTZxvFQ2KIqDfy4BHLOrXk3DjB+Nx4cJjTyygKvZr
   Q==;
X-CSE-ConnectionGUID: ljg5VibbRwqKRmQvHJvS7Q==
X-CSE-MsgGUID: 8w9sCv88Tgmp6P4l+q1SFQ==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540336"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:15:06 +0800
IronPort-SDR: Kuth18AwXRizdpcl+M9MtF8KxYZo4y3kFafARENaUSzSboRzc5jbVTmCKoRn/1p/EqTCp9fE7k
 +lTt78TfVOeZfuKfSjWZQUzgoiXTMzxhEBrB43zipQxKwNDugLxCT7X2gU2V9ei86fr7h+GNqb
 4zBvwO+DDzPrt+c+17fbId4KkZ84ej1dV1tzX36pBTKkSbV4uvq84H06CjIGWjCo3HQdyKonQM
 XKwT6TMXlDGtUVEp2bh3jjYzv/rqHZ1ViOUG1WWQxjX8O/faZwPSR4H7EZ1+FEupf8dBBrWqOQ
 C+E=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:23:04 -0700
IronPort-SDR: sami3499jSAOGC3HyzwU+OB6oEsrO5ZzT/w1xgXYGkUS6IcLFv4gisqMFizlBHcNiluN3twwdU
 /QhJxndRAZgnDC+btgIPpZ5sqBjLTn4iAqlYMDrBP6ZwdqOsn4awipXzyH5o+8sfAeuVWIWJu7
 mdX1NaIihQ2qxnNdA8dm7YaRijdsfvuJqMHyudKxsTDfAeuP4iROVhGLt6U11aZ8GsitYBYGMd
 t8PgKPZv0Q/akxdETYL1U49ZulB5FwgEwCmbZAbgG95YlFFce/IxvDSM337eW2MId/A9Jsz8of
 sXA=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:15:05 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 13/17] nvme/{007,009,011,013,015,020,024}: drop duplicate nvmet blkdev type tests
Date: Sat,  4 May 2024 17:14:44 +0900
Message-ID: <20240504081448.1107562-14-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
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
index 3f9d209..2b5b2e6 100755
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
index 247850c..702c576 100755
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
index c16587f..524203d 100755
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
index e6674e2..f9bbdca 100755
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
index 571c6f4..48d7408 100755
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
index 501256c..9eff03d 100755
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
index 3c43c55..a232246 100755
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

