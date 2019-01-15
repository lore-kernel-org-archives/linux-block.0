Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8B6C43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 17:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012AD20675
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 17:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbfAORyU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:54:20 -0500
Received: from verein.lst.de ([213.95.11.211]:54554 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbfAORyU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 12:54:20 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 84A3467358; Tue, 15 Jan 2019 18:54:18 +0100 (CET)
Date:   Tue, 15 Jan 2019 18:54:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
Subject: Re: [PATCH 2/3] dma: Introduce dma_max_mapping_size()
Message-ID: <20190115175418.GA11402@lst.de>
References: <20190115132257.6426-1-joro@8bytes.org> <20190115132257.6426-3-joro@8bytes.org> <20190115133754.GB29225@lst.de> <20190115162322.GA4681@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115162322.GA4681@8bytes.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 15, 2019 at 05:23:22PM +0100, Joerg Roedel wrote:
> Right, I thought about that too, but didn't find a generic way to check
> for all the cases. There are various checks that could be done:
> 
> 	1) Check if SWIOTLB is initialized at all, if not, return
> 	   SIZE_MAX as the limit. This can't be checked from dma-direct
> 	   code right now, but could be easily implemented.

Yes, this is the low hanging fruit.

> 	2) Check for swiotlb=force needs to be done.
> 
> 	3) Check whether the device can access all of available RAM. I
> 	   have no idea how to check that in an architecture independent
> 	   way. It also has to take memory hotplug into account as well
> 	   as the DMA mask of the device.
> 
> 	   An easy approximation could be to omit the limit if the
> 	   dma-mask covers all of the physical address bits available
> 	   on the platform. It would require to pass the dma-mask as an
> 	   additional parameter like it is done in dma_supported().
> 
> Any better ideas for how to implement 3)?

And yeah, this is hard.  So I'd just go for the low hanging fruit
for now and only implement 1) with a comment mentioning that
we are a little pessimistic.
