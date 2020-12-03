Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE94C83012
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 08:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38CF821741
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 08:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388420AbgLCIXx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 03:23:53 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38583 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388358AbgLCIXx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 03:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606983832; x=1638519832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KujNNC6YB4Tcg29tD5cPcw/DXfPL8yUk439wzvL3bms=;
  b=CNhkHdwQeN+9kIBlhXGCieOybA+YvJmZ42byZkd2uorgSP0PTM32mEnP
   sMzlGbTt7tnvTXLjOYShO17UlnVmKk2D9x9n+ZcOK4QwejHZzwTmLQnMk
   V6k0wZh/47JIT1MRBZ9r8thoyJ8nxNPMBHABU08mASXPeiL8kl9fYTBQn
   TFXt1F59FeBRwj1P6Sr4jja2YrwGJCIKiJd/cSReEroN3VQYITid3Uyep
   uMYH/1KYNCsNUzHSMTgTawAJEZGoeuVg0XtHxi0qz3iM0kUX+haypV6ad
   PKeYabkVL7/gkDS8LhYHIIHRl5X7BglpQY9meZ+CmWG920Rr8XrTJ7cCx
   w==;
IronPort-SDR: 1vo4XpFI8AzZuYWQGNMH+KMOuHdf2ZhJ2KG9C72b7z4ohHgqY6bq+nf4Tjlnhj/c2+6y7UqNaf
 wkKN7v/zS2SZJqssAoZvoQW1oy03NEH5Yojzp6j3PPeHzpo5yGstYT1q/sVTXXPM5Jol66QiKJ
 vGLkVKVXdSS8IyG5btok9K7mCVpwvp6NurzKiuIb39y0o0U936GwUsLthCasb3qtkF3scyrBFg
 NEDa8KbbHFWZrp47ccEvsAVjf8yGBAUnarYHJlc+T8QTzW+siTnlu/Qc+OjN4n3jB+THSDSxH/
 mnc=
X-IronPort-AV: E=Sophos;i="5.78,389,1599494400"; 
   d="scan'208";a="154306299"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2020 16:22:47 +0800
IronPort-SDR: +NWQqBagvV2WNxb8Z48jkNj6P7sS2XHalewdU8cJ7XFyiCzlbH3QFkXplc3Z0dagw63JCFBXIB
 OG14MDAQLRSQiNTtUhEnjQKixGSpgt1qA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 00:06:57 -0800
IronPort-SDR: OsSMmBWI2JBxocuJHb5FoNmpBXKZdXp3IG6qJ0tMAUmmwC9u0wJ/CqOScmqhqvtw0LJgdi0VYQ
 tsWSW9y2ApHQ==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com ([10.149.52.189])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Dec 2020 00:22:47 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/2] common/rc: Check both max_active_zones and max_open_zones
Date:   Thu,  3 Dec 2020 17:22:43 +0900
Message-Id: <20201203082244.268632-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201203082244.268632-1-shinichiro.kawasaki@wdc.com>
References: <20201203082244.268632-1-shinichiro.kawasaki@wdc.com>
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
---
 common/rc       | 21 +++++++++++++++++----
 tests/block/004 |  2 +-
 tests/zbd/003   |  6 +++---
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/common/rc b/common/rc
index d396fb5..a14f093 100644
--- a/common/rc
+++ b/common/rc
@@ -280,12 +280,25 @@ _test_dev_is_partition() {
 	[[ -n ${TEST_DEV_PART_SYSFS} ]]
 }
 
-_test_dev_max_active_zones() {
+# Return max open zones or max active zones of the test target device.
+# If the device has both, return smaller value.
+_test_dev_max_open_active_zones() {
+	local -i ret=0
+	local -i maz=0
+
+	if [[ -r "${TEST_DEV_SYSFS}/queue/max_open_zones" ]]; then
+		ret=$(_test_dev_queue_get max_open_zones)
+	fi
+
 	if [[ -r "${TEST_DEV_SYSFS}/queue/max_active_zones" ]]; then
-		_test_dev_queue_get max_active_zones
-	else
-		echo 0
+		maz=$(_test_dev_queue_get max_active_zones)
 	fi
+
+	if ((!ret)) || ((maz && maz < ret)); then
+		ret="${maz}"
+	fi
+
+	echo "${ret}"
 }
 
 _require_test_dev_is_partition() {
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

