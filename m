Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B54830EF98
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429236; cv=none; b=Oc5xF2gCxQyYtPVehJoge/645THoDtPvpAwNNxXS77q7EIcUD9DUVl0BiEvldSCpyczNgscXIPdNe/Y+9RL/c634FBeDIl+2yyzjxWT9Lvrgj+Ltmlk8IGb/I9CetWfnWu7iyXeZvUfzydcx5RFkdIU7Gc6qc3SVHGJGpFzp32s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429236; c=relaxed/simple;
	bh=W/8qUuXfRe1sI3GhG5HJ/sXq7n9SBQbq5yaCU3/GG28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S83qjK4lobhYlTV5j3++oZl/l8pqT5BBOqtnZwcRnArHEN51kpBgJFX4wCxx7aqBTwAMLRQaZMWT6brnoEeC5ng+itKKbi+4g0toqoj+mBtrv5gDqGvxwXvmX4SZdpF0uOEhkAIxzaA9NCZJjH4FtxGUDPq2MK6gTk7Ft64X0Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OBAiggUH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBAiggUH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760429234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tTrkuFKTla2K+L8YNXA54XVUf+zQx19gGP/m/Y+qRUc=;
	b=OBAiggUHksT83LnEPnBI1ZljBT054SuPps+6FC5Mz6+KHkS/C1Z1ms7362FkarnylUrpFk
	Azfm3JP+SA87pBUquCk/iIZ59QgGY1F/yIZK8uZy4vvomozEDufS/WzRmJkQDFSgs5Lmdd
	xXJvDnxjgCE/zxT8mLsNiYXwF3r4wEA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-XofPY518O7e8QPEJScQ0TQ-1; Tue,
 14 Oct 2025 04:07:10 -0400
X-MC-Unique: XofPY518O7e8QPEJScQ0TQ-1
X-Mimecast-MFC-AGG-ID: XofPY518O7e8QPEJScQ0TQ_1760429228
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF95D180045C;
	Tue, 14 Oct 2025 08:07:06 +0000 (UTC)
Received: from fedora (unknown [10.72.120.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D33F19560B8;
	Tue, 14 Oct 2025 08:06:58 +0000 (UTC)
Date: Tue, 14 Oct 2025 16:06:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai3@huawei.com>
Cc: nilay@linux.ibm.com, tj@kernel.org, josef@toxicpanda.com,
	axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: Re: [PATCH 1/4] blk-mq-debugfs: warn about possible deadlock
Message-ID: <aO4EniFy63IlWM_-@fedora>
References: <20251014022149.947800-1-yukuai3@huawei.com>
 <20251014022149.947800-2-yukuai3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014022149.947800-2-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Oct 14, 2025 at 10:21:46AM +0800, Yu Kuai wrote:
> Creating new debugfs entries can trigger fs reclaim, hence we can't do
> this with queue freezed, meanwhile, other locks that can be held while
> queue is freezed should not be held as well.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-mq-debugfs.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 4896525b1c05..66864ed0b77f 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -608,9 +608,23 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
>  	{},
>  };
>  
> -static void debugfs_create_files(struct dentry *parent, void *data,
> +static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
> +				 void *data,
>  				 const struct blk_mq_debugfs_attr *attr)
>  {
> +	/*
> +	 * Creating new debugfs entries with queue freezed has the rist of
> +	 * deadlock.
> +	 */
> +	WARN_ON_ONCE(q->mq_freeze_depth != 0);
> +	/*
> +	 * debugfs_mutex should not be nested under other locks that can be
> +	 * grabbed while queue is freezed.
> +	 */
> +	lockdep_assert_not_held(&q->elevator_lock);
> +	lockdep_assert_not_held(&q->rq_qos_mutex);

->rq_qos_mutex use looks one real mess, in blk-cgroup.c, it is grabbed after
queue is frozen. However, inside block/blk-rq-qos.c, the two are re-ordered,
maybe we need to fix order between queue freeze and q->rq_qos_mutex first?
Or move on by removing the above line?

Otherwise, this patch looks good.


Thanks,
Ming

