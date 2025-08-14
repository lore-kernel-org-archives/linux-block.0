Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D0120B800
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755159410; cv=none; b=B+2MauDYNCt3ygCQXbpEpj9IdSq0nEIxUSfnLhHLfGoI34JB5whDT7IsVCuMO6eEOUB3tjXXioJ4wBS1mFMoxc4jm3WyV0QKjKWl7b1FY9cWNWoRrx6frJ5JUdwsvgqW9zNEYGoKdnVK8GGbOp1g/CmVH7kuRx+gHhP9Q5k4u0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755159410; c=relaxed/simple;
	bh=JNk1WB0sM/c3AKnWnMw61vo+9cr+QpZkWlweEglazbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5P1axoFZxWNB6L1FBD27m0h2LraJJT49btawi2FOgcM736yoEuoZKhpdqQM/BOibWiTatPiSJ+rD4wqGz78rxKZ9FN6oOZ41oRYyENVCb35VFkBeM7OQGliang0rOs4OsUyQmje9w9TZpbGAn+TBjajba+T8husIm2+6Se+OoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1h+iqxe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1h+iqxe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755159407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prsh9FSOWNJa9cC/Rn26ki138ZPJL8uPSh1phs6eaBo=;
	b=d1h+iqxeUIRMFsSPLVMP/GcVEauMTVzcCKhQatbZ/qKi+QMiNbQGG3ffs3+u9+36/BODp3
	G1psd9FxAVbo2kw4GSiY6AxD/Y2y8LFhTgmC+qeJ+CkhaoTI1a3ABQ4ve9ZZPpPnPTFrzj
	MnvD30xUYfo1f1Jag5/aosWhpxpLV/o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-ssTVxsLWPUSt8FmxS_VULQ-1; Thu,
 14 Aug 2025 04:16:43 -0400
X-MC-Unique: ssTVxsLWPUSt8FmxS_VULQ-1
X-Mimecast-MFC-AGG-ID: ssTVxsLWPUSt8FmxS_VULQ_1755159402
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DDE6195F165;
	Thu, 14 Aug 2025 08:16:41 +0000 (UTC)
Received: from fedora (unknown [10.72.116.148])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E95C31800447;
	Thu, 14 Aug 2025 08:16:31 +0000 (UTC)
Date: Thu, 14 Aug 2025 16:16:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, yukuai3@huawei.com, bvanassche@acm.org,
	nilay@linux.ibm.com, hare@suse.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH 01/16] blk-mq-sched: add new parameter nr_requests in
 blk_mq_alloc_sched_tags()
Message-ID: <aJ2bWqQCMtjT3NZh@fedora>
References: <20250814033522.770575-1-yukuai1@huaweicloud.com>
 <20250814033522.770575-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814033522.770575-2-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Aug 14, 2025 at 11:35:07AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> This helper only support to iallocate the default number of requests,
> add a new parameter to support specific number of requests.
> 
> Prepare to fix tags double free problem if nr_requests is grown by
> queue sysfs attribute nr_requests.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-mq-sched.c | 11 +++++++----
>  block/blk-mq-sched.h |  2 +-
>  block/elevator.c     |  2 +-
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index e2ce4a28e6c9..9a8a0b5e04a9 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -454,7 +454,7 @@ void blk_mq_free_sched_tags_batch(struct xarray *et_table,
>  }
>  
>  struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
> -		unsigned int nr_hw_queues)
> +		unsigned int nr_hw_queues, unsigned int nr_requests)
>  {
>  	unsigned int nr_tags;
>  	int i;
> @@ -475,8 +475,11 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
>  	 * 128, since we don't split into sync/async like the old code
>  	 * did. Additionally, this is a per-hw queue depth.
>  	 */
> -	et->nr_requests = 2 * min_t(unsigned int, set->queue_depth,
> -			BLKDEV_DEFAULT_RQ);
> +	if (nr_requests)
> +		et->nr_requests = nr_requests;
> +	else
> +		et->nr_requests = 2 * min_t(unsigned int, set->queue_depth,
> +				BLKDEV_DEFAULT_RQ);

It looks more readable to add helper blk_mq_default_nr_requests(),
and pass it from call sites directly, then people won't be confused
with the passed zero `nr_requests`.


Thanks, 
Ming

