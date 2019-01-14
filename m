Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E95C43387
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 20:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C292064C
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 20:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfANUWZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:22:25 -0500
Received: from verein.lst.de ([213.95.11.211]:48739 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfANUWZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 15:22:25 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id AE4B468D93; Mon, 14 Jan 2019 21:22:23 +0100 (CET)
Date:   Mon, 14 Jan 2019 21:22:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        brijesh.singh@amd.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Message-ID: <20190114202223.GB10781@lst.de>
References: <20190110134433.15672-1-joro@8bytes.org> <5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com> <20190111091502.GC5825@8bytes.org> <38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com> <20190114095002.GA29874@lst.de> <ac6d83d8-02de-dbdf-e309-3a1115642d50@redhat.com> <20190114131114-mutt-send-email-mst@kernel.org> <cb290df3-4e17-a403-6d69-cf5a8a41c987@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb290df3-4e17-a403-6d69-cf5a8a41c987@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 14, 2019 at 07:12:08PM +0000, Robin Murphy wrote:
> Now, in theory, yes, the real issue at hand is not unique to virtio-blk nor 
> SEV - any driver whose device has a sufficiently large DMA segment size and 
> who manages to get sufficient physically-contiguous memory could 
> technically generate a scatterlist segment longer than SWIOTLB can handle. 
> However, in practice that basically never happens, not least because very 
> few drivers ever override the default 64K DMA segment limit. AFAICS nothing 
> in drivers/virtio is calling dma_set_max_seg_size() or otherwise assigning 
> any dma_parms to replace the defaults either, so the really interesting 
> question here is how are these apparently-out-of-spec 256K segments getting 
> generated at all?

drivers/block/virtio_blk.c:virtblk_probe():

	/* Host can optionally specify maximum segment size and number of
         * segments. */
	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SIZE_MAX,
				   struct virtio_blk_config, size_max, &v);
        if (!err)
		blk_queue_max_segment_size(q, v);
	else
		blk_queue_max_segment_size(q, -1U);

So it really is virtio_blk that is special here.  The host could
set VIRTIO_BLK_F_SIZE_MAX to paper over the problem, but I really
think we need a dma_max_segment_size API that is wired up through
the dma_map_ops to sort this out for real.
