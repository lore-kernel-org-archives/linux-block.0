Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBB425EFB2
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199205; cv=none; b=dpSxyo+GR4LQV8KqrBKqU4ZxUaSReUSpaggX8MuIy0BiDbAubRaiHwQyiETlN17+KaMFcKsSUS2q8EBl+lCS22OJPUVlFyxW9luDWeb1wMdutWyu92dQ3cJR682aNikuKgi4bn+F7i5v1ZXsU173GWFui+dwyeyVAd4vxhzXj4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199205; c=relaxed/simple;
	bh=VV5OQmC7X2+qx+JEFWQYU1ZEWbHaozd5Jzcl7xHiUO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6lPgPBk+zOyiA3j3znavBFZp/xXLMF7RB0zGAJNOWtcw5KlEXJKSkBJwVZNWbPV1ck/oLf7qwiSE3XUbkBPZl3+kNTr45128kG66u2J5S3gJXz3NWiE8KUt+vYm87vaRik/OMgjsNQkF6IwWN+fV44jpdVSDk372GIlnJLcGuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSLxUO3j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSLxUO3j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744199201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Vp5W9LEkNxFHEcqJK3cESygMZwUJNl684+JK4O4FXQ=;
	b=eSLxUO3jgLc3YZMc8slwppmmRoEI971sOYP4hP/C3ZNVP5f+g78cV2TBD0A6aAmyKh8Dlr
	oN9YqhMUDnkjffvRZCuZLa6IMO6jeb48F4Nz2/InchmsNRSFBr3CxtdeOKep2EcAAIznSJ
	UAqipN3RxBrRreCb8DNYBiE1Y3TgKNE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-_QW2vW74MvOUDSBv_3KDxw-1; Wed,
 09 Apr 2025 07:46:37 -0400
X-MC-Unique: _QW2vW74MvOUDSBv_3KDxw-1
X-Mimecast-MFC-AGG-ID: _QW2vW74MvOUDSBv_3KDxw_1744199196
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 123D2180AF4E;
	Wed,  9 Apr 2025 11:46:36 +0000 (UTC)
Received: from fedora (unknown [10.72.120.20])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87FCE1955DCE;
	Wed,  9 Apr 2025 11:46:31 +0000 (UTC)
Date: Wed, 9 Apr 2025 19:46:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: don't grab elevator lock during queue
 initialization
Message-ID: <Z_ZeEXyLLzrYcN3b@fedora>
References: <20250403105402.1334206-1-ming.lei@redhat.com>
 <20250404091037.GB12163@lst.de>
 <92feba7e-84fc-4668-92c3-aba4e8320559@linux.ibm.com>
 <Z_NB2VA9D5eqf0yH@fedora>
 <ea09ea46-4772-4947-a9ad-195e83f1490d@linux.ibm.com>
 <Z_TSYOzPI3GwVms7@fedora>
 <c2c9e913-1c24-49c7-bfc5-671728f8dddc@linux.ibm.com>
 <Z_UpoiWlBnwaUW7B@fedora>
 <ff08d88c-4680-40be-890a-19191e019419@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff08d88c-4680-40be-890a-19191e019419@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Apr 09, 2025 at 02:42:06PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/8/25 7:20 PM, Ming Lei wrote:
