Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2C324395C
	for <linux-block@vger.kernel.org>; Fri, 15 Aug 2025 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755262733; cv=none; b=KCOKUlOzvF5XiiuM2l8Ysqv6ZwYDdfPxR5pILkVPznqnBq/LXjjXtP5smY4UZTc16//5HbVKK6FDxo4Yg6jfS+CbBjx2rSnccujuTHSeXZuHdBfVD9/x6qPkehpdwjUJx6cBFJOoKTr8I8rYvoDHwHxfEkKXv9JpkadmG4e4Rxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755262733; c=relaxed/simple;
	bh=t3k75nQqH3V8jC6ZnJDhvZ8HSREGz7k0KQaQVIUKjcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgGNWFnk6rCTgZFw6pMFL3aSBfhFvDdLkUV8RhLru0mo950bBQJPwzTReAVd3nHRypdwtItXjgtpvYo8fvDOm5qS4K4bmEJQltghPykuKBXHWpoaDEfMDNdQGlRhVp1xfmKiMGG3T7c4SsYcySfQ3NBJp5yjfhqlnm81vMEce14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehwc0x8R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehwc0x8R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755262730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3GRjMXyh5d0Cj94X7pGTWDz1SzFp/LlSjtAlVPy37uI=;
	b=ehwc0x8RBK6cibB8OhPa1aNLNAmNNtyAq63gkbtqvBjieCxMMuCSsZtx29VbvL1BbZ3ZQE
	7YQM/dl/L5nKNZ65rsMyfT3fPMPUtjI9Lw8tH6548DXidrq/Hi1l2/cSl9FVcTt0pUDkLd
	PUcQnkRJ5JC1Jwqb3C8NLZbSMDpMhao=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-aUCleU-gNPyMkJuO0K6wVA-1; Fri,
 15 Aug 2025 08:58:46 -0400
X-MC-Unique: aUCleU-gNPyMkJuO0K6wVA-1
X-Mimecast-MFC-AGG-ID: aUCleU-gNPyMkJuO0K6wVA_1755262725
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E130180035C;
	Fri, 15 Aug 2025 12:58:45 +0000 (UTC)
