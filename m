Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751453AbdF0NnF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2017 09:43:05 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@fb.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH blktests v2 1/2] rc: add helpers to handle PCI test devices
Date: Tue, 27 Jun 2017 15:42:56 +0200
Message-Id: <20170627134257.15863-2-jthumshirn@suse.de>
In-Reply-To: <20170627134257.15863-1-jthumshirn@suse.de>
References: <20170627134257.15863-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add two helpers to check whether a device is attached via PCI and to get the
PCI device from a TEST_DEV

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 common/rc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/common/rc b/common/rc
index 088422ce909b..28116b0fc308 100644
--- a/common/rc
+++ b/common/rc
@@ -127,3 +127,16 @@ _test_dev_queue_set() {
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
+	readlink -f "$TEST_DEV_SYSFS/device" | \
+		grep -Eo '[0-9a-f]{4}:[0-9a-f]{2}:[0-9a-f]{2}\.[0-9a-f]'
+}
-- 
2.12.3
