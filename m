Return-Path: <dingxiang@cmss.chinamobile.com>
From: Ding Xiang <dingxiang@cmss.chinamobile.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: Fix unneeded NULL check
Date: Tue, 28 Aug 2018 15:30:13 +0800
Message-Id: <1535441413-8583-1-git-send-email-dingxiang@cmss.chinamobile.com>
List-ID: <linux-block@vger.kernel.org>

if icq_cache is null, kmem_cache_destroy will do nothing.
So, remove the null check.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 block/elevator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 5ea6e7d..6a06b5d 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -895,8 +895,7 @@ int elv_register(struct elevator_type *e)
 	spin_lock(&elv_list_lock);
 	if (elevator_find(e->elevator_name, e->uses_mq)) {
 		spin_unlock(&elv_list_lock);
-		if (e->icq_cache)
-			kmem_cache_destroy(e->icq_cache);
+		kmem_cache_destroy(e->icq_cache);
 		return -EBUSY;
 	}
 	list_add_tail(&e->list, &elv_list);
-- 
1.9.1
