Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B013F014
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715782204; cv=none; b=pRTeOfS4YPsfEJOBvSpzSHCRP/NGWHB4P9BqQsdp1Xb4H9KHzezi6cK00LzIjalmhYab1IrXt9ZjW515g8o6BSVKQQ5VayuCtjkr2lWhskohPzeoRvlp+4cRZs9WCbnt09Hs4Gn78FXFMwKQJV0mgSTxut9qUuNcqEopquwTWug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715782204; c=relaxed/simple;
	bh=g+QDyuxjxsgsGBExXNWRBten7kh7CdBTtkSJSJTMCNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pqyz62TwkxomUeCJAS54E/yDE1+Vjy98aPfcY2f1qV4kpJRr8wZAWvzcYt+64b8b5+6/1wmbHZKEN+k8+nwWY47aR0ohRBkB37aCL6yElHSZM8XuoYPmcWgo4tkz9hFqvnusRt9dhZxA9Cgp/FuJDUEDoh4HT+lqecr1Psogg4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBEhIC0T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBEhIC0T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715782201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbKrEJDPIarPYT2n7QzP/jw4rJC+im3pv89O3mBnMk4=;
	b=jBEhIC0TpjINCdwm4C9Pw/rz+LToaNFXYdqU7WCyNypXFJDt3Q2cK37BVuFnmwwjLIwDMp
	vJsk+ax1jAkToz6Xa9+mN92BQhEJQUbOfWdthd35Tc77RVUIg+8EuHAWUAN9uhQ7sHdADA
	FkEcPfc4eLMvdY3emVTWJdkEo9qNQ6Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-jRr42Nc4PNyTDEyy2vuLEA-1; Wed, 15 May 2024 10:09:31 -0400
X-MC-Unique: jRr42Nc4PNyTDEyy2vuLEA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2C628016FA;
	Wed, 15 May 2024 14:09:30 +0000 (UTC)
Received: from [10.22.33.50] (unknown [10.22.33.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BB0EA1006B42;
	Wed, 15 May 2024 14:09:30 +0000 (UTC)
Message-ID: <2a0cae15-e9d9-4524-a0db-f665b1832db4@redhat.com>
Date: Wed, 15 May 2024 10:09:30 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] blk-cgroup: fix list corruption from reorder of WRITE
 ->lqueued
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>
References: <20240515013157.443672-1-ming.lei@redhat.com>
 <20240515013157.443672-3-ming.lei@redhat.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240515013157.443672-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3


On 5/14/24 21:31, Ming Lei wrote:
> __blkcg_rstat_flush() can be run anytime, especially when blk_cgroup_bio_start
> is being executed.
>
> If WRITE of `->lqueued` is re-ordered with READ of 'bisc->lnode.next' in
> the loop of __blkcg_rstat_flush(), `next_bisc` can be assigned with one
> stat instance being added in blk_cgroup_bio_start(), then the local
> list in __blkcg_rstat_flush() could be corrupted.
>
> Fix the issue by adding one barrier.
>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-cgroup.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 86752b1652b5..b36ba1d40ba1 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1036,6 +1036,16 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
>   		struct blkg_iostat cur;
>   		unsigned int seq;
>   
> +		/*
> +		 * Order assignment of `next_bisc` from `bisc->lnode.next` in
> +		 * llist_for_each_entry_safe and clearing `bisc->lqueued` for
> +		 * avoiding to assign `next_bisc` with new next pointer added
> +		 * in blk_cgroup_bio_start() in case of re-ordering.
> +		 *
> +		 * The pair barrier is implied in llist_add() in blk_cgroup_bio_start().
> +		 */
> +		smp_mb();
> +
>   		WRITE_ONCE(bisc->lqueued, false);

I believe replacing WRITE_ONCE() by smp_store_release() and the 
READ_ONCE() in blk_cgroup_bio_start() by smp_load_acquire() should 
provide enough barrier to prevent unexpected reordering as the 
subsequent u64_stats_fetch_begin() will also provide a read barrier for 
subsequent read.

Cheers,
Longman

>   
>   		/* fetch the current per-cpu values */

