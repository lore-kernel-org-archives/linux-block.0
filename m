Return-Path: <famz@redhat.com>
From: Fam Zheng <famz@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Jens Axboe <axboe@kernel.dk>,
        "Ed L. Cashin" <ed.cashin@acm.org>, Jiri Kosina <jikos@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Shaohua Li <shli@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Keith Busch <keith.busch@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>, famz@redhat.com
Subject: [PATCH v2 03/12] virtio-blk: Generate uevent after attribute available
Date: Thu, 30 Jun 2016 09:59:44 +0800
Message-Id: <20160630015953.6888-4-famz@redhat.com>
In-Reply-To: <20160630015953.6888-1-famz@redhat.com>
References: <20160630015953.6888-1-famz@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Userspace listens to the KOBJ_ADD uevent generated in add_disk. At that
point we haven't created the serial attribute file, therefore depending
on how fast udev reacts, the /dev/disk/by-id/ entry doesn't always get
created.

This race condition can be easily reproduced by hot plugging a number of
virtio-blk disks.

Also in systemd, there used to be a related workaround in udev rules
called 'WAIT_FOR="serial"', but it is removed in later versions.

Now let's generate a KOBJ_CHANGE event after the attributes are ready.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 drivers/block/virtio_blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index f3a59f9..cd9a036 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -733,7 +733,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	add_disk(vblk->disk, true);
+	add_disk(vblk->disk, false);
 	err = device_create_file(disk_to_dev(vblk->disk), &dev_attr_serial);
 	if (err)
 		goto out_del_disk;
@@ -746,6 +746,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 					 &dev_attr_cache_type_ro);
 	if (err)
 		goto out_del_disk;
+	disk_gen_uevents(vblk->disk);
 	return 0;
 
 out_del_disk:
-- 
2.9.0
