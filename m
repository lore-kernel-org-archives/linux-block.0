Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2B3C4360F
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 11:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA61F20857
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 11:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfDBLGO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:06:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728748AbfDBLGO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Apr 2019 07:06:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B3F4086678;
        Tue,  2 Apr 2019 11:06:13 +0000 (UTC)
Received: from ming.t460p (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BBA787F2CC;
        Tue,  2 Apr 2019 11:06:04 +0000 (UTC)
Date:   Tue, 2 Apr 2019 19:05:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/5] blk-mq: allow to run queue if queue refcount is held
Message-ID: <20190402110558.GA12221@ming.t460p>
References: <20190401020036.GB30776@ming.t460p>
 <a64684d1-c3dc-b10a-1a03-0a8b2d01b331@acm.org>
 <20190401025237.GE30776@ming.t460p>
 <21b2000b-16b6-f5a6-692b-73143a49a4ec@oracle.com>
 <20190401032852.GG30776@ming.t460p>
 <ef192658-74cd-e193-cb40-aed546c2b309@oracle.com>
 <20190401100334.GA5493@ming.t460p>
 <ad0f8f4c-5efe-e50f-a3a7-4f7e3d368d28@oracle.com>
 <20190402025505.GB26316@ming.t460p>
 <ac11c70b-0914-cce7-7ed4-22acb292a965@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac11c70b-0914-cce7-7ed4-22acb292a965@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 02 Apr 2019 11:06:13 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 02, 2019 at 04:07:04PM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 4/2/19 10:55 AM, Ming Lei wrote:
> > On Tue, Apr 02, 2019 at 10:02:43AM +0800, jianchao.wang wrote:
> >> Hi Ming
> >>
> >> On 4/1/19 6:03 PM, Ming Lei wrote:
> >>> On Mon, Apr 01, 2019 at 05:19:01PM +0800, jianchao.wang wrote:
> >>>> Hi Ming
> >>>>
> >>>> On 4/1/19 11:28 AM, Ming Lei wrote:
> >>>>> On Mon, Apr 01, 2019 at 11:25:50AM +0800, jianchao.wang wrote:
> >>>>>> Hi Ming
> >>>>>>
> >>>>>> On 4/1/19 10:52 AM, Ming Lei wrote:
> >>>>>>>> percpu_ref_tryget_live() fails if a per-cpu counter is in the "dead" state.
> >>>>>>>> percpu_ref_kill() changes the state of a per-cpu counter to the "dead"
> >>>>>>>> state. blk_freeze_queue_start() calls percpu_ref_kill(). blk_cleanup_queue()
> >>>>>>>> already calls blk_set_queue_dying() and that last function calls
> >>>>>>>> blk_freeze_queue_start(). So I think that what you wrote is not correct and
> >>>>>>>> that inserting a percpu_ref_tryget_live()/percpu_ref_put() pair in
> >>>>>>>> blk_mq_run_hw_queues() or blk_mq_run_hw_queue() would make a difference and
> >>>>>>>> also that moving the percpu_ref_exit() call into blk_release_queue() makes
> >>>>>>>> sense.
> >>>>>>> If percpu_ref_exit() is moved to blk_release_queue(), we still need to
> >>>>>>> move freeing of hw queue's resource into blk_release_queue() like what
> >>>>>>> the patchset is doing.
> >>>>>>>
> >>>>>>> Then we don't need to get/put q_usage_counter in blk_mq_run_hw_queues() any more,
> >>>>>>> do we?
> >>>>>>
> >>>>>> IMO, if we could get a way to prevent any attempt to run queue, it would be
> >>>>>> better and clearer.
> >>>>>
> >>>>> It is hard to do that way, and not necessary.
> >>>>>
> >>>>> I will post V2 soon for review.
> >>>>>
> >>>>
> >>>> Put percpu_ref_tryget/put pair into blk_mq_run_hw_queues could stop run queue after
> >>>> requet_queue is frozen and drained (run queue is also unnecessary because there is no
> >>>> entered requests). And also percpu_ref_tryget could avoid the io hung issue you mentioned.
> >>>> We have similar one in blk_mq_timeout_work.
> >>>
> >>> If percpu_ref_tryget() is used, percpu_ref_exit() has to be moved into
> >>> queue's release handler.
> >>>
> >>> Then we still have to move freeing hctx's resource into hctx or queue's
> >>> release handler, that is exactly what this patch is doing. Then
> >>> percpu_ref_tryget() becomes unnecessary again, right?
> >>
> >> I'm not sure about the percpu_ref_exit. Perhaps I have some misunderstanding about it.
> >>
> >> From the code of it, it frees the percpu_count and set ref->percpu_count_ptr to __PERCPU_REF_ATOMIC_DEAD.
> >> The comment says 'the caller is responsible for ensuring that @ref is no longer in active use'
> >> But if we use it after kill, does it count a active use ?
> >> Based on the code, the __ref_is_percpu is always false during this, and percpu_ref_tryget will not
> >> touch the freed percpu counter but just the atomic ref->count.
> >>
> >> It looks safe.
> > 
> > OK, you are right.
> > 
> > However, I still think it isn't necessary to hold the perpcu_ref in the
> > very fast io path.
> 
> percpu_ref is born for fast path.
> There are some drivers use it in completion path, such as scsi, does it really
> matter for this kind of device ? If yes, I guess we should remove blk_mq_run_hw_queues
> which is the really bulk and depend on hctx restart mechanism.

