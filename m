Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2101D9357
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454598; cv=none; b=RZWLk/ojCgLJPcqduwTmvBTS0xSPZdaaYLv/B5wffRi9Cwxr0rPWv2zDyR7ywi1aNfh1aXVnMUrgoyDwQRjRJEegdzb9vp9nafV2626Po4yWl+Zck+87PJEIuuUUd4j4JtBB/ItobzmEjX17A0Q1bpXc033Rf4rdOXKhwTSOKWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454598; c=relaxed/simple;
	bh=w12zITrlcS7mKMPlkOl2ZGejq1Eo5bn874xDYkUxjBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXUpA5K3loNeRrH3xEA/jdgrp8muID4Lha/aCRBploUcAr8JENx0mo570voVl3/Nmic7fDucsqzALOG8qRXPUXKRUwj1ZQqM75Gm0KL65/O/YeEG+4uYqbqAXSUmQLzs+RM7M6KffHVJuBWh+Madh3S4nKmU9z9D569lgQc2WAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HqSZ6Csp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqSZ6Csp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725454594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Y6zLyuFowAQXUpe4yq3nH5ym9sfNZkhp6uZ2OTgfrU=;
	b=HqSZ6CspTcwqSeSyQpMD3doc0PdWW6O2PJuv6PGZm4AV5/5isqRkQejN21usPgAw6ka7vW
	37vOszGYH3PWVCvN732KhfmK7dZB/1jaO5uCAJEhPLlV3lIMYJOxil0rBMVKi6LKcVmX35
	Te3CAdk76GvHmqeA8N7eOJ5pnidgrdw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-3Cjfp9NyMZSq6G0H6OWfpw-1; Wed,
 04 Sep 2024 08:56:31 -0400
X-MC-Unique: 3Cjfp9NyMZSq6G0H6OWfpw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEDDE1955DD2;
	Wed,  4 Sep 2024 12:56:29 +0000 (UTC)
Received: from fedora (unknown [10.72.116.59])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F0E5195605A;
	Wed,  4 Sep 2024 12:56:23 +0000 (UTC)
Date: Wed, 4 Sep 2024 20:56:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: axboe@kernel.dk, yukuai1@huaweicloud.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, muchun.song@linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] block: fix ordering between checking
 QUEUE_FLAG_QUIESCED and adding requests
Message-ID: <ZthY8prW0dZ0+Nco@fedora>
References: <20240903081653.65613-1-songmuchun@bytedance.com>
 <20240903081653.65613-3-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903081653.65613-3-songmuchun@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Sep 03, 2024 at 04:16:52PM +0800, Muchun Song wrote:
> Supposing the following scenario.
> 
> CPU0                                        CPU1
> 
> blk_mq_insert_request()         1) store    blk_mq_unquiesce_queue()
> blk_mq_run_hw_queue()                       blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)       3) store
>     if (blk_queue_quiesced())   2) load         blk_mq_run_hw_queues()
>         return                                      blk_mq_run_hw_queue()
>     blk_mq_sched_dispatch_requests()                    if (!blk_mq_hctx_has_pending())     4) load
>                                                            return
> 
> The full memory barrier should be inserted between 1) and 2), as well as
> between 3) and 4) to make sure that either CPU0 sees QUEUE_FLAG_QUIESCED is
> cleared or CPU1 sees dispatch list or setting of bitmap of software queue.
> Otherwise, either CPU will not re-run the hardware queue causing starvation.
> 
> So the first solution is to 1) add a pair of memory barrier to fix the
> problem, another solution is to 2) use hctx->queue->queue_lock to synchronize
> QUEUE_FLAG_QUIESCED. Here, we chose 2) to fix it since memory barrier is not
> easy to be maintained.
> 
> Fixes: f4560ffe8cec1 ("blk-mq: use QUEUE_FLAG_QUIESCED to quiesce queue")
> Cc: stable@vger.kernel.org
> Cc: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


thanks,
Ming

