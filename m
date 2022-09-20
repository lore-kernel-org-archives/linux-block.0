Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0C7C54EE9
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 04:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiITEmN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 00:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiITEmL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 00:42:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1858D53012
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2022 21:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663648930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NGl/WsIKHK6qXqwVjw/8kGSC4H9HcR5hemgEycnEl0A=;
        b=iSh2eOSIxxwxCH9OiabuwauhX6jWfMvczLh6Ay77QXc1qHWkULaGvAo2mmr39nWUYuT44F
        BzenwZYjYHV6YTz3zSU17Jt7qpC7NjvpzEYzXBPGAUVZUgBbtZ7xoAQvqo4VgXVitzOddi
        XZraqv7Psf5oMg5npK0NrivA8wt7qcY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-nlk-64QDPba9eA-ngPBEHw-1; Tue, 20 Sep 2022 00:41:59 -0400
X-MC-Unique: nlk-64QDPba9eA-ngPBEHw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFBD68039A0;
        Tue, 20 Sep 2022 04:41:58 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 72F0A140EBF5;
        Tue, 20 Sep 2022 04:41:54 +0000 (UTC)
Date:   Tue, 20 Sep 2022 12:41:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH V3 4/7] ublk_drv: requeue rqs with recovery feature
 enabled
Message-ID: <YylEjEply6y+bs0B@T590>
References: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
 <20220913041707.197334-5-ZiyangZhang@linux.alibaba.com>
 <YyfoQuw18kOynxcC@T590>
 <ff61718d-da2d-f754-5e56-b58a3e57820f@linux.alibaba.com>
 <Yyhi/kavaq1aLAQY@T590>
 <84b99294-6859-f49f-d529-c6e3899f2aa2@linux.alibaba.com>
 <Yykn7q/T9CUzZpxH@T590>
 <5383bd34-4f61-f3b0-0a75-a8a2eb75d7ef@linux.alibaba.com>
 <Yykw+NdXr/SX4yq4@T590>
 <0642eab9-6124-ba42-1585-82eab1ff9e87@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0642eab9-6124-ba42-1585-82eab1ff9e87@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 20, 2022 at 11:34:32AM +0800, Ziyang Zhang wrote:
> On 2022/9/20 11:18, Ming Lei wrote:
> > On Tue, Sep 20, 2022 at 11:04:30AM +0800, Ziyang Zhang wrote:
> >> On 2022/9/20 10:39, Ming Lei wrote:
> >>> On Tue, Sep 20, 2022 at 09:31:54AM +0800, Ziyang Zhang wrote:
> >>>> On 2022/9/19 20:39, Ming Lei wrote:
> >>>>> On Mon, Sep 19, 2022 at 05:12:21PM +0800, Ziyang Zhang wrote:
> >>>>>> On 2022/9/19 11:55, Ming Lei wrote:
> >>>>>>> On Tue, Sep 13, 2022 at 12:17:04PM +0800, ZiyangZhang wrote:
> >>>>>>>> With recovery feature enabled, in ublk_queue_rq or task work
> >>>>>>>> (in exit_task_work or fallback wq), we requeue rqs instead of
> >>>>>>>> ending(aborting) them. Besides, No matter recovery feature is enabled
> >>>>>>>> or disabled, we schedule monitor_work immediately.
> >>>>>>>>
> >>>>>>>> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> >>>>>>>> ---
> >>>>>>>>  drivers/block/ublk_drv.c | 34 ++++++++++++++++++++++++++++++++--
> >>>>>>>>  1 file changed, 32 insertions(+), 2 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> >>>>>>>> index 23337bd7c105..b067f33a1913 100644
> >>>>>>>> --- a/drivers/block/ublk_drv.c
> >>>>>>>> +++ b/drivers/block/ublk_drv.c
> >>>>>>>> @@ -682,6 +682,21 @@ static void ubq_complete_io_cmd(struct ublk_io *io, int res)
> >>>>>>>>  
> >>>>>>>>  #define UBLK_REQUEUE_DELAY_MS	3
> >>>>>>>>  
> >>>>>>>> +static inline void __ublk_abort_rq_in_task_work(struct ublk_queue *ubq,
> >>>>>>>> +		struct request *rq)
> >>>>>>>> +{
> >>>>>>>> +	pr_devel("%s: %s q_id %d tag %d io_flags %x.\n", __func__,
> >>>>>>>> +			(ublk_queue_can_use_recovery(ubq)) ? "requeue" : "abort",
> >>>>>>>> +			ubq->q_id, rq->tag, ubq->ios[rq->tag].flags);
> >>>>>>>> +	/* We cannot process this rq so just requeue it. */
> >>>>>>>> +	if (ublk_queue_can_use_recovery(ubq)) {
> >>>>>>>> +		blk_mq_requeue_request(rq, false);
> >>>>>>>> +		blk_mq_delay_kick_requeue_list(rq->q, UBLK_REQUEUE_DELAY_MS);
> >>>>>>>
> >>>>>>> Here you needn't to kick requeue list since we know it can't make
> >>>>>>> progress. And you can do that once before deleting gendisk
> >>>>>>> or the queue is recovered.
> >>>>>>
> >>>>>> No, kicking rq here is necessary.
> >>>>>>
> >>>>>> Consider USER_RECOVERY is enabled and everything goes well.
> >>>>>> User sends STOP_DEV, and we have kicked requeue list in
> >>>>>> ublk_stop_dev() and are going to call del_gendisk().
> >>>>>> However, a crash happens now. Then rqs may be still requeued
> >>>>>> by ublk_queue_rq() because ublk_queue_rq() sees a dying
> >>>>>> ubq_daemon. So del_gendisk() will hang because there are
> >>>>>> rqs leaving in requeue list and no one kicks them.
> >>>>>
> >>>>> Why can't you kick requeue list before calling del_gendisk().
> >>>>
> >>>> Yes, we can kick requeue list once before calling del_gendisk().
> >>>> But a crash may happen just after kicking but before del_gendisk().
> >>>> So some rqs may be requeued at this moment. But we have already
> >>>> kicked the requeue list! Then del_gendisk() will hang, right?
> >>>
> >>> ->force_abort is set before kicking in ublk_unquiesce_dev(), so
> >>> all new requests are failed immediately instead of being requeued,
> >>> right?
> >>>
> >>
> >> ->force_abort is not heplful here because there may be fallback wq running
> >> which can requeue rqs after kicking requeue list.
> > 
> > After ublk_wait_tagset_rqs_idle() returns, there can't be any
> > pending requests in fallback wq or task work, can there
> Please consider this case: a crash happens while ublk_stop_dev() is
> calling. In such case I cannot schedule quiesce_work or call
> ublk_wait_tagset_rqs_idle(). This is because quiesce_work has to
> accquire ub_mutex to quiesce request queue.

The issue can be addressed in the following way more reliably &
cleanly & consistently, then you needn't to switch between the
two modes.

ublk_stop_dev()

	if (ublk_can_use_recovery(ub)) {
		if (ub->dev_info.state == UBLK_S_DEV_LIVE)
				__ublk_quiesce_dev(ub);		//lockless version
		ublk_unquiesce_dev();
	}

Meantime not necessary to disable recovery feature in ublk_unquiesce_dev
any more.




thanks,
Ming

