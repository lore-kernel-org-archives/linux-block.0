Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B522777E0
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943699; cv=none; b=YkI9/4HhsmUEOIM9y7fOpohRKf+nPxEs+HZoK0YRokX2J76EthgpO3lS77gABLM6L14I8Rqt7yKyIWZ9gCNGy8koW3ArAbxE/pcsKY+Sft9BAn8bKcs+3d0K2cRqvx2PluggFOg93rAvW0BGqng5LjMYQs4+houZwhHi9uUO0yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943699; c=relaxed/simple;
	bh=rtGPyIMsIZ5cGNqS5znNJu4Oy7CnoGSQYCPRPLX0Cns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqMkB4KmBGhg27j2Gcsu3eeHgZfTQOaIEpMAuSQ0jNf0JooeL8j0BgwPciWxBRvd8RfQtZ0e0RRA3DLYfXnnLj1z06RmFG2qP5ptuqRJEXMiZ3DKazElO3br9tuWowuSrbPn2gjHJaEf+2O/GmZYlPIdbsYumUdxnT4VbcJy9jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpnZQF8N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpnZQF8N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762943696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8nWI/eZT5HjJtDkrsvPT+0OC1XZwFsFlmz0ugKj8oqY=;
	b=dpnZQF8NyS7IubuU6+mRyoyYRfjGVyauttpPwEzPTnCGjqkao1je9OYSnV+DCM9bh38oL8
	O2EPz1DBMxnJq2XzzL2PXZ8VSuiGDObk5S3u2GyKiBx7qRxEOC8H+jVs0uXvMNKaBsaWuI
	aohfxWSAaEnkxyXI/RIsuXJQmzdjwDs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-KNF4TMqrP3-VgiUmmU8FxQ-1; Wed,
 12 Nov 2025 05:34:52 -0500
X-MC-Unique: KNF4TMqrP3-VgiUmmU8FxQ-1
X-Mimecast-MFC-AGG-ID: KNF4TMqrP3-VgiUmmU8FxQ_1762943691
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 252601956095;
	Wed, 12 Nov 2025 10:34:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.179])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 424B4180049F;
	Wed, 12 Nov 2025 10:34:44 +0000 (UTC)
Date: Wed, 12 Nov 2025 18:34:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	yi.zhang@redhat.com, czhong@redhat.com, yukuai@fnnas.com,
	gjoyce@ibm.com
Subject: Re: [PATCHv5 3/5] block: introduce alloc_sched_data and
 free_sched_data elevator methods
Message-ID: <aRRiwBMmLzkD6bag@fedora>
References: <20251112052848.1433256-1-nilay@linux.ibm.com>
 <20251112052848.1433256-4-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112052848.1433256-4-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Nov 12, 2025 at 10:56:04AM +0530, Nilay Shroff wrote:
> The recent lockdep splat [1] highlights a potential deadlock risk
> involving ->elevator_lock and ->freeze_lock dependencies on -pcpu_alloc_
> mutex. The trace shows that the issue occurs when the Kyber scheduler
> allocates dynamic memory for its elevator data during initialization.
> 
> To address this, introduce two new elevator operation callbacks:
> ->alloc_sched_data and ->free_sched_data. The subsequent patch would
> build upon these newly introduced methods to suppress lockdep splat[1].
> 
> [1] https://lore.kernel.org/all/CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDkcnVyjO0=-D5+A@mail.gmail.com/
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  block/blk-mq-sched.h | 15 +++++++++++++++
>  block/elevator.h     |  2 ++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> index 1f8e58dd4b49..3ac64b66176a 100644
> --- a/block/blk-mq-sched.h
> +++ b/block/blk-mq-sched.h
> @@ -39,6 +39,21 @@ void blk_mq_free_sched_res(struct elevator_resources *res,
>  void blk_mq_free_sched_res_batch(struct xarray *et_table,
>  		struct blk_mq_tag_set *set);
>  
> +static inline void *blk_mq_alloc_sched_data(struct request_queue *q,
> +		struct elevator_type *e)
> +{
> +	if (e && e->ops.alloc_sched_data)
> +		return e->ops.alloc_sched_data(q);
> +
> +	return 0;

s/0/NULL


thanks,
Ming

