Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6642136C087
	for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758109767; cv=none; b=oMXoPHjznmqCDbSZ5PG0LOV0nZQ95caOUS+4gyGuY+gtnBPRVKZE9GIFYDaZba7umwyDEa0bQ32AFh01Ath9Vxp8RWDpQ+VNM7J0x8uIGeNDcmf36XuZqYEZIGul6a+XhltXmA2BJ1OlmXgKx17nDKw+olFuQP/ziabEwSZsrzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758109767; c=relaxed/simple;
	bh=xELhwCGzajySFfy82+2pjMvdOXS9FsRkMB8JlQImVbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEwsY5wmF3QckIN8zKW4YFUzM40JcTo2RV96GxLuvFHeKedCEempGfVAYvaBUT5apC1lmLLnoqCMjjyDPz+fohJUylwaB5kWy+7lj3UlOUpHCX/xlKKMyuBSG2p9kcxOktUTCSK++1mHBrfeHxIZRWwLrECryNfiI84UuMdAsnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Y+NTxGTd; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y+NTxGTd"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758109766; x=1789645766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xELhwCGzajySFfy82+2pjMvdOXS9FsRkMB8JlQImVbA=;
  b=Y+NTxGTd/aCnru5Jj6/5n1UEAT/9gigf6KY6XWkzzySqYhyrOGgWwxbf
   1CQHePDVeqTR91/K26nz7Nt9EHTkC5rROB+SOayh5BiMmn9MHe1r+TJza
   N+ibmUEyERpg5WmBCgAqmy1x+DgfRY5kWNppGaUl/bM8JpQxxfGecQ/fJ
   bYUgHBSWnGaRHqq48eWDX3ugSTpUbh8Qm9a+QeyWIRrrxdOzOKpyS3e44
   FQjGs8DHAdy2Wy1gSKGXpDQJWZFVUZdKqrWzNUz/RRg4porrGifH6UoH5
   bZffcwbNrR8caVW3B50fkiH2OuukioYCy7jHIrFnc37a270twsKD2vddQ
   g==;
X-CSE-ConnectionGUID: bUbLP1WhTvyUntTviIz1KA==
X-CSE-MsgGUID: OcigniyyTtGryArcjNYmkg==
X-IronPort-AV: E=Sophos;i="6.18,271,1751212800"; 
   d="scan'208";a="122448617"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2025 19:49:25 +0800
IronPort-SDR: 68caa045_N16wJpPvbkyCZD/1XdboGVXw8X7zbvDg+f1h9zKnJLArre3
 ETz9N6eVOBlGgkeqWz8PaXsUl83EAlxpL8pdNfQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 04:49:25 -0700
WDCIronportException: Internal
Received: from dr34yd3.ad.shared (HELO shinmob.wdc.com) ([10.224.163.71])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Sep 2025 04:49:25 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	John Garry <john.g.garry@oracle.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 3/5] new, Documentation: describe test_device_array()
Date: Wed, 17 Sep 2025 20:49:15 +0900
Message-ID: <20250917114920.142996-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917114920.142996-1-shinichiro.kawasaki@wdc.com>
References: <20250917114920.142996-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous commit introduced the test_device_array() function which
allows a test case to use multiple block devices. Describe how to
implement it in the 'new' script. Also describe how to specify test
target block devices in Documentation/running-tests.md.

This reverts commit 5623805f5a07ea0be4c3916ec68301c469aee843.
---
 Documentation/running-tests.md | 14 ++++++++++++++
 new                            |  9 +++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index a42fc91..f037634 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -42,6 +42,20 @@ If `TEST_DEVS` is not defined or is empty, only tests which do not require a
 device will be run. If `TEST_DEVS` is defined as a normal variable instead of
 an array, it will be converted to an array by splitting on whitespace.
 
+Some test cases require multiple block devices for single test run. These test
+cases implement a special test function test_device_array(). TEST_CASE_DEV_ARRAY
+is an associative array which defines test devices for such test cases. In this
+array, each key represents a test case name or a regular expression to match
+test case names. Each key's corresponding value is a list of devices associated
+with the test case. The test cases run for all of the devices specified in the
+list. Again, note that tests are destructive and will overwrite any data on
+these devices.
+
+```sh
+TEST_CASE_DEV_ARRAY[md/003]="/dev/nvme0n1 /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1"
+TEST_CASE_DEV_ARRAY[meta/02*]="/dev/nvme0n1 /dev/nvme1n1"
+```
+
 ### Excluding Tests
 
 
diff --git a/new b/new
index d84f01d..df4092c 100755
--- a/new
+++ b/new
@@ -245,6 +245,15 @@ DESCRIPTION=""
 #                               is a partition device (e.g.,
 #                               /sys/block/sda/sda1). If the device is not a
 #                               partition, this is an empty string.
+#
+# Tests that require multiple test devices should rename test() to
+# test_device_array(). These tests will be run with variables defined below
+# instead of TEST_DEV and TEST_DEV_SYSFS:
+#    - \$TEST_DEV_ARRAY -- the block devices to run the test on. The devices are
+#                          taken from TEST_CASE_DEV_ARRAY defined in the config.
+#    - \$TEST_DEV_ARRAY_SYSFS -- the sysfs directories of the devices in the
+#                                form of an associative array. Use values in
+#                                TEST_DEV_ARRAY as the keys.
 test() {
 	echo "Running \${TEST_NAME}"
 
-- 
2.51.0

