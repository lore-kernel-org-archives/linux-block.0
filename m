Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3EA12B93
	for <linux-block@vger.kernel.org>; Mon, 21 Oct 2024 02:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729477247; cv=none; b=g9gw5P9Q9u7s0zy/SLAL6idlLGmZASXv1ajOoFlkIX+tmC2Te0w9zXS7mAXIWNmBMy0IHY6hLcExvabC7jDdI8Dx5DimuBCr/rIAmvqYvT/sB/2kGAbBKuq9o0Nwf5dkeDk5/kaK0KeupHtpvHhae69XiXap2f655YqgBO+mti4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729477247; c=relaxed/simple;
	bh=L/FEO22RGN/cUayHCoTKxyt8Ci/g+0Vw4hw8zF9Y2Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zbp5LOSJnjNIN61si16IevdsUC6ijMBGbqvzgYeK4lG1gndvdAjdlcZhp6L7YqypnLvZW7ObCZFJrRD0xc8Cm+YSbdSt8RO5Y48TrlBKIw74hdy92Ue40ehnZu44jPHdRKYVrnfzHYqv7t02CYSqgDDihZ2NMkZkG33yGvrtoWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AuDgnftG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuDgnftG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729477243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vxun2ashoPYlAj3Xz+znYjaOBHidbmoQI9OEWmAfpk0=;
	b=AuDgnftGVnlxC/4P+dS/0FQ9NG37mks1rZ5KAToc1mvrXHxIBm+6yfQa89TmJnQXKXgQ31
	5iDPuxiWdc8jKEnIcqxMyy/t5b6QYrvMC8CmmnNxLX8j4knsfvhTVpRFjh6pnxPHfBCklx
	ykIS65aHfBMQCT+NfHiahezLAHR5dSQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-e0xh2MKIPiWQjmSqWuSZXA-1; Sun,
 20 Oct 2024 22:20:42 -0400
X-MC-Unique: e0xh2MKIPiWQjmSqWuSZXA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C3211955EAB;
	Mon, 21 Oct 2024 02:20:40 +0000 (UTC)
Received: from fedora (unknown [10.72.116.25])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C34619560A3;
	Mon, 21 Oct 2024 02:20:35 +0000 (UTC)
Date: Mon, 21 Oct 2024 10:20:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, ming.lei@redhat.com
Subject: Re: [PATCH] block: model freeze & enter queue as rwsem for
 supporting lockdep
Message-ID: <ZxW6bl-k692d6H62@fedora>
References: <20241018013542.3013963-1-ming.lei@redhat.com>
 <46493f6f-850e-459e-a4be-116deb5d3ca0@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46493f6f-850e-459e-a4be-116deb5d3ca0@acm.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Oct 18, 2024 at 09:57:12AM -0700, Bart Van Assche wrote:
> 
> On 10/17/24 6:35 PM, Ming Lei wrote:
> > Recently we got several deadlock report[1][2][3] caused by blk_mq_freeze_queue
> > and blk_enter_queue().
> > 
> > Turns out the two are just like one rwsem, so model them as rwsem for
> > supporting lockdep:
> > 
> > 1) model blk_mq_freeze_queue() as down_write_trylock()
> > - it is exclusive lock, so dependency with blk_enter_queue() is covered
> > - it is trylock because blk_mq_freeze_queue() are allowed to run concurrently
> > 
> > 2) model blk_enter_queue() as down_read()
> > - it is shared lock, so concurrent blk_enter_queue() are allowed
> > - it is read lock, so dependency with blk_mq_freeze_queue() is modeled
> > - blk_queue_exit() is often called from other contexts(such as irq), and
> > it can't be annotated as rwsem_release(), so simply do it in
> > blk_enter_queue(), this way still covered cases as many as possible
> > 
> > NVMe is the only subsystem which may call blk_mq_freeze_queue() and
> > blk_mq_unfreeze_queue() from different context, so it is the only
> > exception for the modeling. Add one tagset flag to exclude it from
> > the lockdep support.
> > 
> > With lockdep support, such kind of reports may be reported asap and
> > needn't wait until the real deadlock is triggered.
> > 
> > For example, the following lockdep report can be triggered in the
> > report[3].
> 
> Hi Ming,
> 
> Thank you for having reported this issue and for having proposed a
> patch. I think the following is missing from the patch description:
> (a) An analysis of which code causes the inconsistent nested lock order.
> (b) A discussion of potential alternatives.

I guess you might misunderstand this patch which just enables lockdep for
freezing & entering queue, so that lockdep can be used for running early
verification on patches & kernel.

The basic idea is to model .q_usage_counter as rwsem:

- treat freeze_queue as down_write_trylock()
- treat enter_queue() as down_read()

We needn't to care relation with other locks if the following is true:

- .q_usage_counter can be aligned with lock, and

- the modeling in this patch is correct.

Then lock order can be verified by lockdep.

> 
> It seems unavoidable to me that some code freezes request queue(s)
> before the limits are updated. Additionally, there is code that freezes
> queues first (sd_revalidate_disk()), executes commands and next updates
> limits. Hence the inconsistent order of freezing queues and obtaining
> limits_lock.

This is just one specific issue which can be reported with lockdep
support, but this patch only focus on how to model freeze/enter queue as lock,
so please move discussion on this specific lock issue to another standalone thread.

> 
> The alternative (entirely untested) solution below has the following
> advantages:
> * No additional information has to be provided to lockdep about the
>   locking order.

Can you explain a bit more? I think this patch doesn't provide
`additional` info to lockdep APIs.

> * No new flags are required (SKIP_FREEZE_LOCKDEP).

So far it isn't possible, nvme subsystem freezes queue in one context,
and unfreezes queue from another context, this way has caused many
trouble.

And it needs to refactor nvme error handling code path for removing
SKIP_FREEZE_LOCKDEP, not short-term thing.

> * No exceptions are necessary for blk_queue_exit() nor for the NVMe
>   driver.

I think it isn't basically possible since lock won't be used in this way.
More importantly we have covered many enough cases already by not taking
blk_queue_exit() into account.


Thanks, 
Ming

