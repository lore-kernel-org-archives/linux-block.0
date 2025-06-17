Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2276B2E889A
	for <linux-block@vger.kernel.org>; Tue, 17 Jun 2025 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750172894; cv=none; b=fl4Ty5xYt1zmaPO5kDSNnWqiVbTZIq4rQ5dDDNuS7i8oD1dPbrfgQMaZljnH4IETu05OObkHxQqrltkQdE2SrnIkpwabhTqp2DZE/w0BFe0bO7ngpHIP9pKaRLhiWq/5RGmsdy/iYGhsBehyTtRn3bp8J1Xv1/5rqdDraGwhtVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750172894; c=relaxed/simple;
	bh=KGAR8iEIvobJaV5Vdy8IEcH5WkzLA/XjBWLqDannpDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0Ef+pAfGES6fVUISuJbl2j1CYuDmdUfUaJU8UrUF8QhD63fwRLXd408RmBn7TOoQ56sl9cSFqGbj5RLNkNCF06QONbtPQbDcpX1/pd/w0ZeAOB94qHo4N67+Q38z5IeRqk2yXa/76FapeFArcfzD83ZjC2EW7Cxw0Gip3vy0+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F2j1+JjV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2j1+JjV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750172891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0WFE4syE2/Dd6x06rDO7e39GEbxgD11vjmqJ0Pco9EE=;
	b=F2j1+JjVfhSwpzK5Wkx6FSqx7SkrTx1pG/SEGT23YfINd/5CAeKT9TnWFDrKj0G+X2LkuO
	t8oJ1p0bujqZgBKKTgDQaTDI5fAlnLN+q6R5cafOHJMKiY0vTi2zIgVAYKrbDlD5/J+DI4
	zwW9lHnLEnN8hgJrByahI/Bi2pKZavo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-YFK54050MI-hbbapgekGGA-1; Tue,
 17 Jun 2025 11:08:07 -0400
X-MC-Unique: YFK54050MI-hbbapgekGGA-1
X-Mimecast-MFC-AGG-ID: YFK54050MI-hbbapgekGGA_1750172886
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CFCA1800295;
	Tue, 17 Jun 2025 15:08:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.84])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AECF419560B3;
	Tue, 17 Jun 2025 15:08:01 +0000 (UTC)
Date: Tue, 17 Jun 2025 23:07:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	sth@linux.ibm.com, gjoyce@ibm.com
Subject: Re: [PATCHv3 1/2] block: move elevator queue allocation logic into
 blk_mq_init_sched
Message-ID: <aFGEzN5c0-b5VdcM@fedora>
References: <20250616173233.3803824-1-nilay@linux.ibm.com>
 <20250616173233.3803824-2-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616173233.3803824-2-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Jun 16, 2025 at 11:02:25PM +0530, Nilay Shroff wrote:
> In preparation for allocating sched_tags before freezing the request
> queue and acquiring ->elevator_lock, move the elevator queue allocation
> logic from the elevator ops ->init_sched callback into blk_mq_init_sched.
> 
> This refactoring provides a centralized location for elevator queue
> initialization, which makes it easier to store pre-allocated sched_tags
> in the struct elevator_queue during later changes.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  block/bfq-iosched.c   | 13 +++----------
>  block/blk-mq-sched.c  |  7 ++++++-
>  block/elevator.h      |  2 +-
>  block/kyber-iosched.c | 11 ++---------
>  block/mq-deadline.c   | 14 ++------------
>  5 files changed, 14 insertions(+), 33 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 0cb1e9873aab..fd26dc1901b0 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -7232,22 +7232,16 @@ static void bfq_init_root_group(struct bfq_group *root_group,
>  	root_group->sched_data.bfq_class_idle_last_service = jiffies;
>  }
>  
> -static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
> +static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
>  {
>  	struct bfq_data *bfqd;
> -	struct elevator_queue *eq;
>  	unsigned int i;
>  	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
>  
> -	eq = elevator_alloc(q, e);
> -	if (!eq)
> -		return -ENOMEM;
> -
>  	bfqd = kzalloc_node(sizeof(*bfqd), GFP_KERNEL, q->node);
> -	if (!bfqd) {
> -		kobject_put(&eq->kobj);
> +	if (!bfqd)
>  		return -ENOMEM;
> -	}
> +
>  	eq->elevator_data = bfqd;
>  
>  	spin_lock_irq(&q->queue_lock);
> @@ -7405,7 +7399,6 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>  
>  out_free:
>  	kfree(bfqd);
> -	kobject_put(&eq->kobj);
>  	return -ENOMEM;
>  }
>  
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 55a0fd105147..d914eb9d61a6 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -475,6 +475,10 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
>  	q->nr_requests = 2 * min_t(unsigned int, q->tag_set->queue_depth,
>  				   BLKDEV_DEFAULT_RQ);
>  
> +	eq = elevator_alloc(q, e);
> +	if (!eq)
> +		return -ENOMEM;
> +
>  	if (blk_mq_is_shared_tags(flags)) {
>  		ret = blk_mq_init_sched_shared_tags(q);
>  		if (ret)

The above failure needs to be handled by kobject_put(&eq->kobj).

Otherwise, feel free to add:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

