Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:40927 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S947380AbcJaWDt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2016 18:03:49 -0400
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Cc: Rafael.Antognolli@intel.com, axboe@fb.com, keith.busch@intel.com,
        jonathan.derrick@intel.com, j.naumann@fu-berlin.de,
        hch@infradead.org, linux-block@vger.kernel.org,
        Scott Bauer <scott.bauer@intel.com>
Subject: [RFC PATCH 3/6] lib: Add Sed to Kconfig and Makefile
Date: Mon, 31 Oct 2016 15:58:16 -0600
Message-Id: <1477951099-3127-4-git-send-email-scott.bauer@intel.com>
In-Reply-To: <1477951099-3127-1-git-send-email-scott.bauer@intel.com>
References: <1477951099-3127-1-git-send-email-scott.bauer@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
Signed-off-by: Rafael Antognolli <Rafael.Antognolli@intel.com>
---
 lib/Kconfig  | 12 ++++++++++++
 lib/Makefile |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 260a80e..47c39ac 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -547,6 +547,18 @@ config STACKDEPOT
 	bool
 	select STACKTRACE
 
+config SED
+	bool "Self-Encrypting Drive library"
+	help
+	  Provides self-encrypting drive helpers
+
+config SED_OPAL
+	bool "Self-Encrypting Drive library - Opal implementation"
+	depends on SED
+	help
+	  Provides self-encrypting drive helpers for drives that implement the
+	  Opal spec.
+
 config SBITMAP
 	bool
 
diff --git a/lib/Makefile b/lib/Makefile
index 50144a3..976da7a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -229,4 +229,11 @@ obj-$(CONFIG_UBSAN) += ubsan.o
 
 UBSAN_SANITIZE_ubsan.o := n
 
+
+obj-$(CONFIG_SED) += sed.o
+
+obj-$(CONFIG_SED_OPAL) += sed-opal.o
+obj-$(CONFIG_SED_OPAL) += sed-opal_key.o
+
 obj-$(CONFIG_SBITMAP) += sbitmap.o
+
-- 
2.7.4

