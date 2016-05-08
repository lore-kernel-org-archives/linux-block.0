Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:24834 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951AbcEHWgE (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Sun, 8 May 2016 18:36:04 -0400
Subject: [PATCH 1/7] libnvdimm: cleanup nvdimm_namespace_common_probe(),
 kill 'host'
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 08 May 2016 15:35:15 -0700
Message-ID: <146274691573.10891.13888079498835955317.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <146274690999.10891.10714722986208180484.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <146274690999.10891.10714722986208180484.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The 'host' variable can be killed as it is always the same as the passed
in device.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/namespace_devs.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index f5cb88601359..e5ad5162bf34 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1379,21 +1379,16 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
 {
 	struct nd_btt *nd_btt = is_nd_btt(dev) ? to_nd_btt(dev) : NULL;
 	struct nd_pfn *nd_pfn = is_nd_pfn(dev) ? to_nd_pfn(dev) : NULL;
-	struct nd_namespace_common *ndns;
+	struct nd_namespace_common *ndns = NULL;
 	resource_size_t size;
 
 	if (nd_btt || nd_pfn) {
-		struct device *host = NULL;
-
-		if (nd_btt) {
-			host = &nd_btt->dev;
+		if (nd_btt)
 			ndns = nd_btt->ndns;
-		} else if (nd_pfn) {
-			host = &nd_pfn->dev;
+		else if (nd_pfn)
 			ndns = nd_pfn->ndns;
-		}
 
-		if (!ndns || !host)
+		if (!ndns)
 			return ERR_PTR(-ENODEV);
 
 		/*
@@ -1404,12 +1399,12 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
 		device_unlock(&ndns->dev);
 		if (ndns->dev.driver) {
 			dev_dbg(&ndns->dev, "is active, can't bind %s\n",
-					dev_name(host));
+					dev_name(dev));
 			return ERR_PTR(-EBUSY);
 		}
-		if (dev_WARN_ONCE(&ndns->dev, ndns->claim != host,
+		if (dev_WARN_ONCE(&ndns->dev, ndns->claim != dev,
 					"host (%s) vs claim (%s) mismatch\n",
-					dev_name(host),
+					dev_name(dev),
 					dev_name(ndns->claim)))
 			return ERR_PTR(-ENXIO);
 	} else {

