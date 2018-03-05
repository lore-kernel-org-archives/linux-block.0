Return-Path: <holger@applied-asynchrony.com>
To: linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: loop: properly declare rotational flag of underlying device
Message-ID: <627661e4-476f-ade0-97c0-8b4812445d93@applied-asynchrony.com>
Date: Mon, 5 Mar 2018 13:34:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>


The loop driver has always declared the rotational flag of its device as
rotational, even when the device of the mapped file is nonrotational,
as is the case with SSDs or on tmpfs. This can confuse filesystem tools
which are SSD-aware; in my case I frequently forget to tell mkfs.btrfs
that my loop device on tmpfs is nonrotational, and that I really don't
need any automatic metadata redundancy.

The attached patch fixes this by introspecting the rotational flag of the
mapped file's underlying block device, if it exists. If the mapped file's
filesystem has no associated block device - as is the case on e.g. tmpfs -
we assume nonrotational storage. If there is a better way to identify such
non-devices I'd love to hear them.

On previous submission (~2 years ago I think) Jens commented that this
"changes the default". Tat's precisely the point: the default of declaring
rotational behaviour unconditionally is more likely to be wrong than
the other way around. To the best of my knowledge there are no byte-
addressable but physically rotating media without associated block device.
<insert STT-RAM joke here>

This is fresh against 4.16-rc4 and has been in production since 4.9,
with some minor changes to accommodate initialization order in 4.14.

Please consider for 4.17.

Signed-off-by: Holger Hoffstätte <holger@applied-asynchrony.com>

cheers,
Holger

diff -rup linux-4.16-rc4/drivers/block/loop.c linux-4.16-rc4-loop/drivers/block/loop.c
--- linux-4.16-rc4/drivers/block/loop.c	2018-03-04 23:54:11.000000000 +0100
+++ linux-4.16-rc4-loop/drivers/block/loop.c	2018-03-05 00:41:48.013602156 +0100
@@ -829,6 +829,24 @@ static void loop_config_discard(struct l
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
 }
 
+static void loop_update_rotational(struct loop_device *lo)
+{
+	struct file *file = lo->lo_backing_file;
+	struct inode *file_inode = file->f_mapping->host;
+	struct block_device *file_bdev = file_inode->i_sb->s_bdev;
+	struct request_queue *q = lo->lo_queue;
+	bool nonrot = true;
+
+	/* not all filesystems (e.g. tmpfs) have a sb->s_bdev */
+	if (file_bdev)
+		nonrot = blk_queue_nonrot(bdev_get_queue(file_bdev));
+
+	if (nonrot)
+		queue_flag_set_unlocked(QUEUE_FLAG_NONROT, q);
+	else
+		queue_flag_clear_unlocked(QUEUE_FLAG_NONROT, q);
+}
+
 static void loop_unprepare_queue(struct loop_device *lo)
 {
 	kthread_flush_worker(&lo->worker);
@@ -929,6 +947,7 @@ static int loop_set_fd(struct loop_devic
 	loop_update_dio(lo);
 	set_capacity(lo->lo_disk, size);
 	bd_set_size(bdev, size << 9);
+	loop_update_rotational(lo);
 	loop_sysfs_init(lo);
 	/* let user-space know about the new size */
 	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
