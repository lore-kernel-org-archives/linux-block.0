Return-Path: <famz@redhat.com>
From: Fam Zheng <famz@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, "Michael S. Tsirkin" <mst@redhat.com>,
        linux-block@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Paul Mackerras <paulus@samba.org>, linux-mtd@lists.infradead.org,
        "Ed L. Cashin" <ed.cashin@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Minchan Kim <minchan@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nitin Gupta <ngupta@vflare.org>, David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 05/15] genhd: Return error from disk_{add,alloc}_events
Date: Wed, 17 Aug 2016 15:15:05 +0800
Message-Id: <1471418115-3654-6-git-send-email-famz@redhat.com>
In-Reply-To: <1471418115-3654-1-git-send-email-famz@redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
List-ID: <linux-block@vger.kernel.org>

disk_alloc_events and disk_add_events can fail, return the error code so
the caller can handle it.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/genhd.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 8c7510d..4316d2d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -40,8 +40,8 @@ static struct device_type disk_type;
 
 static void disk_check_events(struct disk_events *ev,
 			      unsigned int *clearing_ptr);
-static void disk_alloc_events(struct gendisk *disk);
-static void disk_add_events(struct gendisk *disk);
+static int disk_alloc_events(struct gendisk *disk);
+static int disk_add_events(struct gendisk *disk);
 static void disk_del_events(struct gendisk *disk);
 static void disk_release_events(struct gendisk *disk);
 
@@ -1823,17 +1823,17 @@ module_param_cb(events_dfl_poll_msecs, &disk_events_dfl_poll_msecs_param_ops,
 /*
  * disk_{alloc|add|del|release}_events - initialize and destroy disk_events.
  */
-static void disk_alloc_events(struct gendisk *disk)
+static int disk_alloc_events(struct gendisk *disk)
 {
 	struct disk_events *ev;
 
 	if (!disk->fops->check_events)
-		return;
+		return 0;
 
 	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
 	if (!ev) {
 		pr_warn("%s: failed to initialize events\n", disk->disk_name);
-		return;
+		return -ENOMEM;
 	}
 
 	INIT_LIST_HEAD(&ev->node);
@@ -1845,17 +1845,22 @@ static void disk_alloc_events(struct gendisk *disk)
 	INIT_DELAYED_WORK(&ev->dwork, disk_events_workfn);
 
 	disk->ev = ev;
+	return 0;
 }
 
-static void disk_add_events(struct gendisk *disk)
+static int disk_add_events(struct gendisk *disk)
 {
+	int rc;
+
 	if (!disk->ev)
-		return;
+		return 0;
 
-	/* FIXME: error handling */
-	if (sysfs_create_files(&disk_to_dev(disk)->kobj, disk_events_attrs) < 0)
+	rc = sysfs_create_files(&disk_to_dev(disk)->kobj, disk_events_attrs);
+	if (rc) {
 		pr_warn("%s: failed to create sysfs files for events\n",
 			disk->disk_name);
+		return rc;
+	}
 
 	mutex_lock(&disk_events_mutex);
 	list_add_tail(&disk->ev->node, &disk_events);
@@ -1866,6 +1871,7 @@ static void disk_add_events(struct gendisk *disk)
 	 * unblock kicks it into action.
 	 */
 	__disk_unblock_events(disk, true);
+	return 0;
 }
 
 static void disk_del_events(struct gendisk *disk)
-- 
2.7.4
