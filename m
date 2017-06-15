Return-Path: <linus.walleij@linaro.org>
Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Paolo Valente <paolo.valente@linaro.org>,
	Avri Altman <Avri.Altman@sandisk.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/5] RFC: mmc: block: Convert RPMB to a character device
Date: Thu, 15 Jun 2017 14:12:58 +0200
Message-Id: <20170615121259.8281-5-linus.walleij@linaro.org>
In-Reply-To: <20170615121259.8281-1-linus.walleij@linaro.org>
References: <20170615121259.8281-1-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>

The RPMB partition on the eMMC devices is a special area used
for storing cryptographically safe information signed by a
special secret key. To write and read records from this special
area, authentication is needed.

The RPMB area is *only* and *exclusively* accessed using
ioctl():s from userspace. It is not really a block device,
as blocks cannot be read or written from the device, also
the signed chunks that can be stored on the RPMB are actually
256 bytes, not 512 making a block device a real bad fit.

Currently the RPMB partition spawns a separate block device
named /dev/mmcblkNrpmb for each device with an RPMB partition,
including the creation of a block queue with its own kernel
thread and all overhead associated with this. On the Ux500
HREFv60 platform, for example, the two eMMCs means that two
block queues with separate threads are created for no use
whatsoever.

I have concluded that this block device design for RPMB is
actually pretty wrong. The RPMB area should have been designed
to be accessed from /dev/mmcblkN directly, using ioctl()s on
the main block device. It is however way too late to change
that, since userspace expects to open an RPMB device in
/dev/mmcblkNrpmb and we cannot break userspace.

This patch tries to amend the situation using the following
strategy:

- Stop creating a block device for the RPMB partition/area

- Instead create a custom, dynamic character device with
  the same name.

- Make this new character device support exactly the same
  set of ioctl()s as the old block device.

- Wrap the requests back to the same ioctl() handlers, but
  issue them on the block queue of the main partition/area,
  i.e. /dev/mmcblkN

We need to create a special "rpmb" bus type in order to get
udev and/or busybox hot/coldplug to instantiate the device
node properly.

Before the patch, this appears in 'ps aux':

101 root       0:00 [mmcqd/2rpmb]
123 root       0:00 [mmcqd/3rpmb]

After applying the patch these surplus block queue threads
are gone, but RPMB is as usable as ever using the userspace
MMC tools, such as 'mmc rpmb read-counter'.

We get instead those dynamice devices in /dev:

brw-rw----    1 root     root      179,   0 Jan  1  2000 mmcblk0
brw-rw----    1 root     root      179,   1 Jan  1  2000 mmcblk0p1
brw-rw----    1 root     root      179,   2 Jan  1  2000 mmcblk0p2
brw-rw----    1 root     root      179,   5 Jan  1  2000 mmcblk0p5
brw-rw----    1 root     root      179,   8 Jan  1  2000 mmcblk2
brw-rw----    1 root     root      179,  16 Jan  1  2000 mmcblk2boot0
brw-rw----    1 root     root      179,  24 Jan  1  2000 mmcblk2boot1
crw-rw----    1 root     root      248,   0 Jan  1  2000 mmcblk2rpmb
brw-rw----    1 root     root      179,  32 Jan  1  2000 mmcblk3
brw-rw----    1 root     root      179,  40 Jan  1  2000 mmcblk3boot0
brw-rw----    1 root     root      179,  48 Jan  1  2000 mmcblk3boot1
brw-rw----    1 root     root      179,  33 Jan  1  2000 mmcblk3p1
crw-rw----    1 root     root      248,   1 Jan  1  2000 mmcblk3rpmb

Notice the (248,0) and (248,1) character devices for RPMB.

Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Some discussion points:

I am aware of Tomas Winklers attempts to make RPMB handling into
its own subsystem. I have no such ambitions whatsoever, I am only
trying to sensibly accomodate what we already have and handle
our RPMB in a way that is not littering the place with weirdo
block devices.