Yes, it is designed for fast path, but it doesn't mean percpu_ref
hasn't any cost. blk_mq_run_hw_queues() is called for all blk-mq devices,
includes the fast NVMe.

Also:

It may not be enough to just grab the percpu_ref for blk_mq_run_hw_queues
only, given the idea is to use the percpu_ref to protect hctx's resources.

There are lots of uses on 'hctx', such as other exported blk-mq APIs.
If this approach were chosen, we may have to audit other blk-mq APIs,
cause they might be called after queue is frozen too.

So probably this usage may be misbuse on percpu_ref.

> 
> > 
> >>
> >>
> >>>
> >>>>
> >>>> freeze and drain queue to stop new attempt to run queue, blk_sync_queue syncs and stops
> >>>> the started ones, then hctx->run_queue is cleaned totally.
> >>>>
> >>>> IMO, it would be better to have a checkpoint after which there will be no any in-flight
> >>>> asynchronous activities of the request_queue (hctx->run_work, q->requeue_work, q-> timeout_work)
> >>>> and any attempt to start them will fail.
> >>>
> >>> All are canceled in blk_cleanup_queue(), but not enough, given queue can
> >>> be run in sync mode(such as via plug, direct issue, ...), or driver's
> >>> requeue, such as SCSI's requeue. SCSI's requeue may run other LUN's queue
> >>> just by holding queue's kobject refcount.
> >>
> >> Yes, so we need a checkpoint here to ensure the request_queue to enter into a certain state.
> >> We provide a guarantee that all of the activities are stopped after this checkpoint.
> >> It will be convenient for us to do other things following, for example release request_queue's
> >> resource.
> > 
> > We have such checkpoint already:
> > 
> > 	blk_freeze_queue() together with blk_sync_queue()
> > 
> > Once the two are done, there shouldn't be any driver activities at all.
> > 
> > The current issue is related with blk-mq internal implementation, in which
> > it should have been safe to complete the run queue activity during queue
> > cleanup if the request queue's kobject refcount isn't released.
> > 
> > However, 45a9c9d909b2 ("blk-mq: Fix a use-after-free") frees hctx
> > resource too early, and causes the kernel oops.
> > 
> > Also, isn't it the typical practice to release kobject related resources in
> > its release handler?
> 
> I agree with this.

OK.

Another point with freeing hctx resources in its release handler is that 
things become much simple: if the queue's kobject refcount is held,
almost all blk-mq APIs can be called safely. This way works perfectly on
legacy IO path for ages.

Thanks,
Ming
