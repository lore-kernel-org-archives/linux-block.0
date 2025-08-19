Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DCF322C7D
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600492; cv=none; b=X47afWmiRxCxvLthA9+4EK/ayaIxvrDh1hWLrSmjejmhDvOMiI7too9ldQQwsZwxIXlqQHPgA0Evd5JzqzfrSlO9fIBhjhZMEvPTrYOpcjUMw3ad37Rq0HqUgcZAyiubBntYB9vI2RBrIl8w/vNjLOf0toPLX0qjIRtGdwFfKoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600492; c=relaxed/simple;
	bh=yy7n/PYtL6K2yF8sUxGIIxz1imNTTJE7if5m1LiwgII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQ4yG5spNqt8nHTvZDqcMe99zOv6+yQfqd1FAioNBDYBeyqz5VkWIsBPhkeW0nXjpgJsLneE+U4mdUKa5d19A4/Igam0PxOXRKH+OvRolwGM58aGKOMJ9CwHL0YEVQs1tAI6colUyAJ6inkfghIeoULBk7wVg1zL1jiBCJN8DzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RmIu5tf2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmIu5tf2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755600490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yqXMxhwp2BkpKuqK8wQ55YikkSut+eT+w/7QoweoDNs=;
	b=RmIu5tf2e3JpGqzj0EijiYewuZ0frkrx/UBHjS0B60H8vBGXev76tz4H/qM49DdYjR51+g
	Qvxt6TqSlU6lAmdFGVeegNFFDtClHtJi0izg6vu05VtHTduKwkeJ3IEHeXXHwP8kn1iRrC
	e/RqhWEqjfPl5F/3798TkFQ/pKmH7GM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-3H0bpKwTNcOoyXFqz7vuVg-1; Tue,
 19 Aug 2025 06:48:05 -0400
X-MC-Unique: 3H0bpKwTNcOoyXFqz7vuVg-1
X-Mimecast-MFC-AGG-ID: 3H0bpKwTNcOoyXFqz7vuVg_1755600483
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 373991800289;
	Tue, 19 Aug 2025 10:48:02 +0000 (UTC)
Received: from fedora (unknown [10.72.116.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6452A195419F;
	Tue, 19 Aug 2025 10:47:54 +0000 (UTC)
Date: Tue, 19 Aug 2025 18:47:49 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: yukuai3@huawei.com, axboe@kernel.dk, bvanassche@acm.org, hare@suse.de,
	nilay@linux.ibm.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH v2 2/2] blk-mq: fix blk_mq_tags double free while
 nr_requests grown
Message-ID: <aKRWVUDEiguVzbTN@fedora>
References: <20250819012917.523272-1-yukuai1@huaweicloud.com>
 <20250819012917.523272-3-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819012917.523272-3-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Aug 19, 2025 at 09:29:17AM +0800, Yu Kuai wrote:
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
> Fix this problem by replacing et->tags will new allocated tags as well.
> 
> Noted there are still some long term problems that will require some
> refactor to be fixed thoroughly[1].
> 
> [1] https://lore.kernel.org/all/20250815080216.410665-1-yukuai1@huaweicloud.com/
> Fixes: f5a6604f7a44 ("block: fix lockdep warning caused by lock dependency in elv_iosched_store")
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-mq-tag.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index d880c50629d6..5cffa5668d0c 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -622,6 +622,7 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
>  			return -ENOMEM;
>  
>  		blk_mq_free_map_and_rqs(set, *tagsptr, hctx->queue_num);
> +		hctx->queue->elevator->et->tags[hctx->queue_num] = new;
>  		*tagsptr = new;

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

