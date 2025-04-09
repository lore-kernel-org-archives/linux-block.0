Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B9915530C
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207721; cv=none; b=htXAFPJ9vzQPiCbGnoi3SMNeRn4QAskNmzpJNbfZIQAcfRpvCjekSOkESEPju4aaqOoxkkyMoDWgYrJsZzmOZCzYRcVXdQnAxqzj7aIRaSjwXgQAq0m8DCJIVg5tTuspOT6u8cfzy3ZhTnaW6qW/SEbcTaG7Dtek4HQ+Ha4rAvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207721; c=relaxed/simple;
	bh=upYMPwnEr9VV/C9aSL7c+tahDsM0NDQGnJLcGTWu/Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIGOycsP+fn3Dr673yhuBpA1hV04zdaSepyRPej+7Auxoft6U/B88j9p+bPMGMJ1aeahm6hzfl/azvPp/qhjw7x9JHRhWYBeuUnj2s0XnQvMeByVp93TkWNVEsBhuCS0MdBEI8Wy0GTx3G17/Omg+PlU+hLjnC2LVwsKmghBmxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hrkwRZed; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrkwRZed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744207717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=csy3/FI1zRwmrkzGgG3KxGH4r7culwa5YEUmpS8Y9bk=;
	b=hrkwRZedWEFjWeINCT6la+7fh7F2nQp8PW8rRto3x2f1qU25I1+ZNsWt8gTGYg0mVnbYKi
	g0ZfhZeLn2patBsOztpz1nYck6fZEPT9cdgfxF5dkZOZZN83U8O/EsctPLk0sLLvbPr7qp
	MmTzAAX0VKOS8XPEX1VaSH8dhWNRfsQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-t81cOongO82M8eJpQs1j2g-1; Wed,
 09 Apr 2025 10:08:35 -0400
X-MC-Unique: t81cOongO82M8eJpQs1j2g-1
X-Mimecast-MFC-AGG-ID: t81cOongO82M8eJpQs1j2g_1744207713
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3D20180AF56;
	Wed,  9 Apr 2025 14:08:33 +0000 (UTC)
Received: from fedora (unknown [10.72.120.20])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A90A31955BEF;
	Wed,  9 Apr 2025 14:08:29 +0000 (UTC)
Date: Wed, 9 Apr 2025 22:08:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: don't grab elevator lock during queue
 initialization
Message-ID: <Z_Z_Vt2Rv2UfC1qv@fedora>
References: <20250404091037.GB12163@lst.de>
 <92feba7e-84fc-4668-92c3-aba4e8320559@linux.ibm.com>
 <Z_NB2VA9D5eqf0yH@fedora>
 <ea09ea46-4772-4947-a9ad-195e83f1490d@linux.ibm.com>
 <Z_TSYOzPI3GwVms7@fedora>
 <c2c9e913-1c24-49c7-bfc5-671728f8dddc@linux.ibm.com>
 <Z_UpoiWlBnwaUW7B@fedora>
 <ff08d88c-4680-40be-890a-19191e019419@linux.ibm.com>
 <Z_ZeEXyLLzrYcN3b@fedora>
 <03ba309d-b266-4596-83aa-1731c6cc1cfb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1HVwzvZ8lKiJPGhS"
Content-Disposition: inline
In-Reply-To: <03ba309d-b266-4596-83aa-1731c6cc1cfb@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


