Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43396 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbeEQOdY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 May 2018 10:33:24 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>,
        stable@vger.kernel.org, Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v3] bcache: return 0 from bch_debug_init() if CONFIG_DEBUG_FS=n
Date: Thu, 17 May 2018 22:32:54 +0800
Message-Id: <20180517143254.48670-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Commit 539d39eb2708 ("bcache: fix wrong return value in bch_debug_init()")
returns the return value of debugfs_create_dir() to bcache_init(). When
CONFIG_DEBUG_FS=n, bch_debug_init() always returns 1 and makes
bcache_init() failedi.

This patch makes bch_debug_init() always returns 0 if CONFIG_DEBUG_FS=n,
so bcache can continue to work for the kernels which don't have debugfs
enanbled.

Fixes: Commit 539d39eb2708 ("bcache: fix wrong return value in bch_debug_init()")
Cc: stable@vger.kernel.org
Signed-off-by: Coly Li <colyli@suse.de>
Reported-by: Massimo B. <massimo.b@gmx.net>
Reported-by: Kai Krakow <kai@kaishome.de>
Tested-by: Kai Krakow <kai@kaishome.de>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
---
 drivers/md/bcache/debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 4e63c6f6c04d..d030ce3025a6 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -250,7 +250,9 @@ void bch_debug_exit(void)
 
 int __init bch_debug_init(struct kobject *kobj)
 {
-	bcache_debug = debugfs_create_dir("bcache", NULL);
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return 0;
 
+	bcache_debug = debugfs_create_dir("bcache", NULL);
 	return IS_ERR_OR_NULL(bcache_debug);
 }
-- 
2.16.3
