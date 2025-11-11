Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392B434676F
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762829949; cv=none; b=OT5YrQmjJQRzM6eRrFRXh14siwx7H2IqckMi7dhMGVQXKeTVYMcI3/7Fqk7rqMHrnpnYk0qgzdNenEmw1xiJLkCk0Sgd7G+HutmaK+k/iJIt1q8ik1ti9ykpSjSjGirsSpBkDKXaCh9lrbpkjikd2Cs0OQlG+VzP4Y3ZcuCvgwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762829949; c=relaxed/simple;
	bh=Fuf/cCKfzs1ibT3YtOqOHD/cUNtvEgqO6HERVORSgpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYvHaj8wWHzRaVFRrralUpFAv3ah3utensiy7sM9DbYw1gcagb9gQH5930iRWpCXFYL1Q0XvRH4bECL2U8zQIpf8yMUL8R4UbdhWa9V11uQETGmUg55DigE+80ueL0LRt68A0ovuCWEKtJ+O2/K98BwPSODCOIZkdxEtMn4XDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cFXNITiQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFXNITiQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762829947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ORkGe0DVHpssiRQgtbDolxRG7t5f4zY0TWtYBpQEOQ=;
	b=cFXNITiQomdFvNDq8LULCrmsbgkqQHgX+NmVqMvweY2PjEA6/oHqZdRPYuBdY8rItOJ6EK
	QDw3CZ18WnakPWHYDjPXcubxpkSUwnDMCg5dGzYV1dmw1orv+QInw3JjdSaoPU44lhcpx3
	MHsZ0aMcy9Sh+aNoMkwzMf4oaYZ9xW4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-7dMCuLnJPYywwWuSiDz8aQ-1; Mon,
 10 Nov 2025 21:59:05 -0500
X-MC-Unique: 7dMCuLnJPYywwWuSiDz8aQ-1
X-Mimecast-MFC-AGG-ID: 7dMCuLnJPYywwWuSiDz8aQ_1762829944
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9485D1956080;
	Tue, 11 Nov 2025 02:59:04 +0000 (UTC)
Received: from fedora (unknown [10.72.116.124])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 654211800576;
	Tue, 11 Nov 2025 02:58:58 +0000 (UTC)
Date: Tue, 11 Nov 2025 10:58:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	yi.zhang@redhat.com, czhong@redhat.com, yukuai@fnnas.com,
	gjoyce@ibm.com
Subject: Re: [PATCHv4 4/5] block: use {alloc|free}_sched data methods
Message-ID: <aRKmbtp0J_VPH4v9@fedora>
References: <20251110081457.1006206-1-nilay@linux.ibm.com>
 <20251110081457.1006206-5-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110081457.1006206-5-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Nov 10, 2025 at 01:44:51PM +0530, Nilay Shroff wrote:
> The previous patch introduced ->alloc_sched_data and
> ->free_sched_data methods. This patch builds upon that
> by now using these methods during elevator switch and
> nr_hw_queue update.
> 
> It's also ensured that scheduler-specific data is
> allocated and freed through the new callbacks outside
> of the ->freeze_lock and ->elevator_lock locking contexts,
> thereby preventing any dependency on pcpu_alloc_mutex.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  block/blk-mq-sched.c | 32 ++++++++++++++++++++++++--------
>  block/blk-mq-sched.h |  8 ++++++--
>  block/elevator.c     | 34 ++++++++++++++++++++++------------
>  block/elevator.h     |  4 +++-
>  4 files changed, 55 insertions(+), 23 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index c7091ea4dccd..0ea8f0004274 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -428,12 +428,17 @@ void blk_mq_free_sched_tags(struct elevator_tags *et,
>  }
>  
>  void blk_mq_free_sched_res(struct elevator_resources *res,
> +		struct elevator_type *type,
>  		struct blk_mq_tag_set *set)
>  {
>  	if (res->et) {
>  		blk_mq_free_sched_tags(res->et, set);
>  		res->et = NULL;
>  	}
> +	if (res->data) {
> +		blk_mq_free_sched_data(type, res->data);
> +		res->data = NULL;
> +	}
>  }
>  
>  void blk_mq_free_sched_res_batch(struct xarray *elv_tbl,
> @@ -458,7 +463,7 @@ void blk_mq_free_sched_res_batch(struct xarray *elv_tbl,
>  				WARN_ON_ONCE(1);
>  				continue;
>  			}
> -			blk_mq_free_sched_res(&ctx->res, set);
> +			blk_mq_free_sched_res(&ctx->res, ctx->type, set);
>  		}
>  	}
>  }
> @@ -540,15 +545,24 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
>  	return NULL;
>  }
>  
> -int blk_mq_alloc_sched_res(struct elevator_resources *res,
> -		struct blk_mq_tag_set *set, unsigned int nr_hw_queues)
> +int blk_mq_alloc_sched_res(struct request_queue *q,
> +		struct elevator_type *type,
> +		struct elevator_resources *res,
> +		struct blk_mq_tag_set *set,
> +		unsigned int nr_hw_queues)

As mentioned, `struct request_queue *q` parameter can be added from
beginning, then `struct blk_mq_tag_set *set` can be avoided.

Otherwise, this patch looks fine.

Thanks,
Ming

