Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] nbd: fix use after free on module unload
Date: Fri, 28 Apr 2017 09:49:19 -0400
Message-Id: <1493387359-9496-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

list_for_each_entry() isn't super safe if we're freeing the objects
while we traverse the list.  Also don't bother taking the extra
reference, the module refcounting stuff will save us from having anybody
messing with the device while we're trying to unload.

Reported-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 76e5f8f..9a6d34e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2090,7 +2090,6 @@ static int nbd_exit_cb(int id, void *ptr, void *data)
 	struct list_head *list = (struct list_head *)data;
 	struct nbd_device *nbd = ptr;
 
-	refcount_inc(&nbd->refs);
 	list_add_tail(&nbd->list, list);
 	return 0;
 }
@@ -2106,11 +2105,12 @@ static void __exit nbd_cleanup(void)
 	idr_for_each(&nbd_index_idr, &nbd_exit_cb, &del_list);
 	mutex_unlock(&nbd_index_mutex);
 
-	list_for_each_entry(nbd, &del_list, list) {
-		if (refcount_read(&nbd->refs) != 2)
+	while (!list_empty(&del_list)) {
+		nbd = list_first_entry(&del_list, struct nbd_device, list);
+		list_del_init(&nbd->list);
+		if (refcount_read(&nbd->refs) != 1)
 			printk(KERN_ERR "nbd: possibly leaking a device\n");
 		nbd_put(nbd);
-		nbd_put(nbd);
 	}
 
 	idr_destroy(&nbd_index_idr);
-- 
2.7.4
