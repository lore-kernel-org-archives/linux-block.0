Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB01C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 22:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7909B222CE
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 22:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392511AbfBMWh1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:37:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:38579 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727471AbfBMWh1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 17:37:27 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 14:37:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,366,1544515200"; 
   d="scan'208";a="122254784"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga007.fm.intel.com with ESMTP; 13 Feb 2019 14:37:26 -0800
Date:   Wed, 13 Feb 2019 15:37:11 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 1/5] genirq/affinity: don't mark 'affd' as const
Message-ID: <20190213223711.GC8027@localhost.localdomain>
References: <20190213105041.13537-1-ming.lei@redhat.com>
 <20190213105041.13537-2-ming.lei@redhat.com>
 <20190213150407.GB96272@google.com>
 <alpine.DEB.2.21.1902132112590.1659@nanos.tec.linutronix.de>
 <20190213213149.GB8027@localhost.localdomain>
 <alpine.DEB.2.21.1902132232560.1659@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902132232560.1659@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 13, 2019 at 10:41:55PM +0100, Thomas Gleixner wrote:
> Btw, while I have your attention. There popped up an issue recently related
> to that affinity logic.
> 
> The current implementation fails when:
> 
>         /*
>          * If there aren't any vectors left after applying the pre/post
>          * vectors don't bother with assigning affinity.
> 	 */
> 	if (nvecs == affd->pre_vectors + affd->post_vectors)
>     		return NULL;
> 
> Now the discussion arised, that in that case the affinity sets are not
> allocated and filled in for the pre/post vectors, but somehow the
> underlying device still works and later on triggers the warning in the
> blk-mq code because the MSI entries do not have affinity information
> attached.
>
> Sure, we could make that work, but there are several issues:
> 
>     1) irq_create_affinity_masks() has another reason to return NULL:
>        memory allocation fails.
> 
>     2) Does it make sense at all.
> 
> Right now the PCI allocator ignores the NULL return and proceeds without
> setting any affinities. As a consequence nothing is managed and everything
> happens to work.
> 
> But that happens to work is more by chance than by design and the warning
> is bogus if this is an expected mode of operation.
> 
> We should address these points in some way.

Ah, yes, that's a mistake in the nvme driver. It is assuming IO queues are
always on managed interrupts, but that's not true if when only 1 vector
could be allocated. This should be an appropriate fix to the warning:

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 022ea1ee63f8..f2ccebe1c926 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -506,7 +506,7 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 		 * affinity), so use the regular blk-mq cpu mapping
 		 */
 		map->queue_offset = qoff;
-		if (i != HCTX_TYPE_POLL)
+		if (i != HCTX_TYPE_POLL && dev->num_vecs > 1)
 			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
 		else
 			blk_mq_map_queues(map);
--
