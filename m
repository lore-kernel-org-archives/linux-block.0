Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54BB28152A;
	Tue,  4 Mar 2025 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109413; cv=none; b=UPjCx1bB01sPBB0UDhcnz31CdJ0APWCFnF7TjWtQbLrFoM9X8aSm0h0I2qTGZAw/DXspL0+YVNY4Dx1bEocRDsyClV2oj6W+/HqR9uGGilAcZ94OzJHrmzG07TgLPq1kcEa5SIHIWa2qqi1QiZjCVDLN7LuqMwHH6/RtHDvQmFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109413; c=relaxed/simple;
	bh=OdPmI4U5vFoGTHKzd0tRe7tG0OV3RaqOyfZhfElBWDE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sWQiePKRFNizOmYYVZfbuLZ7wGIgvG2n6hXeTpXmXn3bX+xTIiidB96gSHhDO3l0zMd46kEucss5Rk3ggxaI33j7EQdur7AQrVcoO9aFfv1UU4rzmDe+zUPS1HL+L/7bQ8VbTIJhHkjhHOdlAvnrSjLLM0k7nMHZR0BfPi8Drtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tpViZ-000000000mW-0i6s;
	Tue, 04 Mar 2025 17:06:07 +0000
Date: Tue, 4 Mar 2025 17:06:01 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Jens Axboe <axboe@kernel.dk>, Daniel Golle <daniel@makrotopia.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Douglas Anderson <dianders@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Riyan Dhiman <riyandhiman14@gmail.com>,
	Konstantin Khlebnikov <koct9i@gmail.com>,
	Li Lingfeng <lilingfeng3@huawei.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] block: allow setting partition of_node
Message-ID: <8cfbf225bcda906df0c89dd18ba07ecfa17123c2.1741107851.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Allow partition parsers to set the Device Tree node for a partition by
introducing of_put_partition() and extending struct parsed_partitions
accordingly.

As the partition information is preallocated independently of the actual
number of partitions the additional pointer takes about 2 kiB of allocated
memory which is worth avoiding in case CONFIG_OF is not set. This is
achieved by only adding the corresponding field to the struct in case
CONFIG_OF is set using #ifdef'ery.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 block/partitions/check.h | 16 +++++++++++++++-
 block/partitions/core.c  | 14 +++++++++++---
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/block/partitions/check.h b/block/partitions/check.h
index e5c1c61eb3532..0b326086b1b61 100644
--- a/block/partitions/check.h
+++ b/block/partitions/check.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/pagemap.h>
 #include <linux/blkdev.h>
+#include <linux/of.h>
 #include "../blk.h"
 
 /*
@@ -16,6 +17,9 @@ struct parsed_partitions {
 		int flags;
 		bool has_info;
 		struct partition_meta_info info;
+#ifdef CONFIG_OF
+		struct device_node *np;
+#endif
 	} *parts;
 	int next;
 	int limit;
@@ -34,18 +38,28 @@ static inline void put_dev_sector(Sector p)
 }
 
 static inline void
-put_partition(struct parsed_partitions *p, int n, sector_t from, sector_t size)
+of_put_partition(struct parsed_partitions *p, int n, sector_t from, sector_t size,
+		 struct device_node *np)
 {
 	if (n < p->limit) {
 		char tmp[1 + BDEVNAME_SIZE + 10 + 1];
 
 		p->parts[n].from = from;
 		p->parts[n].size = size;
+#ifdef CONFIG_OF
+		p->parts[n].np = np;
+#endif
 		snprintf(tmp, sizeof(tmp), " %s%d", p->name, n);
 		strlcat(p->pp_buf, tmp, PAGE_SIZE);
 	}
 }
 
+static inline void
+put_partition(struct parsed_partitions *p, int n, sector_t from, sector_t size)
+{
+	of_put_partition(p, n, from, size, NULL);
+}
+
 /* detection routines go here in alphabetical order: */
 int adfspart_check_ADFS(struct parsed_partitions *state);
 int adfspart_check_CUMANA(struct parsed_partitions *state);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 815ed33caa1b8..70d1ad8e37b93 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #include <linux/vmalloc.h>
+#include <linux/device.h>
 #include <linux/raid/detect.h>
 #include "check.h"
 
@@ -292,7 +293,8 @@ static const DEVICE_ATTR(whole_disk, 0444, whole_disk_show, NULL);
  */
 static struct block_device *add_partition(struct gendisk *disk, int partno,
 				sector_t start, sector_t len, int flags,
-				struct partition_meta_info *info)
+				struct partition_meta_info *info,
+				struct device_node *np)
 {
 	dev_t devt = MKDEV(0, 0);
 	struct device *ddev = disk_to_dev(disk);
@@ -341,6 +343,7 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	pdev->class = &block_class;
 	pdev->type = &part_type;
 	pdev->parent = ddev;
+	device_set_node(pdev, of_fwnode_handle(np));
 
 	/* in consecutive minor range? */
 	if (bdev_partno(bdev) < disk->minors) {
@@ -447,7 +450,7 @@ int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 	}
 
 	part = add_partition(disk, partno, start, length,
-			ADDPART_FLAG_NONE, NULL);
+			ADDPART_FLAG_NONE, NULL, NULL);
 	ret = PTR_ERR_OR_ZERO(part);
 out:
 	mutex_unlock(&disk->open_mutex);
@@ -561,8 +564,13 @@ static bool blk_add_partition(struct gendisk *disk,
 		size = get_capacity(disk) - from;
 	}
 
+#ifdef CONFIG_OF
 	part = add_partition(disk, p, from, size, state->parts[p].flags,
-			     &state->parts[p].info);
+			     &state->parts[p].info, state->parts[p].np);
+#else
+	part = add_partition(disk, p, from, size, state->parts[p].flags,
+			     &state->parts[p].info, NULL);
+#endif
 	if (IS_ERR(part)) {
 		if (PTR_ERR(part) != -ENXIO) {
 			printk(KERN_ERR " %s: p%d could not be added: %pe\n",
-- 
2.48.1
