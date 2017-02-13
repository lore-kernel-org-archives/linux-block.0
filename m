Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20831 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752626AbdBMQUs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2017 11:20:48 -0500
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Cc: David.Laight@ACULAB.COM, arnd@arndb.de, axboe@fb.com,
        keith.busch@intel.com, jonathan.derrick@intel.com,
        hch@infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Scott Bauer <scott.bauer@intel.com>
Subject: [PATCH V5 4/4] Maintainers: Modify SED list from nvme to block
Date: Mon, 13 Feb 2017 09:11:12 -0700
Message-Id: <1487002272-17940-5-git-send-email-scott.bauer@intel.com>
In-Reply-To: <1487002272-17940-1-git-send-email-scott.bauer@intel.com>
References: <1487002272-17940-1-git-send-email-scott.bauer@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e325373..b983b25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11094,7 +11094,7 @@ SECURE ENCRYPTING DEVICE (SED) OPAL DRIVER
 M:	Scott Bauer <scott.bauer@intel.com>
 M:	Jonathan Derrick <jonathan.derrick@intel.com>
 M:	Rafael Antognolli <rafael.antognolli@intel.com>
-L:	linux-nvme@lists.infradead.org
+L:	linux-block@vger.kernel.org
 S:	Supported
 F:	block/sed*
 F:	block/opal_proto.h
-- 
2.7.4