--1HVwzvZ8lKiJPGhS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 09, 2025 at 07:16:03PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/9/25 5:16 PM, Ming Lei wrote:
> >>>>> Not sure it is easily, ->tag_list_lock is exactly for protecting the list of "set->tag_list".
> >>>>>
> >>>> Please see this, here nvme_quiesce_io_queues doen't require ->tag_list_lock:
> >>>>
> >>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >>>> index 777db89fdaa7..002d2fd20e0c 100644
> >>>> --- a/drivers/nvme/host/core.c
> >>>> +++ b/drivers/nvme/host/core.c
> >>>> @@ -5010,10 +5010,19 @@ void nvme_quiesce_io_queues(struct nvme_ctrl *ctrl)
> >>>>  {
> >>>>         if (!ctrl->tagset)
> >>>>                 return;
> >>>> -       if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
> >>>> -               blk_mq_quiesce_tagset(ctrl->tagset);
> >>>> -       else
> >>>> -               blk_mq_wait_quiesce_done(ctrl->tagset);
> >>>> +       if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags)) {
> >>>> +               struct nvme_ns *ns;
> >>>> +               int srcu_idx;
> >>>> +
> >>>> +               srcu_idx = srcu_read_lock(&ctrl->srcu);
> >>>> +               list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
> >>>> +                               srcu_read_lock_held(&ctrl->srcu)) {
> >>>> +                       if (!blk_queue_skip_tagset_quiesce(ns->queue))
> >>>> +                               blk_mq_quiesce_queue_nowait(ns->queue);
> >>>> +               }
> >>>> +               srcu_read_unlock(&ctrl->srcu, srcu_idx);
> >>>> +       }
> >>>> +       blk_mq_wait_quiesce_done(ctrl->tagset);
> >>>>  }
> >>>>  EXPORT_SYMBOL_GPL(nvme_quiesce_io_queues);
> >>>>
> >>>> Here we iterate through ctrl->namespaces instead of relying on tag_list
> >>>> and so we don't need to acquire ->tag_list_lock.
> >>>
> >>> How can you make sure all NSs are covered in this way? RCU/SRCU can't
> >>> provide such kind of guarantee.
> >>>
> >> Why is that so? In fact, nvme_wait_freeze also iterates through 
> >> the same ctrl->namespaces to freeze the queue.
> > 
> > It depends if nvme error handling needs to cover new coming NS,
> > suppose it doesn't care, and you can change to srcu and bypass
> > ->tag_list_lock.
> > 
> Yes new incoming NS may not be live yet when we iterate through 
> ctrl->namespaces. So we don't need bother about it yet.
> >>
> >>>>
> >>>>> And the same list is iterated in blk_mq_update_nr_hw_queues() too.
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> So all queues should be frozen first before calling blk_mq_update_nr_hw_queues,
> >>>>>>> fortunately that is what nvme is doing.
> >>>>>>>
> >>>>>>>
> >>>>>>>> If yes then it means that we should be able to grab ->elevator_lock
> >>>>>>>> before freezing the queue in __blk_mq_update_nr_hw_queues and so locking
> >>>>>>>> order should be in each code path,
> >>>>>>>>
> >>>>>>>> __blk_mq_update_nr_hw_queues
> >>>>>>>>     ->elevator_lock 
> >>>>>>>>       ->freeze_lock
> >>>>>>>
> >>>>>>> Now tagset->elevator_lock depends on set->tag_list_lock, and this way
> >>>>>>> just make things worse. Why can't we disable elevator switch during
> >>>>>>> updating nr_hw_queues?
> >>>>>>>
> >>>>>> I couldn't quite understand this. As we already first disable the elevator
> >>>>>> before updating sw to hw queue mapping in __blk_mq_update_nr_hw_queues().
> >>>>>> Once mapping is successful we switch back the elevator.
> >>>>>
> >>>>> Yes, but user still may switch elevator from none to others during the
> >>>>> period, right?
> >>>>>
> >>>> Yes correct, that's possible. So your suggestion was to disable elevator
> >>>> update while we're running __blk_mq_update_nr_hw_queues? And that way user
> >>>> couldn't update elevator through sysfs (elv_iosched_store) while we update
> >>>> nr_hw_queues? If this is true then still how could it help solve lockdep
> >>>> splat? 
> >>>
> >>> Then why do you think per-set lock can solve the lockdep splat?
> >>>
> >>> __blk_mq_update_nr_hw_queues is the only chance for tagset wide queues
> >>> involved wrt. switching elevator. If elevator switching is not allowed
> >>> when __blk_mq_update_nr_hw_queues() is started, why do we need per-set
> >>> lock?
> >>>
> >> Yes if elevator switch is not allowed then we probably don't need per-set lock. 
> >> However my question was if we were to not allow elevator switch while 
> >> __blk_mq_update_nr_hw_queues is running then how would we implement it?
> > 
> > It can be done easily by tag_set->srcu.
> Ok great if that's possible! But I'm not sure how it could be done in this
> case. I think both __blk_mq_update_nr_hw_queues and elv_iosched_store
> run in the writer/updater context. So you may still need lock? Can you
> please send across a (informal) patch with your idea ?

