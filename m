Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF2FC43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 16:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DFD20866
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 16:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfAOQXY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:23:24 -0500
Received: from 8bytes.org ([81.169.241.247]:57836 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728911AbfAOQXY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 11:23:24 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 18D90477; Tue, 15 Jan 2019 17:23:23 +0100 (CET)
Date:   Tue, 15 Jan 2019 17:23:22 +0100
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
Subject: Re: [PATCH 2/3] dma: Introduce dma_max_mapping_size()
Message-ID: <20190115162322.GA4681@8bytes.org>
References: <20190115132257.6426-1-joro@8bytes.org>
 <20190115132257.6426-3-joro@8bytes.org>
 <20190115133754.GB29225@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115133754.GB29225@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 15, 2019 at 02:37:54PM +0100, Christoph Hellwig wrote:
> > +size_t dma_direct_max_mapping_size(struct device *dev)
> > +{
> > +	/*
> > +	 * Return the minimum of the direct DMA limit and the SWIOTLB limit.
> > +	 * Since direct DMA has no limit, it is fine to just return the SWIOTLB
> > +	 * limit.
> > +	 */
> > +	return swiotlb_max_mapping_size(dev);
> 
> Well, if we don't actually use the swiotlb buffers despite it being
> compiled in or even allocated we don't need the limit.

Right, I thought about that too, but didn't find a generic way to check
for all the cases. There are various checks that could be done:

	1) Check if SWIOTLB is initialized at all, if not, return
	   SIZE_MAX as the limit. This can't be checked from dma-direct
	   code right now, but could be easily implemented.

	2) Check for swiotlb=force needs to be done.

	3) Check whether the device can access all of available RAM. I
	   have no idea how to check that in an architecture independent
	   way. It also has to take memory hotplug into account as well
	   as the DMA mask of the device.

	   An easy approximation could be to omit the limit if the
	   dma-mask covers all of the physical address bits available
	   on the platform. It would require to pass the dma-mask as an
	   additional parameter like it is done in dma_supported().

Any better ideas for how to implement 3)?

Regards,

	Joerg
