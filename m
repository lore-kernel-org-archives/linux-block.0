Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22F6C433FE
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 02:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F3222511
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 02:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgLDCoY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 21:44:24 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:58736 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgLDCoX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 21:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607049862; x=1638585862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o/8BTTcjH42o9gXtj9QwzGGzTqSoJKbj0vzlO/tO41U=;
  b=DA3l+53/G+zpKm5ju0QL1Yrb6nnjYmr3QuEsPJKgoNi8kor6wKc5j3+5
   k5lSyP2+x4nefGa2wuoJBRxUwWOoGiL64FPevlNVIOjtL1Ibm2ptSlL6p
   aoNfpWUu4hb1/a3zMLTz0WC4GHAC1uwl+tLI3JXUeufKjUSWnX89UtAiN
   xeeFSgjE5yOEuaUTDCHQsXMkdeZlkckbRg5xrq0xClenm1jmBSGxgJCn/
   fzvpBvvlK0TVuZVfQL9L0UsoKkS97+bYEggIDen2wbrUW3DulogKTE9Ev
   Vk4h6C6NJ4XSQ12iLc2cQJvEWILIg8O4sGwr6srqbmLyidGotNynF4EIv
   Q==;
IronPort-SDR: QJo76BV0NuCPKPbLLDeqDGetjLuQMRCOYgY4btzK/9iHbcU5U6jCG4ekhOazq77UJaHtb1c3MT
 E3Q/wfI9zCsCvwNJ+yshNnraB91Bb1u/cRYbQBaJhtGnGnkpHlymRdaKef5P9vPpQYozfXhBnC
 s4xiOUGSBinf5uTRcu2ltlpohqJizcMCfwqWHioKeJmQd3p1bA5dmSv6xjUDsW7rVhBDv0D57r
 qPxK9e6Fo3ig5KPhppGOBh/brygnk1sYVlWNE2hQWtqOfq+UonUANIhLvmN5Ij/L/5Dwj3X7Zb
 z+8=
X-IronPort-AV: E=Sophos;i="5.78,391,1599494400"; 
   d="scan'208";a="264546964"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2020 10:42:38 +0800
IronPort-SDR: wQzoc1zmUSrvNCFa6dlPhauntNuFQEn16KfrExHAYSvGxYO/frV0MF5Je+5cnyEHDTJGgomUZd
 bKtJBAxKcxKsV78EU/LuQVSs0OU0sOB+U=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 18:28:11 -0800
IronPort-SDR: oRZ65pqvHP5a3lp+BHei8u9lAeW1Ry0587/tpXKeqAJTgrVhU3rHCjaBGPd+mCrLmgngk1oyxx
 UYtbVWFtmjRg==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com ([10.149.52.189])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Dec 2020 18:42:37 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 1/2] common/rc: Check both max_active_zones and max_open_zones
Date:   Fri,  4 Dec 2020 11:42:34 +0900
Message-Id: <20201204024235.273924-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201204024235.273924-1-shinichiro.kawasaki@wdc.com>
References: <20201204024235.273924-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Linux kernel 5.9 introduced new sysfs attributes max_active_zones and
max_open_zones for zoned block devices. Max_open_zones is the limit of
number of zones in open status. Max_active_zones is the limit of number
of zones in open or closed status. Currently, the helper function
_test_dev_max_active_zones() checks only max_active_zones, but it is not
enough. When the device has max_open_zones, check for max_active_zones
can not avoid the errors for write operations.

To avoid the error, improve the function _test_dev_max_active_zones() to
check the limits both. Rename it to _test_dev_max_open_active_zones().
When one of the limits is available for the test target device, return
it. If both limits are available, return smaller limit.

Also modify block/004 and zbd/003 to call the renamed helper function
and update comment description.

Fixes: e6981bb2d9ce ("common/rc: Add _test_dev_max_active_zones() helper function")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/rc       | 19 ++++++++++++++++---
 tests/block/004 |  2 +-
 tests/zbd/003   |  6 +++---
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/common/rc b/common/rc
index d396fb5..a837542 100644
--- a/common/rc
+++ b/common/rc
@@ -280,11 +280,24 @@ _test_dev_is_partition() {
 	[[ -n ${TEST_DEV_PART_SYSFS} ]]
 }
 
-_test_dev_max_active_zones() {
+# Return max open zones or max active zones of the test target device.
+# If the device has both, return smaller value.
+_test_dev_max_open_active_zones() {
+	local -i moz=0
+	local -i maz=0
+
+	if [[ -r "${TEST_DEV_SYSFS}/queue/max_open_zones" ]]; then
+		moz=$(_test_dev_queue_get max_open_zones)
+	fi
+
 	if [[ -r "${TEST_DEV_SYSFS}/queue/max_active_zones" ]]; then
-		_test_dev_queue_get max_active_zones
+		maz=$(_test_dev_queue_get max_active_zones)
+	fi
+
+	if ((!moz)) || ((maz && maz < moz)); then
+		echo "${maz}"
 	else
-		echo 0
+		echo "${moz}"
 	fi
 }
 
diff --git a/tests/block/004 b/tests/block/004
index 6eff6ce..a7cec95 100755
--- a/tests/block/004
+++ b/tests/block/004
@@ -26,7 +26,7 @@ test_device() {
 	if _test_dev_is_zoned; then
 		_test_dev_queue_set scheduler deadline
 		opts+=("--direct=1" "--zonemode=zbd")
-		opts+=("--max_open_zones=$(_test_dev_max_active_zones)")
+		opts+=("--max_open_zones=$(_test_dev_max_open_active_zones)")
 	fi
 
 	FIO_PERF_FIELDS=("write iops")
diff --git a/tests/zbd/003 b/tests/zbd/003
index 1e92e81..7f4fa2c 100755
--- a/tests/zbd/003
+++ b/tests/zbd/003
@@ -30,10 +30,10 @@ test_device() {
 
 	echo "Running ${TEST_NAME}"
 
-	# When the test device has max_active_zone limit, reset all zones. This
-	# ensures the write operations in this test case do not open zones
+	# When the test device has max_open/active_zones limit, reset all zones.
+	# This ensures the write operations in this test case do not open zones
 	# beyond the limit.
-	(($(_test_dev_max_active_zones))) && blkzone reset "${TEST_DEV}"
+	(($(_test_dev_max_open_active_zones))) && blkzone reset "${TEST_DEV}"
 
 	# Get physical block size as dd block size to meet zoned block device
 	# requirement
-- 
2.28.0

