Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD37C282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 09:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1AE218A6
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 09:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfAXJvx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:51:53 -0500
Received: from 8bytes.org ([81.169.241.247]:59494 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfAXJvx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 04:51:53 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 276D048C; Thu, 24 Jan 2019 10:51:51 +0100 (CET)
Date:   Thu, 24 Jan 2019 10:51:51 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
Subject: Re: [PATCH 5/5] virtio-blk: Consider virtio_max_dma_size() for
 maximum segment size
Message-ID: <20190124095150.GL32526@8bytes.org>
References: <20190123163049.24863-1-joro@8bytes.org>
 <20190123163049.24863-6-joro@8bytes.org>
 <20190123213139.GD9032@lst.de>
 <20190124084011.GJ32526@8bytes.org>
 <20190124084221.GB19441@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124084221.GB19441@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 24, 2019 at 09:42:21AM +0100, Christoph Hellwig wrote:
> Yes.  But more importantly it would fix the limit for all other block
> drivers that set large segment sizes when running over swiotlb.

True, so it would be something like the diff below? I havn't worked on
the block layer, so I don't know if that needs additional checks for
->dev or anything.

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 3e7038e475ee..9a927280c904 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -1,6 +1,7 @@
 /*
  * Functions related to setting various queue properties from drivers
  */
+#include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -303,13 +304,17 @@ EXPORT_SYMBOL_GPL(blk_queue_max_discard_segments);
  **/
 void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
 {
+	unsigned int dma_max_size;
+
 	if (max_size < PAGE_SIZE) {
 		max_size = PAGE_SIZE;
 		printk(KERN_INFO "%s: set to minimum %d\n",
 		       __func__, max_size);
 	}
 
-	q->limits.max_segment_size = max_size;
+	dma_max_size = dma_max_mapping_size(q->backing_dev_info->dev);
+
+	q->limits.max_segment_size = min(max_size, dma_max_size);
 }
 EXPORT_SYMBOL(blk_queue_max_segment_size);
 
