Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:38503 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751227AbeFDWtC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Jun 2018 18:49:02 -0400
From: Keith Busch <keith.busch@intel.com>
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [blktests PATCHv2] Fix block/011 to not use sysfs for device disabling
Date: Mon,  4 Jun 2018 16:51:41 -0600
Message-Id: <20180604225141.8950-1-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The PCI sysfs interface may not be a dependable method for toggling the
PCI device state to trigger the timeouts. This patch goes directly to
the config space to make device failure occur.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
v1 -> v2:

  Toggling only PCI Command Register BME bit, rather than including MEM.

 tests/block/011 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/block/011 b/tests/block/011
index 62e89f7..2461442 100755
--- a/tests/block/011
+++ b/tests/block/011
@@ -21,7 +21,7 @@ DESCRIPTION="disable PCI device while doing I/O"
 TIMED=1
 
 requires() {
-	_have_fio
+	_have_fio && _have_program setpci
 }
 
 device_requires() {
@@ -43,10 +43,11 @@ test_device() {
 	_run_fio_rand_io --filename="$TEST_DEV" --size="$size" \
 			--ignore_error=EIO,ENXIO,ENODEV &
 
+	# toggle PCI Command Register's Bus Master Enabling
 	while kill -0 $! 2>/dev/null; do
-		echo 0 > "/sys/bus/pci/devices/${pdev}/enable"
+		setpci -s "${pdev}" 4.w=0:4
 		sleep .2
-		echo 1 > "/sys/bus/pci/devices/${pdev}/enable"
+		setpci -s "${pdev}" 4.w=4:4
 		sleep .2
 	done
 
-- 
2.14.3
