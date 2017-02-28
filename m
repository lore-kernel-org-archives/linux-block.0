Return-Path: <prvs=423213d9ff=jbacik@fb.com>
From: Josef Bacik <jbacik@fb.com>
To: <axboe@kernel.dk>, <nbd-general@lists.sourceforge.net>,
        <linux-block@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH 6/6] nbd: add a basic netlink interface
Date: Tue, 28 Feb 2017 11:57:11 -0500
Message-ID: <1488301031-3199-7-git-send-email-jbacik@fb.com>
In-Reply-To: <1488301031-3199-1-git-send-email-jbacik@fb.com>
References: <1488301031-3199-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

The existing ioctl interface for configuring NBD devices is a bit
cumbersome and hard to extend.  The other problem is we leave a
userspace app sitting in it's syscall until the device disconnects,
which is less than ideal.

This patch introduces a netlink interface for adding and disconnecting
nbd devices.  This has the benefits of being easily extendable without
breaking older userspace applications, and allows us to configure a nbd
device without leaving a userspace app sitting waiting for the device to
disconnect.

With this interface we also gain the ability to configure more devices
than are preallocated at insmod time.  We also have gained the ability
to not specify a particular device and be provided one for us so that
userspace doesn't need to find a free device to configure.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 drivers/block/nbd.c              | 328 ++++++++++++++++++++++++++++++++++-----
 include/uapi/linux/nbd-netlink.h |  69 ++++++++
 2 files changed, 354 insertions(+), 43 deletions(-)
 create mode 100644 include/uapi/linux/nbd-netlink.h

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index aba1aba..62a659e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -40,6 +40,8 @@
 #include <asm/types.h>
 
 #include <linux/nbd.h>
+#include <linux/nbd-netlink.h>
+#include <net/genetlink.h>
 
 static DEFINE_IDR(nbd_index_idr);
 static DEFINE_MUTEX(nbd_index_mutex);
