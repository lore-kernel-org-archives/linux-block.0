Return-Path: <SRS0=DRnZ=PT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C571C43387
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 03:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037AC2146F
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 03:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfAKD3o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 22:29:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbfAKD3o (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 22:29:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 726E573A62;
        Fri, 11 Jan 2019 03:29:43 +0000 (UTC)
Received: from [10.72.12.143] (ovpn-12-143.pek2.redhat.com [10.72.12.143])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 992D65C219;
        Fri, 11 Jan 2019 03:29:34 +0000 (UTC)
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
To:     Joerg Roedel <joro@8bytes.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, hch@lst.de
References: <20190110134433.15672-1-joro@8bytes.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
Date:   Fri, 11 Jan 2019 11:29:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190110134433.15672-1-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 11 Jan 2019 03:29:43 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2019/1/10 下午9:44, Joerg Roedel wrote:
> Hi,
>
> there is a problem with virtio-blk driven devices when
> virtio-ring uses SWIOTLB through the DMA-API. This happens
> for example in AMD-SEV enabled guests, where the guest RAM
> is mostly encrypted and all emulated DMA has to happen
> to/from the SWIOTLB aperture.
>
> The problem is a limitation of the SWIOTLB implementation,
> which does not support allocations larger than 256kb. When
> the virtio-blk driver tries to read/write a block larger
> than that, the allocation of the dma-handle fails and an IO
> error is reported.
>
> This patch-set adds a check to the virtio-code whether it
> might be using SWIOTLB bounce buffering and limits the
> maximum segment size in the virtio-blk driver in this case,
> so that it doesn't try to do larger reads/writes.


Just wonder if my understanding is correct IOMMU_PLATFORM must be set 
for all virtio devices under AMD-SEV guests?

Thanks


>
> Please review.
>
> Thanks,
>
> 	Joerg
>
> Joerg Roedel (3):
>    swiotlb: Export maximum allocation size
>    virtio: Introduce virtio_max_dma_size()
>    virtio-blk: Consider virtio_max_dma_size() for maximum segment size
>
>   drivers/block/virtio_blk.c   | 10 ++++++----
>   drivers/virtio/virtio_ring.c | 11 +++++++++++
>   include/linux/swiotlb.h      | 12 ++++++++++++
>   include/linux/virtio.h       |  2 ++
>   4 files changed, 31 insertions(+), 4 deletions(-)
>