Please see the attached patch which treats elv_iosched_store() as reader.

> 
> > 
> >> Do we need to synchronize with ->tag_list_lock? Or in another words,
> >> elv_iosched_store would now depends on ->tag_list_lock ? 
> > 
> > ->tag_list_lock isn't involved.
> > 
> >>
> >> On another note, if we choose to make ->elevator_lock per-set then 
> >> our locking sequence in blk_mq_update_nr_hw_queues() would be,
> > 
> > There is also add/del disk vs. updating nr_hw_queues, do you want to
> > add the per-set lock in add/del disk path too?
> 
> Ideally no we don't need to acquire ->elevator_lock in this path.
> Please see below.

blk_mq_update_nr_hw_queues() can come anytime, and there is still
race between blk_mq_update_nr_hw_queues and add/del disk.

> 
> >>
> >> blk_mq_update_nr_hw_queues
> >>   -> tag_list_lock
> >>     -> elevator_lock
> >>      -> freeze_lock 
> > 
> > Actually freeze lock is already held for nvme before calling
> > blk_mq_update_nr_hw_queues, and it is reasonable to suppose queue
> > frozen for updating nr_hw_queues, so the above order may not match
> > with the existed code.
> > 
> > Do we need to consider nvme or blk_mq_update_nr_hw_queues now?
> > 
> I think we should consider (may be in different patch) updating
> nvme_quiesce_io_queues and nvme_unquiesce_io_queues and remove
> its dependency on ->tag_list_lock.

If we need to take nvme into account, the above lock order doesn't work,
because nvme freezes queue before calling blk_mq_update_nr_hw_queues(),
and elevator lock still depends on freeze lock.

If it needn't to be considered, per-set lock becomes necessary.

> 
> >>
> >> elv_iosched_store
> >>   -> elevator_lock
> >>     -> freeze_lock
> > 
> > I understand that the per-set elevator_lock is just for avoiding the
> > nested elvevator lock class acquire? If we needn't to consider nvme
> > or blk_mq_update_nr_hw_queues(), this per-set lock may not be needed.
> > 
> > It is actually easy to sync elevator store vs. update nr_hw_queues.
> > 
> >>
> >> So now ->freeze_lock should not depend on ->elevator_lock and that shall
> >> help avoid few of the recent lockdep splats reported with fs_reclaim.
> >> What do you think?
> > 
> > Yes, reordering ->freeze_lock and ->elevator_lock may avoid many fs_reclaim
> > related splat.
> > 
> > However, in del_gendisk(), freeze_lock is still held before calling
> > elevator_exit() and blk_unregister_queue(), and looks not easy to reorder.
> 
> Yes agreed, however elevator_exit() called from del_gendisk() or 
> elv_unregister_queue() called from blk_unregister_queue() are called 
> after we unregister the queue. And if queue has been already unregistered
> while invoking elevator_exit or del_gensidk then ideally we don't need to
> acquire ->elevator_lock. The same is true for elevator_exit() called 
> from add_disk_fwnode(). So IMO, we should update these paths to avoid 
> acquiring ->elevator_lock.

As I mentioned, blk_mq_update_nr_hw_queues() still can come, which is one
host wide event, so either lock or srcu sync is needed.


Thanks,
Ming

--1HVwzvZ8lKiJPGhS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-block-prevent-elevator-switch-during-updating-nr_hw_.patch"

From a475139e47e745f32a68725f4abc59f9a0083d57 Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 1 Apr 2025 12:42:29 +0000
Subject: [PATCH] block: prevent elevator switch during updating nr_hw_queues

updating nr_hw_queues is usually used for error handling code, when it
doesn't make sense to allow blk-mq elevator switching, since nr_hw_queues
may change, and elevator tags depends on nr_hw_queues.

