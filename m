Return-Path: <jiufei.xue@linux.alibaba.com>
From: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Subject: [PATCH 3/4] block: display the correct diskname for bio
To: hch@lst.de, Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, caspar@linux.alibaba.com,
 Joseph Qi <joseph.qi@linux.alibaba.com>
References: <fc363a8d-957c-be3a-e60a-a8b40727d727@linux.alibaba.com>
Message-ID: <675554d9-afdb-c7c5-1c5e-643002048d02@linux.alibaba.com>
Date: Mon, 26 Feb 2018 20:04:41 +0800
MIME-Version: 1.0
In-Reply-To: <fc363a8d-957c-be3a-e60a-a8b40727d727@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

bio_devname use __bdevname to display the device name, and can
only show the major and minor of the part0.
Fix this by using disk_name to display the correct name.

Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
---
 block/partition-generic.c | 6 ++++++
 include/linux/bio.h       | 4 +---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index 91622db..08dabcd 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -51,6 +51,12 @@ const char *bdevname(struct block_device *bdev, char *buf)
 
 EXPORT_SYMBOL(bdevname);
 
+const char *bio_devname(struct bio *bio, char *buf)
+{
+	return disk_name(bio->bi_disk, bio->bi_partno, buf);
+}
+EXPORT_SYMBOL(bio_devname);
+
 /*
  * There's very little reason to use this, you should really
  * have a struct block_device just about everywhere and use
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d0eb659..ce547a2 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -511,6 +511,7 @@ extern struct bio *bio_copy_user_iov(struct request_queue *,
 extern struct bio_vec *bvec_alloc(gfp_t, int, unsigned long *, mempool_t *);
 extern void bvec_free(mempool_t *, struct bio_vec *, unsigned int);
 extern unsigned int bvec_nr_vecs(unsigned short idx);
+extern const char *bio_devname(struct bio *bio, char *buffer);
 
 #define bio_set_dev(bio, bdev) 			\
 do {						\
@@ -529,9 +530,6 @@ extern struct bio *bio_copy_user_iov(struct request_queue *,
 #define bio_dev(bio) \
 	disk_devt((bio)->bi_disk)
 
-#define bio_devname(bio, buf) \
-	__bdevname(bio_dev(bio), (buf))
-
 #ifdef CONFIG_BLK_CGROUP
 int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css);
 void bio_disassociate_task(struct bio *bio);
-- 
1.9.4
