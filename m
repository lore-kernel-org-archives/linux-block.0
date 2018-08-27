Return-Path: <cgxu519@gmx.com>
From: Chengguang Xu <cgxu519@gmx.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] block: remove unnecessary condition check
Date: Tue, 28 Aug 2018 07:31:11 +0800
Message-Id: <20180827233111.9324-1-cgxu519@gmx.com>
List-ID: <linux-block@vger.kernel.org>

kmem_cache_destroy() can handle NULL pointer correctly, so there is
no need to check e->icq_cache before calling kmem_cache_destroy().

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 block/elevator.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 5ea6e7d600e4..6a06b5d040e5 100644
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
2.17.1
