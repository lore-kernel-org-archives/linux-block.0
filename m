Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5C82FE057
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175520; cv=none; b=nY7TFY/FNlGpnas0iSVcPmO+kKZwwofYQjnHpBC7lXDWypiOpu18v0Yasi1GtSuNTdR+DREfIrmHSZ95xW1b+l8HbHD1zLbCzyRzdn3CGVB660nPxjrNbUTB+ArTugdG1UzsX1AxhYUu3HMnRUtFlCpgSaGHj8Hn5bmumpxVBIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175520; c=relaxed/simple;
	bh=todTcotvAjcdMcd8wzewapMg3tI9+lfqj3m9r3Cb7YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kX3oaz6tpNoLwpqgiL2kd20o+AadKLEhZeNzjom+7NS8w413V60NyRA5gjWpHCYsMXTmscRT7m1Jde3pCx9+thRcTbnaqJbkEg/fR0Doxkode0bzHEvbuvax4lkhc3Yzg/78XZK8hMsAdWzo7g9+IjoxSDGOaL7FoCsvlt875gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVfokrZP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVfokrZP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755175516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/ou3stRg4yShlw/XOxURd0KIBi8GFWlSzaZk0G8hKs=;
	b=UVfokrZPiPdehhX2YreBGRa0CO05a750X1aUVTneHMCfGV4rTM/G6iM/xQQO8TX361SG5K
	I7BOCTAhc+hkC923fGx5k1pjMhgnMPwh6KYXgwiTQ1gYPDWxBrXSiBDo7piw5PJMbl01FY
	5yL9h0Lyz0eQnN+mmqqa/yiSQF7uUT0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-V1_JRjOvNZKg9OOXg_zbJQ-1; Thu,
 14 Aug 2025 08:45:12 -0400
X-MC-Unique: V1_JRjOvNZKg9OOXg_zbJQ-1
X-Mimecast-MFC-AGG-ID: V1_JRjOvNZKg9OOXg_zbJQ_1755175511
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 888391956060;
	Thu, 14 Aug 2025 12:45:10 +0000 (UTC)
Received: from fedora (unknown [10.72.116.148])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B59DD3000198;
	Thu, 14 Aug 2025 12:45:01 +0000 (UTC)
Date: Thu, 14 Aug 2025 20:44:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, yukuai1@huaweicloud.com,
	hch@lst.de, shinichiro.kawasaki@wdc.com, kch@nvidia.com,
	gjoyce@ibm.com
Subject: Re: [PATCHv3 3/3] block: avoid cpu_hotplug_lock depedency on
 freeze_lock
Message-ID: <aJ3aR2JodRrAqVcO@fedora>
References: <20250814082612.500845-1-nilay@linux.ibm.com>
 <20250814082612.500845-4-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814082612.500845-4-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Aug 14, 2025 at 01:54:59PM +0530, Nilay Shroff wrote:
> A recent lockdep[1] splat observed while running blktest block/005
> reveals a potential deadlock caused by the cpu_hotplug_lock dependency
> on ->freeze_lock. This dependency was introduced by commit 033b667a823e
> ("block: blk-rq-qos: guard rq-qos helpers by static key").
> 
> That change added a static key to avoid fetching q->rq_qos when
> neither blk-wbt nor blk-iolatency is configured. The static key
> dynamically patches kernel text to a NOP when disabled, eliminating
> overhead of fetching q->rq_qos in the I/O hot path. However, enabling
> a static key at runtime requires acquiring both cpu_hotplug_lock and
> jump_label_mutex. When this happens after the queue has already been
> frozen (i.e., while holding ->freeze_lock), it creates a locking
> dependency from cpu_hotplug_lock to ->freeze_lock, which leads to a
> potential deadlock reported by lockdep [1].
> 
> To resolve this, replace the static key mechanism with q->queue_flags:
> QUEUE_FLAG_QOS_ENABLED. This flag is evaluated in the fast path before
> accessing q->rq_qos. If the flag is set, we proceed to fetch q->rq_qos;
> otherwise, the access is skipped.
> 
> Since q->queue_flags is commonly accessed in IO hotpath and resides in
> the first cacheline of struct request_queue, checking it imposes minimal
> overhead while eliminating the deadlock risk.
> 
> This change avoids the lockdep splat without introducing performance
> regressions.
> 
> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
> 
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
> Fixes: 033b667a823e ("block: blk-rq-qos: guard rq-qos helpers by static key")
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  block/blk-mq-debugfs.c |  1 +
>  block/blk-rq-qos.c     |  9 ++++---
>  block/blk-rq-qos.h     | 54 ++++++++++++++++++++++++------------------
>  include/linux/blkdev.h |  1 +
>  4 files changed, 37 insertions(+), 28 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 7ed3e71f2fc0..32c65efdda46 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -95,6 +95,7 @@ static const char *const blk_queue_flag_name[] = {
>  	QUEUE_FLAG_NAME(SQ_SCHED),
>  	QUEUE_FLAG_NAME(DISABLE_WBT_DEF),
>  	QUEUE_FLAG_NAME(NO_ELV_SWITCH),
> +	QUEUE_FLAG_NAME(QOS_ENABLED),
>  };
>  #undef QUEUE_FLAG_NAME
>  
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index b1e24bb85ad2..654478dfbc20 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -2,8 +2,6 @@
>  
>  #include "blk-rq-qos.h"
>  
> -__read_mostly DEFINE_STATIC_KEY_FALSE(block_rq_qos);
> -
>  /*
>   * Increment 'v', if 'v' is below 'below'. Returns true if we succeeded,
>   * false if 'v' + 1 would be bigger than 'below'.
> @@ -319,8 +317,8 @@ void rq_qos_exit(struct request_queue *q)
>  		struct rq_qos *rqos = q->rq_qos;
>  		q->rq_qos = rqos->next;
>  		rqos->ops->exit(rqos);
> -		static_branch_dec(&block_rq_qos);
>  	}
> +	blk_queue_flag_clear(QUEUE_FLAG_QOS_ENABLED, q);
>  	mutex_unlock(&q->rq_qos_mutex);
>  }
>  
> @@ -346,7 +344,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
>  		goto ebusy;
>  	rqos->next = q->rq_qos;
>  	q->rq_qos = rqos;
> -	static_branch_inc(&block_rq_qos);
> +	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);

One stupid question: can we simply move static_branch_inc(&block_rq_qos)
out of queue freeze in rq_qos_add()?

What matters is just the 1st static_branch_inc() which switches the counter
from 0 to 1, when blk_mq_freeze_queue() guarantees that all in-progress code
paths observe q->rq_qos as NULL. That means static_branch_inc(&block_rq_qos)
needn't queue freeze protection.



Thanks,
Ming

