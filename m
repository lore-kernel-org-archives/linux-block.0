Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D0B168481
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530273; cv=none; b=q9YF0UsGUfhbQLeIEIw7FV4zrm5iqcrwyEyJNZexR1sImmtYt8QyzogNezmm4lbPUepLxTEDPD6DmY4D0zh/P+j3PjOWT8z4JJjaoZaE3DUpDcD7pTVK6h7/zuacU1M79xXls9XlnX/7SVZ0aLDa1J73qnlNTjbPvlAH155VUng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530273; c=relaxed/simple;
	bh=ISZfsX1sdR8oYMUfg9cddXkliIBzshRgiXFd855cu5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m2rssFbVoJepPN3PFsPD+9t0LBI3hTD9jMFVnc66sU0U5Q7WXBy+HgRxEtNzjWgVGPZg7wwq3OhxHlXc2f8pX3J1bfKQ874eCtFb35KOeDnIP0MzWUG6WL3+cpjtipLMDyCzyBm/+F5cLtln7DlvQEI4SD7wjitNPcjeaGva/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cujlNaFv; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cujlNaFv"
X-Envelope-To: axboe@kernel.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720530270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qIq//PVyAZav9RH/O/YvXvb4luJfe+YlS74Qx3jJG5g=;
	b=cujlNaFvYcbREiHVbZGK1ZduR03z82mwda/PzKcqsUKu7Dl5kxKjxfPRM+ra28RllQqkZI
	0QtnjXN3qefLz4VJ2ZtV+Pb6t0FBwkcF9nDZLlwJn4+lZMq9AE+lGluYM/sF4vzBb4sRPi
	vzbu42IT2zfsxzHuRwlT4YwDafyYe0g=
X-Envelope-To: dan.j.williams@intel.com
X-Envelope-To: gregory.price@memverge.com
X-Envelope-To: john@groves.net
X-Envelope-To: jonathan.cameron@huawei.com
X-Envelope-To: bbhushan2@marvell.com
X-Envelope-To: chaitanyak@nvidia.com
X-Envelope-To: rdunlap@infradead.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-cxl@vger.kernel.org
X-Envelope-To: dongsheng.yang@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dongsheng Yang <dongsheng.yang@linux.dev>
To: axboe@kernel.dk,
	dan.j.williams@intel.com,
	gregory.price@memverge.com,
	John@groves.net,
	Jonathan.Cameron@Huawei.com,
	bbhushan2@marvell.com,
	chaitanyak@nvidia.com,
	rdunlap@infradead.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang@linux.dev>
Subject: [PATCH v1 7/7] block: Init for CBD(CXL Block Device) module
Date: Tue,  9 Jul 2024 13:03:43 +0000
Message-Id: <20240709130343.858363-8-dongsheng.yang@linux.dev>
In-Reply-To: <20240709130343.858363-1-dongsheng.yang@linux.dev>
References: <20240709130343.858363-1-dongsheng.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

As shared memory is supported in CXL3.0 spec, we can transfer data
via CXL shared memory. CBD means CXL block device, it use CXL shared memory
to transfer command and data to access block device in different
host, as shown below:

     +-------------------------------+                               +------------------------------------+
     |          node-1               |                               |              node-2                |
     +-------------------------------+                               +------------------------------------+
     |                               |                               |                                    |
     |                       +-------+                               +---------+                          |
     |                       | cbd0  |                               | backend0+------------------+       |
     |                       +-------+                               +---------+                  |       |
     |                       | pmem0 |                               | pmem0   |                  v       |
     |               +-------+-------+                               +---------+----+     +---------------+
     |               |    cxl driver |                               | cxl driver   |     |   /dev/sda    |
     +---------------+--------+------+                               +-----+--------+-----+---------------+
                              |                                            |
                              |                                            |
                              |        CXL                         CXL     |
                              +----------------+               +-----------+
                                               |               |
                                               |               |
                                               |               |
                                           +---+---------------+-----+
                                           |   shared memory device  |
                                           +-------------------------+

any read/write to cbd0 on node-1 will be transferred to node-2 /dev/sda. It works similar with
nbd (network block device), but it transfer data via CXL shared memory rather than network.

The "cbd_backend" is responsible for exposing a local block device (such
as "/dev/sda") through the "cbd_transport" to other hosts.

Any host that registers this transport can map this backend to a local
"cbd device"(such as "/dev/cbd0"). All reads and writes to "cbd0" are transmitted
through the channel inside the transport to the backend. The handler
inside the backend is responsible for processing these read and write
requests, converting them into read and write requests corresponding to "sda".

