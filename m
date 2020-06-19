Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDE2C433DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 10:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45FA72073E
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 10:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJvnA0F9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbgFSKME (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:12:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34881 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732225AbgFSKMB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 06:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592561520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WvnaRcnfDA3IL8aXR7gMxiymCTyL1NKRb2G8dpseDfE=;
        b=SJvnA0F9oXfwPoLv4ZQULdbD8kg2+RSLVr8CpQWhQ4Yefp5yDsYQZfz5LA/+v7oZn/BkCC
        HuFVNWHoMoYovNYB7g97qcyIvTD5VO+Vk0e/00DFcvs2WTAZkrqR2/5UTjRSEJRVyXjSnf
        SYRtIby6MhCnpfrPd7vfMBzfn+ljHS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-KDPzoXx4PqmwmkObSWeS8A-1; Fri, 19 Jun 2020 06:11:58 -0400
X-MC-Unique: KDPzoXx4PqmwmkObSWeS8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 618AB8015CB
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2020 10:11:57 +0000 (UTC)
Received: from T590 (ovpn-12-44.pek2.redhat.com [10.72.12.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 59F6F5BAC1;
        Fri, 19 Jun 2020 10:11:46 +0000 (UTC)
Date:   Fri, 19 Jun 2020 18:11:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: dm-rq: don't call blk_mq_queue_stopped in dm_stop_queue()
Message-ID: <20200619101142.GA339442@T590>
References: <20200619084214.337449-1-ming.lei@redhat.com>
 <20200619094250.GA18410@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619094250.GA18410@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Mike,

On Fri, Jun 19, 2020 at 05:42:50AM -0400, Mike Snitzer wrote:
> Hi Ming,
> 
> Thanks for the patch!  But I'm having a hard time understanding what
> you've written in the patch header,
> 
> On Fri, Jun 19 2020 at  4:42am -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > dm-rq won't stop queue, meantime blk-mq won't stop one queue too, so
> > remove the check.
> 
> It'd be helpful if you could unpack this with more detail before going on
> to explain why using blk_queue_quiesced, despite dm-rq using
> blk_mq_queue_stopped, would also be ineffective.
> 
> SO:
> 
> > dm-rq won't stop queue
> 
> 1) why won't dm-rq stop the queue?  Do you mean it won't reliably
>    _always_ stop the queue because of the blk_mq_queue_stopped() check?

device mapper doesn't call blk_mq_stop_hw_queue or blk_mq_stop_hw_queues.

> 
> > meantime blk-mq won't stop one queue too, so remove the check.
> 
> 2) Meaning?: blk_mq_queue_stopped() will return true even if only one hw
> queue is stopped, given blk-mq must stop all hw queues a positive return
> from this blk_mq_queue_stopped() check is incorrectly assuming it meanss
> all hw queues are stopped.

blk-mq won't call blk_mq_stop_hw_queue or blk_mq_stop_hw_queues for
dm-rq's queue too, so dm-rq's hw queue won't be stopped.

BTW blk_mq_stop_hw_queue or blk_mq_stop_hw_queues are supposed to be
used for throttling queue.

> 
> > dm_stop_queue() actually tries to quiesce hw queues via blk_mq_quiesce_queue(),
> > we can't check via blk_queue_quiesced for avoiding unnecessary queue
> > quiesce because the flag is set before synchronize_rcu() and dm_stop_queue
> > may be called when synchronize_rcu from another blk_mq_quiesce_queue is
> > in-progress.
> 
> But I'm left with questions/confusion on this too:
> 
> 1) you mention blk_queue_quiesced instead of blk_mq_queue_stopped, so I
>    assume you mean that: not only is blk_mq_queue_stopped()
>    ineffective, blk_queue_quiesced() would be too?

blk_mq_queue_stopped isn't necessary because dm-rq's hw queue won't be
stopped by anyone, meantime replacing it with blk_queue_quiesced() is wrong.

> 
> 2) the race you detail (with competing blk_mq_quiesce_queue) relative to
>    synchronize_rcu() and testing "the flag" is very detailed yet vague.

If two code paths are calling dm_stop_queue() at the same time, one path may
return immediately and it is wrong, sine synchronize_rcu() from another path
may not be done.

> 
> Anyway, once we get this heaader cleaned up a bit more I'll be happy to
> get this staged as a stable@ fix for 5.8 inclusion ASAP.

This patch isn't a fix, and it shouldn't be related with rhel8's issue.

Thanks,
Ming

> 
> Thanks!
> Mike
> 
> > 
> > Cc: linux-block@vger.kernel.org
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/md/dm-rq.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
> > index f60c02512121..ed4d5ea66ccc 100644
> > --- a/drivers/md/dm-rq.c
> > +++ b/drivers/md/dm-rq.c
> > @@ -70,9 +70,6 @@ void dm_start_queue(struct request_queue *q)
> >  
> >  void dm_stop_queue(struct request_queue *q)
> >  {
> > -	if (blk_mq_queue_stopped(q))
> > -		return;
> > -
> >  	blk_mq_quiesce_queue(q);
> >  }
> >  
> > -- 
> > 2.25.2
> > 

-- 
Ming