The patch is a lot of "that should have been done differently from
the outset" and "it is not a perfect solution", I'd appreciate if
you take a look at the kernel before and after this patch and
think of it as a path forward, are things better or worse like
this, thinking toward the future.

I guess it would be nicer if I could (from the KERNEL) create a
symlink from mmcblk2rpmb -> mmcblk2 or a second mknod creating
mmcblk2rpmb with the same major/minor numbers as the main device.
I guess that can be done with udev scripts, but that breaks all
setups with old udev scripts, busybox, Android etc. So creating
a proper device seems necessary to satisfy userspace.

I haven't been able to do much testing as my RPMB-capable device
seems to be failing to do anything sensible, but I atleast get
the same error codes from "mmc rpmb read-counter /deb/mmcblkNrpmb"
before/after the patch.
---
 drivers/mmc/core/block.c | 278 +++++++++++++++++++++++++++++++++++++++++++----
 drivers/mmc/core/queue.h |   2 +
 2 files changed, 256 insertions(+), 24 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index b8c71fdb6ed4..0a226bc23429 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -28,6 +28,7 @@
 #include <linux/hdreg.h>
 #include <linux/kdev_t.h>
 #include <linux/blkdev.h>
+#include <linux/cdev.h>
 #include <linux/mutex.h>
 #include <linux/scatterlist.h>
 #include <linux/string_helpers.h>
@@ -86,6 +87,7 @@ static int max_devices;
 #define MAX_DEVICES 256
 
 static DEFINE_IDA(mmc_blk_ida);
+static DEFINE_IDA(mmc_rpmb_ida);
 
 /*
  * There is one mmc_blk_data per slot.
@@ -96,6 +98,7 @@ struct mmc_blk_data {
 	struct gendisk	*disk;
 	struct mmc_queue queue;
 	struct list_head part;
+	struct list_head rpmbs;
 
 	unsigned int	flags;
 #define MMC_BLK_CMD23	(1 << 0)	/* Can do SET_BLOCK_COUNT for multiblock */
@@ -121,6 +124,30 @@ struct mmc_blk_data {
 	int	area_type;
 };
 
+/* Device type for RPMB character devices */
+static dev_t rpmb_devt;
+
+/* Bus type for RPMB character devices */
+static struct bus_type rpmb_bus_type = {
+	.name = "rpmb",
+};
+
+/**
+ * struct mmc_rpmb_data - special RPMB device type for these areas
+ * @dev: the device for the RPMB area
+ * @chrdev: character device for the RPMB area
+ * @id: unique device ID number
+ * @md: parent MMC block device
+ * @node: list item, so we can put this device on a list
+ */
+struct mmc_rpmb_data {
+	struct device dev;
+	struct cdev chrdev;
+	int id;
+	struct mmc_blk_data *md;
+	struct list_head node;
+};
+
 static DEFINE_MUTEX(open_lock);
 
 module_param(perdev_minors, int, 0444);
@@ -432,21 +459,29 @@ static int ioctl_do_sanitize(struct mmc_card *card)
 }
 
 static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
-			       struct mmc_blk_ioc_data *idata)
+			       struct mmc_blk_ioc_data *idata, bool rpmb_ioctl)
 {
 	struct mmc_command cmd = {};
 	struct mmc_data data = {};
 	struct mmc_request mrq = {};
 	struct scatterlist sg;
 	int err;
-	bool is_rpmb = false;
+	unsigned int target_part;
 	u32 status = 0;
 
 	if (!card || !md || !idata)
 		return -EINVAL;
 
-	if (md->area_type & MMC_BLK_DATA_AREA_RPMB)
-		is_rpmb = true;
+	/*
+	 * The RPMB accesses comes in from the character device, so we
+	 * need to target these explicitly. Else we just target the
+	 * partition type for the block device the ioctl() was issued
+	 * on.
+	 */
+	if (rpmb_ioctl)
+		target_part = EXT_CSD_PART_CONFIG_ACC_RPMB;
+	else
+		target_part = md->part_type;
 
 	cmd.opcode = idata->ic.opcode;
 	cmd.arg = idata->ic.arg;
@@ -490,7 +525,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 
 	mrq.cmd = &cmd;
 
-	err = mmc_blk_part_switch(card, md->part_type);
+	err = mmc_blk_part_switch(card, target_part);
 	if (err)
 		return err;
 
@@ -500,7 +535,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 			return err;
 	}
 
