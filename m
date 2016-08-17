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
Subject: [PATCH 14/15] axonram: Pass attribute group to device_add_disk
Date: Wed, 17 Aug 2016 15:15:14 +0800
Message-Id: <1471418115-3654-15-git-send-email-famz@redhat.com>
In-Reply-To: <1471418115-3654-1-git-send-email-famz@redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Previously after device_add_disk returns, the KOBJ_ADD uevent is already
emitted. Adding attributes after that is a poor usage of kobject, and
in practice may result in race conditions with userspace, for
example udev checks availability of certain attributes and initializes
/dev entries conditionally.

device_add_disk can handle adding attribute group better, so use it.
Meanwhile, handle the error of device_add_disk.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 arch/powerpc/sysdev/axonram.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/axonram.c b/arch/powerpc/sysdev/axonram.c
index 6aef6c2..23109e3 100644
--- a/arch/powerpc/sysdev/axonram.c
+++ b/arch/powerpc/sysdev/axonram.c
@@ -158,6 +158,15 @@ static const struct block_device_operations axon_ram_devops = {
 	.direct_access	= axon_ram_direct_access
 };
 
+static struct attribute *axon_attrs[] = {
+	&dev_attr_ecc.attr,
+	NULL,
+};
+
+static struct attribute_group axon_attr_group = {
+	.attrs = axon_attrs,
+};
+
 /**
  * axon_ram_probe - probe() method for platform driver
  * @device: see platform_driver method
@@ -237,7 +246,12 @@ static int axon_ram_probe(struct platform_device *device)
 	set_capacity(bank->disk, bank->size >> AXON_RAM_SECTOR_SHIFT);
 	blk_queue_make_request(bank->disk->queue, axon_ram_make_request);
 	blk_queue_logical_block_size(bank->disk->queue, AXON_RAM_SECTOR_SIZE);
-	device_add_disk(&device->dev, bank->disk, NULL);
+	rc = device_add_disk(&device->dev, bank->disk, &axon_attr_group);
+	if (rc != 0) {
+		dev_err(&device->dev, "Cannot create disk\n");
+		rc = -EFAULT;
+		goto failed;
+	}
 
 	bank->irq_id = irq_of_parse_and_map(device->dev.of_node, 0);
 	if (bank->irq_id == NO_IRQ) {
@@ -255,13 +269,6 @@ static int axon_ram_probe(struct platform_device *device)
 		goto failed;
 	}
 
-	rc = device_create_file(&device->dev, &dev_attr_ecc);
-	if (rc != 0) {
-		dev_err(&device->dev, "Cannot create sysfs file\n");
-		rc = -EFAULT;
-		goto failed;
-	}
-
 	azfs_minor += bank->disk->minors;
 
 	return 0;
-- 
2.7.4
