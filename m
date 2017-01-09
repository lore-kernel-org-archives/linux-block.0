Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: axboe@kernel.dk, Markus Pargmann <mpa@pengutronix.de>
Cc: linux-block@vger.kernel.org, nbd-general@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Subject: [patch] nbd: blk_mq_init_queue returns an error code on failure, not NULL
Date: Mon, 09 Jan 2017 15:20:31 -0500
Message-ID: <x49vatogf3k.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Additionally, don't assign directly to disk->queue, otherwise
blk_put_queue (called via put_disk) will choke (panic) on the errno
stored there.

Bug found by code inspection after Omar found a similar issue in
virtio_blk.  Compile-tested only.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 38c576f..50a2020 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1042,6 +1042,7 @@ static int __init nbd_init(void)
 		return -ENOMEM;
 
 	for (i = 0; i < nbds_max; i++) {
+		struct request_queue *q;
 		struct gendisk *disk = alloc_disk(1 << part_shift);
 		if (!disk)
 			goto out;
@@ -1067,12 +1068,13 @@ static int __init nbd_init(void)
 		 * every gendisk to have its very own request_queue struct.
 		 * These structs are big so we dynamically allocate them.
 		 */
-		disk->queue = blk_mq_init_queue(&nbd_dev[i].tag_set);
-		if (!disk->queue) {
+		q = blk_mq_init_queue(&nbd_dev[i].tag_set);
+		if (IS_ERR(q)) {
 			blk_mq_free_tag_set(&nbd_dev[i].tag_set);
 			put_disk(disk);
 			goto out;
 		}
+		disk->queue = q;
 
 		/*
 		 * Tell the block layer that we are not a rotational device