Prevent elevator switch during updating nr_hw_queues by setting flag of
BLK_MQ_F_UPDATE_HW_QUEUES, and use srcu to fail elevator switch during
the period.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c |  1 +
 block/blk-mq.c         | 32 ++++++++++++++++++++------------
 block/elevator.c       | 12 +++++++++++-
 include/linux/blk-mq.h |  9 ++++++++-
 4 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index c308699ded58..27f984311bb7 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -180,6 +180,7 @@ static const char *const hctx_flag_name[] = {
 	HCTX_FLAG_NAME(BLOCKING),
 	HCTX_FLAG_NAME(TAG_RR),
 	HCTX_FLAG_NAME(NO_SCHED_BY_DEFAULT),
+	HCTX_FLAG_NAME(UPDATE_HW_QUEUES),
 };
 #undef HCTX_FLAG_NAME
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d7a103dc258b..c1e7e1823369 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4776,14 +4776,12 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	if (set->nr_maps == 1 && set->nr_hw_queues > nr_cpu_ids)
 		set->nr_hw_queues = nr_cpu_ids;
 
-	if (set->flags & BLK_MQ_F_BLOCKING) {
-		set->srcu = kmalloc(sizeof(*set->srcu), GFP_KERNEL);
-		if (!set->srcu)
-			return -ENOMEM;
-		ret = init_srcu_struct(set->srcu);
-		if (ret)
-			goto out_free_srcu;
-	}
+	set->srcu = kmalloc(sizeof(*set->srcu), GFP_KERNEL);
+	if (!set->srcu)
+		return -ENOMEM;
+	ret = init_srcu_struct(set->srcu);
+	if (ret)
+		goto out_free_srcu;
 
 	ret = -ENOMEM;
 	set->tags = kcalloc_node(set->nr_hw_queues,
@@ -4864,10 +4862,9 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 
 	kfree(set->tags);
 	set->tags = NULL;
-	if (set->flags & BLK_MQ_F_BLOCKING) {
-		cleanup_srcu_struct(set->srcu);
-		kfree(set->srcu);
-	}
+
+	cleanup_srcu_struct(set->srcu);
+	kfree(set->srcu);
 }
 EXPORT_SYMBOL(blk_mq_free_tag_set);
 
@@ -5081,7 +5078,18 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 {
 	mutex_lock(&set->tag_list_lock);
+	/*
+	 * Mark us in updating nr_hw_queues for preventing switching
+	 * elevator
+	 *
+	 * Elevator switch code can _not_ acquire ->tag_list_lock
+	 */
+	set->flags |= BLK_MQ_F_UPDATE_HW_QUEUES;
+	synchronize_srcu(set->srcu);
+
 	__blk_mq_update_nr_hw_queues(set, nr_hw_queues);
+
+	set->flags &= BLK_MQ_F_UPDATE_HW_QUEUES;
 	mutex_unlock(&set->tag_list_lock);
 }
 EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
diff --git a/block/elevator.c b/block/elevator.c
index cf48613c6e62..e50e04ed15a0 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -718,9 +718,10 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 {
 	char elevator_name[ELV_NAME_MAX];
 	char *name;
-	int ret;
+	int ret, idx;
 	unsigned int memflags;
 	struct request_queue *q = disk->queue;
+	struct blk_mq_tag_set *set = q->tag_set;
 
 	/*
 	 * If the attribute needs to load a module, do it before freezing the
@@ -732,6 +733,13 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 
 	elv_iosched_load_module(name);
 
+	idx = srcu_read_lock(set->srcu);
+
+	if (set->flags & BLK_MQ_F_UPDATE_HW_QUEUES) {
+		ret = -EBUSY;
+		goto exit;
+	}
+
 	memflags = blk_mq_freeze_queue(q);
 	mutex_lock(&q->elevator_lock);
 	ret = elevator_change(q, name);
@@ -739,6 +747,8 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 		ret = count;
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
+exit:
+	srcu_read_unlock(set->srcu, idx);
 	return ret;
 }
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8eb9b3310167..71e05245af9d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -681,7 +681,14 @@ enum {
 	 */
 	BLK_MQ_F_NO_SCHED_BY_DEFAULT	= 1 << 6,
 
-	BLK_MQ_F_MAX = 1 << 7,
+	/*
+	 * True when updating nr_hw_queues is in-progress
+	 *
+	 * tag_set only flag, not usable for hctx
+	 */
+	BLK_MQ_F_UPDATE_HW_QUEUES	= 1 << 7,
+
+	BLK_MQ_F_MAX = 1 << 8,
 };
 
 #define BLK_MQ_MAX_DEPTH	(10240)
-- 
2.44.0


--1HVwzvZ8lKiJPGhS--

