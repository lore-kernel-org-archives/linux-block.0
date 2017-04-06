Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	nbd-general@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 11/12] nbd: add device refcounting
Date: Thu,  6 Apr 2017 17:02:06 -0400
Message-Id: <1491512527-4286-12-git-send-email-jbacik@fb.com>
In-Reply-To: <1491512527-4286-1-git-send-email-jbacik@fb.com>
References: <1491512527-4286-1-git-send-email-jbacik@fb.com>
List-ID: <linux-block@vger.kernel.org>

In order to support deleting the device on disconnect we need to
refcount the actual nbd_device struct.  So add the refcounting framework
and change how we free the normal devices at rmmod time so we can catch
reference leaks.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c | 104 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 86 insertions(+), 18 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index e1289d0..b33014a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -99,10 +99,12 @@ struct nbd_device {
 
 	int index;
 	refcount_t config_refs;
+	refcount_t refs;
 	struct nbd_config *config;
 	struct mutex config_lock;
 	struct gendisk *disk;
 
+	struct list_head list;
 	struct task_struct *task_recv;
 	struct task_struct *task_setup;
 };
@@ -165,6 +167,28 @@ static struct device_attribute pid_attr = {
 	.show = pid_show,
 };
 
+static void nbd_dev_remove(struct nbd_device *nbd)
+{
+	struct gendisk *disk = nbd->disk;
+	if (disk) {
+		del_gendisk(disk);
+		blk_cleanup_queue(disk->queue);
+		blk_mq_free_tag_set(&nbd->tag_set);
+		put_disk(disk);
+	}
+	kfree(nbd);
+}
+
+static void nbd_put(struct nbd_device *nbd)
+{
+	if (refcount_dec_and_mutex_lock(&nbd->refs,
+					&nbd_index_mutex)) {
+		idr_remove(&nbd_index_idr, nbd->index);
+		mutex_unlock(&nbd_index_mutex);
+		nbd_dev_remove(nbd);
+	}
+}
+
 static int nbd_disconnected(struct nbd_config *config)
 {
 	return test_bit(NBD_DISCONNECTED, &config->runtime_flags) ||
@@ -1005,6 +1029,7 @@ static void nbd_config_put(struct nbd_device *nbd)
 		}
 		nbd_reset(nbd);
 		mutex_unlock(&nbd->config_lock);
+		nbd_put(nbd);
 		module_put(THIS_MODULE);
 	}
 }
@@ -1199,6 +1224,10 @@ static int nbd_open(struct block_device *bdev, fmode_t mode)
 		ret = -ENXIO;
 		goto out;
 	}
+	if (!refcount_inc_not_zero(&nbd->refs)) {
+		ret = -ENXIO;
+		goto out;
+	}
 	if (!refcount_inc_not_zero(&nbd->config_refs)) {
 		struct nbd_config *config;
 
@@ -1214,6 +1243,7 @@ static int nbd_open(struct block_device *bdev, fmode_t mode)
 			goto out;
 		}
 		refcount_set(&nbd->config_refs, 1);
+		refcount_inc(&nbd->refs);
 		mutex_unlock(&nbd->config_lock);
 	}
 out:
@@ -1225,6 +1255,7 @@ static void nbd_release(struct gendisk *disk, fmode_t mode)
 {
 	struct nbd_device *nbd = disk->private_data;
 	nbd_config_put(nbd);
+	nbd_put(nbd);
 }
 
 static const struct block_device_operations nbd_fops =
@@ -1378,18 +1409,6 @@ static const struct blk_mq_ops nbd_mq_ops = {
 	.timeout	= nbd_xmit_timeout,
 };
 
-static void nbd_dev_remove(struct nbd_device *nbd)
-{
-	struct gendisk *disk = nbd->disk;
-	if (disk) {
-		del_gendisk(disk);
-		blk_cleanup_queue(disk->queue);
-		blk_mq_free_tag_set(&nbd->tag_set);
-		put_disk(disk);
-	}
-	kfree(nbd);
-}
-
 static int nbd_dev_add(int index)
 {
 	struct nbd_device *nbd;
@@ -1453,6 +1472,8 @@ static int nbd_dev_add(int index)
 
 	mutex_init(&nbd->config_lock);
 	refcount_set(&nbd->config_refs, 0);
+	refcount_set(&nbd->refs, 1);
+	INIT_LIST_HEAD(&nbd->list);
 	disk->major = NBD_MAJOR;
 	disk->first_minor = index << part_shift;
 	disk->fops = &nbd_fops;
@@ -1550,16 +1571,26 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	} else {
 		nbd = idr_find(&nbd_index_idr, index);
 	}
-	mutex_unlock(&nbd_index_mutex);
 	if (!nbd) {
 		printk(KERN_ERR "nbd: couldn't find device at index %d\n",
 		       index);
+		mutex_unlock(&nbd_index_mutex);
+		return -EINVAL;
+	}
+	if (!refcount_inc_not_zero(&nbd->refs)) {
+		mutex_unlock(&nbd_index_mutex);
+		if (index == -1)
+			goto again;
+		printk(KERN_ERR "nbd: device at index %d is going down\n",
+		       index);
 		return -EINVAL;
 	}
