Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46734 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbdBOAjS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2017 19:39:18 -0500
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Cc: David.Laight@ACULAB.COM, arnd@arndb.de, axboe@fb.com,
        keith.busch@intel.com, jonathan.derrick@intel.com,
        hch@infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Scott Bauer <scott.bauer@intel.com>
Subject: [PATCH V6 1/3] uapi: sed-opal fix IOW for activate lsp to use correct struct
Date: Tue, 14 Feb 2017 17:29:35 -0700
Message-Id: <1487118577-1719-1-git-send-email-scott.bauer@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The IOC_OPAL_ACTIVATE_LSP took the wrong strcure which would
give us the wrong size when using _IOC_SIZE, switch it to the
right structure.

Fixes: 058f8a2 ("Include: Uapi: Add user ABI for Sed/Opal")

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
---
 include/uapi/linux/sed-opal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index fc06e3a..c72e073 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -106,7 +106,7 @@ struct opal_mbr_data {
 #define IOC_OPAL_SAVE		    _IOW('p', 220, struct opal_lock_unlock)
 #define IOC_OPAL_LOCK_UNLOCK	    _IOW('p', 221, struct opal_lock_unlock)
 #define IOC_OPAL_TAKE_OWNERSHIP	    _IOW('p', 222, struct opal_key)
-#define IOC_OPAL_ACTIVATE_LSP       _IOW('p', 223, struct opal_key)
+#define IOC_OPAL_ACTIVATE_LSP       _IOW('p', 223, struct opal_lr_act)
 #define IOC_OPAL_SET_PW             _IOW('p', 224, struct opal_new_pw)
 #define IOC_OPAL_ACTIVATE_USR       _IOW('p', 225, struct opal_session_info)
 #define IOC_OPAL_REVERT_TPR         _IOW('p', 226, struct opal_key)
-- 
2.7.4
