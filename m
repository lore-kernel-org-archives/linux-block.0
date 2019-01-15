Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A754C43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 13:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25ED20651
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 13:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfAONFi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:05:38 -0500
Received: from verein.lst.de ([213.95.11.211]:52922 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727744AbfAONFh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 08:05:37 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 675BA67358; Tue, 15 Jan 2019 14:05:36 +0100 (CET)
Date:   Tue, 15 Jan 2019 14:05:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, hch@lst.de,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 1/3] swiotlb: Export maximum allocation size
Message-ID: <20190115130536.GA28364@lst.de>
References: <20190110134433.15672-1-joro@8bytes.org> <20190110134433.15672-2-joro@8bytes.org> <20190110170205.GB27546@char.us.oracle.com> <20190111091231.GB5825@8bytes.org> <20190114204907.GH32038@char.us.oracle.com> <20190114165800-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114165800-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 14, 2019 at 04:59:27PM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 14, 2019 at 03:49:07PM -0500, Konrad Rzeszutek Wilk wrote:
> > On Fri, Jan 11, 2019 at 10:12:31AM +0100, Joerg Roedel wrote:
> > > On Thu, Jan 10, 2019 at 12:02:05PM -0500, Konrad Rzeszutek Wilk wrote:
> > > > Why not use swiotlb_nr_tbl ? That is how drivers/gpu/drm use to figure if they
> > > > need to limit the size of pages.
> > > 
> > > That function just exports the overall size of the swiotlb aperture, no?
> > > What I need here is the maximum size for a single mapping.
> > 
> > Yes. The other drivers just assumed that if there is SWIOTLB they would use
> > the smaller size by default (as in they knew the limitation).
> > 
> > But I agree it would be better to have something smarter - and also convert the
> > DRM drivers to piggy back on this.
> > 
> > Or alternatively we could make SWIOTLB handle bigger sizes..
> 
> 
> Just a thought: is it a good idea to teach blk_queue_max_segment_size
> to get the dma size? This will help us find other devices
> possibly missing this check.

Yes, we should.  Both the existing DMA size communicated through dma_params
which is set by the driver, and this new DMA-ops exposed one which needs
to be added.  I'm working on some preliminary patches for the first part,
as I think I introduced a bug related to that in the SCSI layer in 5.0..
