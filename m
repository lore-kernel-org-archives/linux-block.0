Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9573F278E41
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320467; cv=none; b=QELcaFllPNeV8D22Jy8aduDNTqdO8aWdK2uc9sSCycE1cT2Q1YuMRA1m13KDI+HkJbWhdv2yboJqisshKDNTJ9r7QWxA2oHM4KaZmZz5NHSDevPYEb1qu21C+3h+OA3s1/rcfL6qMmYYQiZZLmzQcgewboJS+E6S1Qxot7nFNt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320467; c=relaxed/simple;
	bh=5nnFc23hduQwBC2JZdMWEbukQVwE6JYujwuU1PVAwus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhblYIInuw9zbhm9agTa5z7mRpdbjNhf/1INNAmLX4AdihxKbfaXtVkBSHx8b/xDfIoLBz05x1XOrMgvPGWmj2qNwNaxrNw0qmdXLiUPx1hAK2AFoRWAT9j5/rh9bP+m7D6ghHzUCyLECgOG31BcZpvNtQMVXMyBWPyX6ESa+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKz5nrTC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKz5nrTC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745320464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sq6hMOJaALpYEeIO2929LsL8SiWQ/T1xcfC1/bYrHWo=;
	b=aKz5nrTCKDhCwM31az0GW83gFh9pAghFxuRhewBQdfDhg3JVKBdq0I04iLw2Ebv6eNWQNe
	W1rE6ejQxWG1MzvT3LB3kJZSwLllzBGxZyJQzl22BVgOFG+E5ORhNAYInOwEPyn1pO4VGR
	4702jDmcGKdxLYHV8BU1uj8hca76Vl4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-XBEIfscFNgmS-djXpOrAdA-1; Tue,
 22 Apr 2025 07:14:21 -0400
X-MC-Unique: XBEIfscFNgmS-djXpOrAdA-1
X-Mimecast-MFC-AGG-ID: XBEIfscFNgmS-djXpOrAdA_1745320460
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D43581956094;
	Tue, 22 Apr 2025 11:14:19 +0000 (UTC)
Received: from fedora (unknown [10.72.116.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F28530001A2;
	Tue, 22 Apr 2025 11:14:14 +0000 (UTC)
Date: Tue, 22 Apr 2025 19:14:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 16/20] block: move elv_register[unregister]_queue out
 of elevator_lock
Message-ID: <aAd6AqtkVOE1l4ZG@fedora>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-17-ming.lei@redhat.com>
 <9d15a519-c0bb-492f-9602-f3840b85dbe1@linux.ibm.com>
 <aAd1PnHtnT6jTZFE@fedora>
 <9455fce4-3296-449b-a828-2696e2e17b16@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9455fce4-3296-449b-a828-2696e2e17b16@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Apr 22, 2025 at 04:36:37PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/22/25 4:23 PM, Ming Lei wrote:
> > On Sat, Apr 19, 2025 at 07:25:31PM +0530, Nilay Shroff wrote:
> >>
> >>
> >> On 4/18/25 10:06 PM, Ming Lei wrote:
> >>> Move elv_register[unregister]_queue out of ->elevator_lock & queue freezing,
> >>> so we can kill many lockdep warnings.
> >>>
> >>> elv_register[unregister]_queue() is serialized, and just dealing with sysfs/
> >>> debugfs things, no need to be done with queue frozen.
> >>>
> >>> With this change, elevator's ->exit() is called before calling
> >>> elv_unregister_queue, then user may call into ->show()/store() of elevator's
> >>> sysfs attributes, and we have covered this issue by adding `ELEVATOR_FLAG_DYNG`.
> >>>
> >>> For blk-mq debugfs, hctx->sched_tags is always checked with ->elevator_lock by
> >>> debugfs code, meantime hctx->sched_tags is updated with ->elevator_lock, so
> >>> there isn't such issue.
> >>>
> >>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>> ---
> >>>  block/blk-mq.c   |  9 ++++----
> >>>  block/blk.h      |  1 +
> >>>  block/elevator.c | 58 ++++++++++++++++++++++++++++++++++--------------
> >>>  block/elevator.h |  5 +++++
> >>>  4 files changed, 52 insertions(+), 21 deletions(-)
> >>>
> >>
> >> [...]
> >>
> >>> +static void elevator_exit(struct request_queue *q)
> >>> +{
> >>> +	__elevator_exit(q);
> >>> +	kobject_put(&q->elevator->kobj);
> >>>  }
> >>
> >> [...]  
> >>> +int elevator_change_done(struct request_queue *q, struct elv_change_ctx *ctx)
> >>> +{
> >>> +	int ret = 0;
> >>> +
> >>> +	if (ctx->old) {
> >>> +		elv_unregister_queue(q, ctx->old);
> >>> +		kobject_put(&ctx->old->kobj);
> >>> +	}
> >>> +	if (ctx->new) {
> >>> +		ret = elv_register_queue(q, ctx->new, ctx->uevent);
> >>> +		if (ret) {
> >>> +			unsigned memflags = blk_mq_freeze_queue(q);
> >>> +
> >>> +			mutex_lock(&q->elevator_lock);
> >>> +			elevator_exit(q);
> >>> +			mutex_unlock(&q->elevator_lock);
> >>> +			blk_mq_unfreeze_queue(q, memflags);
> >>> +		}
> >>> +	}
> >>> +	return 0;
> >>> +}
> >>> +
> >> It seems that we're still leaking ->elevator_lock in sysfs/kernfs with
> >> the above elevator_exit call. I think we probably want to move out 
> >> kobject_put(&q->elevator->kobj) from elevator_exit and invoke it 
> >> after we release ->elevator_lock in elevator_change_done.
> > 
> > q->elevator_lock is owned by request queue instead of elevator queue, so it
> > shouldn't be one issue, or can you explain in details?
> > 
> I meant that one of the objective of this patchset is to ensure that
> we don't grab any block/queue lock and enter the kernefs/sysfs/debugfs 
> code. However here in elevator_change_done() we invoke elevator_exit()
> after grabbing q->elevator_lock. Now if we look at the definition of
> elevator_exit() then it appears that we invoke kobject_put(&ctx->old->kobj)
> from it. So that means that while holding q->elevator_lock we enter in 
> kernfs/sysfs code.
> 
> So my point was to move kobject_put() out of the elevator_exit() and 
> call it after we release q->elevator_lock, maybe something like shown
> below:
> 
> elevator_change_done()
> {
>         ...
>         ...
> 	if (ctx->new) {
> 		ret = elv_register_queue(q, ctx->new, ctx->uevent);
> 		if (ret) {
> 			unsigned memflags = blk_mq_freeze_queue(q);
> 
> 			mutex_lock(&q->elevator_lock);
> 			__elevator_exit(q);
> 			mutex_unlock(&q->elevator_lock);
> 
> 			kobject_put(&q->elevator->kobj);

This way is correct, but not necessary because elevator_release()
contributes nothing to the current lock problem.

However, this way aligns with normal code path wrt. elevator_lock &
freezing queue, and can save elevator_exit(), and will take it in V3.

Thanks,
Ming

