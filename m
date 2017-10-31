Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:64101 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753540AbdJaUfh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Oct 2017 16:35:37 -0400
From: Scott Bauer <scott.bauer@intel.com>
To: linux-block@vger.kernel.org
Cc: jonathan.derrick@intel.com, linux-kernel@vger.kernel.org,
        axboe@fb.com, hch@infradead.org, rafael.antognolli@intel.com,
        Scott Bauer <scott.bauer@intel.com>
Subject: [PATCH] MAINTAINERS: Remove Rafael from Opal maintainers.
Date: Tue, 31 Oct 2017 14:15:02 -0600
Message-Id: <20171031201502.22863-1-scott.bauer@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

He is no longer working on storage.

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index af0cb69f6a3e..5c0864d7d7ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12052,7 +12052,6 @@ F:	drivers/mmc/host/sdhci-spear.c
 SECURE ENCRYPTING DEVICE (SED) OPAL DRIVER
 M:	Scott Bauer <scott.bauer@intel.com>
 M:	Jonathan Derrick <jonathan.derrick@intel.com>
-M:	Rafael Antognolli <rafael.antognolli@intel.com>
 L:	linux-block@vger.kernel.org
 S:	Supported
 F:	block/sed*
-- 
2.11.0
