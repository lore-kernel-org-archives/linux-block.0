Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52881 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751702AbdK0VvP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Nov 2017 16:51:15 -0500
From: Jon Derrick <jonathan.derrick@intel.com>
To: <linux-block@vger.kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Omar Sandoval <osandov@osandov.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH blktests] common/rc: allow 5-digit domains in _get_pci_dev_from_blkdev
Date: Mon, 27 Nov 2017 14:49:05 -0700
Message-Id: <1511819345-18092-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

At least one driver (VMD) uses 32-bit pci domains, but is effectively
limited to 5-digit domains. Allow tests to access devices with 4-5 digit
domains.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 6b29c2b..09ce4ef 100644
--- a/common/rc
+++ b/common/rc
@@ -138,7 +138,7 @@ _test_dev_is_pci() {
 
 _get_pci_dev_from_blkdev() {
 	readlink -f "$TEST_DEV_SYSFS/device" | \
-		grep -Eo '[0-9a-f]{4}:[0-9a-f]{2}:[0-9a-f]{2}\.[0-9a-f]' | \
+		grep -Eo '[0-9a-f]{4,5}:[0-9a-f]{2}:[0-9a-f]{2}\.[0-9a-f]' | \
 		tail -1
 }
 
-- 
1.8.3.1
