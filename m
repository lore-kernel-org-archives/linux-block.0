Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6C42698AF
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 11:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377289; cv=none; b=PhLvTu+RMwH8tnGd9odEsYyJDbWn8WPrV5B/hyX+6pgXI4vmFH+7SI2OfVjtLr6byY1bWsf2uNTykpv5+ymg3USRuCtEbEOZw6qxZad8ngzhowTizjA3DShEavq5ZiOPMw83psHxQkRvhgMouEXm5zTIQQyuxbfddtnvfoCfTiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377289; c=relaxed/simple;
	bh=N9/lcsM0jr7rZhz8ePGmTdOkwjfQ8AFb+CJXtFVCPi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARzBk1e45OmtLH7AtrBQZmUoak2+V1XEilTRtbEFdI7Kh5JcztPuauqzp8fk/n/gqEZRVSPtCQJqFbjadZYRn5yPJfW/J5rVNRovIFsCBMALYqZM/OOXyRT88yArxsF0uG5cBn1iwUIyRGP6x/Oj2NFm081Xt6EC5Xot5c5h31c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GCRcRvji; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCRcRvji"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763377286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rsnoMrn4EKFATCbKyLfMnUmzDXGThmJLwfi6jLEmVxM=;
	b=GCRcRvjiZAKb0KIPHxao5F/EHfiLwJtSgNTFN6cZfeFkS8PleMmxTjVWlJXxC2WLELPouv
	pFh0mb/1IabojiPAzzRC9h7yDqygCd5tdpImayS393MZJC85CGvCMgbbD8avjQP9kyluU1
	eYb+MGkGbats5FnJg+/eTpMqEsdKD3Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-VXLDxIGFN3mlwrIXTFzkZg-1; Mon,
 17 Nov 2025 06:01:22 -0500
X-MC-Unique: VXLDxIGFN3mlwrIXTFzkZg-1
X-Mimecast-MFC-AGG-ID: VXLDxIGFN3mlwrIXTFzkZg_1763377278
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3A2D1956060;
	Mon, 17 Nov 2025 11:01:17 +0000 (UTC)
Received: from fedora (unknown [10.72.116.42])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72013180035F;
	Mon, 17 Nov 2025 11:01:13 +0000 (UTC)
Date: Mon, 17 Nov 2025 19:01:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, tj@kernel.org, nilay@linux.ibm.com
Subject: Re: [PATCH RESEND 1/5] block/blk-rq-qos: add a new helper
 rq_qos_add_freezed()
Message-ID: <aRsAdF3GxNJ3Q1Qv@fedora>
References: <20251116041024.120500-1-yukuai@fnnas.com>
 <20251116041024.120500-2-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116041024.120500-2-yukuai@fnnas.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sun, Nov 16, 2025 at 12:10:20PM +0800, Yu Kuai wrote:
> queue should not be freezed under rq_qos_mutex, see example index
> commit 9730763f4756 ("block: correct locking order for protecting blk-wbt
> parameters"), which means current implementation of rq_qos_add() is
> problematic. Add a new helper and prepare to fix this problem in
> following patches.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> ---
>  block/blk-rq-qos.c | 27 +++++++++++++++++++++++++++
>  block/blk-rq-qos.h |  2 ++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index 654478dfbc20..353397d7e126 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -322,6 +322,33 @@ void rq_qos_exit(struct request_queue *q)
>  	mutex_unlock(&q->rq_qos_mutex);
>  }
>  
> +int rq_qos_add_freezed(struct rq_qos *rqos, struct gendisk *disk,
> +		       enum rq_qos_id id, const struct rq_qos_ops *ops)
> +{
> +	struct request_queue *q = disk->queue;
> +
> +	WARN_ON_ONCE(q->mq_freeze_depth == 0);
> +	lockdep_assert_held(&q->rq_qos_mutex);
> +
> +	if (rq_qos_id(q, id))
> +		return -EBUSY;
> +
> +	rqos->disk = disk;
> +	rqos->id = id;
> +	rqos->ops = ops;
> +	rqos->next = q->rq_qos;
> +	q->rq_qos = rqos;
> +	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
> +
> +	if (rqos->ops->debugfs_attrs) {
> +		mutex_lock(&q->debugfs_mutex);
> +		blk_mq_debugfs_register_rqos(rqos);
> +		mutex_unlock(&q->debugfs_mutex);
> +	}

It will cause more lockdep splat to let q->debugfs_mutex depend on queue freeze,

Also blk_mq_debugfs_register_rqos() does _not_ require queue to be frozen,
and it should be fine to move blk_mq_debugfs_register_rqos() out of queue
freeze.


Thanks,
Ming

