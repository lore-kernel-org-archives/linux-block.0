Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF9622EFB;
	Wed, 26 Jun 2024 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719370291; cv=none; b=Dwn4dYygguhOjxIBI4wwQUEek8Gt54ZIVIggwhnl0JSkRxhEodZTyoMQz9EV6PItuYIAYsnAdganCNNV4hzEblXSJbts8esAHIxU3vhdvK3LNVOeLme7L7C1XQJwLoKgbSaxWPBfu2RZU0hdidpfal40lnwm0MtseES0IQydlEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719370291; c=relaxed/simple;
	bh=+RZMU1zgTO8Xd2hfTyRIhKQbfvzEKu5Nt6btxc5L7L0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaZGOaTvllQ1enF0Qi+HZ+zVW82x+iS2oXV/LqW4q7FSk2PRdN3iUkDKh9xnY6Q01Yj7CZX6AEi4lsruROfgXzs540RlWp35fuPskWv6OhCzBZXpz9G0hMp+n7Jd9+ulHA6dpGYA2TdUyJsZL0FxHuA4LVYO+XOlohtdL6qa8EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sMIkb-000000005sl-2wUE;
	Wed, 26 Jun 2024 02:51:13 +0000
Date: Wed, 26 Jun 2024 03:51:09 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Hauke Mehrtens <hauke@hauke-m.de>, Felix Fietkau <nbd@nbd.name>,
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
Subject: [PATCH v3 3/4] block: add support for notifications
Message-ID: <609f654800583feb016d96d9c3fc2f029f0f460a.1719368448.git.daniel@makrotopia.org>
References: <cover.1719368448.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719368448.git.daniel@makrotopia.org>

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
index 5b623b876d3b..67cd4f92378a 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -209,6 +209,12 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
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
index ddfd21c1a9ff..a131fa7d6b26 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -38,3 +38,4 @@ obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= blk-crypto.o blk-crypto-profile.o \
 					   blk-crypto-sysfs.o
 obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)	+= blk-crypto-fallback.o
 obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)	+= holder.o
+obj-$(CONFIG_BLOCK_NOTIFIERS) += blk-notify.o
diff --git a/block/blk-notify.c b/block/blk-notify.c
new file mode 100644
index 000000000000..594df7aa7be0
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
index b2f1362c4681..8d22ba03e3e1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1687,4 +1687,12 @@ static inline bool bdev_can_atomic_write(struct block_device *bdev)
 
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
2.45.2
