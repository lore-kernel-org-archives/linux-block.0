Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF52199FB0
	for <linux-block@vger.kernel.org>; Tue, 30 Dec 2025 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767094956; cv=none; b=Cbvh0P197+7UCrzi+9YglYdkHP2z773U11Hh1EAbGx+fmaJsRYjd2Zp1qTOFqTo/9Uk5YEC9Arf/0wTMYNHKCPRIx3wgxMOEFYIciecWRhOVwkh0UCC897Gw4+ezLgDxvxoMbyaMQzAKwO2X+vkr+VBBZaaRBl8AIwrj9izarnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767094956; c=relaxed/simple;
	bh=jWscZMMVdXkRPIz2nGs0OCpRUf4a4Bk7hQy+WZVWGtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QK87LBiqVKpCrVfRI59T9/V5LbhK9OkhPvqJEweWw41mavhedMyKnjPObPfhLhtHuwN3BoKFfRRRUAQNLF6TPK8fBovDXmObPu6hFufUiptiJvFcytg2jTLOmyp2KU6IwSAKj1iV+VJ55/XKfzHKX9Nlzff4faR0khmtCEI4/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dw8eggn0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dw8eggn0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767094952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nP43v71cAKrPul52H9dIfZgG5StEL6NFRXzFiIqsqAg=;
	b=Dw8eggn0mlUcvjLpys5mu1er2KjciKSvLpUR5MnlQoYXCu3R5u8qI2hKNEdg51/EGvxvSJ
	4cVlmoRZBYBQVXas1/ZjnDXauatBSBEoAZu4R8Hf4Po8LGBgmUGX2P55wzgZrfCN0cxOgp
	LtLwGupb3vQt23MSuItYaCsH5mQgEvw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-dqVzHYoJP_OhwD0gXQkQ-Q-1; Tue,
 30 Dec 2025 06:42:29 -0500
X-MC-Unique: dqVzHYoJP_OhwD0gXQkQ-Q-1
X-Mimecast-MFC-AGG-ID: dqVzHYoJP_OhwD0gXQkQ-Q_1767094948
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11EFB19560B2;
	Tue, 30 Dec 2025 11:42:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.29])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D6A81800576;
	Tue, 30 Dec 2025 11:42:23 +0000 (UTC)
Date: Tue, 30 Dec 2025 19:42:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Cong Zhang <cong.zhang@oss.qualcomm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-arm-msm@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: skip CPU offline notify on unmapped hctx
Message-ID: <aVO6my9tG1djaKpA@fedora>
References: <20251230-blk_mq_no_ctx_checking-v1-1-2168131383e6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230-blk_mq_no_ctx_checking-v1-1-2168131383e6@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Dec 30, 2025 at 05:17:05PM +0800, Cong Zhang wrote:
> If an hctx has no software ctx mapped, blk_mq_map_swqueue() never
> allocates tags and leaves hctx->tags NULL. The CPU hotplug offline
> notifier can still run for that hctx, return early since hctx cannot
> hold any requests.
> 
> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>

Fixes: bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are offline")

> ---
> This issue was observed during CPU hotplug. If an hctx is not mapped,
> offlining a CPU can trigger a kernel crash.
> When a block device does not map all hctx, some hctx instances may remain
> unused. These unused hctx can still receive CPU offline notifications and
> enter blk_mq_hctx_notify_offline().
> blk_mq_hctx_notify_offline() calls blk_mq_hctx_has_requests() to check
> whether there are pending requests on the hctx. However, unused hctx do
> not have tags allocated, which leads to a crash.
> Since an unused hctx cannot have any requests, fix this by returning
> early when nr_ctx is zero, skipping blk_mq_hctx_notify_offline().
> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1978eef95dca3fb332a73aeff7b9613ee770a8a3..eff4f72ce83be80aac9da86aab35079be7d2b5e4 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3721,7 +3721,7 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
>  			struct blk_mq_hw_ctx, cpuhp_online);
>  	int ret = 0;
>  
> -	if (blk_mq_hctx_has_online_cpu(hctx, cpu))
> +	if (!hctx->nr_ctx || blk_mq_hctx_has_online_cpu(hctx, cpu))
>  		return 0;

Looks correct, and the notify_online handler won't touch hctx->tags:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

