Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3325B19E7F7
	for <linux-block@vger.kernel.org>; Mon, 30 Dec 2024 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549375; cv=none; b=BiBtIa9n9AVcAQ07ACLb8J1eqoBd2O0+yqmOI+/xFXjpexKh7knRIVxKxf2eLv6u/4OoQ8vfRpT37a41UL1GV+uR6bVYn3No2hiTRWtkgW7iParO38I5Hw7DP8EpiHO3hRHDx3gtEZTK+ThgtHnpzgIHiORLtkyBr8+Qoh3K6CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549375; c=relaxed/simple;
	bh=1GiCINEX2dbQLDr0vdOqgC6hmrHqMgfm+CjUqJHO9pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAh5wfsgSup+sss9pNAjiO6G9Mj7CI7r3xG/kt0ytU3KckcAlmnQUDIHoBQPH8G143WNRJ4gxb5EUnN7wEXwF1NTvdbzjMIaVGI6JAyJoeMkS8LWdIfc0jdDxhltHywWwEbFz1fe64IYYflF03V1ekq5JmAVqcdkgOtDXxY1Miw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3ZmCLe0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3ZmCLe0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735549372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PsWPl2bqWAQVZDErYQgj5ZRZio+yiu1zAU/LbBNMaCU=;
	b=V3ZmCLe0LRKQNfqPszEu3rurZeEsNV7yDtzabtvgBSMN3EBp40cB339nFfv/I+SChNXrZI
	z02LLmgj5piYMTCXY9mptOcolU5Og0iDSyY5NkDpjuquEeEiLKJpyQDOKnmDlGuDYhWua0
	I4oT7NX39WNRuEKG8QBg0xl/eSa4Jp4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-Apbu_R1IMxi-bOR1f14plg-1; Mon,
 30 Dec 2024 04:02:46 -0500
X-MC-Unique: Apbu_R1IMxi-bOR1f14plg-1
X-Mimecast-MFC-AGG-ID: Apbu_R1IMxi-bOR1f14plg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50D28195609F;
	Mon, 30 Dec 2024 09:02:45 +0000 (UTC)
Received: from fedora (unknown [10.72.116.32])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C3BD19560AA;
	Mon, 30 Dec 2024 09:02:40 +0000 (UTC)
Date: Mon, 30 Dec 2024 17:02:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: avoid to hold q->limits_lock across APIs for
 atomic update queue limits
Message-ID: <Z3Jhq5Z4gLupIrYm@fedora>
References: <20241217071928.GA19884@lst.de>
 <Z2Eog2mRqhDKjyC6@fedora>
 <a032a3a0-0784-4260-92fd-90feffe1fe20@kernel.org>
 <Z2Iu1CAAC-nE-5Av@fedora>
 <f34f179a-4eaf-4f73-93ff-efb1ff9fe482@linux.ibm.com>
 <Z2LQ0PYmt3DYBCi0@fedora>
 <0fdf7af6-9401-4853-8536-4295a614e6d2@linux.ibm.com>
 <9e2ad956-4d20-456f-9676-8ea88dfd116e@kernel.org>
 <20241219062026.GC19575@lst.de>
 <cf1e007b-dcb5-43cd-84e2-fd72d8836fb8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf1e007b-dcb5-43cd-84e2-fd72d8836fb8@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Sat, Dec 21, 2024 at 06:33:13PM +0530, Nilay Shroff wrote:
> 
> 
> On 12/19/24 11:50, Christoph Hellwig wrote:
> > On Wed, Dec 18, 2024 at 06:57:45AM -0800, Damien Le Moal wrote:
> >>> Yeah agreed but I see sd_revalidate_disk() is probably the only exception 
> >>> which allocates the blk-mq request. Can't we fix it? 
> >>
> >> If we change where limits_lock is taken now, we will again introduce races
> >> between user config and discovery/revalidation, which is what
> >> queue_limits_start_update() and queue_limits_commit_update() intended to fix in
> >> the first place.
> >>
> >> So changing sd_revalidate_disk() is not the right approach.
> > 
> > Well, sd_revalidate_disk is a bit special in that it needs a command
> > on the same queue to query the information.  So it needs to be able
> > to issue commands without the queue frozen.  Freezing the queue inside
> > the limits lock support that, sd just can't use the convenience helpers
> > that lock and freeze.
> > 
> >> This is overly complicated ... As I suggested, I think that a simpler approach
> >> is to call blk_mq_freeze_queue() and blk_mq_unfreeze_queue() inside
> >> queue_limits_commit_update(). Doing so, no driver should need to directly call
> >> freeze/unfreeze. But that would be a cleanup. Let's first fix the few instances
> >> that have the update/freeze order wrong. As mentioned, the pattern simply needs
> > 
> > Yes, the queue only needs to be frozen for the actual update,
> > which would remove the need for the locking.  The big question for both
> > variants is if we can get rid of all the callers that have the queue
> > already frozen and then start an update.
> > 
> After thinking for a while I found that broadly we've four categories of users
> which need this pattern of limits-lock and/or queue-freeze:
> 
> 1. Callers which need acquiring limits-lock while starting the update; and freezing 
>    queue only when committing the update:
>    - sd_revalidate_disk

sd_revalidate_disk() should be the most strange one, in which
passthrough io command is required, so dependency on queue freeze lock
can't be added, such as, q->limits_lock

Actually the current queue limits structure aren't well-organized, otherwise
limit lock isn't needed for reading queue limits from hardware, since
sd_revalidate_disk() just overwrites partial limits. Or it can be
done by refactoring sd_revalidate_disk(). However, the change might
be a little big, and I guess that is the reason why Damien don't like
it.

>    - nvme_init_identify
>    - loop_clear_limits
>    - few more...
> 
> 2. Callers which need both freezing the queue and acquiring limits-lock while starting
>    the update:
>    - nvme_update_ns_info_block
>    - nvme_update_ns_info_generic
>    - few more... 
> 
> 3. Callers which neither need acquiring limits-lock nor require freezing queue as for 
>    these set of callers in the call stack limits-lock is already acquired and queue is 
>    already frozen:
>    - __blk_mq_update_nr_hw_queues
>    - queue_xxx_store and helpers

I think it isn't correct.

The queue limits are applied on fast IO path, in theory anywhere
updating q->limits need to drain IOs in submission path at least
after gendisk is added.

Also Christoph adds limits-lock for avoiding to lose other concurrent
update, which makes the problem more hard to solve.



Thanks, 
Ming

