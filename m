Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD5BC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 01:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EF220863
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 01:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68EF220863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeK2M10 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:27:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbeK2M10 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 07:27:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 556D0369CF;
        Thu, 29 Nov 2018 01:23:52 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5061460C61;
        Thu, 29 Nov 2018 01:23:46 +0000 (UTC)
Date:   Thu, 29 Nov 2018 09:23:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/8] virtio_blk: implement mq_ops->commit_rqs() hook
Message-ID: <20181129012342.GB23249@ming.t460p>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-6-axboe@kernel.dk>
 <20181128021029.GF11128@ming.t460p>
 <35b33a34-9e24-5acb-7a4e-57433328bf3d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35b33a34-9e24-5acb-7a4e-57433328bf3d@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 29 Nov 2018 01:23:52 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 27, 2018 at 07:34:51PM -0700, Jens Axboe wrote:
> On 11/27/18 7:10 PM, Ming Lei wrote:
> > On Mon, Nov 26, 2018 at 09:35:53AM -0700, Jens Axboe wrote:
> >> We need this for blk-mq to kick things into gear, if we told it that
> >> we had more IO coming, but then failed to deliver on that promise.
> >>
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >> ---
> >>  drivers/block/virtio_blk.c | 15 +++++++++++++++
> >>  1 file changed, 15 insertions(+)
> >>
> >> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> >> index 6e869d05f91e..b49c57e77780 100644
> >> --- a/drivers/block/virtio_blk.c
> >> +++ b/drivers/block/virtio_blk.c
> >> @@ -214,6 +214,20 @@ static void virtblk_done(struct virtqueue *vq)
> >>  	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
> >>  }
> >>  
> >> +static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> >> +{
> >> +	struct virtio_blk *vblk = hctx->queue->queuedata;
> >> +	int qid = hctx->queue_num;
> >> +	bool kick;
> >> +
> >> +	spin_lock_irq(&vblk->vqs[qid].lock);
> >> +	kick = virtqueue_kick_prepare(vblk->vqs[qid].vq);
> >> +	spin_unlock_irq(&vblk->vqs[qid].lock);
> >> +
> >> +	if (kick)
> >> +		virtqueue_notify(vblk->vqs[qid].vq);
> >> +}
> >> +
> >>  static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> >>  			   const struct blk_mq_queue_data *bd)
> >>  {
> >> @@ -638,6 +652,7 @@ static void virtblk_initialize_rq(struct request *req)
> >>  
> >>  static const struct blk_mq_ops virtio_mq_ops = {
> >>  	.queue_rq	= virtio_queue_rq,
> >> +	.commit_rqs	= virtio_commit_rqs,
> >>  	.complete	= virtblk_request_done,
> >>  	.init_request	= virtblk_init_request,
> >>  #ifdef CONFIG_VIRTIO_BLK_SCSI
> >> -- 
> >> 2.17.1
> >>
> > 
> > If .commit_rqs() is implemented, virtqueue_notify() in virtio_queue_rq()
> > should have been removed for saving the world switch per .queue_rq()
> 
> ->commits_rqs() is only for the case where bd->last is set to false,
> and we never make it to the end and flag bd->last == true. If bd->last
> is true, the driver should kick things into gear.

OK, looks I misunderstood it. However, virtio-blk doesn't need this
change since virtio_queue_rq() can handle it well. This patch may introduce
one unnecessary VM world switch in case of queue busy.

IMO bd->last won't work well in case of io scheduler given the rq_list
only includes one single request.

I wrote this kind of patch(never posted) before to use sort of ->commits_rqs()
to replace the current bd->last mechanism which need one extra driver tag,
which may improve the above case, also code gets cleaned up.

Thanks,
Ming
