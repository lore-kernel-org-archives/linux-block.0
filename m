Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35982 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbdJHVay (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Oct 2017 17:30:54 -0400
From: Himanshu Jha <himanshujha199640@gmail.com>
To: bart.vanassche@wdc.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH] skd: Use kmem_cache_free
Date: Mon,  9 Oct 2017 03:00:28 +0530
Message-Id: <1507498228-11878-1-git-send-email-himanshujha199640@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Use kmem_cache_free instead of kfree for freeing the memory previously
allocated with kmem_cache_zalloc/kmem_cache_alloc/kmem_cache_node.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/block/skd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 7cedb42..64d0fc1 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -2604,7 +2604,7 @@ static void *skd_alloc_dma(struct skd_device *skdev, struct kmem_cache *s,
 		return NULL;
 	*dma_handle = dma_map_single(dev, buf, s->size, dir);
 	if (dma_mapping_error(dev, *dma_handle)) {
-		kfree(buf);
+		kmem_cache_free(s, buf);
 		buf = NULL;
 	}
 	return buf;
-- 
2.7.4
