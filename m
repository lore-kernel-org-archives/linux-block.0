Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED54258ECA
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788241; cv=none; b=ZoqLVxNSsLd5Ih2kRAObPYQWDqynUJVgWkA/uauBRz/sFZlPL/KIeBOpzFQUhB54pGkyrMwlPSGz5QaK+zCy7o29vFQy87IpQT5BWlmAYWiR70dmLWQmnZNST4IOAmJ5dc1HTdutIW3okU+b1MBIXZWvnoC8NqwMyL8Jw/L1pDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788241; c=relaxed/simple;
	bh=6lmOEYwkG5TMDgcJJjgcXBbTMEWD5OdTFgQSioGiV4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ns+PjXB76JXeh6y57+kSf8B/epQ2aSQDC2XCEkca+4PmD4yxOI1GpRB6RMHFU/B/cohT2dDOhchchNMpQXMUTy5r2cpcyWZg9zLY6yzvEK8+AMdLn6fh/h45na4ywfIlzTwsBrShzcguqhIOSMwMgQp8CeY1i7a/ksB2u1uxlgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYCbDQ3D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYCbDQ3D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767788238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YDEhBM6XmXlmTQr6SBuFo6ax6nE/kZ6YbRwcs8zEoV4=;
	b=aYCbDQ3Dsy+rT+Tz6kRQbwlrp8//9/+JHeJMvPTjByNEctodB/BlPg4/JU+OhCYHFbNsBm
	nSPLf4hBF7FbaUdBTx+uBoUfi1AgVsO5RX8OVc36eGUmY/CQ8uzDjQV4Q0Ra/0bUxUqNkC
	wi38VuSbGR09oYyBQpg71obJJVrwIRY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-ukD5RKEZNN-QDhDGN2kIZQ-1; Wed,
 07 Jan 2026 07:17:15 -0500
X-MC-Unique: ukD5RKEZNN-QDhDGN2kIZQ-1
X-Mimecast-MFC-AGG-ID: ukD5RKEZNN-QDhDGN2kIZQ_1767788234
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F21419560B2;
	Wed,  7 Jan 2026 12:17:14 +0000 (UTC)
Received: from fedora (unknown [10.72.116.199])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2FF11956048;
	Wed,  7 Jan 2026 12:17:09 +0000 (UTC)
Date: Wed, 7 Jan 2026 20:17:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
	nilay@linux.ibm.com
Subject: Re: [PATCH v7 12/16] blk-iocost: fix incorrect lock order for
 rq_qos_mutex and freeze queue
Message-ID: <aV5OwAvw1sRF1IW1@fedora>
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-13-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231085126.205310-13-yukuai@fnnas.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Dec 31, 2025 at 04:51:22PM +0800, Yu Kuai wrote:
> Like wbt, rq_qos_add() can be called from two path and the lock order
> are inversely:
> 
> - From ioc_qos_write(), queue is already frozen before rq_qos_add();
> - From ioc_cost_model_write(), rq_qos_add() is called directly;
> 
> Fix this problem by converting to use blkg_conf_open_bdev_frozen()
> from ioc_cost_model_write(), then since all rq_qos_add() callers
> already freeze queue, convert to use rq_qos_add_frozen().
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> ---
>  block/blk-iocost.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index a0416927d33d..929fc1421d7e 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -2925,7 +2925,7 @@ static int blk_iocost_init(struct gendisk *disk)
>  	 * called before policy activation completion, can't assume that the
>  	 * target bio has an iocg associated and need to test for NULL iocg.
>  	 */
> -	ret = rq_qos_add(&ioc->rqos, disk, RQ_QOS_COST, &ioc_rqos_ops);
> +	ret = rq_qos_add_frozen(&ioc->rqos, disk, RQ_QOS_COST, &ioc_rqos_ops);
>  	if (ret)
>  		goto err_free_ioc;
>  
> @@ -3408,7 +3408,7 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
>  {
>  	struct blkg_conf_ctx ctx;
>  	struct request_queue *q;
> -	unsigned int memflags;
> +	unsigned long memflags;
>  	struct ioc *ioc;
>  	u64 u[NR_I_LCOEFS];
>  	bool user;
> @@ -3417,9 +3417,11 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
>  
>  	blkg_conf_init(&ctx, input);
>  
> -	ret = blkg_conf_open_bdev(&ctx);
> -	if (ret)
> +	memflags = blkg_conf_open_bdev_frozen(&ctx);
> +	if (IS_ERR_VALUE(memflags)) {
> +		ret = memflags;
>  		goto err;
> +	}
>  

The following blk_iocost_init() runs into percpu allocation, so it will
create new lockdep warning.



Thanks,
Ming

