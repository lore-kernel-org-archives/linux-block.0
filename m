Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4239D1BC44;
	Thu, 30 May 2024 02:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717035292; cv=none; b=JyLqc8h8KgFIBT8uYA06EabnTTBZdEi+M0TWy1l6LrAnP5QlpQRshgn1LAnQH2jLI+3R+On95W3ZKL+JqpieZlRX4VKihlMystQd9Tj6qmMe+QANQpVGBhk8pGOlOPyINglyrHy7+fhW+YGJ7wjwkZ847B2s31IaL7i2GyyDEYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717035292; c=relaxed/simple;
	bh=eZcSx2sOVs3qbSCl2YnVDXzrJD2rtCpa0KGRs94iBwg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgRjLfVFzHWX4qBpse70wFbUT1SzG3LMsA6Zl34VeaumithfQLzEne7QSC1kRzDsBn7cJPPamptqLSk3Kdge81INYJZX/nwxfnXnLg8snc4D0QMi1xybfWT5ygKn5i4IbEXP9ZZro1qtQtLt6E4AyLmgoT06HhuWTUg8eerG3jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sCVJO-000000004fi-3Y7Q;
	Thu, 30 May 2024 02:14:38 +0000
Date: Thu, 30 May 2024 03:14:34 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	Min Li <min15.li@samsung.com>, Avri Altman <avri.altman@wdc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Hannes Reinecke <hare@suse.de>,
	Mikko Rapeli <mikko.rapeli@linaro.org>, Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Li Zhijian <lizhijian@fujitsu.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH v2 3/9] block: add support for notifications
Message-ID: <99a9b6347f0b442be40290a26c8cce2621878d6d.1717031992.git.daniel@makrotopia.org>
References: <cover.1717031992.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717031992.git.daniel@makrotopia.org>

Add notifier block to notify other subsystems about the addition or
removal of block devices.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 block/Kconfig          |  6 +++
 block/Makefile         |  1 +
 block/blk-notify.c     | 88 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h |  8 ++++
 4 files changed, 103 insertions(+)
 create mode 100644 block/blk-notify.c

diff --git a/block/Kconfig b/block/Kconfig
index dc12af58dbae..b9a28ecd408f 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -213,6 +213,12 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
 	  by falling back to the kernel crypto API when inline
 	  encryption hardware is not present.
 
+config BLOCK_NOTIFIERS
+	bool "Enable support for notifications in block layer"
+	help
+	  Enable this option to provide notifiers for other subsystems
+	  upon addition or removal of block devices.
+
 source "block/partitions/Kconfig"
 
 config BLK_MQ_PCI
diff --git a/block/Makefile b/block/Makefile
index 168150b9c510..54ff8aded85e 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= blk-crypto.o blk-crypto-profile.o \
 					   blk-crypto-sysfs.o
 obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)	+= blk-crypto-fallback.o
 obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)	+= holder.o
+obj-$(CONFIG_BLOCK_NOTIFIERS) += blk-notify.o
diff --git a/block/blk-notify.c b/block/blk-notify.c
new file mode 100644
index 000000000000..ae161baf1634
--- /dev/null
+++ b/block/blk-notify.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Notifiers for addition and removal of block devices
+ *
+ * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
+ */
+
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+
+#include "blk.h"
+
+struct blk_device_list {
+	struct device *dev;
+	struct list_head list;
+};
+
+static RAW_NOTIFIER_HEAD(blk_notifier_list);
+static DEFINE_MUTEX(blk_notifier_lock);
+static LIST_HEAD(blk_devices);
+
+void blk_register_notify(struct notifier_block *nb)
+{
+	struct blk_device_list *existing_blkdev;
+
+	mutex_lock(&blk_notifier_lock);
+	raw_notifier_chain_register(&blk_notifier_list, nb);
+
+	list_for_each_entry(existing_blkdev, &blk_devices, list)
+		nb->notifier_call(nb, BLK_DEVICE_ADD, existing_blkdev->dev);
+
+	mutex_unlock(&blk_notifier_lock);
+}
+EXPORT_SYMBOL_GPL(blk_register_notify);
+
+void blk_unregister_notify(struct notifier_block *nb)
+{
+	mutex_lock(&blk_notifier_lock);
+	raw_notifier_chain_unregister(&blk_notifier_list, nb);
+	mutex_unlock(&blk_notifier_lock);
+}
+EXPORT_SYMBOL_GPL(blk_unregister_notify);
+
+static int blk_call_notifier_add(struct device *dev)
+{
+	struct blk_device_list *new_blkdev;
+
+	new_blkdev = kmalloc(sizeof(*new_blkdev), GFP_KERNEL);
+	if (!new_blkdev)
+		return -ENOMEM;
+
+	new_blkdev->dev = dev;
+	mutex_lock(&blk_notifier_lock);
+	list_add_tail(&new_blkdev->list, &blk_devices);
+	raw_notifier_call_chain(&blk_notifier_list, BLK_DEVICE_ADD, dev);
+	mutex_unlock(&blk_notifier_lock);
+
+	return 0;
+}
+
+static void blk_call_notifier_remove(struct device *dev)
+{
+	struct blk_device_list *old_blkdev, *tmp;
+
+	mutex_lock(&blk_notifier_lock);
+	list_for_each_entry_safe(old_blkdev, tmp, &blk_devices, list) {
+		if (old_blkdev->dev != dev)
+			continue;
+
+		list_del(&old_blkdev->list);
+		kfree(old_blkdev);
+	}
+	raw_notifier_call_chain(&blk_notifier_list, BLK_DEVICE_REMOVE, dev);
+	mutex_unlock(&blk_notifier_lock);
+}
+
+static struct class_interface blk_notifications_bus_interface __refdata = {
+	.class = &block_class,
+	.add_dev = &blk_call_notifier_add,
+	.remove_dev = &blk_call_notifier_remove,
+};
+
+static int __init blk_notifications_init(void)
+{
+	return class_interface_register(&blk_notifications_bus_interface);
+}
+device_initcall(blk_notifications_init);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index aefdda9f4ec7..0a8c3478a462 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1604,4 +1604,12 @@ struct io_comp_batch {
 
 #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
 
+
+#ifdef CONFIG_BLOCK_NOTIFIERS
+#define BLK_DEVICE_ADD		1
+#define BLK_DEVICE_REMOVE	2
+void blk_register_notify(struct notifier_block *nb);
+void blk_unregister_notify(struct notifier_block *nb);
+#endif
+
 #endif /* _LINUX_BLKDEV_H */
-- 
2.45.1
