Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D273E51C3
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536734; cv=none; b=rwVI+efAfI/ussiHFhs2PCSV3i6KSG7r9wJhWUobPaQCWXaHdT6hCjlQph9sFBZL4vkaFS5/uiatHJYbe412LJTJtbWBlM5Q38hBiqPrcpR3+Xnu0UeysLdlTdNw3cCtjUdra0ZiS9tP/0iw83FaBiXWara3lGkJo66NNVdTyTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536734; c=relaxed/simple;
	bh=p8TwOq6XNgCYWUOa/rJXN2KMKHSKImO3fuYq/BzkT64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ut49JzR5EcvmX2QaBZePAiUb1YORsxS2yxK8UN1tIYDoMXUrQUsRoZK5BToRNLQmZa5NMFZW+IrpVuy14GSuxM56nCeAFqA+J/0MZLvw/hSEO19ZWB0MPyEmMJWSMye5MnRUnEI9k7KDd4BNdjufqiEo8ObN15nVzD1ZLXuoj/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fNUaiaNE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNUaiaNE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774536731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zox/2jSKdcgZUxcOJVHSGyh61eD111eWyS/rEe+M9GM=;
	b=fNUaiaNEpQBZO0muLV/RcAyyTIRhwmb6XExAaJJY4gWsmZN17mpNoyP7tcdXGfioR0xObq
	+edL3l9mODJuVY9nQ0XWNmim33ryrMBVqtyp/CVxijC/KoltYddhU/56DslsKW/CaHL/t6
	g3IT9OJwG3tBPEC/Bg5Rt1b7Y7exa4o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-O287rflkNauALWvLsQ-o3A-1; Thu,
 26 Mar 2026 10:52:08 -0400
X-MC-Unique: O287rflkNauALWvLsQ-o3A-1
X-Mimecast-MFC-AGG-ID: O287rflkNauALWvLsQ-o3A_1774536727
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3024195608B;
	Thu, 26 Mar 2026 14:52:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.100])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97EBB1800673;
	Thu, 26 Mar 2026 14:52:02 +0000 (UTC)
Date: Thu, 26 Mar 2026 22:51:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 3/5] block: Remove a DMA segment boundary mask check
Message-ID: <acVIDQp5WWerx3lA@fedora>
References: <20260325213719.2850619-1-bvanassche@acm.org>
 <20260325213719.2850619-4-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325213719.2850619-4-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Mar 25, 2026 at 02:37:13PM -0700, Bart Van Assche wrote:
> Commit d690cb8ae14b ("block: add an API to atomically update queue limits")
> introduced the following code:
> 
>        /*
>         * By default there is no limit on the segment boundary alignment,
>         * but if there is one it can't be smaller than the page size as
>         * that would break all the normal I/O patterns.
>         */
>        if (!lim->seg_boundary_mask)
>                lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
>        if (WARN_ON_ONCE(lim->seg_boundary_mask < PAGE_SIZE - 1))
>                return -EINVAL;
> 
> The comment about "breaking normal I/O patterns" is incorrect - block
> layer code like get_max_segment_size() supports arbitrary boundary mask
> values as long as the boundary mask is not zero. Remove the comment and
> the check because both are confusing.
> 
> This patch prepares for reducing the value of BLK_MIN_SEGMENT_SIZE.
> 
> Fixes: d690cb8ae14b ("block: add an API to atomically update queue limits")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-settings.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 13f5457f9f4e..8538e50afe2c 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -447,15 +447,9 @@ int blk_validate_limits(struct queue_limits *lim)
>  	if (!lim->max_discard_segments)
>  		lim->max_discard_segments = 1;
>  
> -	/*
> -	 * By default there is no limit on the segment boundary alignment,
> -	 * but if there is one it can't be smaller than the page size as
> -	 * that would break all the normal I/O patterns.
> -	 */
> +	/* By default there is no limit on the segment boundary alignment. */
>  	if (!lim->seg_boundary_mask)
>  		lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
> -	if (WARN_ON_ONCE(lim->seg_boundary_mask < BLK_MIN_SEGMENT_SIZE - 1))
> -		return -EINVAL;

Please fold this change into the real code for reducing
BLK_MIN_SEGMENT_SIZE, then it provides consistent handling/view about
->seg_boundary_mask and BLK_MIN_SEGMENT_SIZE.

Thanks,
Ming

