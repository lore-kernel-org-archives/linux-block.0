Return-Path: <raghuhack78@gmail.com>
Return-Path: <raghuhack78@gmail.com>
From: RAGHU Halharvi <raghuhack78@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	RAGHU Halharvi <raghuhack78@gmail.com>
Subject: [PATCH] pktcdvd:checkpatch:fix pointer declaration
Date: Wed, 18 Jul 2018 21:28:55 +0530
Message-Id: <20180718155855.4949-1-raghuhack78@gmail.com>
List-ID: <linux-block@vger.kernel.org>

* Fix all pointer declaration which causes
   "ERROR: "foo* bar" should be "foo *bar""

Signed-off-by: RAGHU Halharvi <raghuhack78@gmail.com>
---
 drivers/block/pktcdvd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 59fb66c0e064..50a574049144 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -104,7 +104,7 @@ static struct class	*class_pktcdvd;    /* /sys/class/pktcdvd */
 static struct dentry	*pkt_debugfs_root; /* /sys/kernel/debug/pktcdvd */
 
 /* forward declaration */
-static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev);
+static int pkt_setup_dev(dev_t dev, dev_t *pkt_dev);
 static int pkt_remove_dev(dev_t pkt_dev);
 static int pkt_seq_show(struct seq_file *m, void *p);
 
@@ -116,10 +116,10 @@ static sector_t get_zone(sector_t sector, struct pktcdvd_device *pd)
 /*
  * create and register a pktcdvd kernel object.
  */
-static struct pktcdvd_kobj* pkt_kobj_create(struct pktcdvd_device *pd,
-					const char* name,
-					struct kobject* parent,
-					struct kobj_type* ktype)
+static struct pktcdvd_kobj *pkt_kobj_create(struct pktcdvd_device *pd,
+					const char *name,
+					struct kobject *parent,
+					struct kobj_type *ktype)
 {
 	struct pktcdvd_kobj *p;
 	int error;
@@ -246,7 +246,7 @@ static ssize_t kobj_pkt_show(struct kobject *kobj,
 	return n;
 }
 
-static void init_write_congestion_marks(int* lo, int* hi)
+static void init_write_congestion_marks(int *lo, int *hi)
 {
 	if (*hi > 0) {
 		*hi = max(*hi, 500);
@@ -2708,7 +2708,7 @@ static char *pktcdvd_devnode(struct gendisk *gd, umode_t *mode)
 /*
  * Set up mapping from pktcdvd device to CD-ROM device.
  */
-static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
+static int pkt_setup_dev(dev_t dev, dev_t *pkt_dev)
 {
 	int idx;
 	int ret = -ENOMEM;
-- 
2.17.1
