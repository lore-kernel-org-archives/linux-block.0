Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D02C282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 23:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9BA20881
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 23:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfA3XQn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:16:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfA3XQm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 18:16:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83E96C065F63;
        Wed, 30 Jan 2019 21:59:18 +0000 (UTC)
Received: from redhat.com (ovpn-122-6.rdu2.redhat.com [10.10.122.6])
        by smtp.corp.redhat.com (Postfix) with SMTP id 38F734115;
        Wed, 30 Jan 2019 21:59:16 +0000 (UTC)
Date:   Wed, 30 Jan 2019 16:59:14 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH 0/5 v5] Fix virtio-blk issue with SWIOTLB
Message-ID: <20190130165754-mutt-send-email-mst@kernel.org>
References: <20190130164007.26497-1-joro@8bytes.org>
 <20190130183513.GB27284@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130183513.GB27284@char.us.oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 30 Jan 2019 21:59:18 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 30, 2019 at 01:35:13PM -0500, Konrad Rzeszutek Wilk wrote:
> On Wed, Jan 30, 2019 at 05:40:02PM +0100, Joerg Roedel wrote:
> > Hi,
> > 
> > here is the next version of this patch-set. Previous
> > versions can be found here:
> > 
> > 	V1: https://lore.kernel.org/lkml/20190110134433.15672-1-joro@8bytes.org/
> > 
> > 	V2: https://lore.kernel.org/lkml/20190115132257.6426-1-joro@8bytes.org/
> > 
> > 	V3: https://lore.kernel.org/lkml/20190123163049.24863-1-joro@8bytes.org/
> > 
> > 	V4: https://lore.kernel.org/lkml/20190129084342.26030-1-joro@8bytes.org/
> > 
> > The problem solved here is a limitation of the SWIOTLB implementation,
> > which does not support allocations larger than 256kb.  When the
> > virtio-blk driver tries to read/write a block larger than that, the
> > allocation of the dma-handle fails and an IO error is reported.
> > 
> > Changes to v4 are:
> > 
> > 	- Added Reviewed-by tags from Christoph
> > 
> > 	- Added missing EXPORT_SYMBOL(_GPL) lines
> > 
> > Please review.
> 
> I can put it in my tree and send it to Linus .. unless folks want
> to do it through a different tree?

I queued it in my tree as it seems virtio specific.

> 
> > 
> > Thanks,
> > 
> > 	Joerg
> > Joerg Roedel (5):
> >   swiotlb: Introduce swiotlb_max_mapping_size()
> >   swiotlb: Add is_swiotlb_active() function
> >   dma: Introduce dma_max_mapping_size()
> >   virtio: Introduce virtio_max_dma_size()
> >   virtio-blk: Consider virtio_max_dma_size() for maximum segment size
> > 
> >  Documentation/DMA-API.txt    |  8 ++++++++
> >  drivers/block/virtio_blk.c   | 10 ++++++----
> >  drivers/virtio/virtio_ring.c | 11 +++++++++++
> >  include/linux/dma-mapping.h  | 16 ++++++++++++++++
> >  include/linux/swiotlb.h      | 11 +++++++++++
> >  include/linux/virtio.h       |  2 ++
> >  kernel/dma/direct.c          | 12 ++++++++++++
> >  kernel/dma/swiotlb.c         | 14 ++++++++++++++
> >  8 files changed, 80 insertions(+), 4 deletions(-)
> > 
> > -- 
> > 2.17.1
> > 
