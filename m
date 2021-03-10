Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDD6C433E6
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 01:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B603650FD
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 01:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhCJBnp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 20:43:45 -0500
Received: from mga11.intel.com ([192.55.52.93]:20658 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231422AbhCJBnm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Mar 2021 20:43:42 -0500
IronPort-SDR: JZTopoaVIAtciT6GBg6LMHiGyQCBhkM354fHXBs8ZoxscnF3O47DCdloFlpDIcNBt+n2s6Tnwm
 YRRO+SwcBx4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="185004425"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="185004425"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 17:43:39 -0800
IronPort-SDR: Y7+W9Tom12E92Bku2I5dnJLtcYucyCcPGg1e9R0eUmX++VmOvYAoe74ImkoAF04m6TxXJHyD+q
 JzwsFQh5Lx0Q==
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="409973299"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 17:43:38 -0800
Subject: [PATCH v2] libnvdimm: Notify disk drivers to revalidate region
 read-only
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        kernel test robot <lkp@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Date:   Tue, 09 Mar 2021 17:43:38 -0800
Message-ID: <161534060720.528671.2341213328968989192.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Previous kernels allowed the BLKROSET to override the disk's read-only
status. With that situation fixed the pmem driver needs to rely on
notification events to reevaluate the disk read-only status after the
host region has been marked read-write.

Recall that when libnvdimm determines that the persistent memory has
lost persistence (for example lack of energy to flush from DRAM to FLASH
on an NVDIMM-N device) it marks the region read-only, but that state can
be overridden by the user via:

   echo 0 > /sys/bus/nd/devices/regionX/read_only

...to date there is no notification that the region has restored
persistence, so the user override is the only recovery.

Fixes: 52f019d43c22 ("block: add a hard-readonly flag to struct gendisk")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v1 [1]:
- Move from the sinking ship of revalidate_disk() to the local hotness
  of nd_pmem_notify() (hch).

[1]: http://lore.kernel.org/r/161527286194.446794.5215036039655765042.stgit@dwillia2-desk3.amr.corp.intel.com

 drivers/nvdimm/bus.c         |   14 ++++++--------
 drivers/nvdimm/pmem.c        |   37 +++++++++++++++++++++++++++++++++----
 drivers/nvdimm/region_devs.c |    7 +++++++
 include/linux/nd.h           |    1 +
 4 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 48f0985ca8a0..3a777d0073b7 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -631,16 +631,14 @@ void nvdimm_check_and_set_ro(struct gendisk *disk)
 	struct nd_region *nd_region = to_nd_region(dev->parent);
 	int disk_ro = get_disk_ro(disk);
 
-	/*
-	 * Upgrade to read-only if the region is read-only preserve as
-	 * read-only if the disk is already read-only.
-	 */
-	if (disk_ro || nd_region->ro == disk_ro)
+	/* catch the disk up with the region ro state */
+	if (disk_ro == nd_region->ro)
 		return;
 
-	dev_info(dev, "%s read-only, marking %s read-only\n",
-			dev_name(&nd_region->dev), disk->disk_name);
-	set_disk_ro(disk, 1);
+	dev_info(dev, "%s read-%s, marking %s read-%s\n",
+		 dev_name(&nd_region->dev), nd_region->ro ? "only" : "write",
+		 disk->disk_name, nd_region->ro ? "only" : "write");
+	set_disk_ro(disk, nd_region->ro);
 }
 EXPORT_SYMBOL(nvdimm_check_and_set_ro);
 
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index b8a85bfb2e95..7daac795db39 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -26,6 +26,7 @@
 #include <linux/mm.h>
 #include <asm/cacheflush.h>
 #include "pmem.h"
+#include "btt.h"
 #include "pfn.h"
 #include "nd.h"
 
@@ -585,7 +586,7 @@ static void nd_pmem_shutdown(struct device *dev)
 	nvdimm_flush(to_nd_region(dev->parent), NULL);
 }
 
-static void nd_pmem_notify(struct device *dev, enum nvdimm_event event)
+static void pmem_revalidate_poison(struct device *dev)
 {
 	struct nd_region *nd_region;
 	resource_size_t offset = 0, end_trunc = 0;
@@ -595,9 +596,6 @@ static void nd_pmem_notify(struct device *dev, enum nvdimm_event event)
 	struct range range;
 	struct kernfs_node *bb_state;
 
-	if (event != NVDIMM_REVALIDATE_POISON)
-		return;
-
 	if (is_nd_btt(dev)) {
 		struct nd_btt *nd_btt = to_nd_btt(dev);
 
@@ -635,6 +633,37 @@ static void nd_pmem_notify(struct device *dev, enum nvdimm_event event)
 		sysfs_notify_dirent(bb_state);
 }
 
+static void pmem_revalidate_region(struct device *dev)
+{
+	struct pmem_device *pmem;
+
+	if (is_nd_btt(dev)) {
+		struct nd_btt *nd_btt = to_nd_btt(dev);
+		struct btt *btt = nd_btt->btt;
+
+		nvdimm_check_and_set_ro(btt->btt_disk);
+		return;
+	}
+
+	pmem = dev_get_drvdata(dev);
+	nvdimm_check_and_set_ro(pmem->disk);
+}
+
+static void nd_pmem_notify(struct device *dev, enum nvdimm_event event)
+{
+	switch (event) {
+	case NVDIMM_REVALIDATE_POISON:
+		pmem_revalidate_poison(dev);
+		break;
+	case NVDIMM_REVALIDATE_REGION:
+		pmem_revalidate_region(dev);
+		break;
+	default:
+		dev_WARN_ONCE(dev, 1, "notify: unknown event: %d\n", event);
+		break;
+	}
+}
+
 MODULE_ALIAS("pmem");
 MODULE_ALIAS_ND_DEVICE(ND_DEVICE_NAMESPACE_IO);
 MODULE_ALIAS_ND_DEVICE(ND_DEVICE_NAMESPACE_PMEM);
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index ef23119db574..51870eb51da6 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -518,6 +518,12 @@ static ssize_t read_only_show(struct device *dev,
 	return sprintf(buf, "%d\n", nd_region->ro);
 }
 
+static int revalidate_read_only(struct device *dev, void *data)
+{
+	nd_device_notify(dev, NVDIMM_REVALIDATE_REGION);
+	return 0;
+}
+
 static ssize_t read_only_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
@@ -529,6 +535,7 @@ static ssize_t read_only_store(struct device *dev,
 		return rc;
 
 	nd_region->ro = ro;
+	device_for_each_child(dev, NULL, revalidate_read_only);
 	return len;
 }
 static DEVICE_ATTR_RW(read_only);
diff --git a/include/linux/nd.h b/include/linux/nd.h
index cec526c8043d..ee9ad76afbba 100644
--- a/include/linux/nd.h
+++ b/include/linux/nd.h
@@ -11,6 +11,7 @@
 
 enum nvdimm_event {
 	NVDIMM_REVALIDATE_POISON,
+	NVDIMM_REVALIDATE_REGION,
 };
 
 enum nvdimm_claim_class {

