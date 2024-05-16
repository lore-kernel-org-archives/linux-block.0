Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F83379DF
	for <linux-block@vger.kernel.org>; Thu, 16 May 2024 00:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715821150; cv=none; b=UE4EY/zSp92Bd3474kW+7H+glO8M+MsXv+K+Swo+rdsXWi9CHiMe4EyPe8zzsqDxhe5P2JjYrDdSus7rwOKtV2MV7/cjieHffbup3DNY4Pn2wDfYsqSDGNW4ENo58GQa3IS5PRRZA3T5AaiS0H71QYRY3zyteMaD/uNVTBrCsks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715821150; c=relaxed/simple;
	bh=GcBuK4Nuc9xXhaVY/kO9c5C2MkhG8X7wNCzHScU8D/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7ehyLhsgOl9yEJrYFhcG1c2nfON0KLzEdJA3ROlmu28PBrktAt7fox2if3U7T1NRjajKni7U781kT//NgMtz8KbfuwfDo7u6g7hKw5/mEGcznga5PnKXvFwt8li1KK37feCS5VILBVmBcay0UgS+oOMHLzxudmSzN4GEzYhvow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=asearSrm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asearSrm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715821147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2w5aOVHEZm4nc0Z+hefQA5lRMP41wDQBdh2mfjnW6Fo=;
	b=asearSrmhgs1KBC6Idp/s3T1bey5p1+zDZW3q4pPx1MMmKssJArb0Sp1utmBXG2e4/pOqZ
	bjNNbdq2AAFMek9B3QMYxeVjMtfcWJfUvrXE1QjpQ1veqb7ZKpoUsatbph2CaUgHAkmi5D
	5s4I88tgoOZAvm9/0/Nil5FKjGPnir4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-a99uRrfZMo-sMhKYsfBApg-1; Wed,
 15 May 2024 20:58:58 -0400
X-MC-Unique: a99uRrfZMo-sMhKYsfBApg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7ABB43803903;
	Thu, 16 May 2024 00:58:58 +0000 (UTC)
Received: from fedora (unknown [10.72.116.49])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 27451105480A;
	Thu, 16 May 2024 00:58:54 +0000 (UTC)
Date: Thu, 16 May 2024 08:58:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, ming.lei@redhat.com
Subject: Re: [PATCH 2/2] blk-cgroup: fix list corruption from reorder of
 WRITE ->lqueued
Message-ID: <ZkVaSg154oU3XltA@fedora>
References: <20240515013157.443672-1-ming.lei@redhat.com>
 <20240515013157.443672-3-ming.lei@redhat.com>
 <2a0cae15-e9d9-4524-a0db-f665b1832db4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a0cae15-e9d9-4524-a0db-f665b1832db4@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Wed, May 15, 2024 at 10:09:30AM -0400, Waiman Long wrote:
> 
> On 5/14/24 21:31, Ming Lei wrote:
> > __blkcg_rstat_flush() can be run anytime, especially when blk_cgroup_bio_start
> > is being executed.
> > 
> > If WRITE of `->lqueued` is re-ordered with READ of 'bisc->lnode.next' in
> > the loop of __blkcg_rstat_flush(), `next_bisc` can be assigned with one
> > stat instance being added in blk_cgroup_bio_start(), then the local
> > list in __blkcg_rstat_flush() could be corrupted.
> > 
> > Fix the issue by adding one barrier.
> > 
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/blk-cgroup.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > 
> > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > index 86752b1652b5..b36ba1d40ba1 100644
> > --- a/block/blk-cgroup.c
> > +++ b/block/blk-cgroup.c
> > @@ -1036,6 +1036,16 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
> >   		struct blkg_iostat cur;
> >   		unsigned int seq;
> > +		/*
> > +		 * Order assignment of `next_bisc` from `bisc->lnode.next` in
> > +		 * llist_for_each_entry_safe and clearing `bisc->lqueued` for
> > +		 * avoiding to assign `next_bisc` with new next pointer added
> > +		 * in blk_cgroup_bio_start() in case of re-ordering.
> > +		 *
> > +		 * The pair barrier is implied in llist_add() in blk_cgroup_bio_start().
> > +		 */
> > +		smp_mb();
> > +
> >   		WRITE_ONCE(bisc->lqueued, false);
> 
> I believe replacing WRITE_ONCE() by smp_store_release() and the READ_ONCE()
> in blk_cgroup_bio_start() by smp_load_acquire() should provide enough
> barrier to prevent unexpected reordering as

Yeah, smp_load_acquire() and smp_store_release() pair works too, but with
one extra cost of smp_mb() around llist_add() which implies barrier
already.

So I prefer to this patch.

> the subsequent
> u64_stats_fetch_begin() will also provide a read barrier for subsequent
> read.

u64_stats_fetch_begin() is nop in case of `BITS_PER_LONG == 64`.


Thanks,
Ming

