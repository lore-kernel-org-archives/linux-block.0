Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF3AC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 03:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4552086B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 03:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4552086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeK1OFV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:05:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbeK1OFV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 09:05:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A17BC30B4A3E;
        Wed, 28 Nov 2018 03:05:20 +0000 (UTC)
Received: from redhat.com (ovpn-121-88.rdu2.redhat.com [10.10.121.88])
        by smtp.corp.redhat.com (Postfix) with SMTP id AAC215C1B2;
        Wed, 28 Nov 2018 03:05:19 +0000 (UTC)
Date:   Tue, 27 Nov 2018 22:05:18 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 5/8] virtio_blk: implement mq_ops->commit_rqs() hook
Message-ID: <20181127220128-mutt-send-email-mst@kernel.org>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-6-axboe@kernel.dk>
 <20181127234538.GD846@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127234538.GD846@vader>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 28 Nov 2018 03:05:20 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 27, 2018 at 03:45:38PM -0800, Omar Sandoval wrote:
> On Mon, Nov 26, 2018 at 09:35:53AM -0700, Jens Axboe wrote:
> > We need this for blk-mq to kick things into gear, if we told it that
> > we had more IO coming, but then failed to deliver on that promise.
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> 
> But also cc'd the virtio-blk maintainers.

Acked-by: Michael S. Tsirkin <mst@redhat.com>


Feel free to queue with other changes.


> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > ---
> >  drivers/block/virtio_blk.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 6e869d05f91e..b49c57e77780 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -214,6 +214,20 @@ static void virtblk_done(struct virtqueue *vq)
> >  	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
> >  }
> >  
> > +static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> > +{
> > +	struct virtio_blk *vblk = hctx->queue->queuedata;
> > +	int qid = hctx->queue_num;
> > +	bool kick;
> > +
> > +	spin_lock_irq(&vblk->vqs[qid].lock);
> > +	kick = virtqueue_kick_prepare(vblk->vqs[qid].vq);
> > +	spin_unlock_irq(&vblk->vqs[qid].lock);
> > +
> > +	if (kick)
> > +		virtqueue_notify(vblk->vqs[qid].vq);
> > +}
> > +
> >  static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> >  			   const struct blk_mq_queue_data *bd)
> >  {
> > @@ -638,6 +652,7 @@ static void virtblk_initialize_rq(struct request *req)
> >  
> >  static const struct blk_mq_ops virtio_mq_ops = {
> >  	.queue_rq	= virtio_queue_rq,
> > +	.commit_rqs	= virtio_commit_rqs,
> >  	.complete	= virtblk_request_done,
> >  	.init_request	= virtblk_init_request,
> >  #ifdef CONFIG_VIRTIO_BLK_SCSI
> > -- 
> > 2.17.1
> > 
