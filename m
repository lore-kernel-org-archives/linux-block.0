Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B171D36CC79
	for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758109768; cv=none; b=dda9zNuoCoCCw7ouBueaNuF0XqX/RsgziEo8Ivv8Wzsow/Jn4TViQqPQvDf7zJxvpkNnjP0IYhZpkzqKSX8xcqkMFLi/ITiaag9IppahpmxQ6E/nEK8vLQychkckHbUGsY1fKwP3LEhmxs98f7pVXP7MQN1DFrAlsagnrNRx5aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758109768; c=relaxed/simple;
	bh=GUBfpb9qHBoygolb8/lX8/hcoC8Y4ddR20f8gxhbJVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hd+FvZIQ2+cZHtZowAGH1Un1rIQ+i5SMgpj9wXugbSraHRsRjt4qLpC16HFpbEaQ3Vc4GaGHhBWUh/UL/BoNiAq3f6J25wGtsR6+0ErUUz0dEGpkIKtht8XBCWSeL+wM0Lo5H2hT4DnkcvUtQYQc0iYGYIQpYcTh1SicG9vtILI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XYMsH5Xx; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XYMsH5Xx"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758109766; x=1789645766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GUBfpb9qHBoygolb8/lX8/hcoC8Y4ddR20f8gxhbJVM=;
  b=XYMsH5XxRoNG8Zdxx57HqM9ZjcifBQcEnsy27GpXPrNkI12ubFh2gcpy
   Ng8jqd803QaP7Z9PcmPqg98spC3hxHOAVrsJZR70pk8QHDoXp5kCwfzPH
   zVopw7qVSSFtIF/0NVm+5KS6Z75xYjtBtWr4OdYptP/XhopH/dguOATIo
   l7fMJNSHmQkGg03oCzRzHZD8xGgJBTf/H2U/Faf2Ml60yZJLYhxW71PGP
   hOWOVtc1dnToYyxrXw73yoshFEmH8FkvNQNuFoXkYekvgxj7TlCEd+kyT
   6ArSVRHu95EYmoa8Z6aPuuim5353lfxAn4N4+G1dQS/Eqogo5jr1q5afy
   Q==;
X-CSE-ConnectionGUID: LfrIo+t6RNCkZD8pl/257Q==
X-CSE-MsgGUID: 7/sKhYSKQ1uLEWlTXCV0gg==
X-IronPort-AV: E=Sophos;i="6.18,271,1751212800"; 
   d="scan'208";a="122448656"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2025 19:49:26 +0800
IronPort-SDR: 68caa046_No9sxjfkeg95ZcddZRhV4TFHeTWqnMRupTYDLYp+L275jgR
 J5g4SoA2Q7A6YQSxiqMXDrnPHtprY4vfw2N329A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 04:49:26 -0700
WDCIronportException: Internal
Received: from dr34yd3.ad.shared (HELO shinmob.wdc.com) ([10.224.163.71])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Sep 2025 04:49:26 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	John Garry <john.g.garry@oracle.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 4/5] new, Documentation: improve descriptions about TEST_DEVS
Date: Wed, 17 Sep 2025 20:49:16 +0900
Message-ID: <20250917114920.142996-5-shinichiro.kawasaki@wdc.com>
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

While I worked on the previous commit, I noticed that there is a room
to improve descriptions about TEST_DEVS. Add more descriptions about it
in Documentation/running-tests.md. Also note the relation between
TEST_DEVS and the test_device() function in the 'new' script.

This reverts commit 6aa89879d4b8a79a54589b53fe287fd188ca2131.
---
 Documentation/running-tests.md | 13 ++++++++-----
 new                            |  3 ++-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index f037634..8ccd739 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -30,17 +30,20 @@ options have precedence over the configuration file.
 
 ### Test Devices
 
-The `TEST_DEVS` variable is an array of block devices to test on. Tests will be
-run on all of these devices where applicable. Note that tests are destructive
-and will overwrite any data on these devices.
+Some test cases require a block device for testing. These test cases implement
+a special test function test_device(). The `TEST_DEVS` variable is an array of
+block devices that such test cases to test on. Every test will be run on each of
+these devices where applicable. Note that tests are destructive and will
+overwrite any data on these devices.
 
 ```sh
 TEST_DEVS=(/dev/nvme0n1 /dev/sdb)
 ```
 
 If `TEST_DEVS` is not defined or is empty, only tests which do not require a
-device will be run. If `TEST_DEVS` is defined as a normal variable instead of
-an array, it will be converted to an array by splitting on whitespace.
+device will be run, which implments the test function 'test()'. If `TEST_DEVS`
+is defined as a normal variable instead of an array, it will be converted to an
+array by splitting on whitespace.
 
 Some test cases require multiple block devices for single test run. These test
 cases implement a special test function test_device_array(). TEST_CASE_DEV_ARRAY
diff --git a/new b/new
index df4092c..4773175 100755
--- a/new
+++ b/new
@@ -235,7 +235,8 @@ DESCRIPTION=""
 #
 # Tests that require a test device should rename test() to test_device(). These
 # tests will be run with a few more variables defined:
-#    - \$TEST_DEV -- the block device to run the test on (e.g., /dev/sda1).
+#    - \$TEST_DEV -- the block device to run the test on (e.g., /dev/sda1). The
+#                    device is taken from TEST_DEVS in the config for each run.
 #    - \$TEST_DEV_SYSFS -- the sysfs directory of the device (e.g.,
 #                         /sys/block/sda). In general, you should use the
 #                         _test_dev_queue_{get,set} helpers. If the device is a
-- 
2.51.0

