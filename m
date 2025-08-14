Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11342E7188
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 08:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755159687; cv=none; b=LdLLj1/vNPOhy/sLcG7hHUus2kCvozzeXxWiwSCITjhIrTrvo2PbBXQMtY70D5tesa/UueYR276fvtbF3J7H2bvlzfyMzGBgkKjFEKz3T7hq7iQ6pZu5eKxDVi8FYlH2GUYnk9uzrio/b1fUd5Y0QKnIrZlIdmAStDt4bEM4HU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755159687; c=relaxed/simple;
	bh=HnBnHwpP5i7jq+xMSEgshYAyEEtYmu/pth0vrOmnpCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZ8JCI+XEoPSrSmAq90Reto4Lm1WuYnMQJffwmV8HHoweUwY9cg5oErGNfh8YDTdBd/Mwc3N03trAkHMe6/FSNZfg05OSaVwERISZ1ue98cKGfMGf2gaeERSxzfBR2Sc0+Eq20hYbXgl7gBbW8XhSCdndEMOJdOpHhW3GFpv46E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gILZRX2s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gILZRX2s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755159684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fqaib5LzYjLIdEGI0u5LX7r7Yg4ypsXH3pC6i5Z2Rog=;
	b=gILZRX2svsoZyymmPHfoiyojDHytBfurFtR3wIHNBkwPf2A2Ju64Pdrtga4YhMyX1RBh7F
	nCVs9Dszwu327fqs1QAgZ8a/s0hZ3EHKs+S6YiHg4SvjMYbU3FJwBIvCN2wGsI8CDu14ks
	1zIZk1m1DE2bP7xjCkJQnkdAcidIGVE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-ZYsI0mZsNQKkzbVbyIQmwA-1; Thu,
 14 Aug 2025 04:21:20 -0400
X-MC-Unique: ZYsI0mZsNQKkzbVbyIQmwA-1
X-Mimecast-MFC-AGG-ID: ZYsI0mZsNQKkzbVbyIQmwA_1755159678
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FA6419775DE;
	Thu, 14 Aug 2025 08:21:17 +0000 (UTC)
Received: from fedora (unknown [10.72.116.148])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 808631955E89;
	Thu, 14 Aug 2025 08:21:09 +0000 (UTC)
Date: Thu, 14 Aug 2025 16:20:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, yukuai3@huawei.com, bvanassche@acm.org,
	nilay@linux.ibm.com, hare@suse.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH 08/16] blk-mq: fix blk_mq_tags double free while
 nr_requests grown
Message-ID: <aJ2cZGAWvZ0XfNr4@fedora>
References: <20250814033522.770575-1-yukuai1@huaweicloud.com>
 <20250814033522.770575-9-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814033522.770575-9-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Aug 14, 2025 at 11:35:14AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> In the case user trigger tags grow by queue sysfs attribute nr_requests,
> hctx->sched_tags will be freed directly and replaced with a new
> allocated tags, see blk_mq_tag_update_depth().
> 
> The problem is that hctx->sched_tags is from elevator->et->tags, while
> et->tags is still the freed tags, hence later elevator exist will try to
> free the tags again, causing kernel panic.
> 
> Fix this problem by using new halper blk_mq_alloc_sched_tags() to
> allocate a new sched_tags. Meanwhile, there is a longterm problem can be
> fixed as well:
> 
> If blk_mq_tag_update_depth() succeed for previous hctx, then bitmap depth
> is updated, however, if following hctx failed, q->nr_requests is not
> updated and the previous hctx->sched_tags endup bigger than q->nr_requests.
> 
> Fixes: f5a6604f7a44 ("block: fix lockdep warning caused by lock dependency in elv_iosched_store")
> Fixes: e3a2b3f931f5 ("blk-mq: allow changing of queue depth through sysfs")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-mq.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a7d6a20c1524..f1c11f591c27 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4917,6 +4917,23 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
>  }
>  EXPORT_SYMBOL(blk_mq_free_tag_set);
>  
> +static int blk_mq_sched_grow_tags(struct request_queue *q, unsigned int nr)
> +{
> +	struct elevator_tags *et =
> +		blk_mq_alloc_sched_tags(q->tag_set, q->nr_hw_queues, nr);
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned long i;
> +
> +	if (!et)
> +		return -ENOMEM;
> +
> +	blk_mq_free_sched_tags(q->elevator->et, q->tag_set);
> +	queue_for_each_hw_ctx(q, hctx, i)
> +		hctx->sched_tags = et->tags[i];
> +	q->elevator->et = et;
> +	return 0;
> +}

It depends on protection from elevator_lock, so probably it is
helpful by adding lockdep_assert_held(&q->elevator_lock), otherwise
this fix looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

