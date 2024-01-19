Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF8779C5
	for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 02:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705632058; cv=none; b=bPzO0ZvkSkC/da5Oxe0EwvUpb2l/WmKKMkXzwRQJ5vMFCbGJ4BXYlyUpb8Cp9X3dVwS6y3rvSM5bg3wftljPqPBave85XN8rONbl3Is45jVzfFwNcSWlSo7IkqcBgkqbnLr/gTNcoxBQmmQjhiiFjexn4PcCSg4DGPtyZKvLZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705632058; c=relaxed/simple;
	bh=mqu/oYgc39NCtbNEfd31+1L6bRinx684vh926/4r8XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbUfbPN09aKQ+sHjU2o1T//4VDYmF5o843E7HOW80VkI2j8s3ARTEyqHPg/UF422ptC93JGbxcbt+XlJZXyxfAa59Z6CRdADWpghcDDYnfzAJ1AE/EVCIcw/ZLwm3VVZihFk8uXMX4bmprJMjC9qtCjLNR6Nke7+4ZOozz/IEgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXY0bZrL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXY0bZrL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705632055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=48NL6D0TFLHayEtkNm5LqOA8XMHwzOhk5xf3Nd7hWxc=;
	b=VXY0bZrLmx4yg7PEsKxZo4+yEWn7SeRrq2P5/FJvRUcPofYnuHQYm2K0hTWbbjE2wDBRbo
	Hyn7CiENPn+ayXkMZjE0VH6/W28QDghhvalBlcsVjdYS7OuAWwWhd0YoTGsN0NNT/fVhh2
	8F7mxlucqprOZiPhgtxasvWMq23+940=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-wORpOeeiN22G7LQw97jVbw-1; Thu, 18 Jan 2024 21:40:54 -0500
X-MC-Unique: wORpOeeiN22G7LQw97jVbw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E046685A588;
	Fri, 19 Jan 2024 02:40:53 +0000 (UTC)
Received: from fedora (unknown [10.72.116.48])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BD76494;
	Fri, 19 Jan 2024 02:40:51 +0000 (UTC)
Date: Fri, 19 Jan 2024 10:40:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, bvanassche@acm.org, ming.lei@redhat.com
Subject: Re: [PATCH 1/2] block/mq-deadline: serialize request dispatching
Message-ID: <ZanhL+fOWNSz2zJf@fedora>
References: <20240118180541.930783-1-axboe@kernel.dk>
 <20240118180541.930783-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118180541.930783-2-axboe@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Thu, Jan 18, 2024 at 11:04:56AM -0700, Jens Axboe wrote:
> If we're entering request dispatch but someone else is already
> dispatching, then just skip this dispatch. We know IO is inflight and
> this will trigger another dispatch event for any completion. This will
> potentially cause slightly lower queue depth for contended cases, but
> those are slowed down anyway and this should not cause an issue.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/mq-deadline.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index f958e79277b8..9e0ab3ea728a 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -79,10 +79,20 @@ struct dd_per_prio {
>  	struct io_stats_per_prio stats;
>  };
>  
> +enum {
> +	DD_DISPATCHING	= 0,
> +};
> +
>  struct deadline_data {
>  	/*
>  	 * run time data
>  	 */
> +	struct {
> +		spinlock_t lock;
> +		spinlock_t zone_lock;
> +	} ____cacheline_aligned_in_smp;
> +
> +	unsigned long run_state;
>  
>  	struct dd_per_prio per_prio[DD_PRIO_COUNT];
>  
> @@ -100,9 +110,6 @@ struct deadline_data {
>  	int front_merges;
>  	u32 async_depth;
>  	int prio_aging_expire;
> -
> -	spinlock_t lock;
> -	spinlock_t zone_lock;
>  };
>  
>  /* Maps an I/O priority class to a deadline scheduler priority. */
> @@ -600,6 +607,15 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  	struct request *rq;
>  	enum dd_prio prio;
>  
> +	/*
> +	 * If someone else is already dispatching, skip this one. This will
> +	 * defer the next dispatch event to when something completes, and could
> +	 * potentially lower the queue depth for contended cases.
> +	 */
> +	if (test_bit(DD_DISPATCHING, &dd->run_state) ||
> +	    test_and_set_bit(DD_DISPATCHING, &dd->run_state))
> +		return NULL;
> +

This patch looks fine.

BTW, the current dispatch is actually piggyback in the in-progress dispatch,
see blk_mq_do_dispatch_sched(). And the correctness should depend on
the looping dispatch & retry for nothing to dispatch in
blk_mq_do_dispatch_sched(), maybe we need to document it here.


Thanks,
Ming