-	if (is_rpmb) {
+	if (rpmb_ioctl) {
 		err = mmc_set_blockcount(card, data.blocks,
 			idata->ic.write_flag & (1 << 31));
 		if (err)
@@ -540,7 +575,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 
 	memcpy(&(idata->ic.response), cmd.resp, sizeof(cmd.resp));
 
-	if (is_rpmb) {
+	if (rpmb_ioctl) {
 		/*
 		 * Ensure RPMB command has completed by polling CMD13
 		 * "Send Status".
@@ -556,7 +591,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 }
 
 static int mmc_blk_ioctl_cmd(struct mmc_blk_data *md,
-			     struct mmc_ioc_cmd __user *ic_ptr)
+			     struct mmc_ioc_cmd __user *ic_ptr,
+			     bool rpmb_ioctl)
 {
 	struct mmc_blk_ioc_data *idata;
 	struct mmc_blk_ioc_data *idatas[1];
@@ -583,7 +619,10 @@ static int mmc_blk_ioctl_cmd(struct mmc_blk_data *md,
 		idata->ic.write_flag ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
 		__GFP_RECLAIM);
 	idatas[0] = idata;
-	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_IOCTL;
+	if (rpmb_ioctl)
+		req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_IOCTL_RPMB;
+	else
+		req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_IOCTL;
 	req_to_mmc_queue_req(req)->drv_op_data = idatas;
 	req_to_mmc_queue_req(req)->ioc_count = 1;
 	blk_execute_rq(mq->queue, NULL, req, 0);
@@ -598,7 +637,8 @@ static int mmc_blk_ioctl_cmd(struct mmc_blk_data *md,
 }
 
 static int mmc_blk_ioctl_multi_cmd(struct mmc_blk_data *md,
-				   struct mmc_ioc_multi_cmd __user *user)
+				   struct mmc_ioc_multi_cmd __user *user,
+				   bool rpmb_ioctl)
 {
 	struct mmc_blk_ioc_data **idata = NULL;
 	struct mmc_ioc_cmd __user *cmds = user->cmds;
@@ -642,7 +682,10 @@ static int mmc_blk_ioctl_multi_cmd(struct mmc_blk_data *md,
 	req = blk_get_request(mq->queue,
 		idata[0]->ic.write_flag ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
 		__GFP_RECLAIM);
-	req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_IOCTL;
+	if (rpmb_ioctl)
+		req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_IOCTL_RPMB;
+	else
+		req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_IOCTL;
 	req_to_mmc_queue_req(req)->drv_op_data = idata;
 	req_to_mmc_queue_req(req)->ioc_count = num_of_cmds;
 	blk_execute_rq(mq->queue, NULL, req, 0);
@@ -690,7 +733,8 @@ static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
 		if (!md)
 			return -EINVAL;
 		ret = mmc_blk_ioctl_cmd(md,
-					(struct mmc_ioc_cmd __user *)arg);
+					(struct mmc_ioc_cmd __user *)arg,
+					false);
 		mmc_blk_put(md);
 		return ret;
 	case MMC_IOC_MULTI_CMD:
@@ -701,7 +745,8 @@ static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
 		if (!md)
 			return -EINVAL;
 		ret = mmc_blk_ioctl_multi_cmd(md,
-					(struct mmc_ioc_multi_cmd __user *)arg);
+					(struct mmc_ioc_multi_cmd __user *)arg,
+					false);
 		mmc_blk_put(md);
 		return ret;
 	default:
@@ -1173,26 +1218,29 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 	struct mmc_queue_req *mq_rq;
 	struct mmc_card *card = mq->card;
 	struct mmc_blk_data *md = mq->blkdata;
-	struct mmc_blk_data *main_md = dev_get_drvdata(&card->dev);
 	struct mmc_blk_ioc_data **idata;
+	bool rpmb_ioctl;
 	u8 **ext_csd;
 	u32 status;
 	int ret;
 	int i;
 
 	mq_rq = req_to_mmc_queue_req(req);
+	rpmb_ioctl = (mq_rq->drv_op == MMC_DRV_OP_IOCTL_RPMB);
 
 	switch (mq_rq->drv_op) {
 	case MMC_DRV_OP_IOCTL:
+	case MMC_DRV_OP_IOCTL_RPMB:
 		idata = mq_rq->drv_op_data;
 		for (i = 0; i < mq_rq->ioc_count; i++) {
-			ret = __mmc_blk_ioctl_cmd(card, md, idata[i]);
+			ret = __mmc_blk_ioctl_cmd(card, md, idata[i],
+						  rpmb_ioctl);
 			if (ret)
 				break;
 		}
 		/* Always switch back to main area after RPMB access */
-		if (md->area_type & MMC_BLK_DATA_AREA_RPMB)
-			mmc_blk_part_switch(card, main_md->part_type);
+		if (rpmb_ioctl)
+			mmc_blk_part_switch(card, 0);
 		break;
 	case MMC_DRV_OP_BOOT_WP:
 		ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BOOT_WP,
@@ -2006,6 +2054,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 
 	spin_lock_init(&md->lock);
 	INIT_LIST_HEAD(&md->part);
+	INIT_LIST_HEAD(&md->rpmbs);
 	md->usage = 1;
 
 	ret = mmc_init_queue(&md->queue, card, &md->lock, subname);
@@ -2124,6 +2173,151 @@ static int mmc_blk_alloc_part(struct mmc_card *card,
 	return 0;
 }
 
+/**
+ * rpmb_ioctl() - ioctl handler for the RPMB chardev
+ * @filp: the character device file
+ * @cmd: the ioctl() command
+ * @arg: the argument from userspace
+ *
+ * This will essentially just redirect the ioctl()s coming in over to
+ * the main block device spawning the RPMB character device.
+ */
+static long rpmb_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct mmc_rpmb_data *rpmb = filp->private_data;
+	int ret;
+
+	switch (cmd) {
+	case MMC_IOC_CMD:
+		ret = mmc_blk_ioctl_cmd(rpmb->md,
+					(struct mmc_ioc_cmd __user *)arg,
+					true);
+		break;
+	case MMC_IOC_MULTI_CMD:
+		ret = mmc_blk_ioctl_multi_cmd(rpmb->md,
+					(struct mmc_ioc_multi_cmd __user *)arg,
+					true);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_COMPAT
+static long rpmb_ioctl_compat(struct file *filp, unsigned int cmd,
+			      unsigned long arg)
+{
+	return rpmb_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
+static int rpmb_chrdev_open(struct inode *inode, struct file *filp)
+{
+	struct mmc_rpmb_data *rpmb = container_of(inode->i_cdev,
+						  struct mmc_rpmb_data, chrdev);
+
+	get_device(&rpmb->dev);
+	filp->private_data = rpmb;
+	mutex_lock(&open_lock);
+	rpmb->md->usage++;
+	mutex_unlock(&open_lock);
+
+	return nonseekable_open(inode, filp);
+}
+
+static int rpmb_chrdev_release(struct inode *inode, struct file *filp)
+{
+	struct mmc_rpmb_data *rpmb = container_of(inode->i_cdev,
+						  struct mmc_rpmb_data, chrdev);
+
+	put_device(&rpmb->dev);
+	mutex_lock(&open_lock);
+	rpmb->md->usage--;
+	mutex_unlock(&open_lock);
+
+	return 0;
+}
+
+static const struct file_operations rpmb_fileops = {
+	.release = rpmb_chrdev_release,
+	.open = rpmb_chrdev_open,
+	.owner = THIS_MODULE,
+	.llseek = no_llseek,
+	.unlocked_ioctl = rpmb_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = rpmb_ioctl_compat,
+#endif
+};
+
+
+static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
+				   struct mmc_blk_data *md,
+				   sector_t size,
+				   const char *subname)
+{
+	int devidx, ret;
+	char rpmb_name[DISK_NAME_LEN];
+	char cap_str[10];
+	struct mmc_rpmb_data *rpmb;
+
+	/* This creates the minor number for the RPMB char device */
+	devidx = ida_simple_get(&mmc_rpmb_ida, 0, max_devices, GFP_KERNEL);
+	if (devidx < 0)
+		return devidx;
+
+	rpmb = kzalloc(sizeof(*rpmb), GFP_KERNEL);
+	if (!rpmb)
+		return -ENOMEM;
+
+	snprintf(rpmb_name, sizeof(rpmb_name),
+		 "mmcblk%u%s", card->host->index, subname ? subname : "");
+
+	rpmb->id = devidx;
+	rpmb->dev.init_name = rpmb_name;
+	rpmb->dev.bus = &rpmb_bus_type;
+	rpmb->dev.devt = MKDEV(MAJOR(rpmb_devt), rpmb->id);
+	rpmb->dev.parent = &card->dev;
+	device_initialize(&rpmb->dev);
+	dev_set_drvdata(&rpmb->dev, rpmb);
+	rpmb->md = md;
+
+	cdev_init(&rpmb->chrdev, &rpmb_fileops);
+	rpmb->chrdev.owner = THIS_MODULE;
+	ret = cdev_device_add(&rpmb->chrdev, &rpmb->dev);
+	if (ret) {
+		pr_err("%s: could not add character device\n", rpmb_name);
+		goto out_remove_ida;
+	}
+
+	list_add(&rpmb->node, &md->rpmbs);
+
+	string_get_size((u64)size, 512, STRING_UNITS_2,
+			cap_str, sizeof(cap_str));
+
+	pr_info("%s: %s %s partition %u %s, chardev (%d:%d)\n",
+		rpmb_name, mmc_card_id(card),
+		mmc_card_name(card), EXT_CSD_PART_CONFIG_ACC_RPMB, cap_str,
+		MAJOR(rpmb_devt), rpmb->id);
+
+	return 0;
+
+out_remove_ida:
+	ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
+	kfree(rpmb);
+	return ret;
+}
+
+static void mmc_blk_remove_rpmb_part(struct mmc_rpmb_data *rpmb)
+{
+	cdev_device_del(&rpmb->chrdev, &rpmb->dev);
+	device_del(&rpmb->dev);
+	ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
+	kfree(rpmb);
+}
+
 /* MMC Physical partitions consist of two boot partitions and
  * up to four general purpose partitions.
  * For each partition enabled in EXT_CSD a block device will be allocatedi
@@ -2132,13 +2326,25 @@ static int mmc_blk_alloc_part(struct mmc_card *card,
 
 static int mmc_blk_alloc_parts(struct mmc_card *card, struct mmc_blk_data *md)
 {
-	int idx, ret = 0;
+	int idx, ret;
 
 	if (!mmc_card_mmc(card))
 		return 0;
 
 	for (idx = 0; idx < card->nr_parts; idx++) {
-		if (card->part[idx].size) {
+		if (card->part[idx].area_type & MMC_BLK_DATA_AREA_RPMB) {
+			/*
+			 * RPMB partitions does not provide block access, they
+			 * are only accessed using ioctl():s. Thus create
+			 * special RPMB block devices that do not have a
+			 * backing block queue for these.
+			 */
+			ret = mmc_blk_alloc_rpmb_part(card, md,
+				card->part[idx].size >> 9,
+				card->part[idx].name);
+			if (ret)
+				return ret;
+		} else if (card->part[idx].size) {
 			ret = mmc_blk_alloc_part(card, md,
 				card->part[idx].part_cfg,
 				card->part[idx].size >> 9,
@@ -2150,7 +2356,7 @@ static int mmc_blk_alloc_parts(struct mmc_card *card, struct mmc_blk_data *md)
 		}
 	}
 
-	return ret;
+	return 0;
 }
 
 static void mmc_blk_remove_req(struct mmc_blk_data *md)
@@ -2183,7 +2389,15 @@ static void mmc_blk_remove_parts(struct mmc_card *card,
 {
 	struct list_head *pos, *q;
 	struct mmc_blk_data *part_md;
+	struct mmc_rpmb_data *rpmb;
 
+	/* Remove RPMB partitions */
+	list_for_each_safe(pos, q, &md->rpmbs) {
+		rpmb = list_entry(pos, struct mmc_rpmb_data, node);
+		list_del(pos);
+		mmc_blk_remove_rpmb_part(rpmb);
+	}
+	/* Remove block partitions */
 	list_for_each_safe(pos, q, &md->part) {
 		part_md = list_entry(pos, struct mmc_blk_data, part);
 		list_del(pos);
@@ -2502,6 +2716,17 @@ static int __init mmc_blk_init(void)
 {
 	int res;
 
+	res  = bus_register(&rpmb_bus_type);
+	if (res < 0) {
+		pr_err("mmcblk: could not register RPMB bus type\n");
+		return res;
+	}
+	res = alloc_chrdev_region(&rpmb_devt, 0, MAX_DEVICES, "rpmb");
+	if (res < 0) {
+		pr_err("mmcblk: failed to allocate rpmb chrdev region\n");
+		goto out_bus_unreg;
+	}
+
 	if (perdev_minors != CONFIG_MMC_BLOCK_MINORS)
 		pr_info("mmcblk: using %d minors per device\n", perdev_minors);
 
@@ -2509,16 +2734,20 @@ static int __init mmc_blk_init(void)
 
 	res = register_blkdev(MMC_BLOCK_MAJOR, "mmc");
 	if (res)
-		goto out;
+		goto out_chrdev_unreg;
 
 	res = mmc_register_driver(&mmc_driver);
 	if (res)
-		goto out2;
+		goto out_blkdev_unreg;
 
 	return 0;
- out2:
+
+out_blkdev_unreg:
 	unregister_blkdev(MMC_BLOCK_MAJOR, "mmc");
- out:
+out_chrdev_unreg:
+	unregister_chrdev_region(rpmb_devt, MAX_DEVICES);
+out_bus_unreg:
+	bus_unregister(&rpmb_bus_type);
 	return res;
 }
 
@@ -2526,6 +2755,7 @@ static void __exit mmc_blk_exit(void)
 {
 	mmc_unregister_driver(&mmc_driver);
 	unregister_blkdev(MMC_BLOCK_MAJOR, "mmc");
+	unregister_chrdev_region(rpmb_devt, MAX_DEVICES);
 }
 
 module_init(mmc_blk_init);
diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
index 04fc89360a7a..a2b6a9fcab01 100644
--- a/drivers/mmc/core/queue.h
+++ b/drivers/mmc/core/queue.h
@@ -35,12 +35,14 @@ struct mmc_blk_request {
 /**
  * enum mmc_drv_op - enumerates the operations in the mmc_queue_req
  * @MMC_DRV_OP_IOCTL: ioctl operation
+ * @MMC_DRV_OP_IOCTL_RPMB: RPMB-oriented ioctl operation
  * @MMC_DRV_OP_BOOT_WP: write protect boot partitions
  * @MMC_DRV_OP_GET_CARD_STATUS: get card status
  * @MMC_DRV_OP_GET_EXT_CSD: get the EXT CSD from an eMMC card
  */
 enum mmc_drv_op {
 	MMC_DRV_OP_IOCTL,
+	MMC_DRV_OP_IOCTL_RPMB,
 	MMC_DRV_OP_BOOT_WP,
 	MMC_DRV_OP_GET_CARD_STATUS,
 	MMC_DRV_OP_GET_EXT_CSD,
-- 
2.9.4
