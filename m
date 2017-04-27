Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:20095 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164234AbdD0VwT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2017 17:52:19 -0400
Subject: [PATCH] block: hide badblocks attribute by default
From: Dan Williams <dan.j.williams@intel.com>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org,
        Vishal Verma <vishal.l.verma@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Date: Thu, 27 Apr 2017 14:46:26 -0700
Message-ID: <149332958627.40858.3562179022452904734.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Commit 99e6608c9e74 "block: Add badblock management for gendisks"
allowed for drivers like pmem and software-raid to advertise a list of
bad media areas. However, it inadvertently added a 'badblocks' to all
block devices. Lets clean this up by having the 'badblocks' attribute
not be visible when the driver has not populated a 'struct badblocks'
instance in the gendisk.

Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Reported-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 block/genhd.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index a9c516a8b37d..12acd48e1210 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1060,8 +1060,19 @@ static struct attribute *disk_attrs[] = {
 	NULL
 };
 
+static umode_t disk_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+	struct gendisk *disk = dev_to_disk(dev);
+
+	if (a == &dev_attr_badblocks.attr && !disk->bb)
+		return 0;
+	return a->mode;
+}
+
 static struct attribute_group disk_attr_group = {
 	.attrs = disk_attrs,
+	.is_visible = disk_visible,
 };
 
 static const struct attribute_group *disk_attr_groups[] = {
