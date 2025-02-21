Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58372F3B
	for <linux-block@vger.kernel.org>; Fri, 21 Feb 2025 02:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740106543; cv=none; b=U9cXaJ/KXXvO+1/LRfZrjeK+vjsLpxLH4GU4+NZmBknBrazgoLcCarYI9rHJaWOJnWXotkEK/no6yRUr6RlFQw6tg/oSYTz7NvOxT33C/QnO/Yavob846T/Mcfkgtgdkzygdj8x4g21Yhqvi0DdRv9CK5ID4irj1iRYxlA5bX2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740106543; c=relaxed/simple;
	bh=yA9yb+v/RyQTqipBCXHv1BDNck+KMt9TAtL4IzWZgJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7UA3+eTXRqhqmGISt+tmdl7N/+4St+9CviPAc20wMg8MqADG6SeumvnH4N4CwAdMNxPhGtL/+x1Gmc22Bbj3vTbbODj/p8lsuwU/cwE3nEWrnS1T9/EGywxiJwXcB2MTsxjXSyThIdS3G82uyQBbw6/f8XTVI2Qxq1KsMfqzW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YtgTFrWI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YtgTFrWI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740106540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1mVTzm9GkpidsK39/v1CuCMhdkhioOej4w+t01AWWV8=;
	b=YtgTFrWI7PWkJGwujhh9bwa4zxPum+nbWxf+e5E4L9SFD8enfcolsm6ObJS6l21fu1Ga4O
	Z50rhgXVr0HcrxEZ+11F5NXiQecTnx5kSQhWQaiyM4eaDh165u9sWKb6uSIiMb/52Nnerq
	xRWisXRySnBBrITwrbuRYQgqjnqT0bo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-sXRCsVUxOYWV5ca3R50Rvw-1; Thu,
 20 Feb 2025 21:55:37 -0500
X-MC-Unique: sXRCsVUxOYWV5ca3R50Rvw-1
X-Mimecast-MFC-AGG-ID: sXRCsVUxOYWV5ca3R50Rvw_1740106534
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B228D1800873;
	Fri, 21 Feb 2025 02:55:33 +0000 (UTC)
Received: from fedora (unknown [10.72.120.9])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3476C1955BCB;
	Fri, 21 Feb 2025 02:55:28 +0000 (UTC)
Date: Fri, 21 Feb 2025 10:55:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] block: throttle: don't add one extra jiffy mistakenly
 for bps limit
Message-ID: <Z7frGxuMCTLwH9BW@fedora>
References: <20250220111735.1187999-1-ming.lei@redhat.com>
 <a8f10a51-c9c8-0d1a-296d-f1f542bf8523@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8f10a51-c9c8-0d1a-296d-f1f542bf8523@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Yukuai,

On Thu, Feb 20, 2025 at 09:38:12PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/02/20 19:17, Ming Lei 写道:
> > When the current bio needs to be throttled because of bps limit, the wait
> > time for the extra bytes may be less than 1 jiffy, tg_within_bps_limit()
> > adds one extra 1 jiffy.
> > 
> > However, when taking roundup time into account, the extra 1 jiffy
> > may become not necessary, then bps limit becomes not accurate. This way
> > causes blktests throtl/001 failure in case of CONFIG_HZ_100=y.
> > 
> > Fix it by not adding the 1 jiffy in case that the roundup time can
> > cover it.
> > 
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Yu Kuai <yukuai3@huawei.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   block/blk-throttle.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> > index 8d149aff9fd0..8348972c517b 100644
> > --- a/block/blk-throttle.c
> > +++ b/block/blk-throttle.c
> > @@ -729,14 +729,14 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
> >   	extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
> >   	jiffy_wait = div64_u64(extra_bytes * HZ, bps_limit);
> > -	if (!jiffy_wait)
> > -		jiffy_wait = 1;
> > -
> >   	/*
> >   	 * This wait time is without taking into consideration the rounding
> >   	 * up we did. Add that time also.
> >   	 */
> >   	jiffy_wait = jiffy_wait + (jiffy_elapsed_rnd - jiffy_elapsed);
> > +	if (!jiffy_wait)
> > +		jiffy_wait = 1;
> 
> Just wonder, will wait (0, 1) less jiffies is better than wait (0, 1)
> more jiffies.
> 
> How about following changes?
> 
> Thanks,
> Kuai
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 8d149aff9fd0..f8430baf3544 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -703,6 +703,7 @@ static unsigned long tg_within_bps_limit(struct
> throtl_grp *tg, struct bio *bio,
>                                 u64 bps_limit)
>  {
>         bool rw = bio_data_dir(bio);
> +       long long carryover_bytes;
>         long long bytes_allowed;
>         u64 extra_bytes;
>         unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
> @@ -727,10 +728,11 @@ static unsigned long tg_within_bps_limit(struct
> throtl_grp *tg, struct bio *bio,
> 
>         /* Calc approx time to dispatch */
>         extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
> -       jiffy_wait = div64_u64(extra_bytes * HZ, bps_limit);
> +       jiffy_wait = div64_u64_rem(extra_bytes * HZ, bps_limit,
> carryover_bytes);
> 

&carryover_bytes

> +       /* carryover_bytes is dispatched without waiting */
>         if (!jiffy_wait)
> -               jiffy_wait = 1;
> +               tg->carryover_bytes[rw] -= carryover_bytes;
> 
>         /*
>          * This wait time is without taking into consideration the rounding
> 
> > +
> >   	return jiffy_wait;

Looks result is worse with your patch:

throtl/001 (basic functionality)                             [failed]
    runtime  6.488s  ...  28.862s
    --- tests/throtl/001.out	2024-11-21 09:20:47.514353642 +0000
    +++ /root/git/blktests/results/nodev/throtl/001.out.bad	2025-02-21 02:51:36.723754146 +0000
    @@ -1,6 +1,6 @@
     Running throtl/001
    +13
     1
    -1
    -1
    +13
     1
    ...
    (Run 'diff -u tests/throtl/001.out /root/git/blktests/results/nodev/throtl/001.out.bad' to see the entire diff)


thanks,
Ming

