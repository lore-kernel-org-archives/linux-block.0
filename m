Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9C61A0BD0
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 00:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756256308; cv=none; b=SRtNh0jmUP/6uidTXKEtQimv0he5ej/om5+Dry+0rEK/OC/IS73K8U+/xVgunQGRy5r/YSznxEWCsuX62SiKDDQcK1C0v+ZSCuWs00zN9whuam4P/3Mr145J+ercm4kCwyaFkfU2iD4jH/79gXSKgeW//Viig3jh985FNNr8/Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756256308; c=relaxed/simple;
	bh=pJcb+Fht6vB+reX+TqG9R4aKlunq8AvYtB6xYR2vnQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahkUjYPsRBkcX3BnZeQ7tiwdfINUB1BgTuO6Nzfj92tnhcP6wMIZ6c4JB/AGLUh7G0gf604+0VzqN8jCACgVKBqojMv0MgEJda3JGD4v866EmR3sNRHa+4K/WelPB4t3w5pAvFqvjO5ySwrjn+KUOU6JruQICksKdospJkq8kNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KB4lL5V9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KB4lL5V9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756256305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9Vds8El0nHCfAOchscouR6LADiC3NFwfPcPYTHIEQ4=;
	b=KB4lL5V90pBMiqaUM81BTpbNzM0FB448aACFgng3ggOYpygoXD5tG9ghLj1CFqT+ACe18t
	01ZxAxQiI9mK73LfVr/E5x8TATpTBhwaR+dtIFnNbWljxF9kF0q2nx8V6C72ND22v5cOsa
	GaSA33CbZqdEPx1olTDbkAKJxcaSLs0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-2asWDuvsMGqG5usYVPu2Zg-1; Tue,
 26 Aug 2025 20:58:21 -0400
X-MC-Unique: 2asWDuvsMGqG5usYVPu2Zg-1
X-Mimecast-MFC-AGG-ID: 2asWDuvsMGqG5usYVPu2Zg_1756256300
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCEB919560B2;
	Wed, 27 Aug 2025 00:58:19 +0000 (UTC)
Received: from fedora (unknown [10.72.116.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23BC519560AB;
	Wed, 27 Aug 2025 00:58:12 +0000 (UTC)
Date: Wed, 27 Aug 2025 08:58:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: linan666@huaweicloud.com
Cc: axboe@kernel.dk, jianchao.w.wang@oracle.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yangerkun@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH] blk-mq: check kobject state_in_sysfs before deleting in
 blk_mq_unregister_hctx
Message-ID: <aK5YH4Jbt3ZNngwR@fedora>
References: <20250826084854.1030545-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826084854.1030545-1-linan666@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Aug 26, 2025 at 04:48:54PM +0800, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
> 
> In __blk_mq_update_nr_hw_queues() the return value of
> blk_mq_sysfs_register_hctxs() is not checked. If sysfs creation for hctx

Looks we should check its return value and handle the failure in both
the call site and blk_mq_sysfs_register_hctxs().

> fails, later changing the number of hw_queues or removing disk will
> trigger the following warning:
> 
>   kernfs: can not remove 'nr_tags', no directory
>   WARNING: CPU: 2 PID: 637 at fs/kernfs/dir.c:1707 kernfs_remove_by_name_ns+0x13f/0x160
>   Call Trace:
>    remove_files.isra.1+0x38/0xb0
>    sysfs_remove_group+0x4d/0x100
>    sysfs_remove_groups+0x31/0x60
>    __kobject_del+0x23/0xf0
>    kobject_del+0x17/0x40
>    blk_mq_unregister_hctx+0x5d/0x80
>    blk_mq_sysfs_unregister_hctxs+0x94/0xd0
>    blk_mq_update_nr_hw_queues+0x124/0x760
>    nullb_update_nr_hw_queues+0x71/0xf0 [null_blk]
>    nullb_device_submit_queues_store+0x92/0x120 [null_blk]
> 
> kobjct_del() was called unconditionally even if sysfs creation failed.
> Fix it by checkig the kobject creation statusbefore deleting it.
> 
> Fixes: 477e19dedc9d ("blk-mq: adjust debugfs and sysfs register when updating nr_hw_queues")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  block/blk-mq-sysfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> index 24656980f443..5c399ac562ea 100644
> --- a/block/blk-mq-sysfs.c
> +++ b/block/blk-mq-sysfs.c
> @@ -150,9 +150,11 @@ static void blk_mq_unregister_hctx(struct blk_mq_hw_ctx *hctx)
>  		return;
>  
>  	hctx_for_each_ctx(hctx, ctx, i)
> -		kobject_del(&ctx->kobj);
> +		if (ctx->kobj.state_in_sysfs)
> +			kobject_del(&ctx->kobj);
>  
> -	kobject_del(&hctx->kobj);
> +	if (hctx->kobj.state_in_sysfs)
> +		kobject_del(&hctx->kobj);

It is bad to use kobject internal state in block layer.


Thanks,
Ming

