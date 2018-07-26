Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60808 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730584AbeGZPkO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jul 2018 11:40:14 -0400
From: Coly Li <colyli@suse.de>
To: colyli@suse.de, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
Subject: [PATCH 4/9] bcache: add a comment in register_bdev()
Date: Thu, 26 Jul 2018 22:22:34 +0800
Message-Id: <20180726142239.44669-5-colyli@suse.de>
In-Reply-To: <20180726142239.44669-1-colyli@suse.de>
References: <20180726142239.44669-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

---
 drivers/md/bcache/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index c7ffa6ef3f82..f517d7d1fa10 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1291,6 +1291,7 @@ static void register_bdev(struct cache_sb *sb, struct page *sb_page,
 	pr_info("registered backing device %s", dc->backing_dev_name);
 
 	list_add(&dc->list, &uncached_devices);
+	/* attch to a matched cache set if it exists */
 	list_for_each_entry(c, &bch_cache_sets, list)
 		bch_cached_dev_attach(dc, c, NULL);
 
-- 
2.17.1
