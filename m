Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38757 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751488AbdFWOaG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jun 2017 10:30:06 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH blktests 1/2] rc: add helpers to handle PCI test devices
Date: Fri, 23 Jun 2017 16:29:50 +0200
Message-Id: <20170623142951.17189-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add two helpers to check whether a device is attached via PCI and to get the
PCI device from a TEST_DEV

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 common/rc | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/common/rc b/common/rc
index b01f936b878b..497cf81ec475 100644
--- a/common/rc
+++ b/common/rc
@@ -120,3 +120,18 @@ _test_dev_queue_set() {
 	fi
 	echo "$2" >"${TEST_DEV_SYSFS}/queue/$1"
 }
+
+_test_dev_is_pci() {
+	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q pci; then
+		SKIP_REASON="$TEST_DEV is not a PCI device"
+		return 1
+	fi
+	return 0
+}
+
+_get_pci_dev_from_blkdev() {
+	pdev="$(readlink -f "$TEST_DEV_SYSFS/device" | \
+		grep -Eo '[0-9a-f]{4}:[0-9a-f]{2}:[0-9a-f]{2}\.[0-9a-f]')"
+
+	echo "$pdev"
+}
-- 
2.12.3
