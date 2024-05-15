Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A60213FD75
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715781548; cv=none; b=VJFvzKa9xaRWzwAvoMzo6fKFv/BZyXQUMORbbbOPuEcR8dCbHr9g6hVHK9G9wXz02HeVdBBjD/y4Qun/UuvYqltxru0BoIedvqgT7otTWpdiqJf6ZU1O3PQdMdX+C6J9ENX0MlTNH/onlZZoA35Jqg1a+HMpEXI2LeAMHYaKKXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715781548; c=relaxed/simple;
	bh=rXjbn/XmBzZi1VlsBK5szeltygemCnt1pVy5tRNMQlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alySMxik7OcJboqmmPjI6M9+b0HAcSLDSVrztsWAihj9qaAXwOZzHX1tOBqHpBlJRAWbsQ3rJkq3AIhfZXfWTwUGd1yfkxcZ6hayQSJrHvApqgfd/hNL24mw/P/UCfD3fmnyIma3LXn1ewVtLu7o5qNXIooFs4cOGFGHK7iQmzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxPWa0ZA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxPWa0ZA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715781546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hxluf7fXv8K6mMhArnjgUdWKJ31fjvKmbrUFeNJHxZA=;
	b=UxPWa0ZAJ8kTtYWSrke7+NcGpTHhJYTs6qFC0UYFcYHPBUodpI+Bt6wz3wfhyX9j+7AWCO
	x7nsaMQm7KAjVcTp94nVKWNo6EXkO+9yTQdvuFAHErG5155FeCuhtvy83nCpNiT4Z3eDq4
	VvyBkKKUWkg6WhFvuTAGfFuXp9ODpG4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-hTmxgJEMO3COyEcZYpZ0YQ-1; Wed, 15 May 2024 09:59:02 -0400
X-MC-Unique: hTmxgJEMO3COyEcZYpZ0YQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55B21101A551;
	Wed, 15 May 2024 13:59:02 +0000 (UTC)
Received: from [10.22.33.50] (unknown [10.22.33.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1768B103A3AA;
	Wed, 15 May 2024 13:59:01 +0000 (UTC)
Message-ID: <a776ac38-acfa-4c1a-b665-d442f6b481f0@redhat.com>
Date: Wed, 15 May 2024 09:59:01 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] blk-cgroup: fix list corruption from resetting io
 stat
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Jay Shin <jaeshin@redhat.com>
References: <20240515013157.443672-1-ming.lei@redhat.com>
 <20240515013157.443672-2-ming.lei@redhat.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240515013157.443672-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3


On 5/14/24 21:31, Ming Lei wrote:
> Since commit 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()"),
> each iostat instance is added to blkcg percpu list, so blkcg_reset_stats()
> can't reset the stat instance by memset(), otherwise the llist may be
> corrupted.
>
> Fix the issue by only resetting the counter part.
>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Jay Shin <jaeshin@redhat.com>
> Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-cgroup.c | 58 ++++++++++++++++++++++++++++------------------
>   1 file changed, 35 insertions(+), 23 deletions(-)
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 059467086b13..86752b1652b5 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -619,12 +619,45 @@ static void blkg_destroy_all(struct gendisk *disk)
>   	spin_unlock_irq(&q->queue_lock);
>   }
>   
> +static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
> +{
> +	int i;
> +
> +	for (i = 0; i < BLKG_IOSTAT_NR; i++) {
> +		dst->bytes[i] = src->bytes[i];
> +		dst->ios[i] = src->ios[i];
> +	}
> +}
> +
> +static void __blkg_clear_stat(struct blkg_iostat_set *bis)
> +{
> +	struct blkg_iostat cur = {0};
> +	unsigned long flags;
> +
> +	flags = u64_stats_update_begin_irqsave(&bis->sync);
> +	blkg_iostat_set(&bis->cur, &cur);
> +	blkg_iostat_set(&bis->last, &cur);
> +	u64_stats_update_end_irqrestore(&bis->sync, flags);
> +}
> +
> +static void blkg_clear_stat(struct blkcg_gq *blkg)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct blkg_iostat_set *s = per_cpu_ptr(blkg->iostat_cpu, cpu);
> +
> +		__blkg_clear_stat(s);
> +	}
> +	__blkg_clear_stat(&blkg->iostat);
> +}
> +
>   static int blkcg_reset_stats(struct cgroup_subsys_state *css,
>   			     struct cftype *cftype, u64 val)
>   {
>   	struct blkcg *blkcg = css_to_blkcg(css);
>   	struct blkcg_gq *blkg;
> -	int i, cpu;
> +	int i;
>   
>   	mutex_lock(&blkcg_pol_mutex);
>   	spin_lock_irq(&blkcg->lock);
> @@ -635,18 +668,7 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
>   	 * anyway.  If you get hit by a race, retry.
>   	 */
>   	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
> -		for_each_possible_cpu(cpu) {
> -			struct blkg_iostat_set *bis =
> -				per_cpu_ptr(blkg->iostat_cpu, cpu);
> -			memset(bis, 0, sizeof(*bis));
> -
> -			/* Re-initialize the cleared blkg_iostat_set */
> -			u64_stats_init(&bis->sync);
> -			bis->blkg = blkg;
> -		}
> -		memset(&blkg->iostat, 0, sizeof(blkg->iostat));
> -		u64_stats_init(&blkg->iostat.sync);
> -
> +		blkg_clear_stat(blkg);
>   		for (i = 0; i < BLKCG_MAX_POLS; i++) {
>   			struct blkcg_policy *pol = blkcg_policy[i];
>   
> @@ -949,16 +971,6 @@ void blkg_conf_exit(struct blkg_conf_ctx *ctx)
>   }
>   EXPORT_SYMBOL_GPL(blkg_conf_exit);
>   
> -static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
> -{
> -	int i;
> -
> -	for (i = 0; i < BLKG_IOSTAT_NR; i++) {
> -		dst->bytes[i] = src->bytes[i];
> -		dst->ios[i] = src->ios[i];
> -	}
> -}
> -
>   static void blkg_iostat_add(struct blkg_iostat *dst, struct blkg_iostat *src)
>   {
>   	int i;
Reviewed-by: Waiman Long <longman@redhat.com>