> > On Tue, Apr 08, 2025 at 06:55:26PM +0530, Nilay Shroff wrote:
> >>
> >>
> >> On 4/8/25 1:08 PM, Ming Lei wrote:
> >>> On Mon, Apr 07, 2025 at 01:59:48PM +0530, Nilay Shroff wrote:
> >>>>
> >>>>
> >>>> On 4/7/25 8:39 AM, Ming Lei wrote:
> >>>>> On Sat, Apr 05, 2025 at 07:44:19PM +0530, Nilay Shroff wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 4/4/25 2:40 PM, Christoph Hellwig wrote:
> >>>>>>> On Thu, Apr 03, 2025 at 06:54:02PM +0800, Ming Lei wrote:
> >>>>>>>> Fixes the following lockdep warning:
> >>>>>>>
> >>>>>>> Please spell the actual dependency out here, links are not permanent
> >>>>>>> and also not readable for any offline reading of the commit logs.
> >>>>>>>
> >>>>>>>> +static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> >>>>>>>> +				   struct request_queue *q, bool lock)
> >>>>>>>> +{
> >>>>>>>> +	if (lock) {
> >>>>>>>
> >>>>>>> bool lock(ed) arguments are an anti-pattern, and regularly get Linus
> >>>>>>> screaming at you (in this case even for the right reason :))
> >>>>>>>
> >>>>>>>> +		/* protect against switching io scheduler  */
> >>>>>>>> +		mutex_lock(&q->elevator_lock);
> >>>>>>>> +		__blk_mq_realloc_hw_ctxs(set, q);
> >>>>>>>> +		mutex_unlock(&q->elevator_lock);
> >>>>>>>> +	} else {
> >>>>>>>> +		__blk_mq_realloc_hw_ctxs(set, q);
> >>>>>>>> +	}
> >>>>>>>
> >>>>>>> I think the problem here is again that because of all the other
> >>>>>>> dependencies elevator_lock really needs to be per-set instead of
> >>>>>>> per-queue which will allows us to have much saner locking hierarchies.
> >>>>>>>
> >>>>>> I believe you meant here q->tag_set->elevator_lock? 
> >>>>>
> >>>>> I don't know what locks you are planning to invent.
> >>>>>
> >>>>> For set->tag_list_lock, it has been very fragile:
> >>>>>
> >>>>> blk_mq_update_nr_hw_queues
> >>>>> 	set->tag_list_lock
> >>>>> 		freeze_queue
> >>>>>
> >>>>> If IO failure happens when waiting in above freeze_queue(), the nvme error
> >>>>> handling can't provide forward progress any more, because the error
> >>>>> handling code path requires set->tag_list_lock.
> >>>>
> >>>> I think you're referring here nvme_quiesce_io_queues and nvme_unquiesce_io_queues
> >>>
> >>> Yes.
> >>>
> >>>> which is called in nvme error handling path. If yes then I believe this function 
> >>>> could be easily modified so that it doesn't require ->tag_list_lock. 
> >>>
> >>> Not sure it is easily, ->tag_list_lock is exactly for protecting the list of "set->tag_list".
> >>>
> >> Please see this, here nvme_quiesce_io_queues doen't require ->tag_list_lock:
> >>
> >> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >> index 777db89fdaa7..002d2fd20e0c 100644
> >> --- a/drivers/nvme/host/core.c
> >> +++ b/drivers/nvme/host/core.c
> >> @@ -5010,10 +5010,19 @@ void nvme_quiesce_io_queues(struct nvme_ctrl *ctrl)
> >>  {
> >>         if (!ctrl->tagset)
> >>                 return;
> >> -       if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
> >> -               blk_mq_quiesce_tagset(ctrl->tagset);
> >> -       else
> >> -               blk_mq_wait_quiesce_done(ctrl->tagset);
> >> +       if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags)) {
> >> +               struct nvme_ns *ns;
> >> +               int srcu_idx;
> >> +
> >> +               srcu_idx = srcu_read_lock(&ctrl->srcu);
> >> +               list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
> >> +                               srcu_read_lock_held(&ctrl->srcu)) {
> >> +                       if (!blk_queue_skip_tagset_quiesce(ns->queue))
> >> +                               blk_mq_quiesce_queue_nowait(ns->queue);
> >> +               }
> >> +               srcu_read_unlock(&ctrl->srcu, srcu_idx);
> >> +       }
> >> +       blk_mq_wait_quiesce_done(ctrl->tagset);
> >>  }
> >>  EXPORT_SYMBOL_GPL(nvme_quiesce_io_queues);
> >>
> >> Here we iterate through ctrl->namespaces instead of relying on tag_list
> >> and so we don't need to acquire ->tag_list_lock.
> > 
> > How can you make sure all NSs are covered in this way? RCU/SRCU can't
> > provide such kind of guarantee.
> > 
> Why is that so? In fact, nvme_wait_freeze also iterates through 
> the same ctrl->namespaces to freeze the queue.

