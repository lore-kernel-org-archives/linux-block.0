Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED56158A22
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 08:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945614; cv=none; b=ejGPzyKymSQW0U6BjVxFVwXnAoScuEQUAuJyEGz/xEY4jAHTPJc52KlON2J7V8NXmkt6wUXbINCKSY3bGBfVdyuLJt6dz2if0/kuZT2XMLIX0YCo1MliZfDtgP1MtiUrJb1mjCvpCPvG+OZ2HIFk9wDuiJwXATQn2DH08ovg5zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945614; c=relaxed/simple;
	bh=8xdHdVnq2DuNvi82OK9GytjO+E9jtZ70bPcGmaQ2f08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLLtBjg8HTMkOOhGQ4alAEyCIHhuQTPJrv9GV+jwOjXibgXlQkouqLLrNNUplwzpB3gf4LhJIDAFhpGj9kZOzvqAzC0ZurP0UF1lIDJzxTgEc1mbCe3wNzVVlL5NuBo8VuDcqAm4nVbteaOtCzl5UZx908UvjNZJtyuys/o3CVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fxG1fwa3; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fxG1fwa3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945612; x=1745481612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8xdHdVnq2DuNvi82OK9GytjO+E9jtZ70bPcGmaQ2f08=;
  b=fxG1fwa3PgQOajDbvRM8Pm93RUpn26nRgeIRGJsx9Xy/4crSgQrHefUc
   5JLqr3TXcYn8KwPcKlvnDUJMODyBwGaAAihTPGSVRaigBCaXeP7awdnfq
   G7fuDc6Via//jC9JrXI8MuQ40ZVxXX8XmLzN8lCXf3O1+ig3/qGf9umKp
   pVlb6yydMSlizyBEexlcmMDaC6E1tVogMBg5/6p9IaO02ogg4ZRb8KSRE
   VzWtsUfmQqFQHAv6BcHSW9Y0ZR97xGoy+KrjkvTYi7gUJoSNR8VdsAYV2
   aWYtvtJz42iHDTL7tw/sKcOfgmI8ZU7NXhkCKd+vd7fOgL47S1Dpku2yO
   Q==;
X-CSE-ConnectionGUID: BrS8ypeiTK+wM0zFwsOK0Q==
X-CSE-MsgGUID: YgmxmrzyTNO9seE3pYh8YA==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14515716"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:09 +0800
IronPort-SDR: UTpcGPlBSzwSvXWv3akAjNDFWu5oeP/juKv1DnP7xwx4iH/gOB/TDKgfS56RhX7SRaCa4uWXKY
 wWadGmiZ3kJ68BZpd+COWVV1IkElc06e6tnb0uk9oRaWFjQjl3N3vP53Mww72miwQ2fJ6E+qxu
 WF+CuKjzeqS02Xrcv6Ama2EPhncaLUxeu0QSBHEpjXdcdMlpnPtftgTqvaFBHEQp6WLD4vqcpi
 MJMvlm4aX6YyGoPsVpWXWFsjXub3uA6RjvlLdmulD8epU1GsQMdZg1Q02kmJE8wk46oB7TSS1Z
 ed4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:19 -0700
IronPort-SDR: 3ZbTAafxwQ4Xu/YkdmnTyMImm4/52wWERPKIemNrZ9bUE4R4ka3f0bql00Umq6k74qFvAqo3z4
 V1h4epcXg3GgOmA9nnRmBAonPEfQHb7VWKgsMQTcNuM1lcHbBbL5nBkyNq1qBJKp8fTSTxe4Fl
 9fbWqToX5ANZLGgoJwIu4ZXmY9Ven7Qjab1k1aMw6SRTFI8ou1RCgd6meXvD0WsMwsNPBdM4ln
 t0n0AB9iUE5c6WWWgRmv/PTUpblIWx0NKxcc3Nx18Vxg386JJSf3luwFJJLS8dXr4a87kqOo++
 fEE=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 01:00:08 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 12/15] nvme/{021,022,025,026,027,028}: do not hard code target blkdev type
Date: Wed, 24 Apr 2024 16:59:52 +0900
Message-ID: <20240424075955.3604997-13-shinichiro.kawasaki@wdc.com>
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

There is no need to hardcode the target blkdev type. This allows
the user to select different blkdev types via the nvmet_blkdev_type
environment variable. Also modify set_conditions() hooks to call
_set_nvme_trtype_and_nvmet_blkdev_type() instead of _set_nvme_trtype(),
so that the test cases are run for all blkdev types set in
NVMET_BLKDEV_TYPES.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
[Shin'ichiro: modify set_conditions()]
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
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
index 270d90e..d7add6f 100755
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
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
@@ -26,7 +26,7 @@ test() {
 
 	local ns
 
-	_nvmet_target_setup --blkdev file
+	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
diff --git a/tests/nvme/022 b/tests/nvme/022
index adaa765..0f2868c 100755
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
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
@@ -26,7 +26,7 @@ test() {
 
 	local nvmedev
 
-	_nvmet_target_setup --blkdev file
+	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
diff --git a/tests/nvme/025 b/tests/nvme/025
index 224492b..a171099 100755
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
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
@@ -26,7 +26,7 @@ test() {
 
 	local ns
 
-	_nvmet_target_setup --blkdev file
+	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
diff --git a/tests/nvme/026 b/tests/nvme/026
index 6ee6a51..7196c60 100755
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
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
@@ -26,7 +26,7 @@ test() {
 
 	local ns
 
-	_nvmet_target_setup --blkdev file
+	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
diff --git a/tests/nvme/027 b/tests/nvme/027
index a63e42b..b117cc1 100755
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
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
@@ -26,7 +26,7 @@ test() {
 
 	local nvmedev
 
-	_nvmet_target_setup --blkdev file
+	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
diff --git a/tests/nvme/028 b/tests/nvme/028
index 65c52a9..d6ffdd6 100755
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
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
@@ -24,7 +24,7 @@ test() {
 
 	_setup_nvmet
 
-	_nvmet_target_setup --blkdev file
+	_nvmet_target_setup
 
 	_nvme_connect_subsys
 
-- 
2.44.0

