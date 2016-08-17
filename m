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
Subject: [PATCH 04/15] block: Return error from blk_integrity_add
Date: Wed, 17 Aug 2016 15:15:04 +0800
Message-Id: <1471418115-3654-5-git-send-email-famz@redhat.com>
In-Reply-To: <1471418115-3654-1-git-send-email-famz@redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
List-ID: <linux-block@vger.kernel.org>

The kobject_init_and_add call in blk_integrity_add can fail, return the
error code in this case, so that it can be handled in the caller.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/blk-integrity.c | 12 ++++++++----
 include/linux/genhd.h |  4 ++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index d69c5c7..437e09a 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -450,13 +450,17 @@ void blk_integrity_revalidate(struct gendisk *disk)
 			~BDI_CAP_STABLE_WRITES;
 }
 
-void blk_integrity_add(struct gendisk *disk)
+int blk_integrity_add(struct gendisk *disk)
 {
-	if (kobject_init_and_add(&disk->integrity_kobj, &integrity_ktype,
-				 &disk_to_dev(disk)->kobj, "%s", "integrity"))
-		return;
+	int rc;
+
+	rc = kobject_init_and_add(&disk->integrity_kobj, &integrity_ktype,
+				  &disk_to_dev(disk)->kobj, "%s", "integrity");
+	if (rc)
+		return rc;
 
 	kobject_uevent(&disk->integrity_kobj, KOBJ_ADD);
+	return 0;
 }
 
 void blk_integrity_del(struct gendisk *disk)
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index b6fd666..85ce560 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -725,11 +725,11 @@ static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
 }
 
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
-extern void blk_integrity_add(struct gendisk *);
+extern int blk_integrity_add(struct gendisk *);
 extern void blk_integrity_del(struct gendisk *);
 extern void blk_integrity_revalidate(struct gendisk *);
 #else	/* CONFIG_BLK_DEV_INTEGRITY */
-static inline void blk_integrity_add(struct gendisk *disk) { }
+static inline int blk_integrity_add(struct gendisk *disk) { return 0; }
 static inline void blk_integrity_del(struct gendisk *disk) { }
 static inline void blk_integrity_revalidate(struct gendisk *disk) { }
 #endif	/* CONFIG_BLK_DEV_INTEGRITY */
-- 
2.7.4
