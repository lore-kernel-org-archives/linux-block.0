Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA2DC169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 07:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FE02175B
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 07:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbfA2Hil (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:38:41 -0500
Received: from verein.lst.de ([213.95.11.211]:44604 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfA2Hil (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 02:38:41 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BB9FB68CEB; Tue, 29 Jan 2019 08:38:39 +0100 (CET)
Date:   Tue, 29 Jan 2019 08:38:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
Subject: Re: [PATCH 5/5] virtio-blk: Consider virtio_max_dma_size() for
 maximum segment size
Message-ID: <20190129073839.GB4087@lst.de>
References: <20190123163049.24863-1-joro@8bytes.org> <20190123163049.24863-6-joro@8bytes.org> <20190123213139.GD9032@lst.de> <20190124084011.GJ32526@8bytes.org> <20190124084221.GB19441@lst.de> <20190124095150.GL32526@8bytes.org> <20190128080526.GA3874@lst.de> <20190128121407-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128121407-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 28, 2019 at 12:14:33PM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 28, 2019 at 09:05:26AM +0100, Christoph Hellwig wrote:
> > On Thu, Jan 24, 2019 at 10:51:51AM +0100, Joerg Roedel wrote:
> > > On Thu, Jan 24, 2019 at 09:42:21AM +0100, Christoph Hellwig wrote:
> > > > Yes.  But more importantly it would fix the limit for all other block
> > > > drivers that set large segment sizes when running over swiotlb.
> > > 
> > > True, so it would be something like the diff below? I havn't worked on
> > > the block layer, so I don't know if that needs additional checks for
> > > ->dev or anything.
> > 
> > Looks sensible.  Maybe for now we'll just do the virtio-blk case
> > that triggered it, and we'll do something like this patch for the
> > next merge window.  We'll also need to apply the same magic to the
> > DMA boundary.
> 
> So do I get an ack for this patch then?

I'll wait for a resend of the series to review the whole thing.