Received: from fedora (unknown [10.72.116.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B373219327C0;
	Fri, 15 Aug 2025 12:58:34 +0000 (UTC)
Date: Fri, 15 Aug 2025 20:58:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] blk-mq: fix lockdep warning in
 __blk_mq_update_nr_hw_queues
Message-ID: <aJ8u7nI4GtyOECF9@fedora>
References: <20250815075636.304660-1-ming.lei@redhat.com>
 <ff5639d3-9a63-e26c-a062-cb8a23c0ed5d@huaweicloud.com>
 <b4183646-a5cf-1f29-5451-c63fdda7c490@huaweicloud.com>
 <aJ8AAiINKj-3c1Xw@fedora>
 <5c57a6a5-d9a4-4c21-86cd-784e4f3876fd@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c57a6a5-d9a4-4c21-86cd-784e4f3876fd@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Aug 15, 2025 at 03:36:02PM +0530, Nilay Shroff wrote:
> 
> 
> On 8/15/25 3:08 PM, Ming Lei wrote:
> > On Fri, Aug 15, 2025 at 05:34:23PM +0800, Yu Kuai wrote:
> >> Hi,
> >>
> >> 在 2025/08/15 17:15, Yu Kuai 写道:
> >>> Will it be simpler if we move blk_mq_freeze_queue_nomemsave() into
> >>> blk_mq_elv_switch_none(), after elevator is succeed switching to none
> >>> then freeze the queue.
> >>>
> >>> Later in blk_mq_elv_switch_back we'll know if xa_load() return valid
> >>> elevator_type, related queue is already freezed.
> >>
> >> Like following:
> >>
> >> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >> index e9f037a25fe3..3640fae5707b 100644
> >> --- a/block/blk-mq.c
> >> +++ b/block/blk-mq.c
> >> @@ -5010,7 +5010,13 @@ static int blk_mq_elv_switch_none(struct
> >> request_queue *q,
> >>                 __elevator_get(q->elevator->type);
> >>
> >>                 elevator_set_none(q);
> >> +       } else {
> >> +               ret = xa_insert(elv_tbl, q->id, xa_mk_value(1), GFP_KERNEL);
> >> +               if (WARN_ON_ONCE(ret))
> >> +                       return ret;
> >>         }
> >> +
> >> +       blk_mq_freeze_queue_nomemsave(q);
> >>         return ret;
> >>  }
> >>
> >> @@ -5045,9 +5051,6 @@ static void __blk_mq_update_nr_hw_queues(struct
> >> blk_mq_tag_set *set,
> >>                 blk_mq_sysfs_unregister_hctxs(q);
> >>         }
> >>
> >> -       list_for_each_entry(q, &set->tag_list, tag_set_list)
> >> -               blk_mq_freeze_queue_nomemsave(q);
> >> -
> >>         /*
> >>          * Switch IO scheduler to 'none', cleaning up the data associated
> >>          * with the previous scheduler. We will switch back once we are done
> >> diff --git a/block/elevator.c b/block/elevator.c
> >> index e2ebfbf107b3..9400ea9ec024 100644
> >> --- a/block/elevator.c
> >> +++ b/block/elevator.c
> >> @@ -715,16 +715,21 @@ void elv_update_nr_hw_queues(struct request_queue *q,
> >> struct elevator_type *e,
> >>
> >>         WARN_ON_ONCE(q->mq_freeze_depth == 0);
> >>
> >> -       if (e && !blk_queue_dying(q) && blk_queue_registered(q)) {
> >> -               ctx.name = e->elevator_name;
> >> -               ctx.et = t;
> >> -
> >> -               mutex_lock(&q->elevator_lock);
> >> -               /* force to reattach elevator after nr_hw_queue is updated
> >> */
> >> -               ret = elevator_switch(q, &ctx);
> >> -               mutex_unlock(&q->elevator_lock);
> >> +       if (e) {
> >> +               if (!xa_is_value(e) && !blk_queue_dying(q) &&
> >> +                   blk_queue_registered(q)) {
> >> +                       ctx.name = e->elevator_name;
> >> +                       ctx.et = t;
> >> +
> >> +                       mutex_lock(&q->elevator_lock);
> >> +                       /* force to reattach elevator after nr_hw_queue is
> >> updated */
> >> +                       ret = elevator_switch(q, &ctx);
> >> +                       mutex_unlock(&q->elevator_lock);
> >> +               }
> >> +
> >> +               blk_mq_unfreeze_queue_nomemrestore(q);
> >>         }
> >> -       blk_mq_unfreeze_queue_nomemrestore(q);
> >> +
> > 
> > I feel it doesn't become simpler, :-(
> > 
> > However we still can avoid the change in elv_update_nr_hw_queues() by moving
> > freeze/unfree queue to blk_mq_elv_switch_back(), which looks more readable.
> > 
> I think yes that seems reasonable but then we also need to move 
> elevator_change_done() and blk_mq_free_sched_tags() from 
> elv_update_nr_hw_queues() to blk_mq_elv_switch_back(). As you know
> both these functions (elevator_change_done and blk_mq_free_sched_tags)
> have to be called after we unfreeze the queue.

It can be done in easier way:


diff --git a/block/blk-mq.c b/block/blk-mq.c
index b67d6c02eceb..69949929dfbb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4974,11 +4974,15 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
  * Switch back to the elevator type stored in the xarray.
  */
 static void blk_mq_elv_switch_back(struct request_queue *q,
-		struct xarray *elv_tbl, struct xarray *et_tbl)
+		struct xarray *elv_tbl, struct xarray *et_tbl, bool frozen)
 {
 	struct elevator_type *e = xa_load(elv_tbl, q->id);
 	struct elevator_tags *t = xa_load(et_tbl, q->id);
 
+	/* elv_update_nr_hw_queues() expects queue to be frozen */
+	if (!frozen)
+		blk_mq_freeze_queue_nomemsave(q);
+
 	/* The elv_update_nr_hw_queues unfreezes the queue. */
 	elv_update_nr_hw_queues(q, e, t);
 
@@ -5033,6 +5037,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	unsigned int memflags;
 	int i;
 	struct xarray elv_tbl, et_tbl;
+	bool queues_frozen = false;
 
 	lockdep_assert_held(&set->tag_list_lock);
 
@@ -5056,9 +5061,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_sysfs_unregister_hctxs(q);
 	}
 
-	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_freeze_queue_nomemsave(q);
-
 	/*
 	 * Switch IO scheduler to 'none', cleaning up the data associated
 	 * with the previous scheduler. We will switch back once we are done
@@ -5068,6 +5070,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		if (blk_mq_elv_switch_none(q, &elv_tbl))
 			goto switch_back;
 
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_freeze_queue_nomemsave(q);
+	queues_frozen = true;
 	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
 		goto switch_back;
 
@@ -5092,7 +5097,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 switch_back:
 	/* The blk_mq_elv_switch_back unfreezes queue for us. */
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_elv_switch_back(q, &elv_tbl, &et_tbl);
+		blk_mq_elv_switch_back(q, &elv_tbl, &et_tbl, queues_frozen);
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_sysfs_register_hctxs(q);

Thanks,
Ming

