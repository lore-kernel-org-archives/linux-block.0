Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D18FC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 02:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD44E2081C
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 02:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD44E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeK2Nzk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:55:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbeK2Nzk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 08:55:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D7EDFA6DE0;
        Thu, 29 Nov 2018 02:51:52 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5838B6A6A2;
        Thu, 29 Nov 2018 02:51:47 +0000 (UTC)
Date:   Thu, 29 Nov 2018 10:51:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/8] virtio_blk: implement mq_ops->commit_rqs() hook
Message-ID: <20181129025143.GC23390@ming.t460p>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-6-axboe@kernel.dk>
 <20181128021029.GF11128@ming.t460p>
 <35b33a34-9e24-5acb-7a4e-57433328bf3d@kernel.dk>
 <20181129012342.GB23249@ming.t460p>
 <e937451d-57dd-41a4-fc4d-b5bbdb10869f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e937451d-57dd-41a4-fc4d-b5bbdb10869f@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 29 Nov 2018 02:51:52 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 28, 2018 at 07:19:09PM -0700, Jens Axboe wrote:
> On 11/28/18 6:23 PM, Ming Lei wrote:
> > On Tue, Nov 27, 2018 at 07:34:51PM -0700, Jens Axboe wrote:
> >> On 11/27/18 7:10 PM, Ming Lei wrote:
> >>> On Mon, Nov 26, 2018 at 09:35:53AM -0700, Jens Axboe wrote:
> >>>> We need this for blk-mq to kick things into gear, if we told it that
> >>>> we had more IO coming, but then failed to deliver on that promise.
> >>>>
> >>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >>>> ---
> >>>>  drivers/block/virtio_blk.c | 15 +++++++++++++++
> >>>>  1 file changed, 15 insertions(+)
> >>>>
> >>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> >>>> index 6e869d05f91e..b49c57e77780 100644
> >>>> --- a/drivers/block/virtio_blk.c
> >>>> +++ b/drivers/block/virtio_blk.c
> >>>> @@ -214,6 +214,20 @@ static void virtblk_done(struct virtqueue *vq)
> >>>>  	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
> >>>>  }
> >>>>  
> >>>> +static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> >>>> +{
> >>>> +	struct virtio_blk *vblk = hctx->queue->queuedata;
> >>>> +	int qid = hctx->queue_num;
> >>>> +	bool kick;
> >>>> +
> >>>> +	spin_lock_irq(&vblk->vqs[qid].lock);
> >>>> +	kick = virtqueue_kick_prepare(vblk->vqs[qid].vq);
> >>>> +	spin_unlock_irq(&vblk->vqs[qid].lock);
> >>>> +
> >>>> +	if (kick)
> >>>> +		virtqueue_notify(vblk->vqs[qid].vq);
> >>>> +}
> >>>> +
> >>>>  static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> >>>>  			   const struct blk_mq_queue_data *bd)
> >>>>  {
> >>>> @@ -638,6 +652,7 @@ static void virtblk_initialize_rq(struct request *req)
> >>>>  
> >>>>  static const struct blk_mq_ops virtio_mq_ops = {
> >>>>  	.queue_rq	= virtio_queue_rq,
> >>>> +	.commit_rqs	= virtio_commit_rqs,
> >>>>  	.complete	= virtblk_request_done,
> >>>>  	.init_request	= virtblk_init_request,
> >>>>  #ifdef CONFIG_VIRTIO_BLK_SCSI
> >>>> -- 
> >>>> 2.17.1
> >>>>
> >>>
> >>> If .commit_rqs() is implemented, virtqueue_notify() in virtio_queue_rq()
> >>> should have been removed for saving the world switch per .queue_rq()
> >>
> >> ->commits_rqs() is only for the case where bd->last is set to false,
> >> and we never make it to the end and flag bd->last == true. If bd->last
> >> is true, the driver should kick things into gear.
> > 
> > OK, looks I misunderstood it. However, virtio-blk doesn't need this
> > change since virtio_queue_rq() can handle it well. This patch may introduce
> > one unnecessary VM world switch in case of queue busy.
> 
> Not it won't, it may in the case of some failure outside of the driver.

If the failure is because of out of tag, blk_mq_dispatch_wake() will
rerun the queue, and the bd->last will be set finally. Or is there
other failure(outside of driver) not covered?

> The only reason that virtio-blk doesn't currently hang is because it
> has restart logic, and the failure case only happens in the if we
> already have IO in-flight.

Yeah, virtqueue_kick() is called in case of any error in virtio_queue_rq(),
so I am still wondering why we have to implement .commit_rqs() for virtio-blk.

> For the NVMe variant, that's not going to be the case.

OK.

> 
> > IMO bd->last won't work well in case of io scheduler given the rq_list
> > only includes one single request.
> 
> But that's a fake limitation that definitely should just be lifted,
> the fact that blk-mq-sched is _currently_ just doing single requests
> is woefully inefficient.

I agree, but seems a bit hard given we have to consider request
merge.

> 
> > I wrote this kind of patch(never posted) before to use sort of
> > ->commits_rqs() to replace the current bd->last mechanism which need
> > one extra driver tag, which may improve the above case, also code gets
> > cleaned up.
> 
> It doesn't need one extra driver tag, we currently get an extra one just
> to flag ->last correctly. That's not a requirement, that's a limitation
> of the current implementation. We could get rid of that, and it it
> proves to be an issue, that's not hard to do.

What do you think about using .commit_rqs() to replace ->last? For
example, just call .commit_rqs() after the last request is queued to
driver successfully. Then we can remove bd->last and avoid to get the
extra tag for figuring out bd->last.

Thanks,
Ming
