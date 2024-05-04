Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CCD12B7D
	for <linux-block@vger.kernel.org>; Sat,  4 May 2024 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714810514; cv=none; b=et8PfQAngPGtPCZpQcANSLPyn4WnEWEzEOrEpm+KqhRcmntvVMFmVqOE5OKirvviO3uTHpS9SWs57AHmUiRHPNWY7AmfYt1MR9Ngiajl3fdaiF61R8G0vW7UpQmeJIZ399ybZ4MlW/fP+ldWradR5yB2UpejY+wp5kEZ2uaSMAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714810514; c=relaxed/simple;
	bh=t7G2Ho5WPgwkt3ZFuraW47O0HRzd+FaFO+yo28FOtDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJu2iGT8u/IYdfihItUPHMe8MlH2UVevxaeGMbriGUN6Pty+dzwDUV6YudFChwynn48STJwxZOonJM+NOKMmOSbU/cCbquRBI1yhuvH1qujpHxyR9j/1GIJ62gWJW7Pm1BGE95kVyfJwpqJwB6/92aFgBOvnG4feYRpiURxtPe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=M2xFXMiw; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M2xFXMiw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810512; x=1746346512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t7G2Ho5WPgwkt3ZFuraW47O0HRzd+FaFO+yo28FOtDU=;
  b=M2xFXMiwIEsTcRgxg6uaz952VUOD0l0jB8Ej3kBrYAJEV/bNvd8n2BMM
   l6x9XaUtwWManRoLJRf+YBHLWU0RShuhMl41jfUtTb+hADOW/QZyfZ5oD
   qk8der7Dizw5W3z72zjXaEa6yVE8Gc3pP2FOp8q34d+8eigVuEVvdycGE
   HUHUn3c72CkQTcBCG9tm9tcIkJ4YFZ9OSo1G4tCeQtcyPnZITjWY9Nuy/
   llWzvT8K1+LysjrQV37DXQ+93ZzOmJ79VilLDf7uZk2gWFV671QolJJTp
   kHByH1T+TBd2TS+wiaTgemnjnr2EOVO7DH6hMc6acfWPOMwkYfJSkNtNZ
   A==;
X-CSE-ConnectionGUID: 6ZLNBTP+SNSsFK/uzc+abw==
X-CSE-MsgGUID: 96UXMnAoT9qW+4o1WwMybw==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540358"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:15:12 +0800
IronPort-SDR: VrXKfzrk8cD8/NTLMxlvfP/pdoe+5/2i49WxCxbGATrYsLgGKtBH/Bj1v714fMtMAHMWAEWGTJ
 JbHYPVWr7KbDpyCEmYCQeGhYs4Kb5Jymazh4p0EmN54gp9zxT5GRjBZ5WJfLe6BxT4xmLTcoFW
 1eSsmUK3AUxLh5lzZ9/UxvWa7LOgIuGd3pbJHbZgPJ/nuxEhADz/g7UCD/ZBV7ZD8K4LuphthT
 eH0YL7ae3kH81qaE7cpIWth7/aoNagdERRTelctm7f3OeLG7XSISmjrxVz6Yqi1eSIiBUBiLht
 yQw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:23:10 -0700
IronPort-SDR: +VsxZNyaEtyXC2FUTDXm5TSjW5TLuz8wCYTv7CUL+KZNduTEprAmYkX/VO7HR2rylv44ElWF0Z
 eBxqn5/2yhb+ahLhY4we4IulCddX0WCaA/UASNwKJhxrZBaKU9IKpPvW5a1p8AAcXC1I+QLzJg
 J5I4grPWLBdmuzJ8GQcqQCEslrZ+jfdPa2breAqXcY4UYPbKMonUq3LMJCGPLsB6wpDCmZPiQF
 WKp0RdGXoMUYjzj6IBdxL0Fg0OOcNg2MIPOersX0mbTt4jIaogmc75RIi6MTUaCwXFEuJPtKmC
 wyw=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:15:10 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 17/17] nvme/rc,srp/rc,common/multipath-over-rdma: rename use_rxe to USE_RXE
Date: Sat,  4 May 2024 17:14:48 +0900
Message-ID: <20240504081448.1107562-18-shinichiro.kawasaki@wdc.com>
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

To follow uppercase letter guide of environment variables, rename
use_rxe to USE_RXE.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
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
index 6fc0020..c1ddf41 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -97,7 +97,7 @@ _nvme_requires() {
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

