Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C4F14885A
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833963; cv=none; b=W4FT6iyK3EsONFDflRNfY1qpB6Xx9fi4vMWhJjfnK8pWe3B/RYh6zc2zsXFft4TRsver9yye28QbUw/N5sy+BtGQ6pt1C2w3kLUgBUlBNwJrJrjISff/p0gKeEPfigQX/Ak+fttyJL3VNkSOHDGuTA/R4SBL4qDjeBRjXaLW/sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833963; c=relaxed/simple;
	bh=a3mYw5dZYWpBYbWDrYxR2B8qW/L5n4xS8Y3bHI8WHVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6GqblNjyhv5lN0+aK7crNffSX8zBbNGPSuqQfKPOqUno6ddHwT3YeT/uWWvMG09mhqejYYj13k7+xPkJDsBqubLM32+QLzld/FaWK8FkJF/WctgH1SkGXy0T7MipBz5F/AIMkBP1CV1aLWuXYEpqBzPia9O9UHsPtjqFDfy45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=COg16XgT; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="COg16XgT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712833962; x=1744369962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a3mYw5dZYWpBYbWDrYxR2B8qW/L5n4xS8Y3bHI8WHVE=;
  b=COg16XgTZq5xXj4YpIGART4UpvP5Ll6OX8lTCI1I+sKAXoThy4YI5+/O
   NIam58maefqk3CEhOA0Pi6XXW64kw3S0NyLEAlDjl8r9/sXt850kpZl8e
   4BMfxMw/A8DtI8L4JbBieCzmbqZ27pPtgBZyrPpdUg7oZLxosPT/8kn7F
   yEJsnA9VrqUJg1x6x8O6FK1/S5sL74tv4bxf4d5CzLOj3RD4RJdEeJBwq
   YQheb6WtIG7Wi3onlHoYHGTcIqpwpdt84vP9DQkVf2m7tVDbQsybRCBs9
   J712sGJCHvS9KPk6oet0oQmq4a2hPahMXK/LWPrSVajA8RCGZAyCUhX2+
   g==;
X-CSE-ConnectionGUID: V+stwwoCRZyOMUNGi9o5ug==
X-CSE-MsgGUID: MuTTxHGmTl6yTGd4VfcSfQ==
X-IronPort-AV: E=Sophos;i="6.07,193,1708358400"; 
   d="scan'208";a="13579884"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2024 19:12:38 +0800
IronPort-SDR: qxu10wHl7EqCpRizKLiNaUQvtcNs5cCwhFsDV9mLu7OSPRFeFJiaXBI8fg3mHFNWlRGyH6dq7u
 J5HGHJKG4yhA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 03:15:23 -0700
IronPort-SDR: sV749hVlOpjLYpNX1/Pd3VMuUlK0ngrRFfdB1j0RvYN0c6OTJqgZA4UrV6WBIMXt1WOl73hr3A
 RltqBp/MfExg==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Apr 2024 04:12:38 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests 09/11] nvme/{006,008,010,012,014,019,023}: support NVMET_BLKDEV_TYPES
Date: Thu, 11 Apr 2024 20:12:26 +0900
Message-ID: <20240411111228.2290407-10-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
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
NVMET_BLKDEV_TYPES and NVMET_TR_TYPES.

The default values of NVMET_BLKDEV_TYPES is (device file). With this
default set up, each of the listed test cases are run twice. The second
runs of the test cases for 'file' blkdev type do exact same test as
other test cases nvme/007, 009, 011, 013, 015, 020 and 024.

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
index a0c4096..0e1f142 100755
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

