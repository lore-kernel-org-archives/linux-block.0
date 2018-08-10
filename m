Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57818 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727771AbeHJSc3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Aug 2018 14:32:29 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH v3 10/17] bcache: prefer 'help' in Kconfig
Date: Sat, 11 Aug 2018 00:00:40 +0800
Message-Id: <20180810160047.5363-11-colyli@suse.de>
In-Reply-To: <20180810160047.5363-1-colyli@suse.de>
References: <20180810160047.5363-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Current bcache Kconfig uses '---help---' as header of help information,
for now 'help' is prefered. This patch fixes this style by replacing
'---help---' by 'help' in bcache Kconfig file.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Shenghui Wang <shhuiw@foxmail.com>
---
 drivers/md/bcache/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/Kconfig b/drivers/md/bcache/Kconfig
index 17bf109c58e9..817b9fba50db 100644
--- a/drivers/md/bcache/Kconfig
+++ b/drivers/md/bcache/Kconfig
@@ -1,7 +1,7 @@
 
 config BCACHE
 	tristate "Block device as cache"
-	---help---
+	help
 	Allows a block device to be used as cache for other devices; uses
 	a btree for indexing and the layout is optimized for SSDs.
 
@@ -10,7 +10,7 @@ config BCACHE
 config BCACHE_DEBUG
 	bool "Bcache debugging"
 	depends on BCACHE
-	---help---
+	help
 	Don't select this option unless you're a developer
 
 	Enables extra debugging tools, allows expensive runtime checks to be
@@ -20,7 +20,7 @@ config BCACHE_CLOSURES_DEBUG
 	bool "Debug closures"
 	depends on BCACHE
 	select DEBUG_FS
-	---help---
+	help
 	Keeps all active closures in a linked list and provides a debugfs
 	interface to list them, which makes it possible to see asynchronous
 	operations that get stuck.
-- 
2.18.0
