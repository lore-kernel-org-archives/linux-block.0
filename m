Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37958 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754301AbeCSAgu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Mar 2018 20:36:50 -0400
Received: by mail-pl0-f65.google.com with SMTP id m22-v6so9230686pls.5
        for <linux-block@vger.kernel.org>; Sun, 18 Mar 2018 17:36:50 -0700 (PDT)
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@fb.com, Tang Junhui <tang.junhui@zte.com.cn>
Subject: [for-4.17 08/20] bcache: fix error return value in memory shrink
Date: Sun, 18 Mar 2018 17:36:21 -0700
Message-Id: <20180319003633.27225-9-mlyle@lyle.org>
In-Reply-To: <20180319003633.27225-1-mlyle@lyle.org>
References: <20180319003633.27225-1-mlyle@lyle.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Tang Junhui <tang.junhui@zte.com.cn>

In bch_mca_scan(), the return value should not be the number of freed btree
nodes, but the number of pages of freed btree nodes.

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
---
 drivers/md/bcache/btree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 39cc8a549091..b2d4899f48d5 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -719,7 +719,7 @@ static unsigned long bch_mca_scan(struct shrinker *shrink,
 	}
 out:
 	mutex_unlock(&c->bucket_lock);
-	return freed;
+	return freed * c->btree_pages;
 }
 
 static unsigned long bch_mca_count(struct shrinker *shrink,
-- 
2.14.1