Signed-off-by: Dongsheng Yang <dongsheng.yang@linux.dev>
---
 drivers/block/Kconfig        |   2 +
 drivers/block/Makefile       |   2 +
 drivers/block/cbd/Kconfig    |  23 ++++
 drivers/block/cbd/Makefile   |   3 +
 drivers/block/cbd/cbd_main.c | 224 +++++++++++++++++++++++++++++++++++
 5 files changed, 254 insertions(+)
 create mode 100644 drivers/block/cbd/Kconfig
 create mode 100644 drivers/block/cbd/Makefile
 create mode 100644 drivers/block/cbd/cbd_main.c

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 5b9d4aaebb81..1f6376828af9 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -219,6 +219,8 @@ config BLK_DEV_NBD
 
 	  If unsure, say N.
 
+source "drivers/block/cbd/Kconfig"
+
 config BLK_DEV_RAM
 	tristate "RAM block device support"
 	help
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 101612cba303..8be2a39f5a7c 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -39,4 +39,6 @@ obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
 
 obj-$(CONFIG_BLK_DEV_UBLK)			+= ublk_drv.o
 
+obj-$(CONFIG_BLK_DEV_CBD)	+= cbd/
+
 swim_mod-y	:= swim.o swim_asm.o
diff --git a/drivers/block/cbd/Kconfig b/drivers/block/cbd/Kconfig
new file mode 100644
index 000000000000..5171ddd9eab8
--- /dev/null
+++ b/drivers/block/cbd/Kconfig
@@ -0,0 +1,23 @@
+config BLK_DEV_CBD
+	tristate "CXL Block Device"
+	help
+	  CBD allows you to register a CXL memory device as a CBD transport.
+	  This enables you to expose any block device through this CBD
+	  transport for access by others. Any machine that has registered
+	  the same CXL memory device can see the block devices exposed
+	  through this CBD transport and can map them locally, allowing
+	  remote block devices to be accessed as if they were local block
+	  devices.
+
+	  Select 'y' to build this module directly into the kernel.
+	  Select 'm' to build this module as a loadable kernel module.
+
+	  If unsure say 'N'.
+
+config CBD_CRC
+	bool "Enable CBD checksum"
+	help
+	  When CBD_CRC is enabled, all data sent by CBD will include
+	  a checksum. This includes a data checksum, a submit entry checksum,
+	  and a completion entry checksum. This ensures the integrity of the
+	  data transmitted through the CXL memory device.
diff --git a/drivers/block/cbd/Makefile b/drivers/block/cbd/Makefile
new file mode 100644
index 000000000000..646d087ae058
--- /dev/null
+++ b/drivers/block/cbd/Makefile
@@ -0,0 +1,3 @@
+cbd-y := cbd_main.o cbd_transport.o cbd_channel.o cbd_host.o cbd_backend.o cbd_handler.o cbd_blkdev.o cbd_queue.o cbd_segment.o
+
+obj-$(CONFIG_BLK_DEV_CBD) += cbd.o
diff --git a/drivers/block/cbd/cbd_main.c b/drivers/block/cbd/cbd_main.c
new file mode 100644
index 000000000000..bbc268676694
--- /dev/null
+++ b/drivers/block/cbd/cbd_main.c
@@ -0,0 +1,224 @@
+/*
+ * Copyright(C) 2024, Dongsheng Yang <dongsheng.yang@linux.dev>
+ */
+
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/blk-mq.h>
+#include <linux/blkdev.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/bio.h>
+#include <linux/module.h>
+#include <linux/blk-mq.h>
+#include <linux/fs.h>
+#include <linux/blkdev.h>
+#include <linux/slab.h>
+#include <linux/idr.h>
+#include <linux/workqueue.h>
+#include <linux/delay.h>
+#include <net/genetlink.h>
+
+#include <linux/types.h>
+
+#include "cbd_internal.h"
+
+struct workqueue_struct	*cbd_wq;
+
+enum {
+	CBDT_REG_OPT_ERR		= 0,
+	CBDT_REG_OPT_FORCE,
+	CBDT_REG_OPT_FORMAT,
+	CBDT_REG_OPT_PATH,
+	CBDT_REG_OPT_HOSTNAME,
+};
+
+static const match_table_t register_opt_tokens = {
+	{ CBDT_REG_OPT_FORCE,		"force=%u" },
+	{ CBDT_REG_OPT_FORMAT,		"format=%u" },
+	{ CBDT_REG_OPT_PATH,		"path=%s" },
+	{ CBDT_REG_OPT_HOSTNAME,	"hostname=%s" },
+	{ CBDT_REG_OPT_ERR,		NULL	}
+};
+
+static int parse_register_options(
+		char *buf,
+		struct cbdt_register_options *opts)
+{
+	substring_t args[MAX_OPT_ARGS];
+	char *o, *p;
+	int token, ret = 0;
+
+	o = buf;
+
+	while ((p = strsep(&o, ",\n")) != NULL) {
+		if (!*p)
+			continue;
+
+		token = match_token(p, register_opt_tokens, args);
+		switch (token) {
+		case CBDT_REG_OPT_PATH:
+			if (match_strlcpy(opts->path, &args[0],
+				CBD_PATH_LEN) == 0) {
+				ret = -EINVAL;
+				break;
+			}
+			break;
+		case CBDT_REG_OPT_FORCE:
+			if (match_uint(args, &token)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			opts->force = (token != 0);
+			break;
+		case CBDT_REG_OPT_FORMAT:
+			if (match_uint(args, &token)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			opts->format = (token != 0);
+			break;
+		case CBDT_REG_OPT_HOSTNAME:
+			if (match_strlcpy(opts->hostname, &args[0],
+				CBD_NAME_LEN) == 0) {
+				ret = -EINVAL;
+				break;
+			}
+			break;
+		default:
+			pr_err("unknown parameter or missing value '%s'\n", p);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+out:
+	return ret;
+}
+
+static ssize_t transport_unregister_store(const struct bus_type *bus, const char *ubuf,
+				      size_t size)
+{
+	u32 transport_id;
+	int ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (sscanf(ubuf, "transport_id=%u", &transport_id) != 1)
+		return -EINVAL;
+
+	ret = cbdt_unregister(transport_id);
+	if (ret < 0)
+		return ret;
+
+	return size;
+}
+
+static ssize_t transport_register_store(const struct bus_type *bus, const char *ubuf,
+				      size_t size)
+{
+	struct cbdt_register_options opts = { 0 };
+	char *buf;
+	int ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	buf = kmemdup(ubuf, size + 1, GFP_KERNEL);
+	if (IS_ERR(buf)) {
+		pr_err("failed to dup buf for adm option: %d", (int)PTR_ERR(buf));
+		return PTR_ERR(buf);
+	}
+	buf[size] = '\0';
+
+	ret = parse_register_options(buf, &opts);
+	if (ret < 0) {
+		kfree(buf);
+		return ret;
+	}
+	kfree(buf);
+
+	ret = cbdt_register(&opts);
+	if (ret < 0)
+		return ret;
+
+	return size;
+}
+
+static BUS_ATTR_WO(transport_unregister);
+static BUS_ATTR_WO(transport_register);
+
+static struct attribute *cbd_bus_attrs[] = {
+	&bus_attr_transport_unregister.attr,
+	&bus_attr_transport_register.attr,
+	NULL,
+};
+
+static const struct attribute_group cbd_bus_group = {
+	.attrs = cbd_bus_attrs,
+};
+__ATTRIBUTE_GROUPS(cbd_bus);
+
+const struct bus_type cbd_bus_type = {
+	.name		= "cbd",
+	.bus_groups	= cbd_bus_groups,
+};
+
+static void cbd_root_dev_release(struct device *dev)
+{
+}
+
+struct device cbd_root_dev = {
+	.init_name =    "cbd",
+	.release =      cbd_root_dev_release,
+};
+
+static int __init cbd_init(void)
+{
+	int ret;
+
+	cbd_wq = alloc_workqueue(CBD_DRV_NAME, WQ_MEM_RECLAIM, 0);
+	if (!cbd_wq)
+		return -ENOMEM;
+
+	ret = device_register(&cbd_root_dev);
+	if (ret < 0) {
+		put_device(&cbd_root_dev);
+		goto destroy_wq;
+	}
+
+	ret = bus_register(&cbd_bus_type);
+	if (ret < 0)
+		goto device_unregister;
+
+	ret = cbd_blkdev_init();
+	if (ret < 0)
+		goto bus_unregister;
+
+	return 0;
+
+bus_unregister:
+	bus_unregister(&cbd_bus_type);
+device_unregister:
+	device_unregister(&cbd_root_dev);
+destroy_wq:
+	destroy_workqueue(cbd_wq);
+
+	return ret;
+}
+
+static void cbd_exit(void)
+{
+	cbd_blkdev_exit();
+	bus_unregister(&cbd_bus_type);
+	device_unregister(&cbd_root_dev);
+
+	destroy_workqueue(cbd_wq);
+}
+
+MODULE_AUTHOR("Dongsheng Yang <dongsheng.yang@linux.dev>");
+MODULE_DESCRIPTION("CXL(Compute Express Link) Block Device");
+MODULE_LICENSE("GPL v2");
+module_init(cbd_init);
+module_exit(cbd_exit);
-- 
2.34.1

