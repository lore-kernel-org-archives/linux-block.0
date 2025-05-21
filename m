Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCBC33993
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 04:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747800501; cv=none; b=IrEzhrBc60e7OwD9bHPP+YeadEi+8mOJI2nVXXqsLOj2YOHlMav3hnY3NHJsPGIEJiiaPjzG/qKQUTRofElBwcGuRI34aCWv3IJE4jw3H7qXiCLbWW5de23miZkOr6xJ+osolRJ/DCWfypT8+PtdqyiQUZQiUBQeIhqup2YwIvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747800501; c=relaxed/simple;
	bh=071SgkPhXIyEilkC2hbcaj7pVuc2DRq8/6uaJPKvyug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QobAjDfLZQSydxvinSR0MAZ9QktyNcQV+lGNCfEx+XQv9hktnucKLzIjutNnnea2F8ugjj5YwxJw6clI2Ow8u4+d5TXrISDBhQwSB3onwYE8k6P9Le8JJg9jMlMuwOUV2r1zGNPTA/luQBOQQPKEuAJJxhtmeYLgnxyOK+2mej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dg5so6ah; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dg5so6ah"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747800498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cCCL0VNje351ehzeswpr30paLw7wHA/xhyXG+xds0l0=;
	b=dg5so6ahMrw1Eaz2+vhtTOBu7kHKzSh71kMUGJwuoqouJMiIohgwQK4DM8FbGo3uYSF0l6
	bxtzkI1R+M6qZywrmIQkEh12OPzZUwoS0CHGRrrNyZeKaDIS8LZMDPbLbTRqzIu/8wHqR4
	sDqTu8v+ATFGrW+BPx14Q/BKXmLTsZ0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-FX3hDTnYNeGu1rC6HT_oeA-1; Wed,
 21 May 2025 00:08:13 -0400
X-MC-Unique: FX3hDTnYNeGu1rC6HT_oeA-1
X-Mimecast-MFC-AGG-ID: FX3hDTnYNeGu1rC6HT_oeA_1747800492
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFB9B1800879;
	Wed, 21 May 2025 04:08:11 +0000 (UTC)
Received: from fedora (unknown [10.72.116.109])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9218C30001AA;
	Wed, 21 May 2025 04:08:07 +0000 (UTC)
Date: Wed, 21 May 2025 12:08:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	sth@linux.ibm.com, gjoyce@ibm.com
Subject: Re: [PATCH] block: fix lock dependency between percpu alloc lock and
 elevator lock
Message-ID: <aC1Ropdb5x05WCIc@fedora>
References: <20250520103425.1259712-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520103425.1259712-1-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Nilay,

On Tue, May 20, 2025 at 04:03:49PM +0530, Nilay Shroff wrote:
> Recent lockdep reports [1] have indicated a potential deadlock arising
> from the dependency between the percpu allocator lock and the elevaor
> lock. This issue can be mitigated by ensuring that elevator/sched tags
> allocation and release occur outside the eleavtor lock. Moreover, we also
> don't require queue remains frozen while we allocate/release sched tags.
> So this patch addresses this problem by moving the allocation and de-
> allocation of elevator sched tags outside the elevator switch path that
> is protected by the ->freeze_lock and ->elevator_lock. Specifically, new
> elevator sched tags are now allocated before switching the elevator and
> outside the freeze section and elevator lock section. The old elevator's
> sched tags are then freed after the elevator lock is released and queue
> is unfrozen.
> 
> To support this, the elv_change_ctx structure is extended to hold relevant
> data needed for allocation and deferred release of sched tags during
> elevator switching. With these changes, all sched tag allocations and
> releases are performed outside both ->freeze_lock and ->elevator_lock,
> preventing the lock ordering issue when elv_iosched_store is triggered
> via sysfs.

Not dig into this implementation, will look into later.

I guess it should work by extending elv_change_ctx.

However we have other elevator_queue lifetime issue, that is why
->elevator_lock is used almost everywhere.

Another solution is to move all `sched_data` into 'struct elevator_queue':

I feel it may be simpler in concept:

- sched data and elevator queue share same lifetime

- kobject_put(&eq->kobj) is already called without holding ->elevator_lock &
  queue isn't freezed

- replace unnecessary ->elevator_lock by blk_get_elevator()/blk_put_elevator()

But it needs some cleanup/refactor on scheduler interface.

What do you think about the above way?

Thanks,
Ming

