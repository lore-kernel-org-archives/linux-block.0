Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XlLF4y8o"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50438BA
	for <linux-block@vger.kernel.org>; Wed, 29 Nov 2023 02:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701253908; x=1732789908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9batTlaSDrFqw9U3fReQJZMXqCnbBM0PPNyoyRkA5C8=;
  b=XlLF4y8oHSPcTeLiiRwhmrtLdfGXx3ZbR7Vg3ztqJccKyM3i3vZlwtes
   IxaOBcOCDsmSZ5JFPf6+tt6H3Uid0HfGwxyNSJf9TT4wA3lY8LlILSIEE
   QnBoFHNUURqlx9lNb1uZMs+oHienVb0qVmFSpvgoAZ/tafNKO95WKQWUz
   DVeDM7ZjXlqhKq4lAGg+zoH1CBalHDs+jzAebJTgaiPmrZZMGcxwZQglh
   0suddePyETLvzHR1uPXdhby3ya9nBgmvmnQjv4hZx/c8vYKA7yBxodHgW
   c7Sz6CLqYf7Nhp3lIADWJMO4cnWTkWISWVHk7Jiw7Fi+kZSsF1DLqrkED
   Q==;
X-CSE-ConnectionGUID: ATHDeardR5yQI/hWl2IT9g==
X-CSE-MsgGUID: 0ZkYh5unQHKzpwwDCjqgqA==
X-IronPort-AV: E=Sophos;i="6.04,235,1695657600"; 
   d="scan'208";a="3614311"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2023 18:31:46 +0800
IronPort-SDR: UKsW5p2XdLVpR836IdYtcKO/xH+4YXkHgtH3XOxSfK5wiz0qqTNPcCA7HOrqk8KO0R/eyLaQqm
 CmKAMzIGJCbg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2023 01:37:16 -0800
IronPort-SDR: 6etQF5tyg3NVrGO7MSGz7dIYknX9xE+5YVgxWIuq0CHfJK+v+s1fQstyBoLf53dXdqXZFV9yEK
 JoPPJaHrPP1Q==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Nov 2023 02:31:46 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/2] block/011: recover test target devices to online or live status
Date: Wed, 29 Nov 2023 19:31:44 +0900
Message-ID: <20231129103145.655612-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129103145.655612-1-shinichiro.kawasaki@wdc.com>
References: <20231129103145.655612-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test case runs fio while disabling and enabling PCI device of the
test target block device. This often leaves the devices in offline or
dead status. For example, when the block device is a HDD connected to
HBA, kernel makes the device into offline mode with this message:

    sd x:x:x:x Device offlined - not ready after error recovery

This causes following test cases to fail. To avoid the failure, remove
and rescan the devices to get them back to online or live status. This
improvement is similar as the commit f8f33218eca7 ("block/011: recover
test target NVME device capacity"). While at this change, improve code
comments for the commit f8f33218eca7, and add missing local variable
declarations.

Of note is that the added rescan operation triggers a lockdep WARN if
the system has devices which depend on P2SB [1].

[1] https://lore.kernel.org/linux-pci/6xb24fjmptxxn5js2fjrrddjae6twex5bjaftwqsuawuqqqydx@7cl3uik5ef6j/

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/011 | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/tests/block/011 b/tests/block/011
index a4230f4..2a967d1 100755
--- a/tests/block/011
+++ b/tests/block/011
@@ -38,6 +38,8 @@ device_requires() {
 test_device() {
 	echo "Running ${TEST_NAME}"
 
+	local pdev size rescan=false state i
+
 	pdev="$(_get_pci_dev_from_blkdev)"
 
 	if _test_dev_is_rotational; then
@@ -60,17 +62,36 @@ test_device() {
 
 	echo "Test complete"
 
-	# This test triggers NVME controller resets. When any failure happens
-	# during the resets, the driver marks the NVME block devices with zero
-	# capacity. Then following tests fail with the zero capacity devices. To
-	# get back the correct capacity, remove and rescan the devices.
+	# This test triggers NVME controller resets. When failures happen during
+	# the resets, the driver marks the NVME block devices as zero capacity.
+	# Remove and rescan the devices to regain the correct capacity.
 	if ((!$(<"$TEST_DEV_SYSFS/size"))); then
-		echo "$TEST_DEV has zero capacity" >> "$FULL"
-		if [[ -w $TEST_DEV_SYSFS/device/device/remove ]] &&
+		echo "$TEST_DEV has zero capacity. Rescan it." >> "$FULL"
+		rescan=true
+	fi
+
+	# This test case often makes NVME or HDDs connected to HBAs in offline
+	# or dead mode. Remove and rescan the devices to make them online again.
+	if [[ -r $TEST_DEV_SYSFS/device/state ]]; then
+		state=$(cat "$TEST_DEV_SYSFS/device/state")
+		if [[ $state == offline || $state == dead ]]; then
+			echo "$TEST_DEV is $state. Rescan it." >> "$FULL"
+			rescan=true
+		fi
+	fi
+
+	if [[ $rescan == true ]]; then
+		if [[ -w /sys/bus/pci/devices/$pdev/remove ]] &&
 			   [[ -w /sys/bus/pci/rescan ]]; then
-			echo "Rescan to tegain the correct capacity" >> "$FULL"
-			echo 1 > "$TEST_DEV_SYSFS/device/device/remove"
+			echo 1 > "/sys/bus/pci/devices/$pdev/remove"
 			echo 1 > /sys/bus/pci/rescan
+		else
+			echo "Can not rescan PCI device for recovery"
+			return 1
 		fi
+		for ((i = 0; i < 10; i++)); do
+			[[ -w $TEST_DEV ]] && break
+			sleep 5
+		done
 	fi
 }
-- 
2.43.0

