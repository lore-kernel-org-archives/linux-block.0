Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DABE1D7E52
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746019864; cv=none; b=aEIucsJarnCIHbVq+Sum47OcM8CcMn2CNRWth5ewi00WHvqmioAJP5p4pwt8Iub/dccpJ+4iONfhbz8cJROn+X5SZMKrcSwapUYiR/jz/hAN6gwuJc1r3J5LvJpReiZyxFKLgXDpXZ8GNYEUgWO4M4d1kyqdi8gtgvgl185QTng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746019864; c=relaxed/simple;
	bh=EcRdrcybE0B5AJwPW8v/cBJCMIvjaOzyuP+E0sWYXgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wz49AGMF74aOgfjuh98shEpfbswtoY1VSS6kdfuPC9dq/zXo3UYxY+hXbmMZbcTO7hjEwFoOqVFyuxQSM7JePLJgzk4eUlMfWKLY7ygRz0bzfQzzqiAXx/KANv4i2ah65TmLOztexM1f1L+EO8QmJhgQad1jg4D6248Y46Errkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=crzEbeTa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crzEbeTa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746019861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QFkenUwi52cp9lK98AiDt0IdnNS9VmyMd7jBKQtlbNc=;
	b=crzEbeTa7Wf3KtBcrQDcoKGoQ4qOuBDAXLd5nGeBTt6dW3SyK753zZX3s5Oo5Bbs9lxBAf
	2LNO2UHRoIA36XbcKrKXXBa5v+uLs5LRI3E4VFhCYPUcZVf5kJCX5B9SljyNLy5UXUdItZ
	Kn9WQHK50CHInfVjHmn0qc/fLBbxldc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-MMKE11WWPR-BjktGfKjlwA-1; Wed,
 30 Apr 2025 09:30:57 -0400
X-MC-Unique: MMKE11WWPR-BjktGfKjlwA-1
X-Mimecast-MFC-AGG-ID: MMKE11WWPR-BjktGfKjlwA_1746019850
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE4E91955DEA;
	Wed, 30 Apr 2025 13:30:48 +0000 (UTC)
Received: from fedora (unknown [10.72.116.59])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C99F19560A3;
	Wed, 30 Apr 2025 13:30:43 +0000 (UTC)
Date: Wed, 30 Apr 2025 21:30:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 18/24] block: fail to show/store elevator sysfs
 attribute if elevator is dying
Message-ID: <aBIl_-8-JbG7hUJV@fedora>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
 <20250430043529.1950194-19-ming.lei@redhat.com>
 <c4694029-f8c9-46fd-ba2a-b486a48d615b@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4694029-f8c9-46fd-ba2a-b486a48d615b@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Apr 30, 2025 at 08:31:01AM +0200, Hannes Reinecke wrote:
> On 4/30/25 06:35, Ming Lei wrote:
> > Prepare for moving elv_register[unregister]_queue out of elevator_lock
> > & queue freezing, so we may have to call elv_unregister_queue() after
> > elevator ->exit() is called, then there is small window for user to
> > call into ->show()/store(), and user-after-free can be caused.
> > 
> > Fail to show/store elevator sysfs attribute if elevator is dying by
> > adding one new flag of ELEVATOR_FLAG_DYNG, which is protected by
> > elevator ->sysfs_lock.
> > 
> > Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/blk-mq-sched.c |  1 +
> >   block/elevator.c     | 10 ++++++----
> >   block/elevator.h     |  1 +
> >   3 files changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > index 336a15ffecfa..55a0fd105147 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -551,5 +551,6 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
> >   	if (e->type->ops.exit_sched)
> >   		e->type->ops.exit_sched(e);
> >   	blk_mq_sched_tags_teardown(q, flags);
> > +	set_bit(ELEVATOR_FLAG_DYING, &q->elevator->flags);
> >   	q->elevator = NULL;
> >   }
> 
> set_bit() is unordered; don't you need to take ->sysfs_lock here?

Yes.

blk_mq_exit_sched() is called from elevator_exit() with eq->sysfs_lock held.


thanks,
Ming

