Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4D9C282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 22:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A77D20856
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 22:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfAWWZJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:25:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfAWWZJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 17:25:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07D8EC0C2723;
        Wed, 23 Jan 2019 22:25:09 +0000 (UTC)
Received: from redhat.com (ovpn-120-183.rdu2.redhat.com [10.10.120.183])
        by smtp.corp.redhat.com (Postfix) with SMTP id 169E46013C;
        Wed, 23 Jan 2019 22:25:00 +0000 (UTC)
Date:   Wed, 23 Jan 2019 17:25:00 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de,
        pbonzini@redhat.com, jsnow@redhat.com
Subject: Re: [PATCH 5/5] virtio-blk: Consider virtio_max_dma_size() for
 maximum segment size
Message-ID: <20190123170850-mutt-send-email-mst@kernel.org>
References: <20190123163049.24863-1-joro@8bytes.org>
 <20190123163049.24863-6-joro@8bytes.org>
 <20190123213139.GD9032@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123213139.GD9032@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 23 Jan 2019 22:25:09 +0000 (UTC)
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
> 
> Btw, I wonder why virtio-scsi sticks to the default segment size,
> unlike virtio-blk.

Well no one bothered exposing that through that device.
Why does virtio block have it? Hard for me to say. First driver version
had it already but QEMU does not seem to use it and it seems that it
never did.


-- 
MST
