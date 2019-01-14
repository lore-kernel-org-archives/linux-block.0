Return-Path: <SRS0=WI6O=PW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A12C43387
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 20:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D6B20675
	for <linux-block@archiver.kernel.org>; Mon, 14 Jan 2019 20:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfANU3n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:29:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfANU3n (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 15:29:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DC885F722;
        Mon, 14 Jan 2019 20:29:42 +0000 (UTC)
Received: from redhat.com (ovpn-124-229.rdu2.redhat.com [10.10.124.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 655491800B;
        Mon, 14 Jan 2019 20:29:39 +0000 (UTC)
Date:   Mon, 14 Jan 2019 15:29:38 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        brijesh.singh@amd.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Message-ID: <20190114151537-mutt-send-email-mst@kernel.org>
References: <20190110134433.15672-1-joro@8bytes.org>
 <5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
 <20190111091502.GC5825@8bytes.org>
 <38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com>
 <20190114095002.GA29874@lst.de>
 <ac6d83d8-02de-dbdf-e309-3a1115642d50@redhat.com>
 <20190114131114-mutt-send-email-mst@kernel.org>
 <cb290df3-4e17-a403-6d69-cf5a8a41c987@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb290df3-4e17-a403-6d69-cf5a8a41c987@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 14 Jan 2019 20:29:42 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 14, 2019 at 07:12:08PM +0000, Robin Murphy wrote:
> On 14/01/2019 18:20, Michael S. Tsirkin wrote:
> > On Mon, Jan 14, 2019 at 08:41:37PM +0800, Jason Wang wrote:
> > > 
> > > On 2019/1/14 下午5:50, Christoph Hellwig wrote:
> > > > On Mon, Jan 14, 2019 at 05:41:56PM +0800, Jason Wang wrote:
> > > > > On 2019/1/11 下午5:15, Joerg Roedel wrote:
> > > > > > On Fri, Jan 11, 2019 at 11:29:31AM +0800, Jason Wang wrote:
> > > > > > > Just wonder if my understanding is correct IOMMU_PLATFORM must be set for
> > > > > > > all virtio devices under AMD-SEV guests?
> > > > > > Yes, that is correct. Emulated DMA can only happen on the SWIOTLB
> > > > > > aperture, because that memory is not encrypted. The guest bounces the
> > > > > > data then to its encrypted memory.
> > > > > > 
> > > > > > Regards,
> > > > > > 
> > > > > > 	Joerg
> > > > > 
> > > > > Thanks, have you tested vhost-net in this case. I suspect it may not work
> > > > Which brings me back to my pet pevee that we need to take actions
> > > > that virtio uses the proper dma mapping API by default with quirks
> > > > for legacy cases.  The magic bypass it uses is just causing problems
> > > > over problems.
> > > 
> > > 
> > > Yes, I fully agree with you. This is probably an exact example of such
> > > problem.
> > > 
> > > Thanks
> > 
> > I don't think so - the issue is really that DMA API does not yet handle
> > the SEV case 100% correctly. I suspect passthrough devices would have
> > the same issue.
> 
> Huh? Regardless of which virtio devices use it or not, the DMA API is
> handling the SEV case as correctly as it possibly can, by forcing everything
> through the unencrypted bounce buffer. If the segments being mapped are too
> big for that bounce buffer in the first place, there's nothing it can
> possibly do except fail, gracefully or otherwise.

It seems reasonable to be able to ask it what it's capabilities are
though.

> Now, in theory, yes, the real issue at hand is not unique to virtio-blk nor
> SEV - any driver whose device has a sufficiently large DMA segment size and
> who manages to get sufficient physically-contiguous memory could technically
> generate a scatterlist segment longer than SWIOTLB can handle. However, in
> practice that basically never happens, not least because very few drivers
> ever override the default 64K DMA segment limit. AFAICS nothing in
> drivers/virtio is calling dma_set_max_seg_size() or otherwise assigning any
> dma_parms to replace the defaults either, so the really interesting question
> here is how are these apparently-out-of-spec 256K segments getting generated
> at all?
> 
> Robin.

I guess this is what you are looking for:

        /* Host can optionally specify maximum segment size and number of
         * segments. */
        err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SIZE_MAX,
                                   struct virtio_blk_config, size_max, &v);
        if (!err)
                blk_queue_max_segment_size(q, v);
        else
                blk_queue_max_segment_size(q, -1U);

virtio isn't the only caller with a value >64K:

$ git grep -A1 blk_queue_max_segment_size
Documentation/block/biodoc.txt: blk_queue_max_segment_size(q, max_seg_size)
Documentation/block/biodoc.txt-         Maximum size of a clustered segment, 64kB default.
--
block/blk-settings.c: * blk_queue_max_segment_size - set max segment size for blk_rq_map_sg
block/blk-settings.c- * @q:  the request queue for the device
--
block/blk-settings.c:void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
block/blk-settings.c-{
--
block/blk-settings.c:EXPORT_SYMBOL(blk_queue_max_segment_size);
block/blk-settings.c-
--
drivers/block/mtip32xx/mtip32xx.c:      blk_queue_max_segment_size(dd->queue, 0x400000);
drivers/block/mtip32xx/mtip32xx.c-      blk_queue_io_min(dd->queue, 4096);
--
drivers/block/nbd.c:    blk_queue_max_segment_size(disk->queue, UINT_MAX);
drivers/block/nbd.c-    blk_queue_max_segments(disk->queue, USHRT_MAX);
--
drivers/block/ps3disk.c:        blk_queue_max_segment_size(queue, dev->bounce_size);
drivers/block/ps3disk.c-
--
drivers/block/ps3vram.c:        blk_queue_max_segment_size(queue, BLK_MAX_SEGMENT_SIZE);
drivers/block/ps3vram.c-        blk_queue_max_hw_sectors(queue, BLK_SAFE_MAX_SECTORS);
--
drivers/block/rbd.c:    blk_queue_max_segment_size(q, UINT_MAX);
drivers/block/rbd.c-    blk_queue_io_min(q, objset_bytes);
--
drivers/block/sunvdc.c: blk_queue_max_segment_size(q, PAGE_SIZE);
drivers/block/sunvdc.c-
--
drivers/block/virtio_blk.c:             blk_queue_max_segment_size(q, v);
drivers/block/virtio_blk.c-     else
drivers/block/virtio_blk.c:             blk_queue_max_segment_size(q, -1U);
drivers/block/virtio_blk.c-
--
drivers/block/xen-blkfront.c:   blk_queue_max_segment_size(rq, PAGE_SIZE);
drivers/block/xen-blkfront.c-
--
drivers/cdrom/gdrom.c:  blk_queue_max_segment_size(gd.gdrom_rq, 0x40000);
drivers/cdrom/gdrom.c-  gd.disk->queue = gd.gdrom_rq;
--
drivers/memstick/core/ms_block.c:       blk_queue_max_segment_size(msb->queue,
drivers/memstick/core/ms_block.c-                                  MS_BLOCK_MAX_PAGES * msb->page_size);
--
drivers/memstick/core/mspro_block.c:    blk_queue_max_segment_size(msb->queue,
drivers/memstick/core/mspro_block.c-                               MSPRO_BLOCK_MAX_PAGES * msb->page_size);
--
drivers/mmc/core/queue.c:       blk_queue_max_segment_size(mq->queue, host->max_seg_size);
drivers/mmc/core/queue.c-
--
drivers/s390/block/dasd.c:      blk_queue_max_segment_size(q, PAGE_SIZE);
drivers/s390/block/dasd.c-      blk_queue_segment_boundary(q, PAGE_SIZE - 1);
--
drivers/scsi/be2iscsi/be_main.c:        blk_queue_max_segment_size(sdev->request_queue, 65536);
drivers/scsi/be2iscsi/be_main.c-        return 0;
--
drivers/scsi/scsi_debug.c:      blk_queue_max_segment_size(sdp->request_queue, -1U);
drivers/scsi/scsi_debug.c-      if (sdebug_no_uld)
--
drivers/scsi/scsi_lib.c:        blk_queue_max_segment_size(q, dma_get_max_seg_size(dev));
drivers/scsi/scsi_lib.c-
--
drivers/scsi/ufs/ufshcd.c:      blk_queue_max_segment_size(q, PRDT_DATA_BYTE_COUNT_MAX);
drivers/scsi/ufs/ufshcd.c-
--
include/linux/blkdev.h:extern void blk_queue_max_segment_size(struct request_queue *, unsigned int);
include/linux/blkdev.h-extern void blk_queue_max_discard_sectors(struct request_queue *q,
--
include/linux/mmc/host.h:       unsigned int            max_seg_size;   /* see blk_queue_max_segment_size */
include/linux/mmc/host.h-       unsigned short          max_segs;       /* see blk_queue_max_segments */


Some of these devices are probably not going to work well if
passed through to a SEV guest.

Going back to virtio, at some level virtio is like a stacking device so
it does not necessarily need a limit.

-- 
MST