It depends if nvme error handling needs to cover new coming NS,
suppose it doesn't care, and you can change to srcu and bypass
->tag_list_lock.

> 
> >>
> >>> And the same list is iterated in blk_mq_update_nr_hw_queues() too.
> >>>
> >>>>
> >>>>>
> >>>>> So all queues should be frozen first before calling blk_mq_update_nr_hw_queues,
> >>>>> fortunately that is what nvme is doing.
> >>>>>
> >>>>>
> >>>>>> If yes then it means that we should be able to grab ->elevator_lock
> >>>>>> before freezing the queue in __blk_mq_update_nr_hw_queues and so locking
> >>>>>> order should be in each code path,
> >>>>>>
> >>>>>> __blk_mq_update_nr_hw_queues
> >>>>>>     ->elevator_lock 
> >>>>>>       ->freeze_lock
> >>>>>
> >>>>> Now tagset->elevator_lock depends on set->tag_list_lock, and this way
> >>>>> just make things worse. Why can't we disable elevator switch during
> >>>>> updating nr_hw_queues?
> >>>>>
> >>>> I couldn't quite understand this. As we already first disable the elevator
> >>>> before updating sw to hw queue mapping in __blk_mq_update_nr_hw_queues().
> >>>> Once mapping is successful we switch back the elevator.
> >>>
> >>> Yes, but user still may switch elevator from none to others during the
> >>> period, right?
> >>>
> >> Yes correct, that's possible. So your suggestion was to disable elevator
> >> update while we're running __blk_mq_update_nr_hw_queues? And that way user
> >> couldn't update elevator through sysfs (elv_iosched_store) while we update
> >> nr_hw_queues? If this is true then still how could it help solve lockdep
> >> splat? 
> > 
> > Then why do you think per-set lock can solve the lockdep splat?
> > 
> > __blk_mq_update_nr_hw_queues is the only chance for tagset wide queues
> > involved wrt. switching elevator. If elevator switching is not allowed
> > when __blk_mq_update_nr_hw_queues() is started, why do we need per-set
> > lock?
> > 
> Yes if elevator switch is not allowed then we probably don't need per-set lock. 
> However my question was if we were to not allow elevator switch while 
> __blk_mq_update_nr_hw_queues is running then how would we implement it?

It can be done easily by tag_set->srcu.

> Do we need to synchronize with ->tag_list_lock? Or in another words,
> elv_iosched_store would now depends on ->tag_list_lock ? 

->tag_list_lock isn't involved.

> 
> On another note, if we choose to make ->elevator_lock per-set then 
> our locking sequence in blk_mq_update_nr_hw_queues() would be,

There is also add/del disk vs. updating nr_hw_queues, do you want to
add the per-set lock in add/del disk path too?

> 
> blk_mq_update_nr_hw_queues
>   -> tag_list_lock
>     -> elevator_lock
>      -> freeze_lock 

Actually freeze lock is already held for nvme before calling
blk_mq_update_nr_hw_queues, and it is reasonable to suppose queue
frozen for updating nr_hw_queues, so the above order may not match
with the existed code.

Do we need to consider nvme or blk_mq_update_nr_hw_queues now?

> 
> elv_iosched_store
>   -> elevator_lock
>     -> freeze_lock

I understand that the per-set elevator_lock is just for avoiding the
nested elvevator lock class acquire? If we needn't to consider nvme
or blk_mq_update_nr_hw_queues(), this per-set lock may not be needed.

It is actually easy to sync elevator store vs. update nr_hw_queues.

> 
> So now ->freeze_lock should not depend on ->elevator_lock and that shall
> help avoid few of the recent lockdep splats reported with fs_reclaim.
> What do you think?

Yes, reordering ->freeze_lock and ->elevator_lock may avoid many fs_reclaim
related splat.

However, in del_gendisk(), freeze_lock is still held before calling
elevator_exit() and blk_unregister_queue(), and looks not easy to reorder.

Thanks,
Ming

