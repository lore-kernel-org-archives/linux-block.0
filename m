Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B1AC282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 08:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBC0218A2
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 08:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfAXIkN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:40:13 -0500
Received: from 8bytes.org ([81.169.241.247]:59470 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfAXIkN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 03:40:13 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A74AB3C8; Thu, 24 Jan 2019 09:40:11 +0100 (CET)
Date:   Thu, 24 Jan 2019 09:40:11 +0100
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
Message-ID: <20190124084011.GJ32526@8bytes.org>
References: <20190123163049.24863-1-joro@8bytes.org>
 <20190123163049.24863-6-joro@8bytes.org>
 <20190123213139.GD9032@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123213139.GD9032@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 23, 2019 at 10:31:39PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 23, 2019 at 05:30:49PM +0100, Joerg Roedel wrote:
> > +	max_size = virtio_max_dma_size(vdev);
> > +
> >  	/* Host can optionally specify maximum segment size and number of
> >  	 * segments. */
> >  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SIZE_MAX,
> >  				   struct virtio_blk_config, size_max, &v);
> >  	if (!err)
> > -		blk_queue_max_segment_size(q, v);
> > -	else
> > -		blk_queue_max_segment_size(q, -1U);
> > +		max_size = min(max_size, v);
> > +
> > +	blk_queue_max_segment_size(q, max_size);
> 
> I wonder if we should just move the dma max segment size check
> into blk_queue_max_segment_size so that all block drivers benefit
> from it.  Even if not I think at least the SCSI midlayer should
> be updated to support it.

In that case the limit would also apply to virtio-blk even if it doesn't
use the DMA-API. If that is acceptable we can move the check to
blk_queue_max_segment_size().

Regards,

	Joerg
