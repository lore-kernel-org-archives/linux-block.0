Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84609F513
	for <linux-block@vger.kernel.org>; Sat,  4 May 2024 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714810510; cv=none; b=NLQ2lJ+ASy0Nf//JbbDf1f7fmbEYHBuJoXZxARTYDds7VwqtcFmH/Guze/QZUu6Esk+9prgBrItG8t2FkFB6l2SqupplY2bP3+Cs1ziqRuJMV/fC6k9ZK5HNMfLrk5SjIgE/w5OPJMRUXB3y8xBAm8ZtNG66AbdOiakgFVHRASg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714810510; c=relaxed/simple;
	bh=uXIK6imN9fYvo8/acUzILbanjCM3PXn0aD3YzOkwU5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdYaGt2pNdrAELa4YBRxNP9plIoqjkXD8GQsvFSs4J2ywtGB04vNVdYZA0q+ZWYynVsVKtMeQZG8YSKoazZr6BdnC6IihKti2XWHFwY5qHr/W1Z49sAdNH/iRcpNqgcf1rH/LUmvAiVciYXTSMxSNxqAHE2WZRmK+es6YJZZbf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=V/bDBZqw; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V/bDBZqw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810508; x=1746346508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uXIK6imN9fYvo8/acUzILbanjCM3PXn0aD3YzOkwU5Q=;
  b=V/bDBZqwjFsOxsFIiurgEp2NrvPQx8vlN+Vl8ZmduuLDjMchOaRzxByt
   Ctn1btrN78/KBpUE9EZgwjPwGIQLqH0bck/ZVZr9k0HkKvAzQwcQClpaV
   RxrFIWxH0Z5tKC6sbJIPxeJE9opPfPzoKAGmEWsOlrzz6mNYm7F/sSmwo
   9AuBzOzZyffvC7wIhx72LmXZG5/SIT4Wiev8xS3r30OBmCNFKAn4niSut
   AjkfnKva1jS5dIZJasEboy6Mhr5rmqP3kDg3vfUBMbuNK62QBuuiRB4H5
   FFfGbC+85w4veBOQorbw7RYXRcmmQ8PQ3xcNi6J9rXiKhZO/J2eQDMxPk
   Q==;
X-CSE-ConnectionGUID: gnMBVSSASV+dhq1/y37Qng==
X-CSE-MsgGUID: wWt6GKMESEaGho8bPtpqdQ==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540340"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:15:07 +0800
IronPort-SDR: Tmkuh435yhPHvXizQE7v584hVOy6rQIE586VriQZVLDHiMHe+MC2ttgbv5aeN4HRCZJprsgLEd
 cH4LKWtGGG+WpdvEhow56YcL8q2QPV1q5WrXieExX+z7xcErOqN5CFqdu5L3jK7D3pKl/xw297
 bPAH+QvRzdReVpyDpZbql01VbkgoyAR7xWTefQzkui7N6V14fCqFTTuCsAxjOoG0U2l8JGtlNv
 YUGoMDP11SWhG5lkVuajCZjGLoXHQ/IzgaDNWmvP1bjpxvky28eQ+15qnqAqrtemldcrTZ6Vcj
 FNE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:23:05 -0700
IronPort-SDR: 8qgFDOK6lyoEOeYv/lnaBhVIU7h7x/kfpdZGHdOOL49y8UlZGoZbgpOHN24t3QpPps9I/aXbvO
 R+5lMeGd+N5TCrrQdiywHOSvTFGhkMvtHVaeMQdgY4/cKT+O8tX9sGbgmDWk+AhIwFZe8GhKJc
 tlBqKsWOxpxn81tw6UFMrkL7c3xEI84jN2VXjHqTT2TDUeV42OURmR/Mv5TKzLZI58EZZSkrJb
 PyI4AOiSuczfmnFkVTMgVwISoJeX71dSJkRK7DbiMsKPJeiLR7gKGxyxa9yMLfhiXOYbqQNctK
 LNk=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:15:06 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 14/17] nvme/{021,022,025,026,027,028}: do not hard code target blkdev type
Date: Sat,  4 May 2024 17:14:45 +0900
Message-ID: <20240504081448.1107562-15-shinichiro.kawasaki@wdc.com>
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

