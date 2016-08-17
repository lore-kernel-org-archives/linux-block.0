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
Subject: [PATCH 12/15] mtip: Pass attribute group to device_add_disk
Date: Wed, 17 Aug 2016 15:15:12 +0800
Message-Id: <1471418115-3654-13-git-send-email-famz@redhat.com>
In-Reply-To: <1471418115-3654-1-git-send-email-famz@redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Previously after device_add_disk returns, the KOBJ_ADD uevent is already
emitted. Adding attributes after that is a poor usage of kobject, and
in practice may result in race conditions with userspace, for
example udev checks availability of certain attributes and initializes
/dev entries conditionally.

device_add_disk can handle adding attribute group better, so use it.
Meanwhile, update the error check code and message.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 38 ++++++++------------------------------
 1 file changed, 8 insertions(+), 30 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 4048a70..504c549 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2702,26 +2702,14 @@ static const struct file_operations mtip_flags_fops = {
 	.llseek = no_llseek,
 };
 
-/*
- * Create the sysfs related attributes.
- *
- * @dd   Pointer to the driver data structure.
- * @kobj Pointer to the kobj for the block device.
- *
- * return value
- *	0	Operation completed successfully.
- *	-EINVAL Invalid parameter.
- */
-static int mtip_hw_sysfs_init(struct driver_data *dd, struct kobject *kobj)
-{
-	if (!kobj || !dd)
-		return -EINVAL;
+static struct attribute *mtip_dev_attrs[] = {
+	&dev_attr_status.attr,
+	NULL
+};
 
-	if (sysfs_create_file(kobj, &dev_attr_status.attr))
-		dev_warn(&dd->pdev->dev,
-			"Error creating 'status' sysfs entry\n");
-	return 0;
-}
+static struct attribute_group mtip_attr_group = {
+	.attrs = mtip_dev_attrs,
+};
 
 /*
  * Remove the sysfs related attributes.
@@ -3918,7 +3906,6 @@ static int mtip_block_initialize(struct driver_data *dd)
 	int rv = 0, wait_for_rebuild = 0;
 	sector_t capacity;
 	unsigned int index = 0;
-	struct kobject *kobj;
 
 	if (dd->disk)
 		goto skip_create_disk; /* hw init done, before rebuild */
@@ -4041,18 +4028,9 @@ skip_create_disk:
 	set_capacity(dd->disk, capacity);
 
 	/* Enable the block device and add it to /dev */
-	device_add_disk(&dd->pdev->dev, dd->disk, NULL);
+	device_add_disk(&dd->pdev->dev, dd->disk, &mtip_attr_group);
 
 	dd->bdev = bdget_disk(dd->disk, 0);
-	/*
-	 * Now that the disk is active, initialize any sysfs attributes
-	 * managed by the protocol layer.
-	 */
-	kobj = kobject_get(&disk_to_dev(dd->disk)->kobj);
-	if (kobj) {
-		mtip_hw_sysfs_init(dd, kobj);
-		kobject_put(kobj);
-	}
 
 	if (dd->mtip_svc_handler) {
 		set_bit(MTIP_DDF_INIT_DONE_BIT, &dd->dd_flag);
-- 
2.7.4
