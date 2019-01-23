Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5916AC282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 18:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38FB121855
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 18:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfAWSvc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:51:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfAWSvc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 13:51:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 018DBA429A;
        Wed, 23 Jan 2019 18:51:32 +0000 (UTC)
Received: from redhat.com (ovpn-123-123.rdu2.redhat.com [10.10.123.123])
        by smtp.corp.redhat.com (Postfix) with SMTP id 043915C23D;
        Wed, 23 Jan 2019 18:51:29 +0000 (UTC)
Date:   Wed, 23 Jan 2019 13:51:29 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
Subject: Re: [PATCH 0/5 v3] Fix virtio-blk issue with SWIOTLB
Message-ID: <20190123135000-mutt-send-email-mst@kernel.org>
References: <20190123163049.24863-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123163049.24863-1-joro@8bytes.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 23 Jan 2019 18:51:32 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 23, 2019 at 05:30:44PM +0100, Joerg Roedel wrote:
> Hi,
> 
> here is the third version of this patch-set. Previous
> versions can be found here:
> 
> 	V1: https://lore.kernel.org/lkml/20190110134433.15672-1-joro@8bytes.org/
> 
> 	V2: https://lore.kernel.org/lkml/20190115132257.6426-1-joro@8bytes.org/
> 
> The problem solved here is a limitation of the SWIOTLB implementation,
> which does not support allocations larger than 256kb.  When the
> virtio-blk driver tries to read/write a block larger than that, the
> allocation of the dma-handle fails and an IO error is reported.


OK looks good to me.
I will park this in my tree for now this way it will get
testing in linux-next.
Can I get an ack from DMA maintainers on the DMA bits for
merging this in 5.0?

> Changes to v2 are:
> 
> 	* Check if SWIOTLB is active before returning its limit in
> 	  dma_direct_max_mapping_size()
> 
> 	* Only apply the maximum segment limit in virtio-blk when
> 	  DMA-API is used for the vring
> 
> Please review.
> 
> Thanks,
> 
> 	Joerg
> 
> Joerg Roedel (5):
>   swiotlb: Introduce swiotlb_max_mapping_size()
>   swiotlb: Add is_swiotlb_active() function
>   dma: Introduce dma_max_mapping_size()
>   virtio: Introduce virtio_max_dma_size()
>   virtio-blk: Consider virtio_max_dma_size() for maximum segment size
> 
>  drivers/block/virtio_blk.c   | 10 ++++++----
>  drivers/virtio/virtio_ring.c | 10 ++++++++++
>  include/linux/dma-mapping.h  | 16 ++++++++++++++++
>  include/linux/swiotlb.h      | 11 +++++++++++
>  include/linux/virtio.h       |  2 ++
>  kernel/dma/direct.c          | 11 +++++++++++
>  kernel/dma/swiotlb.c         | 10 ++++++++++
>  7 files changed, 66 insertions(+), 4 deletions(-)
> 
> -- 
> 2.17.1
