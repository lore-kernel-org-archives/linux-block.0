Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001DB158DA2
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945615; cv=none; b=LzJzItg/ed6aW0hy8/4FttfpJ8gvDDWtFT1fnUV9krjIj83H16+mS3fE6AklBtBV5aGYejvQevOOxrVV6nf/xB5+ucwlUHJYBcdAjyswYZfR2EM4sidK4ISpNzpj971nJA78uXD6LgVDB+/brXyrQhWgALGWHzAWoBt9tMAmJjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945615; c=relaxed/simple;
	bh=sSC9duX72FifCTm3ELiWm9Q8X/xeNDFYZA8WyilwbPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIBWrRhDJXDnvi1kRrYL0fHEaLkH/0aVgLRZZt5oWlehk7ExxZvLewVZLKwL2yHLDZp68xUAa5JRapQgDCQs8pQWf9lCu0OEcQFtFUyNVFTMnAZulcIlRLQKVRLEy3Omwf8Xu0hi1aihWP3IoKYya+VYJU7nyLY46uwBFJATPiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JJQN7GQs; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JJQN7GQs"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945613; x=1745481613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sSC9duX72FifCTm3ELiWm9Q8X/xeNDFYZA8WyilwbPA=;
  b=JJQN7GQs5uxiQZXRgiOPllUFw7PZVVZYK6QPSh9Jy9Q2g7z5+nICByGi
   3zp0wFXkXFI1RD2PIg41Bjyf9vuXnZ5XfPRQOaJkik1p1iEsTO9POYMbs
   fUAjiPtiblyfs5FJsPZtkGHhOTaCODkpijEi5ZKkXzdLkE2UzC6hi4NuL
   eOTmkFFqFXP8Zkdykd1dKuiCdbwqLXiTIoUgiYiFrVDO9WUNHPpYg1dcV
   oPHrAln6W7zBGRVZ5lpZV2unyPuKXPe6wsi2cOgILJXPuEhc++FIW5Dk2
   tN3lNkbaPVkJHM+FZwzSgsCgpJxxB1PWvC9b06e1A8xnQU2Jpvv/UNIyh
   w==;
X-CSE-ConnectionGUID: 5Nfehy6+QgaMZ9CrMn4SqQ==
X-CSE-MsgGUID: Hdr/MklGS1iGnf0rmubhrA==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14515732"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:12 +0800
IronPort-SDR: X/fAv3dqSlQrJ0HuUGAt6teCIFZQBNfgmtbvcT5uQNaITbzIFXFVXbbh0olqoUmBHEmgREO8cM
 8rAQvhzKyVs+p1mQV+9ZNs7qMjin5psBmxCUBgd3SQXuVJLVF7rCjpMr7xUC+0Xzpt2wA6ns3D
 h1Z5JmCncvgkk7cuI6g6rtxG+sPxBJzjU9ng/uBpzlfD/AL+VDSKG6XiYmnPeAKOhJhO4zILyY
 RU3mno4t1mF2TJjdqCUZe7Rpo9/jZw66QJovgUzFzIKzfx1/KTX2ioZe1JImWou9OH6Zlt/VKk
 9vA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:22 -0700
IronPort-SDR: MlOKba1Lp9hfmyqNfUobT2+/JTJBQNiAdMH4tJM+WV86fNGZqX2T0vMBObHYNN46iS1ZdaTs0t
 9lAM/msyFXlje5E8D1IWkgHXjhyFUEs3fZIeWtoxuBJeEnLZqu/RMC8ij8YThpUz/Lm60cn+st
 dJUcb3ZdaKSF0+Gv2cYyVXovUJLK+EuKHR8sr0wOdy0vSE+u8iJ1NZH0Obv8ClXv5CxEVl7mfw
 GsIHV/OnCpQRyR6IUi97M9i8VwYDvNK+3Povc/hBPOildynX6Tx/TUGebQRigDIi3PfFGiQKsw
 zEk=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 01:00:12 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 15/15] nvme/rc,srp/rc,common/multipath-over-rdma: rename use_rxe to USE_RXE
Date: Wed, 24 Apr 2024 16:59:55 +0900
Message-ID: <20240424075955.3604997-16-shinichiro.kawasaki@wdc.com>
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
use_rxe to USE_RXE.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md | 6 ++++--
 common/multipath-over-rdma     | 5 +++--
 tests/nvme/rc                  | 2 +-
 tests/srp/rc                   | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 7bd0885..968702e 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -132,9 +132,11 @@ NVMET_TRTYPES=rdma ./check nvme/
 ./check srp/
 
 To use the rdma_rxe driver:
-use_rxe=1 NVMET_TRTYPES=rdma ./check nvme/
-use_rxe=1 ./check srp/
+USE_RXE=1 NVMET_TRTYPES=rdma ./check nvme/
+USE_RXE=1 ./check srp/
 ```
+'USE_RXE' had the old name 'use_rxe'. The old name is still usable but not
+recommended.
 
 ### Normal user
 
diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index ee05100..d0f4d26 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -12,12 +12,13 @@ filesystem_type=ext4
 fio_aux_path=/tmp/fio-state-files
 memtotal=$(sed -n 's/^MemTotal:[[:blank:]]*\([0-9]*\)[[:blank:]]*kB$/\1/p' /proc/meminfo)
 max_ramdisk_size=$((1<<25))
-use_rxe=${use_rxe:-""}
 ramdisk_size=$((memtotal*(1024/16)))  # in bytes
 if [ $ramdisk_size -gt $max_ramdisk_size ]; then
 	ramdisk_size=$max_ramdisk_size
 fi
 
+_check_conflict_and_set_default USE_RXE use_rxe ""
+
 _have_legacy_dm() {
 	_have_kernel_config_file || return
 	if ! _check_kernel_option DM_MQ_DEFAULT; then
@@ -396,7 +397,7 @@ start_soft_rdma() {
 	local type
 
 	{
-	if [ -z "$use_rxe" ]; then
+	if [ -z "$USE_RXE" ]; then
 		modprobe siw || return $?
 		type=siw
 	else
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 8762a56..24eafd2 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -103,7 +103,7 @@ _nvme_requires() {
 		_have_driver nvmet-rdma
 		_have_configfs
 		_have_program rdma
-		if [ -n "$use_rxe" ]; then
+		if [ -n "$USE_RXE" ]; then
 			_have_driver rdma_rxe
 		else
 			_have_driver siw
diff --git a/tests/srp/rc b/tests/srp/rc
index c77ef6c..85bd1dd 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -51,7 +51,7 @@ group_requires() {
 	_have_module ib_uverbs
 	_have_module null_blk
 	_have_module rdma_cm
-	if [ -n "$use_rxe" ]; then
+	if [ -n "$USE_RXE" ]; then
 		_have_module rdma_rxe
 	else
 		_have_module siw
-- 
2.44.0

