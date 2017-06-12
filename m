Return-Path: <linux-block-owner@vger.kernel.org>
Received: from iad1-shared-relay2.dreamhost.com ([208.113.157.41]:44078 "EHLO
        iad1-shared-relay2.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752545AbdF3KQX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 06:16:23 -0400
Received: from iad1-shared-relay1.dreamhost.com (iad1-shared-relay1.dreamhost.com [208.113.157.50])
        by iad1-shared-relay2.dreamhost.com (Postfix) with ESMTP id 348E53E51E7
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 15:12:08 -0700 (PDT)
Received: from ware.dreamhost.com (ware.dreamhost.com [64.111.127.160])
        by iad1-shared-relay1.dreamhost.com (Postfix) with ESMTP id 53D80B400C0
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 15:12:07 -0700 (PDT)
In-Reply-To: <20170629134510.GA32385@infradead.org>
References: <20170629134510.GA32385@infradead.org>
From: Tony Asleson <tasleson@redhat.com>
Date: Mon, 12 Jun 2017 16:18:26 -0500
Subject: [PATCH 14/19] bcache: Correct return value for sysfs attach errors
To: linux-block@vger.kernel.org
Message-Id: <20170629221207.43E9B100127@ware.dreamhost.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If you encounter any errors in bch_cached_dev_attach it will return a negative
error code.  The variable 'v' which stores the result is unsigned, thus user
space sees a very large value returned for bytes written which can cause
incorrect user space behavior.  Utilize 1 signed variable to use throughout
the function to preserve error return capability.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
Acked-by: Coly Li <colyli@suse.de>
Cc: stable@vger.kernel.org
---
 drivers/md/bcache/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index cc0076d..7579ca6 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -206,7 +206,7 @@ STORE(__cached_dev)
 {
 	struct cached_dev *dc = container_of(kobj, struct cached_dev,
 					     disk.kobj);
-	unsigned v = size;
+	ssize_t v = size;
 	struct cache_set *c;
 	struct kobj_uevent_env *env;
 	unsigned ioprio_class = 0; /* invalid initial ioprio values */
@@ -245,7 +245,7 @@ STORE(__cached_dev)
 		bch_cached_dev_run(dc);
 
 	if (attr == &sysfs_cache_mode) {
-		ssize_t v = bch_read_string_list(buf, bch_cache_modes + 1);
+		v = bch_read_string_list(buf, bch_cache_modes + 1);
 
 		if (v < 0)
 			return v;
-- 
1.8.3.1
