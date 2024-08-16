Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFC013AA41
	for <linux-block@vger.kernel.org>; Fri, 16 Aug 2024 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799686; cv=none; b=J1s+PiP+cq620TlZdo7wYFkzpIJNN4R8Xi/isnhNiXFucdba7hWnR8CZnHlvPfH4flNoi7Gz1SSqCCHEb3Ys8KiBLAIA6jkj72Id46BLVKniqrh9l52Y48uhMeLLBwCE9UALOIhqnHdfvo1HnZBeJNoXV+IZBtTeenOJZzxTfAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799686; c=relaxed/simple;
	bh=tNq3Msi+yGcRXDegFEmrjnz059hC5TCb/lzLoe5WkYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhnWREAvB0C/PfQZ9QtwSPwrN/6lV7422qmPh56u3UsJ6qAEdNvapUn9GsRfzmjZvKr/S+bPJr60rDd7mNYVT/OtKhikhGSexiwEqpAq5cT9DvIzHDbh4rA5ZZDobHT7wzNgN+zvY/0a1Cv5gua7DF9QnHJ+ZyQ0jZ2IMJl/2Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJgWmbIE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJgWmbIE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723799684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vycu3OS486oz1R2CUeEvlPsrB5GfdSWVCGoj7Glyhi8=;
	b=AJgWmbIEjSqgyiHY3WEbWBqmjO5o7TdQBXQ8NoQka0HgwIsuVvfgOgqykClvcOAkRa3amT
	fv+w1lniQTK4DyXC3ftv4ZgeTLgwEGgEMYQQduQprHvY4z+z8sCoXBJeSQIk4U1JL/O5jD
	CSCwlC9MQTabQ3slwDoOcMOVaadOliQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-BJ7ttN6dOWe6cUpyg4Jeaw-1; Fri,
 16 Aug 2024 05:14:40 -0400
X-MC-Unique: BJ7ttN6dOWe6cUpyg4Jeaw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B8051955F42;
	Fri, 16 Aug 2024 09:14:39 +0000 (UTC)
Received: from fedora (unknown [10.72.116.121])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3C76300019A;
	Fri, 16 Aug 2024 09:14:34 +0000 (UTC)
Date: Fri, 16 Aug 2024 17:14:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] block: fix request starvation when queue is stopped
 or quiesced
Message-ID: <Zr8YdAhw6tDqImzF@fedora>
References: <20240811101921.4031-1-songmuchun@bytedance.com>
 <20240811101921.4031-2-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811101921.4031-2-songmuchun@bytedance.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sun, Aug 11, 2024 at 06:19:18PM +0800, Muchun Song wrote:
> Supposing the following scenario with a virtio_blk driver.
> 
> CPU0                                    CPU1                                    CPU2
> 
> blk_mq_try_issue_directly()
>     __blk_mq_issue_directly()
>         q->mq_ops->queue_rq()
>             virtio_queue_rq()
>                 blk_mq_stop_hw_queue()
>                                         blk_mq_try_issue_directly()             virtblk_done()
>                                             if (blk_mq_hctx_stopped())
>     blk_mq_request_bypass_insert()                                                  blk_mq_start_stopped_hw_queue()
>     blk_mq_run_hw_queue()                                                               blk_mq_run_hw_queue()
>                                                 blk_mq_insert_request()
>                                                 return // Who is responsible for dispatching this IO request?
> 
> After CPU0 has marked the queue as stopped, CPU1 will see the queue is stopped.
> But before CPU1 puts the request on the dispatch list, CPU2 receives the interrupt
> of completion of request, so it will run the hardware queue and marks the queue
> as non-stopped. Meanwhile, CPU1 also runs the same hardware queue. After both CPU1
> and CPU2 complete blk_mq_run_hw_queue(), CPU1 just puts the request to the same
> hardware queue and returns. Seems it misses dispatching a request. Fix it by
> running the hardware queue explicitly. I think blk_mq_request_issue_directly()
> should handle a similar problem.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  block/blk-mq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e3c3c0c21b553..b2d0f22de0c7f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2619,6 +2619,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>  
>  	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(rq->q)) {
>  		blk_mq_insert_request(rq, 0);
> +		blk_mq_run_hw_queue(hctx, false);
>  		return;
>  	}
>  
> @@ -2649,6 +2650,7 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
>  
>  	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(rq->q)) {
>  		blk_mq_insert_request(rq, 0);
> +		blk_mq_run_hw_queue(hctx, false);
>  		return BLK_STS_OK;
>  	}

Looks one real issue, and the fix is fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks, 
Ming

