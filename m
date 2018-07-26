Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60960 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730068AbeGZPkk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jul 2018 11:40:40 -0400
From: Coly Li <colyli@suse.de>
To: colyli@suse.de, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
Subject: [PATCH 8/9] bcache: initiate bcache_debug to NULL
Date: Thu, 26 Jul 2018 22:22:38 +0800
Message-Id: <20180726142239.44669-9-colyli@suse.de>
In-Reply-To: <20180726142239.44669-1-colyli@suse.de>
References: <20180726142239.44669-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Global variable bcache_debug is firstly initialized in bch_debug_init(),
and destroyed in bch_debug_exit(). bch_debug_init() is called in
bcache_init() with many other functions, if one of the previous calling
onces failed, bcache_exit() will be called in the failure path.

The problem is, if bcache_init() fails before bch_debug_init() is called,
then in bcache_exit() when bch_debug_exit() is called to destroy global
variable bcache_debug, at this moment bcache_debug is unndefined, then the
test of "if (!IS_ERR_OR_NULL(bcache_debug))" might be buggy.

This patch initializes global varabile bcache_debug to be NULL, to make
the failure code path to be predictable.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 57f8f5aeee55..24b0eb65ddec 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -17,7 +17,7 @@
 #include <linux/random.h>
 #include <linux/seq_file.h>
 
-struct dentry *bcache_debug;
+struct dentry *bcache_debug = NULL;
 
 #ifdef CONFIG_BCACHE_DEBUG
 
-- 
2.17.1
