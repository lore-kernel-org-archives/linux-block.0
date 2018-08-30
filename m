Return-Path: <jpittman@redhat.com>
From: John Pittman <jpittman@redhat.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	John Pittman <jpittman@redhat.com>
Subject: [PATCH] block: elevator: remove unneeded null check in elv_register()
Date: Thu, 30 Aug 2018 15:56:18 -0400
Message-Id: <20180830195618.25658-1-jpittman@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Since commit 3942d2991852 ("mm/slab_common: allow NULL cache
pointer in kmem_cache_destroy()"), the kmem_cache_destroy()
function has been able to handle null pointers.  Remove NULL
check against e->icq_cache in elv_register(), simplifying the code.

Signed-off-by: John Pittman <jpittman@redhat.com>
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