@@ -63,6 +65,7 @@ struct recv_thread_args {
 #define NBD_DISCONNECT_REQUESTED	1
 #define NBD_DISCONNECTED		2
 #define NBD_HAS_SOCKS_REF		3
+#define NBD_BOUND			4
 
 struct nbd_device {
 	u32 flags;
@@ -75,6 +78,7 @@ struct nbd_device {
 
 	struct recv_thread_args *args;
 	int magic;
+	int index;
 
 	struct blk_mq_tag_set tag_set;
 
@@ -115,6 +119,7 @@ static int part_shift;
 static int nbd_dev_dbg_init(struct nbd_device *nbd);
 static void nbd_dev_dbg_close(struct nbd_device *nbd);
 static void nbd_put(struct nbd_device *nbd);
+static void nbd_connect_reply(struct genl_info *info, int index);
 
 static inline struct device *nbd_to_dev(struct nbd_device *nbd)
 {
@@ -752,7 +757,8 @@ static int nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg)
+static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
+			  bool netlink)
 {
 	struct socket *sock;
 	struct nbd_sock **socks;
@@ -764,13 +770,14 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg)
 		return err;
 
 	err = -EINVAL;
-	if (!nbd->task_setup && !atomic_cmpxchg(&nbd->refs, 0, 1)) {
+	if (!netlink && !nbd->task_setup &&
+	    !atomic_cmpxchg(&nbd->refs, 0, 1)) {
 		nbd->task_setup = current;
 		set_bit(NBD_HAS_SOCKS_REF, &nbd->runtime_flags);
 		try_module_get(THIS_MODULE);
 	}
 
-	if (nbd->task_setup != current) {
+	if (!netlink && nbd->task_setup != current) {
 		dev_err(disk_to_dev(nbd->disk),
 			"Device being setup by another task");
 		goto out;
@@ -895,52 +902,36 @@ static void nbd_put(struct nbd_device *nbd)
 	}
 }
 
-static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
+static int nbd_start_device(struct nbd_device *nbd)
 {
 	struct recv_thread_args *args;
 	int num_connections = nbd->num_connections;
 	int error = 0, i;
 
-	if (!nbd_get_unless_zero(nbd))
+	if (nbd->task_recv)
+		return -EBUSY;
+	if (!nbd->socks)
 		return -EINVAL;
-	if (nbd->task_recv) {
-		error = -EBUSY;
-		goto out;
-	}
-	if (!nbd->socks) {
-		error = -EINVAL;
-		goto out;
-	}
 	if (num_connections > 1 &&
 	    !(nbd->flags & NBD_FLAG_CAN_MULTI_CONN)) {
 		dev_err(disk_to_dev(nbd->disk), "server does not support multiple connections per device.\n");
-		error = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
-	if (max_part)
-		bdev->bd_invalidated = 1;
-
 	blk_mq_update_nr_hw_queues(&nbd->tag_set, nbd->num_connections);
 	args = kcalloc(num_connections, sizeof(*args), GFP_KERNEL);
-	if (!args) {
-		error = -ENOMEM;
-		goto out;
-	}
+	if (!args)
+		return -ENOMEM;
 	nbd->args = args;
 	nbd->task_recv = current;
-	mutex_unlock(&nbd->config_lock);
 
 	nbd_parse_flags(nbd);
 
 	error = device_create_file(disk_to_dev(nbd->disk), &pid_attr);
 	if (error) {
 		dev_err(disk_to_dev(nbd->disk), "device_create_file failed!\n");
-		goto out;
+		return error;
 	}
-	if (max_part)
-		bdev->bd_invalidated = 1;
-	bd_set_size(bdev, nbd->bytesize);
 
 	nbd_dev_dbg_init(nbd);
 	for (i = 0; i < num_connections; i++) {
@@ -952,21 +943,39 @@ static int nbd_start_device(struct nbd_device *nbd, struct block_device *bdev)
 		args[i].index = i;
 		queue_work(recv_workqueue, &args[i].work);
 	}
-	error = wait_event_interruptible(nbd->recv_wq,
+	return error;
+}
+
+static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *bdev)
+{
+	int ret, i;
+
+	if (!nbd_get_unless_zero(nbd))
+		return -EINVAL;
+
+	ret = nbd_start_device(nbd);
+	if (ret)
+		return ret;
+
+	bd_set_size(bdev, nbd->bytesize);
+	if (max_part)
+		bdev->bd_invalidated = 1;
+	mutex_unlock(&nbd->config_lock);
+	ret = wait_event_interruptible(nbd->recv_wq,
 					 atomic_read(&nbd->recv_threads) == 0);
-	if (error)
+	if (ret)
 		sock_shutdown(nbd);
-	for (i = 0; i < num_connections; i++)
-		flush_work(&args[i].work);
+	for (i = 0; i < nbd->num_connections; i++)
+		flush_work(&nbd->args[i].work);
 	mutex_lock(&nbd->config_lock);
-out:
+	bd_set_size(bdev, 0);
 	/* user requested, ignore socket errors */
 	if (test_bit(NBD_DISCONNECT_REQUESTED, &nbd->runtime_flags))
-		error = 0;
+		ret = 0;
 	if (test_bit(NBD_TIMEDOUT, &nbd->runtime_flags))
-		error = -ETIMEDOUT;
+		ret = -ETIMEDOUT;
 	nbd_put(nbd);
-	return error;
+	return ret;
 }
 
 static void nbd_clear_sock_ioctl(struct nbd_device *nbd,
@@ -990,7 +999,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		nbd_clear_sock_ioctl(nbd, bdev);
 		return 0;
 	case NBD_SET_SOCK:
-		return nbd_add_socket(nbd, arg);
+		return nbd_add_socket(nbd, arg, false);
 	case NBD_SET_BLKSIZE:
 		nbd_size_set(nbd, arg,
 			     div_s64(nbd->bytesize, arg));
@@ -1013,7 +1022,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
 		nbd->flags = arg;
 		return 0;
 	case NBD_DO_IT:
-		return nbd_start_device(nbd, bdev);
+		return nbd_start_device_ioctl(nbd, bdev);
 	case NBD_CLEAR_QUE:
 		/*
 		 * This is for compatibility only.  The queue is always cleared
@@ -1034,7 +1043,7 @@ static int nbd_ioctl(struct block_device *bdev, fmode_t mode,
 		     unsigned int cmd, unsigned long arg)
 {
 	struct nbd_device *nbd = bdev->bd_disk->private_data;
-	int error;
+	int error = -EINVAL;
 	bool need_put = false;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -1046,7 +1055,15 @@ static int nbd_ioctl(struct block_device *bdev, fmode_t mode,
 	if (nbd_get_unless_zero(nbd))
 		need_put = true;
 	mutex_lock(&nbd->config_lock);
-	error = __nbd_ioctl(bdev, nbd, cmd, arg);
+
+	/* Don't allow ioctl operations on a nbd device that was created with
+	 * netlink, unless it's DISCONNECT or CLEAR_SOCK, which are fine.
+	 */
+	if (!test_bit(NBD_BOUND, &nbd->runtime_flags) ||
+	    (cmd == NBD_DISCONNECT || cmd == NBD_CLEAR_SOCK))
+		error = __nbd_ioctl(bdev, nbd, cmd, arg);
+	else
+		dev_err(nbd_to_dev(nbd), "Cannot use ioctl interface on a netlink controlled device.\n");
 	mutex_unlock(&nbd->config_lock);
 	if (need_put)
 		nbd_put(nbd);
@@ -1242,6 +1259,7 @@ static int nbd_dev_add(int index)
 	if (err < 0)
 		goto out_free_disk;
 
+	nbd->index = index;
 	nbd->disk = disk;
 	nbd->tag_set.ops = &nbd_mq_ops;
 	nbd->tag_set.nr_hw_queues = 1;
@@ -1301,10 +1319,228 @@ static int nbd_dev_add(int index)
 	return err;
 }
 
-/*
- * And here should be modules and kernel interface 
- *  (Just smiley confuses emacs :-)
- */
+static int find_free_cb(int id, void *ptr, void *data)
+{
+	struct nbd_device *nbd = ptr;
+	struct nbd_device **found = data;
+
+	if (!atomic_read(&nbd->refs)) {
+		*found = nbd;
+		return 1;
+	}
+	return 0;
+}
+
+/* Netlink interface. */
+static struct nla_policy nbd_attr_policy[NBD_ATTR_MAX + 1] = {
+	[NBD_ATTR_INDEX]		=	{ .type = NLA_U32 },
+	[NBD_ATTR_SIZE_BYTES]		=	{ .type = NLA_U64 },
+	[NBD_ATTR_BLOCK_SIZE_BYTES]	=	{ .type = NLA_U64 },
+	[NBD_ATTR_TIMEOUT]		=	{ .type = NLA_U64 },
+	[NBD_ATTR_SERVER_FLAGS]		=	{ .type = NLA_U64 },
+	[NBD_ATTR_CLIENT_FLAGS]		=	{ .type = NLA_U64 },
+	[NBD_ATTR_SOCKETS]		=	{ .type = NLA_NESTED},
+};
+
+static struct nla_policy nbd_sock_policy[NBD_SOCK_MAX + 1] = {
+	[NBD_SOCK_FD]			=	{ .type = NLA_U32 },
+};
+
+static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nbd_device *nbd = NULL;
+	int index = -1;
+	int ret;
+
+	if (!netlink_capable(skb, CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (info->attrs[NBD_ATTR_INDEX])
+		index = nla_get_u32(info->attrs[NBD_ATTR_INDEX]);
+	if (!info->attrs[NBD_ATTR_SOCKETS]) {
+		printk(KERN_ERR "nbd: must specify at least one socket\n");
+		return -EINVAL;
+	}
+	if (!info->attrs[NBD_ATTR_SIZE_BYTES]) {
+		printk(KERN_ERR "nbd: must specify a size in bytes for the device\n");
+		return -EINVAL;
+	}
+again:
+	mutex_lock(&nbd_index_mutex);
+	if (index == -1) {
+		ret = idr_for_each(&nbd_index_idr, &find_free_cb, &nbd);
+		if (ret == 0) {
+			int new_index;
+			new_index = nbd_dev_add(-1);
+			if (new_index < 0) {
+				mutex_unlock(&nbd_index_mutex);
+				printk(KERN_ERR "nbd: failed to add new device\n");
+				return ret;
+			}
+			nbd = idr_find(&nbd_index_idr, new_index);
+		}
+	} else {
+		nbd = idr_find(&nbd_index_idr, index);
+	}
+	mutex_unlock(&nbd_index_mutex);
+	if (!nbd) {
+		printk(KERN_ERR "nbd: couldn't find device at index %d\n",
+		       index);
+		return -EINVAL;
+	}
+
+	mutex_lock(&nbd->config_lock);
+	if (atomic_cmpxchg(&nbd->refs, 0, 1)) {
+		mutex_unlock(&nbd->config_lock);
+		if (index == -1)
+			goto again;
+		printk(KERN_ERR "nbd: nbd%d already in use\n", index);
+		return -EBUSY;
+	}
+	try_module_get(THIS_MODULE);
+	/*
+	 * There is a very slight race where we could have just put the last
+	 * reference on this device and are now unable to tear everything down,
+	 * so check for NBD_BOUND or task_recv and cycle the config_mutex to
+	 * allow the teardown to happen.
+	 */
+	if (test_and_set_bit(NBD_BOUND, &nbd->runtime_flags) ||
+	    nbd->task_recv) {
+		mutex_unlock(&nbd->config_lock);
+		mutex_lock(&nbd->config_lock);
+		set_bit(NBD_BOUND, &nbd->runtime_flags);
+	}
+
+	if (info->attrs[NBD_ATTR_SIZE_BYTES]) {
+		u64 bytes = nla_get_u64(info->attrs[NBD_ATTR_SIZE_BYTES]);
+		nbd_size_set(nbd, nbd->blksize,
+			     div64_u64(bytes, nbd->blksize));
+	}
+	if (info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]) {
+		u64 bsize =
+			nla_get_u64(info->attrs[NBD_ATTR_BLOCK_SIZE_BYTES]);
+		nbd_size_set(nbd, bsize, div64_u64(nbd->bytesize, bsize));
+	}
+	if (info->attrs[NBD_ATTR_TIMEOUT]) {
+		u64 timeout = nla_get_u64(info->attrs[NBD_ATTR_TIMEOUT]);
+		nbd->tag_set.timeout = timeout * HZ;
+	}
+	if (info->attrs[NBD_ATTR_SERVER_FLAGS])
+		nbd->flags =
+			nla_get_u64(info->attrs[NBD_ATTR_SERVER_FLAGS]);
+	if (info->attrs[NBD_ATTR_SOCKETS]) {
+		struct nlattr *attr;
+		int rem, fd;
+
+		nla_for_each_nested(attr, info->attrs[NBD_ATTR_SOCKETS],
+				    rem) {
+			struct nlattr *socks[NBD_SOCK_MAX+1];
+
+			if (nla_type(attr) != NBD_SOCK_ITEM) {
+				printk(KERN_ERR "nbd: socks must be embedded in a SOCK_ITEM attr\n");
+				ret = -EINVAL;
+				goto out;
+			}
+			ret = nla_parse_nested(socks, NBD_SOCK_MAX, attr,
+					       nbd_sock_policy);
+			if (ret != 0) {
+				printk(KERN_ERR "nbd: error processing sock list\n");
+				ret = -EINVAL;
+				goto out;
+			}
+			if (!socks[NBD_SOCK_FD])
+				continue;
+			fd = (int)nla_get_u32(socks[NBD_SOCK_FD]);
+			ret = nbd_add_socket(nbd, fd, true);
+			if (ret)
+				goto out;
+		}
+	}
+	ret = nbd_start_device(nbd);
+out:
+	mutex_unlock(&nbd->config_lock);
+	if (!ret)
+		nbd_connect_reply(info, nbd->index);
+	nbd_put(nbd);
+	return ret;
+}
+
+static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nbd_device *nbd;
+	int index;
+
+	if (!netlink_capable(skb, CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (!info->attrs[NBD_ATTR_INDEX]) {
+		printk(KERN_ERR "nbd: must specify an index to disconnect\n");
+		return -EINVAL;
+	}
+	index = nla_get_u32(info->attrs[NBD_ATTR_INDEX]);
+	mutex_lock(&nbd_index_mutex);
+	nbd = idr_find(&nbd_index_idr, index);
+	mutex_unlock(&nbd_index_mutex);
+	if (!nbd) {
+		printk(KERN_ERR "nbd: couldn't find device at index %d\n",
+		       index);
+		return -EINVAL;
+	}
+	if (!nbd_get_unless_zero(nbd))
+		return 0;
+	mutex_lock(&nbd->config_lock);
+	nbd_disconnect(nbd);
+	mutex_unlock(&nbd->config_lock);
+	nbd_put(nbd);
+	return 0;
+}
+
+static const struct genl_ops nbd_connect_genl_ops[] = {
+	{
+		.cmd	= NBD_CMD_CONNECT,
+		.policy	= nbd_attr_policy,
+		.doit	= nbd_genl_connect,
+	},
+	{
+		.cmd	= NBD_CMD_DISCONNECT,
+		.policy	= nbd_attr_policy,
+		.doit	= nbd_genl_disconnect,
+	},
+};
+
+static struct genl_family nbd_genl_family __ro_after_init = {
+	.hdrsize	= 0,
+	.name		= NBD_GENL_FAMILY_NAME,
+	.version	= NBD_GENL_VERSION,
+	.module		= THIS_MODULE,
+	.ops		= nbd_connect_genl_ops,
+	.n_ops		= ARRAY_SIZE(nbd_connect_genl_ops),
+	.maxattr	= NBD_ATTR_MAX,
+};
+
+static void nbd_connect_reply(struct genl_info *info, int index)
+{
+	struct sk_buff *skb;
+	void *msg_head;
+	int ret;
+
+	skb = genlmsg_new(nla_total_size(sizeof(u32)), GFP_KERNEL);
+	if (!skb)
+		return;
+	msg_head = genlmsg_put_reply(skb, info, &nbd_genl_family, 0,
+				     NBD_CMD_CONNECT);
+	if (!msg_head) {
+		nlmsg_free(skb);
+		return;
+	}
+	ret = nla_put_u32(skb, NBD_ATTR_INDEX, index);
+	if (ret) {
+		nlmsg_free(skb);
+		return;
+	}
+	genlmsg_end(skb, msg_head);
+	genlmsg_reply(skb, info);
+}
 
 static int __init nbd_init(void)
 {
@@ -1347,6 +1583,11 @@ static int __init nbd_init(void)
 		return -EIO;
 	}
 
+	if (genl_register_family(&nbd_genl_family)) {
+		unregister_blkdev(NBD_MAJOR, "nbd");
+		destroy_workqueue(recv_workqueue);
+		return -EINVAL;
+	}
 	nbd_dbg_init();
 
 	mutex_lock(&nbd_index_mutex);
@@ -1369,6 +1610,7 @@ static void __exit nbd_cleanup(void)
 
 	idr_for_each(&nbd_index_idr, &nbd_exit_cb, NULL);
 	idr_destroy(&nbd_index_idr);
+	genl_unregister_family(&nbd_genl_family);
 	destroy_workqueue(recv_workqueue);
 	unregister_blkdev(NBD_MAJOR, "nbd");
 }
diff --git a/include/uapi/linux/nbd-netlink.h b/include/uapi/linux/nbd-netlink.h
new file mode 100644
index 0000000..fd0f4e4
--- /dev/null
+++ b/include/uapi/linux/nbd-netlink.h
@@ -0,0 +1,69 @@
+/*
+ * Copyright (C) 2017 Facebook.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 021110-1307, USA.
+ */
+#ifndef _UAPILINUX_NBD_NETLINK_H
+#define _UAPILINUX_NBD_NETLINK_H
+
+#define NBD_GENL_FAMILY_NAME	"nbd"
+#define NBD_GENL_VERSION	0x1
+
+/* Configuration policy attributes, used for CONNECT */
+enum {
+	NBD_ATTR_UNSPEC,
+	NBD_ATTR_INDEX,
+	NBD_ATTR_SIZE_BYTES,
+	NBD_ATTR_BLOCK_SIZE_BYTES,
+	NBD_ATTR_TIMEOUT,
+	NBD_ATTR_SERVER_FLAGS,
+	NBD_ATTR_CLIENT_FLAGS,
+	NBD_ATTR_SOCKETS,
+	__NBD_ATTR_MAX,
+};
+#define NBD_ATTR_MAX (__NBD_ATTR_MAX - 1)
+
+/*
+ * This is the format for multiple sockets with NBD_ATTR_SOCKETS
+ *
+ * [NBD_ATTR_SOCKETS]
+ *   [NBD_SOCK_ITEM]
+ *     [NBD_SOCK_FD]
+ *   [NBD_SOCK_ITEM]
+ *     [NBD_SOCK_FD]
+ */
+enum {
+	NBD_SOCK_ITEM_UNSPEC,
+	NBD_SOCK_ITEM,
+	__NBD_SOCK_ITEM_MAX,
+};
+#define NBD_SOCK_ITEM_MAX (__NBD_SOCK_ITEM_MAX - 1)
+
+enum {
+	NBD_SOCK_UNSPEC,
+	NBD_SOCK_FD,
+	__NBD_SOCK_MAX,
+};
+#define NBD_SOCK_MAX (__NBD_SOCK_MAX - 1)
+
+enum {
+	NBD_CMD_UNSPEC,
+	NBD_CMD_CONNECT,
+	NBD_CMD_DISCONNECT,
+	__NBD_CMD_MAX,
+};
+#define NBD_CMD_MAX	(__NBD_CMD_MAX - 1)
+
+#endif /* _UAPILINUX_NBD_NETLINK_H */
-- 
2.7.4
