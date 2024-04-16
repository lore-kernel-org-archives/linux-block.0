Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997573D38E
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263539; cv=none; b=qT1i9b9clbc0UkNXLsI05d7/AWlt0m8Ms2jjS5tloYAE0TSDP0dz0jP0lKyLzL87QLTUonjGnlNqKLBF3b+N3Wuf50ZoOijp8wis8POZxesHCMWRBXEtxecAMUtzyzrps+KKVbGoSIu+YiqkK9TZlf20CAjmrhRw71mdrxeQspA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263539; c=relaxed/simple;
	bh=wKrzhkD2vg/WvRStbcCDepGHYo8qCYqridvUcZHyY20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxhtHbVUvuhBIEQaKVW2dXbvNriTGXWbjhNGfMzH2W9ozNGZHkchQvoBc9O9mBE+SxXIPVKlp8SvZcx/HBqmsgBx/u/TYBV8SUSEcszHcghEjjxwnlxPao1vERl4uAAptlnyiWIAQC5MDy84pkNkUIU/O29TnVyPjrLRuvMgWyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qZt+LTXh; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qZt+LTXh"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263537; x=1744799537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wKrzhkD2vg/WvRStbcCDepGHYo8qCYqridvUcZHyY20=;
  b=qZt+LTXhoed1mm5QaItyoi6qrOtVfMINcNBN9QWwc3AGCXRUbZA8sI37
   Qzsj8y0RIFfktF0opod7YvRD62anTI4PzN7t9j5m6NHNkLnCFjfo1DDMh
   mahDNrl1SmaCOpmonBRSveLL8BAIYJfGGVYrC5wEyupK78E4kPd7808vt
   9dmdCiNIaKeq0bVz1ufqp3jwFxRrVIuDq6x/3TA5OzlktITJn5ctA+wMe
   rUBeFGj6oU9cklmHDPI6gK5TCGi0JlTXfowwcG6V2KArRir2Lyqv5F5px
   niNnPUQ/xniF8wKGq5x9qlUhHb/8ZiAxBNuV+NFmAS1qImBiot1EHM5/+
   g==;
X-CSE-ConnectionGUID: BaTuNwykSPSx42lqrtsOPg==
X-CSE-MsgGUID: wFkJbbJuT9y6IcbEZSjR/A==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14322625"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:32:17 +0800
IronPort-SDR: 7vO60s5qHzLVQN/2T/oTxEednf1A7z8WKguG4xX6NR84f25bxYlFbdkX8PZj4hQjMaXUVQorm0
 p/wdIFb7O16Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:34:56 -0700
IronPort-SDR: OCYt+4IGiSmW3wki+5ltkt26okeUcFju6kRV0lM8/gun52l2xgB/5S0VtpWoq84xfNS1zYnHn3
 fwvvXV7mFrzGwr9qi/vJX62Rgk8ZgcDaB/H+/F9Q3KhjPhb4M9Z5BC0ekm6sjNOzwyQx2BHO6A
 n2/3O5y7BvZoBGOCz5wyE1rOFyG6uhvEPea+1d8MmNu6aeWqN4J9vYTfGUdTnzoj6gs6HahRKu
 PDWKryHhNyvMeij4W0LynrXUobiLl9OfJ20wzxuLkTN/q2WTuXouhdGSE1dWgNAwjVE0VygclC
 Ats=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Apr 2024 03:32:16 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 09/11] nvme/{006,008,010,012,014,019,023}: support NVMET_BLKDEV_TYPES
Date: Tue, 16 Apr 2024 19:32:05 +0900
Message-ID: <20240416103207.2754778-10-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
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

