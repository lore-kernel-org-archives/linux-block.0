Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22493 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbcEHWhh (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Sun, 8 May 2016 18:37:37 -0400
Subject: [PATCH 3/7] libnvdimm,
 dax: reserve space to store labels for device-dax
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 08 May 2016 15:35:26 -0700
Message-ID: <146274692623.10891.5503895995224585718.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <146274690999.10891.10714722986208180484.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <146274690999.10891.10714722986208180484.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We may want to subdivide a device-dax range into multiple devices so
that each can have separate permissions or naming.  Reserve 128K of
label space by default so we have the capability of making allocation
decisions persistent.  This reservation is not something we can add
later since it would result in the default size of a device-dax range
changing between kernel versions.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/pfn_devs.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 6ade2eb7615d..ca396c8f2cd5 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -540,6 +540,7 @@ static struct vmem_altmap *__nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
 
 static int nd_pfn_init(struct nd_pfn *nd_pfn)
 {
+	u32 dax_label_reserve = is_nd_dax(&nd_pfn->dev) ? SZ_128K : 0;
 	struct nd_namespace_common *ndns = nd_pfn->ndns;
 	u32 start_pad = 0, end_trunc = 0;
 	resource_size_t start, size;
@@ -606,10 +607,11 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 	size = resource_size(&nsio->res);
 	npfns = (size - start_pad - end_trunc - SZ_8K) / SZ_4K;
 	if (nd_pfn->mode == PFN_MODE_PMEM)
-		offset = ALIGN(start + SZ_8K + 64 * npfns, nd_pfn->align)
-			- start;
+		offset = ALIGN(start + SZ_8K + 64 * npfns + dax_label_reserve,
+				nd_pfn->align) - start;
 	else if (nd_pfn->mode == PFN_MODE_RAM)
-		offset = ALIGN(start + SZ_8K, nd_pfn->align) - start;
+		offset = ALIGN(start + SZ_8K + dax_label_reserve,
+				nd_pfn->align) - start;
 	else
 		return -ENXIO;
 

