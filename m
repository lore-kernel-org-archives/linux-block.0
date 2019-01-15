Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E767C43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 13:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F90520657
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 13:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfAONUV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:20:21 -0500
Received: from verein.lst.de ([213.95.11.211]:53015 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbfAONUV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 08:20:21 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 095DE67358; Tue, 15 Jan 2019 14:20:20 +0100 (CET)
Date:   Tue, 15 Jan 2019 14:20:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Message-ID: <20190115132019.GA28778@lst.de>
References: <20190110134433.15672-1-joro@8bytes.org> <5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com> <20190111091502.GC5825@8bytes.org> <38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com> <20190114095002.GA29874@lst.de> <ac6d83d8-02de-dbdf-e309-3a1115642d50@redhat.com> <20190114131114-mutt-send-email-mst@kernel.org> <20190115083742.GF5825@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115083742.GF5825@8bytes.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 15, 2019 at 09:37:42AM +0100, Joerg Roedel wrote:
> On Mon, Jan 14, 2019 at 01:20:45PM -0500, Michael S. Tsirkin wrote:
> > Which would be fine especially if we can manage not to introduce a bunch
> > of indirect calls all over the place and hurt performance.
> 
> Which indirect calls? In case of unset dma_ops the DMA-API functions
> call directly into the dma-direct implementation, no indirect calls at
> all.

True.  But the NULL-ops dma direct case still has two issues that might
not work for virtio:

 (a) if the architecture supports devices that are not DMA coherent it
     will dip into a special allocator and do cache maintainance for
     streaming mappings.  Although it would be a bit of a hack we could
     work around this in virtio doings something like:

#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
	dev->dma_coherent = true;
#endif

    except that won't work for mips, which has a mode where it does
    a system instead of device level coherency flag and thus doesn't
    look at this struct device field

 (b) we can still mangle the DMA address, either using the
     dma_pfn_offset field in struct device, or by a full override
     of __phys_to_dma / __dma_to_phys by the architecture code.
     The first could be solved using a hack like the one above,
     but the latter would be a little harder.  In the long run
     I'd love to get rid of that hook and have everyone use the
     generic offset code, but for that we first need to support
     multiple ranges with different offset and do quite some
     nasty arch code surgery.
 
So for the legacy virtio case I fear we need to keep local dma mapping
implementation for now.  I just wish now recent hypervisor would ever
offer devices in this broken legacy mode..

> 
> Regards,
> 
> 	Joerg
---end quoted text---
