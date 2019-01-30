Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFF4C282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 15:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85533218A4
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 15:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfA3PtZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:49:25 -0500
Received: from 8bytes.org ([81.169.241.247]:35894 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbfA3PtZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 10:49:25 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 42238301; Wed, 30 Jan 2019 16:49:23 +0100 (CET)
Date:   Wed, 30 Jan 2019 16:49:23 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "jfehlig@suse.com" <jfehlig@suse.com>,
        "Grimm, Jon" <Jon.Grimm@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "jroedel@suse.de" <jroedel@suse.de>
Subject: Re: [PATCH 4/5] virtio: Introduce virtio_max_dma_size()
Message-ID: <20190130154922.GO32526@8bytes.org>
References: <20190129084342.26030-1-joro@8bytes.org>
 <20190129084342.26030-5-joro@8bytes.org>
 <e138b703-188c-59d2-edec-65fe3e76d229@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e138b703-188c-59d2-edec-65fe3e76d229@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Tom,

On Wed, Jan 30, 2019 at 03:10:29PM +0000, Lendacky, Thomas wrote:
> On 1/29/19 2:43 AM, Joerg Roedel wrote:

> > +size_t virtio_max_dma_size(struct virtio_device *vdev)
> > +{
> > +	size_t max_segment_size = SIZE_MAX;
> > +
> > +	if (vring_use_dma_api(vdev))
> > +		max_segment_size = dma_max_mapping_size(&vdev->dev);
> > +
> > +	return max_segment_size;
> > +}
> 
> When I build with these patches and with the virtio devices as modules I
> get a build failure. Looks like this needs an EXPORT_SYMBOL_GPL().

Thanks for pointing that out, I added the missing EXPORTs and will send
a new version shortly.

Regards,

	Joerg
