Return-Path: <SRS0=MQDU=QM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A71C282CB
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 20:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A712083B
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 20:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfBEUwt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:52:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfBEUwt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Feb 2019 15:52:49 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B1F0FC0528BD;
        Tue,  5 Feb 2019 20:52:48 +0000 (UTC)
Received: from redhat.com (ovpn-116-138.sin2.redhat.com [10.67.116.138])
        by smtp.corp.redhat.com (Postfix) with SMTP id 331D7601B0;
        Tue,  5 Feb 2019 20:52:40 +0000 (UTC)
Date:   Tue, 5 Feb 2019 15:52:38 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH 0/5 v6] Fix virtio-blk issue with SWIOTLB
Message-ID: <20190205155133-mutt-send-email-mst@kernel.org>
References: <20190131163403.11363-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131163403.11363-1-joro@8bytes.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 05 Feb 2019 20:52:49 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 31, 2019 at 05:33:58PM +0100, Joerg Roedel wrote:
> Hi,
> 
> here is the next version of this patch-set. Previous
> versions can be found here:
> 
> 	V1: https://lore.kernel.org/lkml/20190110134433.15672-1-joro@8bytes.org/
> 
> 	V2: https://lore.kernel.org/lkml/20190115132257.6426-1-joro@8bytes.org/
> 
> 	V3: https://lore.kernel.org/lkml/20190123163049.24863-1-joro@8bytes.org/
> 
> 	V4: https://lore.kernel.org/lkml/20190129084342.26030-1-joro@8bytes.org/
> 
> 	V5: https://lore.kernel.org/lkml/20190130164007.26497-1-joro@8bytes.org/
> 
> The problem solved here is a limitation of the SWIOTLB implementation,
> which does not support allocations larger than 256kb.  When the
> virtio-blk driver tries to read/write a block larger than that, the
> allocation of the dma-handle fails and an IO error is reported.
> 
> Changes to v5 are:
> 
> 	- Changed patch 3 to uninline dma_max_mapping_size()

And this lead to problems reported by kbuild :(

BTW when you repost, can I ask you to pls include
the version in all patches? Both --subject-prefix
and -v flags to git format-patch will do this for you.


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
>  Documentation/DMA-API.txt    |  8 ++++++++
>  drivers/block/virtio_blk.c   | 10 ++++++----
>  drivers/virtio/virtio_ring.c | 11 +++++++++++
>  include/linux/dma-mapping.h  |  8 ++++++++
>  include/linux/swiotlb.h      | 11 +++++++++++
>  include/linux/virtio.h       |  2 ++
>  kernel/dma/direct.c          | 11 +++++++++++
>  kernel/dma/mapping.c         | 14 ++++++++++++++
>  kernel/dma/swiotlb.c         | 14 ++++++++++++++
>  9 files changed, 85 insertions(+), 4 deletions(-)
> 
> -- 
> 2.17.1