+	mutex_unlock(&nbd_index_mutex);
 
 	mutex_lock(&nbd->config_lock);
 	if (refcount_read(&nbd->config_refs)) {
 		mutex_unlock(&nbd->config_lock);
+		nbd_put(nbd);
 		if (index == -1)
 			goto again;
 		printk(KERN_ERR "nbd: nbd%d already in use\n", index);
@@ -1567,11 +1598,13 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 	}
 	if (WARN_ON(nbd->config)) {
 		mutex_unlock(&nbd->config_lock);
+		nbd_put(nbd);
 		return -EINVAL;
 	}
 	config = nbd->config = nbd_alloc_config();
 	if (!nbd->config) {
 		mutex_unlock(&nbd->config_lock);
+		nbd_put(nbd);
 		printk(KERN_ERR "nbd: couldn't allocate config\n");
 		return -ENOMEM;
 	}
@@ -1656,14 +1689,23 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 	index = nla_get_u32(info->attrs[NBD_ATTR_INDEX]);
 	mutex_lock(&nbd_index_mutex);
 	nbd = idr_find(&nbd_index_idr, index);
-	mutex_unlock(&nbd_index_mutex);
 	if (!nbd) {
+		mutex_unlock(&nbd_index_mutex);
 		printk(KERN_ERR "nbd: couldn't find device at index %d\n",
 		       index);
 		return -EINVAL;
 	}
-	if (!refcount_inc_not_zero(&nbd->config_refs))
+	if (!refcount_inc_not_zero(&nbd->refs)) {
+		mutex_unlock(&nbd_index_mutex);
+		printk(KERN_ERR "nbd: device at index %d is going down\n",
+		       index);
+		return -EINVAL;
+	}
+	mutex_unlock(&nbd_index_mutex);
+	if (!refcount_inc_not_zero(&nbd->config_refs)) {
+		nbd_put(nbd);
 		return 0;
+	}
 	mutex_lock(&nbd->config_lock);
 	nbd_disconnect(nbd);
 	mutex_unlock(&nbd->config_lock);
@@ -1671,6 +1713,7 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
 			       &nbd->config->runtime_flags))
 		nbd_config_put(nbd);
 	nbd_config_put(nbd);
+	nbd_put(nbd);
 	return 0;
 }
 
@@ -1691,16 +1734,24 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 	index = nla_get_u32(info->attrs[NBD_ATTR_INDEX]);
 	mutex_lock(&nbd_index_mutex);
 	nbd = idr_find(&nbd_index_idr, index);
-	mutex_unlock(&nbd_index_mutex);
 	if (!nbd) {
+		mutex_unlock(&nbd_index_mutex);
 		printk(KERN_ERR "nbd: couldn't find a device at index %d\n",
 		       index);
 		return -EINVAL;
 	}
+	if (!refcount_inc_not_zero(&nbd->refs)) {
+		mutex_unlock(&nbd_index_mutex);
+		printk(KERN_ERR "nbd: device at index %d is going down\n",
+		       index);
+		return -EINVAL;
+	}
+	mutex_unlock(&nbd_index_mutex);
 
 	if (!refcount_inc_not_zero(&nbd->config_refs)) {
 		dev_err(nbd_to_dev(nbd),
 			"not configured, cannot reconfigure\n");
+		nbd_put(nbd);
 		return -EINVAL;
 	}
 
@@ -1759,6 +1810,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 out:
 	mutex_unlock(&nbd->config_lock);
 	nbd_config_put(nbd);
+	nbd_put(nbd);
 	return ret;
 }
 
@@ -2004,16 +2056,32 @@ static int __init nbd_init(void)
 
 static int nbd_exit_cb(int id, void *ptr, void *data)
 {
+	struct list_head *list = (struct list_head *)data;
 	struct nbd_device *nbd = ptr;
-	nbd_dev_remove(nbd);
+
+	refcount_inc(&nbd->refs);
+	list_add_tail(&nbd->list, list);
 	return 0;
 }
 
 static void __exit nbd_cleanup(void)
 {
+	struct nbd_device *nbd;
+	LIST_HEAD(del_list);
+
 	nbd_dbg_close();
 
-	idr_for_each(&nbd_index_idr, &nbd_exit_cb, NULL);
+	mutex_lock(&nbd_index_mutex);
+	idr_for_each(&nbd_index_idr, &nbd_exit_cb, &del_list);
+	mutex_unlock(&nbd_index_mutex);
+
+	list_for_each_entry(nbd, &del_list, list) {
+		if (refcount_read(&nbd->refs) != 2)
+			printk(KERN_ERR "nbd: possibly leaking a device\n");
+		nbd_put(nbd);
+		nbd_put(nbd);
+	}
+
 	idr_destroy(&nbd_index_idr);
 	genl_unregister_family(&nbd_genl_family);
 	destroy_workqueue(recv_workqueue);
-- 
2.7.4
