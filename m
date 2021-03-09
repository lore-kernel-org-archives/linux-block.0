Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516B7C433E0
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 06:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A00265295
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 06:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhCIGyk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 01:54:40 -0500
Received: from mga14.intel.com ([192.55.52.115]:32597 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229520AbhCIGyX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Mar 2021 01:54:23 -0500
IronPort-SDR: VYsOELHL9HME5jppojtuht8hTq5dSczJKc3TCpbS/SW8QZsxlmAWnzdprO5V6WrPx+KMTPIqmo
 CKmPhXkV+1yA==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="187536076"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="187536076"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 22:54:22 -0800
IronPort-SDR: dAdWMk+JmlDxVk9M4A/URs+ost3nLPKwcJrq77fVg6oR6mQ2pIIvTAH8qM+HEUGr7z6MhnKkF+
 bBc0A5Z9L0jg==
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="437569479"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 22:54:22 -0800
Subject: [PATCH] libnvdimm: Let revalidate_disk() revalidate region read-only
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        kernel test robot <lkp@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Date:   Mon, 08 Mar 2021 22:54:22 -0800
Message-ID: <161527286194.446794.5215036039655765042.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Previous kernels allowed the BLKROSET to override the disk's read-only
status. With that situation fixed the pmem driver needs to rely on
revalidate_disk() to clear the disk read-only status after the host
region has been marked read-write.

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
 drivers/nvdimm/btt.c  |    7 +++++++
 drivers/nvdimm/bus.c  |   14 ++++++--------
 drivers/nvdimm/pmem.c |    7 +++++++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 41aa1f01fc07..73d3bf5aa208 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1508,11 +1508,18 @@ static int btt_getgeo(struct block_device *bd, struct hd_geometry *geo)
 	return 0;
 }
 
+static int btt_revalidate(struct gendisk *disk)
+{
+	nvdimm_check_and_set_ro(disk);
+	return 0;
+}
+
 static const struct block_device_operations btt_fops = {
 	.owner =		THIS_MODULE,
 	.submit_bio =		btt_submit_bio,
 	.rw_page =		btt_rw_page,
 	.getgeo =		btt_getgeo,
+	.revalidate_disk =	btt_revalidate,
 };
 
 static int btt_blk_init(struct btt *btt)
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
index b8a85bfb2e95..af204fce1b1c 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -276,10 +276,17 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 	return PHYS_PFN(pmem->size - pmem->pfn_pad - offset);
 }
 
+static int pmem_revalidate(struct gendisk *disk)
+{
+	nvdimm_check_and_set_ro(disk);
+	return 0;
+}
+
 static const struct block_device_operations pmem_fops = {
 	.owner =		THIS_MODULE,
 	.submit_bio =		pmem_submit_bio,
 	.rw_page =		pmem_rw_page,
+	.revalidate_disk =	pmem_revalidate,
 };
 
 static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,

