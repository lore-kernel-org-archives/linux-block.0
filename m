Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34741 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751582AbcKITIf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Nov 2016 14:08:35 -0500
From: Jeff Moyer <jmoyer@redhat.com>
To: "Dan J. Williams" <dan.j.williams@intel.com>,
        linux-nvdimm@ml01.01.org
Cc: linux-block@vger.kernel.org
Subject: [patch] nd_blk,nd_pmem,nd_btt: add endio blktrace events
Date: Wed, 09 Nov 2016 14:08:33 -0500
Message-ID: <x49twbgo4i6.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Right now, any of the above three drivers will report Q events in
blktrace but no corresponding C events.  Fix it.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index 9faaa96..90676f3 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -19,6 +19,7 @@
 #include <linux/moduleparam.h>
 #include <linux/nd.h>
 #include <linux/sizes.h>
+#include <trace/events/block.h>
 #include "nd.h"
 
 static u32 nsblk_meta_size(struct nd_namespace_blk *nsblk)
@@ -213,6 +214,7 @@ static blk_qc_t nd_blk_make_request(struct request_queue *q, struct bio *bio)
 		nd_iostat_end(bio, start);
 
  out:
+	trace_block_bio_complete(q, bio, bio->bi_error);
 	bio_endio(bio);
 	return BLK_QC_T_NONE;
 }
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 368795a..a11c00d 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -23,6 +23,7 @@
 #include <linux/ndctl.h>
 #include <linux/fs.h>
 #include <linux/nd.h>
+#include <trace/events/block.h>
 #include "btt.h"
 #include "nd.h"
 
@@ -1195,6 +1196,7 @@ static blk_qc_t btt_make_request(struct request_queue *q, struct bio *bio)
 		nd_iostat_end(bio, start);
 
 out:
+	trace_block_bio_complete(q, bio, bio->bi_error);
 	bio_endio(bio);
 	return BLK_QC_T_NONE;
 }
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 42b3a82..4ea3b9f 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/pmem.h>
 #include <linux/nd.h>
+#include <trace/events/block.h>
 #include "pmem.h"
 #include "pfn.h"
 #include "nd.h"
@@ -165,6 +166,7 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
 	if (bio->bi_opf & REQ_FUA)
 		nvdimm_flush(nd_region);
 
+	trace_block_bio_complete(q, bio, bio->bi_error);
 	bio_endio(bio);
 	return BLK_QC_T_NONE;
 }
