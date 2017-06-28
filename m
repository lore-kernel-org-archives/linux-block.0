Return-Path: <linux-block-owner@vger.kernel.org>
Received: from iad1-shared-relay2.dreamhost.com ([208.113.157.41]:43741 "EHLO
        iad1-shared-relay2.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751675AbdF3KQN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 06:16:13 -0400
Received: from iad1-shared-relay1.dreamhost.com (iad1-shared-relay1.dreamhost.com [208.113.157.50])
        by iad1-shared-relay2.dreamhost.com (Postfix) with ESMTP id 628883E51F3
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 15:12:08 -0700 (PDT)
Received: from ware.dreamhost.com (ware.dreamhost.com [64.111.127.160])
        by iad1-shared-relay1.dreamhost.com (Postfix) with ESMTP id 452FAB400CA
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 15:12:07 -0700 (PDT)
In-Reply-To: <20170629134510.GA32385@infradead.org>
References: <20170629134510.GA32385@infradead.org>
From: Tang Junhui <tang.junhui@zte.com.cn>
Date: Tue, 27 Jun 2017 17:30:39 -0700
Subject: [PATCH 13/19] bcache: delete redundant calling set_gc_sectors()
To: linux-block@vger.kernel.org
Message-Id: <20170629221207.362ED10012A@ware.dreamhost.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

set_gc_sectors() has been called in bch_gc_thread(), and it was called
again in bch_btree_gc_finish() . The following call is unnecessary, so
delete it.

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
---
 drivers/md/bcache/btree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 77aa20b..66d8036 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1662,7 +1662,6 @@ static size_t bch_btree_gc_finish(struct cache_set *c)
 
 	mutex_lock(&c->bucket_lock);
 
-	set_gc_sectors(c);
 	c->gc_mark_valid = 1;
 	c->need_gc	= 0;
 
-- 
1.8.3.1
