Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F9A18A6AB
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 02:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749435254; cv=none; b=s8BZJwua3BIbBvNx+Wn6BymgxJ8YVcL5xSvY2qCjS+Q9bpRDzfdSutz/dclTNJIcGlM41sunQY2IjIiJohtWG57+aBiND3ZbHW3wEbHsc3CEiGcSIfOdxaQH+lRneLTzYJmuzMS7Lx6O9nDhEdbzDwBEVRNGzmdVAp90gDlo5qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749435254; c=relaxed/simple;
	bh=X6pHW4rA+v0dZiXYc26DOCdwlAXcUG3rlrAwZnkrNj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3YPm+//aXhQ2n/fiL+VHqcQuxjatEN8cdeorRnbQHC11ITkxe0etmvTf3UIhLOvCFxeGps1RkphVnPa40l/xrHRLUW9mllGReufFjaW0kBScTrSZmEpEBEE23EGsqsMftmC35xQD6DEUm2fUIwjIdV1YPaGx59rlree7eR5X0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aRCWhAhZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRCWhAhZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749435250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2HcwFaH830Zah676918JZz4Nr3fHIwcb4N3zd+JXnrI=;
	b=aRCWhAhZl+e/f1dsOHBEQ+lyryx+SoUcl3OsieMwzeRRoOiD1HpH54m28gCJplgg+bFCtq
	1c5XekGLf3Q860b43Po1vGYlGJc+I5AcbYdhOSYeVofRZXjjnxCXbrDW7wsJcYHdkoaT3x
	FGJ+BBijph0hMYEoEizexfvbDgQwUg0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-VBV6CgAqNUScjcNLU422bQ-1; Sun,
 08 Jun 2025 22:14:07 -0400
X-MC-Unique: VBV6CgAqNUScjcNLU422bQ-1
X-Mimecast-MFC-AGG-ID: VBV6CgAqNUScjcNLU422bQ_1749435246
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C706F1800BF3;
	Mon,  9 Jun 2025 02:14:05 +0000 (UTC)
Received: from fedora (unknown [10.72.116.120])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54A7A19560AB;
	Mon,  9 Jun 2025 02:14:00 +0000 (UTC)
Date: Mon, 9 Jun 2025 10:13:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	sth@linux.ibm.com, gjoyce@ibm.com
Subject: Re: [PATCHv2] block: fix lock dependency between percpu alloc lock
 and elevator lock
Message-ID: <aEZDZJUVnYNPc9Sa@fedora>
References: <20250528123638.1029700-1-nilay@linux.ibm.com>
 <aD60SF6QGMSPykq-@fedora>
 <9f5b0cbb-10cb-44a7-9565-28673bcbdf84@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f5b0cbb-10cb-44a7-9565-28673bcbdf84@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Jun 05, 2025 at 11:22:17AM +0530, Nilay Shroff wrote:
> 
> 
> On 6/3/25 2:07 PM, Ming Lei wrote:
> > On Wed, May 28, 2025 at 06:03:58PM +0530, Nilay Shroff wrote:
> 
> >> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> >> index 0cb1e9873aab..51d406da4abf 100644
> >> --- a/block/bfq-iosched.c
> >> +++ b/block/bfq-iosched.c
> >> @@ -7232,17 +7232,12 @@ static void bfq_init_root_group(struct bfq_group *root_group,
> >>  	root_group->sched_data.bfq_class_idle_last_service = jiffies;
> >>  }
> >>  
> >> -static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
> >> +static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
> >>  {
> >>  	struct bfq_data *bfqd;
> >> -	struct elevator_queue *eq;
> >>  	unsigned int i;
> >>  	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
> >>  
> >> -	eq = elevator_alloc(q, e);
> >> -	if (!eq)
> >> -		return -ENOMEM;
> >> -
> > 
> > Please make the above elevator interface change be one standalone patch if possible,
> > which may help review much.
> 
> Yeah you're right, in fact I considered to make elevator interface changes into 
> a separate patch however the changes are so much tightly coupled with block layer
> change that I couldn't make it independent. As you may see here I replaced second
> argument of ->init_sched from "struct elevator_type *" to "struct elevator_queue *".
> And as you might have noticed we allocate the "struct elevator_queue *" very early
> while switching the elevator and that's passed down to this ->init_sched function
> through elv_change_ctx. So making elevator interface change a standalone patch 
> is not possible.

You can make a patch to move elevator_queue allocation into
blk_mq_init_sched() first, then pass it to all ->init_sched()
implementation first. And you can avoid to pass 'elevator_queue *'
from 'struct elv_change_ctx'.

> 
> >>  
> >> +int blk_mq_alloc_elevator_and_sched_tags(struct request_queue *q,
> >> +		struct elv_change_ctx *ctx)
> >> +{
> >> +	unsigned long i;
> >> +	struct elevator_queue *elevator;
> >> +	struct elevator_type *e;
> >> +	struct blk_mq_tag_set *set = q->tag_set;
> >> +	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
> >> +
> >> +	if (strncmp(ctx->new.name, "none", 4)) {
> > 
> > You can return early if new name is "none", then all indent in the code
> > block can be avoided.
> Yeah agreed, will do it in the next patch.
> 
> > 
> >> +
> >> +		e = elevator_find_get(ctx->new.name);
> >> +		if (!e)
> >> +			return -EINVAL;
> >> +
> >> +		elevator = ctx->new.elevator = elevator_alloc(q, e);
> > 
> > You needn't to allocate elevator queue here, then the big elv_change_ctx change
> > may be avoided by passing sched tags directly.
> 
> Hmm, okay so you recommend keeping allocation of elevator queue in ->init_sched
> method as it's today?

I meant you can move elevator queue allocation into blk_mq_init_sched(), then
you just need to pass allocated sched tag via `elv_change_ctx` or function
parameter.

> If so then yes it could be done but then as I see the elvator 
> queue is being freed in elevator_change_done() after we release ->elevator_lock
> So I thought it's also quite possible in theory to allocate elevator queue outside
> of ->elevator_lock. Moreover, we shall not require holding ->elevator_lock or 
> ->freeze_lock while allocating elevator queue, and thus probably avoid holding
> block layer locks while perfroming dynamic allocation, isn't it?
> 
> > 
> > Also it may be fragile to allocate elevator queue here without holding elevator
> > lock. You may have to document this way is safe by allocating elevator
> > queue with specified elevator type lockless.
> > 
> Yes I'd document it. And looking through this code path it appears safe because
> we first get reference to the elevator type before assiging elevator type to
> the elevator queue in elevator_alloc(). Do you see any potential issue with 
> this, if we were to allocate elevator queue lockless here?

The correctness depends that our current implementation disables 
updating nr_hw_queues by holding set->update_nr_hwq_lock, otherwise you
have to double check nr_hw_queues after grabbing elevator_lock, so this
point might need to document.

> 
> >> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> >> index 1326526bb733..6c0f1936b81c 100644
> >> --- a/block/blk-mq-sched.h
> >> +++ b/block/blk-mq-sched.h
> >> @@ -7,6 +7,26 @@
> >>  
> >>  #define MAX_SCHED_RQ (16 * BLKDEV_DEFAULT_RQ)
> >>  
> >> +/* Holding context data for changing elevator */
> >> +struct elv_change_ctx {
> >> +	/* for unregistering/freeing old elevator */
> >> +	struct {
> >> +		struct elevator_queue *elevator;
> >> +	} old;
> >> +
> >> +	/* for registering/allocating new elevator */
> >> +	struct {
> >> +		const char *name;
> >> +		bool no_uevent;
> >> +		unsigned long nr_requests;
> >> +		struct elevator_queue *elevator;
> >> +		int inited;
> >> +	} new;
> >> +
> >> +	/* elevator switch status */
> >> +	int status;
> >> +};
> >> +
> > 
> > As I mentioned, 'elv_change_ctx' becomes more complicated, which may be
> > avoided.
> Yes I agreed, however as I mentioned above if we choose to allocate 
> elevator queue before we acquire ->elevator_lock or ->freeze_lock

Allocating elevator queue is just plain kmalloc(), which can be done
under ->elevator_lock or ->freeze_lock, since we have called
memalloc_noio_save().

> then we may need to keep this updated elv_change_ctx. So it depends
> on whether we choose to allocate elevator queue befor acquiring locks or
> keeping allocation under ->init_sched.
> 
> > Queue is still frozen, so the dependency between freeze lock and
> > the global percpu allocation lock isn't cut completely.
> > 
> Yes correct and so in the commit message I mentioned that this depedency is
> currenlty cut only while calling elevator switch from elv_iosched_store context
> through sysfs. We do need to still cut it in the conetxt of elevator switch 
> being called from blk_mq_update_nr_hw_queues context or called while unregistering 
> queue from del_gendisk. And this I thought should be handled in a seperate patch.
> Anyways, I would explicitly call this out in the commit message.

OK, looks fine, I'd suggest to address them all in single patchset, because
it is same problem, and helps us to review with single context.


Thanks,
Ming

