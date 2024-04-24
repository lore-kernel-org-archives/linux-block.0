Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539DD158D8D
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945612; cv=none; b=B7m7AvewGhQt3jo4G9HH7QwJpayu+ornPjRxCw6E2T64aZbkKrC59UYH/JcE0ai9s3h7fOHXWkDmSFqieLNIpxdQ3z8S4rQ3TIKzDgWnirpCLwMRqNNKq0yBInrCbNrZZCvgk4Q4T6NfLGEUS98U7xG2Jpk6OsiFQ7m9z+8lCxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945612; c=relaxed/simple;
	bh=e3O80rkK1CVAuLxzt039J7MwxeMHq2ELp8O6/iaSTkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUUMSrlpy1t3IMPUnUB15ctrN74VXYtEQbcfXQkS5PMa3nWMQ04ppp1P5eMfaqzbtg4zZGkqlIDef1RE20b+F4v7+f0hZNWtFJv0Eg1wT6ANdCrqLse2yV3tUszN4kxsrfRqKL/lvOF3wGzWQzPIroi7kuCA5j4xb6gF0u4RCU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FzwCTONh; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FzwCTONh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945611; x=1745481611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e3O80rkK1CVAuLxzt039J7MwxeMHq2ELp8O6/iaSTkw=;
  b=FzwCTONhQvBFsk57v8FHM8p5NOVPEWsz/W4PaCpD0+CW1j4dW04RP63u
   ICHXClOagY+/Gqo3BfwoY6zFdq/QJPSP2efqrTDdibEiyAqkxth4vfxZa
   byVwa9oEF0vBHOVi+tN1WU+WWH7S10DrgvlWGa5Wra+roCOzB1ifQZNlS
   q3a+ekNpUDpzW30fidKVsBccgDBPTbi0jAX13okByifVe/NqWmo8mlBfI
   V0/5SvjdYP3s2MyvOzxFYxwszwJ3a6Eo1pTO8mf4Q23WIeYQhIoP6WB2K
   69+XwW7090B+08ISCfyuvIS+9ZmCn+VVhtJ8OjILIQm7CJFgJ0USw8rmz
   w==;
X-CSE-ConnectionGUID: FY4KImWxTPypghjxWYPaag==
X-CSE-MsgGUID: lhnIuKfIQ6q7AysHkXiCNw==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14515704"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:07 +0800
IronPort-SDR: fm8dE1IAZURMBb7j36O4dtnFlxv6Gut+ASMVhByCawj65xv9rZVT2CMFSToHo/aRtM0j64Id/5
 e0ubwKrCAqxu6Tx6tU0Qu9b1HEIm1NlSLMdsArJhD2X5zQFNYpxKy4Wz6NyERSLiwy/0dQ3Rh8
 6TM7Drs6t/k2kkAEt0GM7mv3TmDVZI0SZhoXJEUK3GR4ve/Bn55dfiqWAuk1unnKQN//NGZ1Hf
 HCM8+d2bSZpy9jvuNoX7lIAkzMDDO8NM+UIqPojXbilGIMxMsDP30gK2uNqN0ui7sQBybKU3nN
 Mes=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:17 -0700
IronPort-SDR: n8nDbOR+7WshaDgN5fl6gZMoqhKTX8niSXw6hoGP1JzWJBPdcyY8d7JT1hf00uuEWQ6UryubBh
 snv3ADs/QkbXTmRfNkW/YiG9I2mq8BdB9KtpoNKWJz8jzLU1e1hnSJjz8zqqauF7RLSqXfgk5J
 SlzlaW2zNzzNQg5lXcvu5WqQ8BTIVMDoYKRZ3nyO8BT4HIuDz93hFhcAD65dQqA5vmHud3xjSQ
 1NpZ5aI1VflViAqDVBm/fc6Ptq0LJcx/XizUPS8XJsW5R/Qthg7XExjYPJKeugE5WiO25yXXXW
 SpM=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 01:00:06 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 10/15] nvme/{006,008,010,012,014,019,023}: support NVMET_BLKDEV_TYPES
Date: Wed, 24 Apr 2024 16:59:50 +0900
Message-ID: <20240424075955.3604997-11-shinichiro.kawasaki@wdc.com>
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

Enable repeated test runs for the listed test cases for
NVMET_BLKDEV_TYPES. Modify the set_conditions() hooks to call
_set_nvme_trtype_and_nvmet_blkdev_type() instead of _set_nvmet_trtype()
so that the test cases are repeated for listed conditions in
NVMET_BLKDEV_TYPES and NVMET_TRTYPES.

The default values of NVMET_BLKDEV_TYPES is (device file). With this
default set up, each of the listed test cases are run twice. The second
runs of the test cases for 'file' blkdev type do exact same test as
other test cases nvme/007, 009, 011, 013, 015, 020 and 024.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/006 | 2 +-
 tests/nvme/008 | 2 +-
 tests/nvme/010 | 2 +-
 tests/nvme/012 | 2 +-
 tests/nvme/014 | 2 +-
 tests/nvme/019 | 2 +-
 tests/nvme/023 | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/nvme/006 b/tests/nvme/006
index ff0a9eb..c543b40 100755
--- a/tests/nvme/006
+++ b/tests/nvme/006
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/008 b/tests/nvme/008
index 1877d8a..b53ecdb 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/010 b/tests/nvme/010
index 34914a7..0417daf 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/012 b/tests/nvme/012
index e06bf8d..37b9056 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -20,7 +20,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/014 b/tests/nvme/014
index ff0ebfb..bcfbc87 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/019 b/tests/nvme/019
index 31020d9..fb11d41 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
diff --git a/tests/nvme/023 b/tests/nvme/023
index da99406..a723b73 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -16,7 +16,7 @@ requires() {
 }
 
 set_conditions() {
-	_set_nvme_trtype "$@"
+	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
 }
 
 test() {
-- 
2.44.0