There is no need to hardcode the target blkdev type. This allows
the user to select different blkdev types via the nvmet_blkdev_type
environment variable. Also modify set_conditions() hooks to cover
combinations of NVMET_TRTYPES and NVMET_BLKDEV_TYPES.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
[Shin'ichiro: modified set_conditions()]
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/021 | 8 ++++----
 tests/nvme/022 | 8 ++++----
 tests/nvme/025 | 8 ++++----
 tests/nvme/026 | 8 ++++----
 tests/nvme/027 | 8 ++++----
 tests/nvme/028 | 8 ++++----
 6 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/tests/nvme/021 b/tests/nvme/021
index 270d90e..43d85e6 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMe list command on NVMeOF with a file-backed ns.
+# Test NVMe list command.
 
 . tests/nvme/rc
 
-DESCRIPTION="test NVMe list command on NVMeOF file-backed ns"
+DESCRIPTION="test NVMe list command"
 QUICK=1
 
 requires() {
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
 }
 
 test() {
@@ -26,7 +26,7 @@ test() {
 
 	local ns
 
-	_nvmet_target_setup --blkdev file
+	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
diff --git a/tests/nvme/022 b/tests/nvme/022
index adaa765..6b3a8fb 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMe reset command on NVMeOF with a file-backed ns.
+# Test NVMe reset command.
 
 . tests/nvme/rc
 
-DESCRIPTION="test NVMe reset command on NVMeOF file-backed ns"
+DESCRIPTION="test NVMe reset command"
 QUICK=1
 
 requires() {
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
 }
 
 test() {
@@ -26,7 +26,7 @@ test() {
 
 	local nvmedev
 
-	_nvmet_target_setup --blkdev file
+	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
diff --git a/tests/nvme/025 b/tests/nvme/025
index 224492b..529fd0b 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMe effects-log command on NVMeOF with a file-backed ns.
+# Test NVMe effects-log command.
 
 . tests/nvme/rc
 
-DESCRIPTION="test NVMe effects-log command on NVMeOF file-backed ns"
+DESCRIPTION="test NVMe effects-log"
 QUICK=1
 
 requires() {
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
 }
 
 test() {
@@ -26,7 +26,7 @@ test() {
 
 	local ns
 
-	_nvmet_target_setup --blkdev file
+	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
diff --git a/tests/nvme/026 b/tests/nvme/026
index 6ee6a51..6dfb9e5 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMe ns-descs command on NVMeOF with a file-backed ns.
+# Test NVMe ns-descs command.
 
 . tests/nvme/rc
 
-DESCRIPTION="test NVMe ns-descs command on NVMeOF file-backed ns"
+DESCRIPTION="test NVMe ns-descs"
 QUICK=1
 
 requires() {
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
 }
 
 test() {
@@ -26,7 +26,7 @@ test() {
 
 	local ns
 
-	_nvmet_target_setup --blkdev file
+	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
diff --git a/tests/nvme/027 b/tests/nvme/027
index a63e42b..06fccab 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMe ns-rescan command on NVMeOF with a file-backed ns.
+# Test NVMe ns-rescan command.
 
 . tests/nvme/rc
 
-DESCRIPTION="test NVMe ns-rescan command on NVMeOF file-backed ns"
+DESCRIPTION="test NVMe ns-rescan command"
 QUICK=1
 
 requires() {
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
 }
 
 test() {
@@ -26,7 +26,7 @@ test() {
 
 	local nvmedev
 
-	_nvmet_target_setup --blkdev file
+	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
diff --git a/tests/nvme/028 b/tests/nvme/028
index 65c52a9..c35d0ac 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
 #
-# Test NVMe list-subsys command on NVMeOF with a file-backed ns.
+# Test NVMe list-subsys command.
 
 . tests/nvme/rc
 
-DESCRIPTION="test NVMe list-subsys command on NVMeOF file-backed ns"
+DESCRIPTION="test NVMe list-subsys"
 QUICK=1
 
 requires() {
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
 }
 
 test() {
@@ -24,7 +24,7 @@ test() {
 
 	_setup_nvmet
 
-	_nvmet_target_setup --blkdev file
+	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
-- 
2.44.0

