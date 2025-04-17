Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B324C91
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 02:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744856856; cv=none; b=ijJtOUQCGBF72W0SfzqGRk4JGX5blGAE0LUx+a4iRfXtWbPylqQHGU/Wp8BjL+SDDwDltIg8wxVrDEfXqsbg6Ylks4CQfQX+MCr5AttJoxUANHGX1rlCLqSa1AaJwrlVGa0ffv2eE4XjIg7oF4PdDEhcy8oEbhcmZ/VQUzuVdLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744856856; c=relaxed/simple;
	bh=gk1MRrEmtV9egtDbqwJSyD7dNzchEjKLcPl2N4tDGbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSJ6LXAEgchdWclULfd5gPLllOpuFpu+tjYuzlzIQea0ZilO6cJCjzd3AU5x8guWjhp5eC+FEAVUxu1TLbvOZON1d9kFNoRC7WZjvYhApfkz/YYbfvysNMPAbLtBVQGe5Tk+oyeVt37kCEaLOYRGDvylX4KKOOJWS++3MwtP3Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JQVMJSCy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQVMJSCy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744856852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ksirz+LTX+iskMwRR+nNUXM6YfxyjDotAyofeKPDojI=;
	b=JQVMJSCy7SeFVbXe6iNk1iO8jJAZkulvHS6Zay29tt5J6omF1yxLNMraSYsn0OOwWzrYWo
	qEEwnCo7GGmfqr5egnZgxyGaqP6KjZkV4imoYJwjVcC/ywwj5NaPjZJAV+DoXzK92BZruH
	zHIK+Eg4CtfkinB3OV2S2MXMyVpmZvU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-rQ0f5JQGPtC-urEpLZdlhg-1; Wed,
 16 Apr 2025 22:27:28 -0400
X-MC-Unique: rQ0f5JQGPtC-urEpLZdlhg-1
X-Mimecast-MFC-AGG-ID: rQ0f5JQGPtC-urEpLZdlhg_1744856847
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EA00195608C;
	Thu, 17 Apr 2025 02:27:27 +0000 (UTC)
Received: from fedora (unknown [10.72.116.90])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44266180045B;
	Thu, 17 Apr 2025 02:27:21 +0000 (UTC)
Date: Thu, 17 Apr 2025 10:27:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, yangerkun@huawei.com,
	yukuai3@huawei.com, tj@kernel.org
Subject: Re: [PATCH 1/3] blk-throttle: Fix wrong tg->[bytes/io]_disp update
 in __tg_update_carryover()
Message-ID: <aABnBBp4ZZ6pQAOM@fedora>
References: <20250417015033.512940-1-wozizhi@huawei.com>
 <20250417015033.512940-2-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417015033.512940-2-wozizhi@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Apr 17, 2025 at 09:50:31AM +0800, Zizhi Wo wrote:
> In commit 6cc477c36875 ("blk-throttle: carry over directly"), the carryover
> bytes/ios was be carried to [bytes/io]_disp. However, its update mechanism
> has some issues.
> 
> In __tg_update_carryover(), we calculate "bytes" and "ios" to represent the
> carryover, but the computation when updating [bytes/io]_disp is incorrect.
> This patch fixes the issue.
> 
> And if the bps/iops limit was previously set to max and later changed to a
> smaller value, we may not update tg->[bytes/io]_disp to 0 in
> tg_update_carryover(). Relying solely on throtl_trim_slice() is not
> sufficient, which can lead to subsequent bio dispatches not behaving as
> expected. We should set tg->[bytes/io]_disp to 0 in non_carryover case.
> The same handling applies when nr_queued is 0.
> 
> Fixes: 6cc477c36875 ("blk-throttle: carry over directly")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>  block/blk-throttle.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 91dab43c65ab..df9825eb83be 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -644,20 +644,39 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
>  	u64 bps_limit = tg_bps_limit(tg, rw);
>  	u32 iops_limit = tg_iops_limit(tg, rw);
>  
> +	/*
> +	 * If the queue is empty, carryover handling is not needed. In such cases,
> +	 * tg->[bytes/io]_disp should be reset to 0 to avoid impacting the dispatch
> +	 * of subsequent bios. The same handling applies when the previous BPS/IOPS
> +	 * limit was set to max.
> +	 */
> +	if (tg->service_queue.nr_queued[rw] == 0) {
> +		tg->bytes_disp[rw] = 0;
> +		tg->io_disp[rw] = 0;
> +		return;
> +	}
> +
>  	/*
>  	 * If config is updated while bios are still throttled, calculate and
>  	 * accumulate how many bytes/ios are waited across changes. And
>  	 * carryover_bytes/ios will be used to calculate new wait time under new
>  	 * configuration.
>  	 */
> -	if (bps_limit != U64_MAX)
> +	if (bps_limit != U64_MAX) {
>  		*bytes = calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
>  			tg->bytes_disp[rw];
> -	if (iops_limit != UINT_MAX)
> +		tg->bytes_disp[rw] = -*bytes;
> +	} else {
> +		tg->bytes_disp[rw] = 0;
> +	}

It should be fine to do	'tg->bytes_disp[rw] = -*bytes;' directly
because `*bytes` is initialized as zero.

> +
> +	if (iops_limit != UINT_MAX) {
>  		*ios = calculate_io_allowed(iops_limit, jiffy_elapsed) -
>  			tg->io_disp[rw];
> -	tg->bytes_disp[rw] -= *bytes;
> -	tg->io_disp[rw] -= *ios;
> +		tg->io_disp[rw] = -*ios;
> +	} else {
> +		tg->io_disp[rw] = 0;
> +	}

Same with above.

Otherwise, this patch looks fine.


thanks,
Ming

