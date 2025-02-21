Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB70A15A8
	for <linux-block@vger.kernel.org>; Fri, 21 Feb 2025 04:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740111522; cv=none; b=TuOsqJ60N4LGg5o9bctE7+jwgAt4bzdG2rdR1RuJK4B4+YVk515okAgkTlF4vP+tqSxffOtmG7qxwQvb78gFwL8RU/wcQJy4Mi3vQW8XOxjsGFwvKgt5HVMYLuezD2PijSi63whidsRLQr4As+YbmRvtLkj93qazWqmqO41Ljxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740111522; c=relaxed/simple;
	bh=oUu+0IBD0BY6JbDJS6HBVXCpUSHlw9Lhs/x+2/GdiQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ufyo4k1qhHfUkrGz/3stocHQ1kd103cqgLKijGz0Pokgt121PRe3tlP5qbQQ/nKXZGKNAEVFB5vYii1iZhCR9fRDcHnZdnIAAttAGD2RFrKuoY5UOQ59FIOPvXrc1cVNNt9j+splshjgPIIXeXhGhlrdAuWTAWiGCN2KmgYN2Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bdl7s7JT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdl7s7JT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740111518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YFntIzXvGA0LhzMnuyehVcaJ45ktkOfMdi5W3tlY0ak=;
	b=bdl7s7JTaG+3nA9NAk/iuDvEoy4ago7YxFUXKgPcaRBeP4+3q/o9I92BWFHWAtMmgQhVpi
	zRyzMnFy5Nt0V+buP7Pyswg3tM8/3TG9KbtjO+Fqm98g2WRSbkP9ncMJqAJEUpA6uEJC+M
	fqRsbnW/ywwMHIVkScoe3E/5L7JntnY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-pyhq110SOBSdNDipNSsuCA-1; Thu,
 20 Feb 2025 23:18:36 -0500
X-MC-Unique: pyhq110SOBSdNDipNSsuCA-1
X-Mimecast-MFC-AGG-ID: pyhq110SOBSdNDipNSsuCA_1740111515
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F04B119560B9;
	Fri, 21 Feb 2025 04:18:34 +0000 (UTC)
Received: from fedora (unknown [10.72.120.9])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 460A81956094;
	Fri, 21 Feb 2025 04:18:29 +0000 (UTC)
Date: Fri, 21 Feb 2025 12:18:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] block: throttle: don't add one extra jiffy mistakenly
 for bps limit
Message-ID: <Z7f-jx9LRXUrj_ao@fedora>
References: <20250220111735.1187999-1-ming.lei@redhat.com>
 <a8f10a51-c9c8-0d1a-296d-f1f542bf8523@huaweicloud.com>
 <Z7frGxuMCTLwH9BW@fedora>
 <83147b4b-9be8-3a50-6a4f-2ec9b37c8ab8@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83147b4b-9be8-3a50-6a4f-2ec9b37c8ab8@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Feb 21, 2025 at 11:39:17AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/02/21 10:55, Ming Lei 写道:
> > Hi Yukuai,
> > 
> > On Thu, Feb 20, 2025 at 09:38:12PM +0800, Yu Kuai wrote:
> > > Hi,
> > > 
> > > 在 2025/02/20 19:17, Ming Lei 写道:
> > > > When the current bio needs to be throttled because of bps limit, the wait
> > > > time for the extra bytes may be less than 1 jiffy, tg_within_bps_limit()
> > > > adds one extra 1 jiffy.
> > > > 
> > > > However, when taking roundup time into account, the extra 1 jiffy
> > > > may become not necessary, then bps limit becomes not accurate. This way
> > > > causes blktests throtl/001 failure in case of CONFIG_HZ_100=y.
> > > > 
> > > > Fix it by not adding the 1 jiffy in case that the roundup time can
> > > > cover it.
> > > > 
> > > > Cc: Tejun Heo <tj@kernel.org>
> > > > Cc: Yu Kuai <yukuai3@huawei.com>
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >    block/blk-throttle.c | 6 +++---
> > > >    1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> > > > index 8d149aff9fd0..8348972c517b 100644
> > > > --- a/block/blk-throttle.c
> > > > +++ b/block/blk-throttle.c
> > > > @@ -729,14 +729,14 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
> > > >    	extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
> > > >    	jiffy_wait = div64_u64(extra_bytes * HZ, bps_limit);
> > > > -	if (!jiffy_wait)
> > > > -		jiffy_wait = 1;
> > > > -
> > > >    	/*
> > > >    	 * This wait time is without taking into consideration the rounding
> > > >    	 * up we did. Add that time also.
> > > >    	 */
> > > >    	jiffy_wait = jiffy_wait + (jiffy_elapsed_rnd - jiffy_elapsed);
> > > > +	if (!jiffy_wait)
> > > > +		jiffy_wait = 1;
> > > 
> > > Just wonder, will wait (0, 1) less jiffies is better than wait (0, 1)
> > > more jiffies.
> > > 
> > > How about following changes?
> > > 
> > > Thanks,
> > > Kuai
> > > 
> > > diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> > > index 8d149aff9fd0..f8430baf3544 100644
> > > --- a/block/blk-throttle.c
> > > +++ b/block/blk-throttle.c
> > > @@ -703,6 +703,7 @@ static unsigned long tg_within_bps_limit(struct
> > > throtl_grp *tg, struct bio *bio,
> > >                                  u64 bps_limit)
> > >   {
> > >          bool rw = bio_data_dir(bio);
> > > +       long long carryover_bytes;
> > >          long long bytes_allowed;
> > >          u64 extra_bytes;
> > >          unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
> > > @@ -727,10 +728,11 @@ static unsigned long tg_within_bps_limit(struct
> > > throtl_grp *tg, struct bio *bio,
> > > 
> > >          /* Calc approx time to dispatch */
> > >          extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
> > > -       jiffy_wait = div64_u64(extra_bytes * HZ, bps_limit);
> > > +       jiffy_wait = div64_u64_rem(extra_bytes * HZ, bps_limit,
> > > carryover_bytes);
> Hi, Thanks for the test.
> 
> This is a mistake, carryover_bytes is much bigger than expected :(
> That's why the result is much worse. My bad.
> > > 
> > 
> > &carryover_bytes
> > 
> > > +       /* carryover_bytes is dispatched without waiting */
> > >          if (!jiffy_wait)
> The if condition shound be removed.
> > > -               jiffy_wait = 1;
> > > +               tg->carryover_bytes[rw] -= carryover_bytes;
> > > 
> > >          /*
> > >           * This wait time is without taking into consideration the rounding
> > > 
> > > > +
> > > >    	return jiffy_wait;
> > 
> > Looks result is worse with your patch:
> > 
> > throtl/001 (basic functionality)                             [failed]
> >      runtime  6.488s  ...  28.862s
> >      --- tests/throtl/001.out	2024-11-21 09:20:47.514353642 +0000
> >      +++ /root/git/blktests/results/nodev/throtl/001.out.bad	2025-02-21 02:51:36.723754146 +0000
> >      @@ -1,6 +1,6 @@
> >       Running throtl/001
> >      +13
> >       1
> >      -1
> >      -1
> >      +13
> >       1
> >      ...
> >      (Run 'diff -u tests/throtl/001.out /root/git/blktests/results/nodev/throtl/001.out.bad' to see the entire diff)
> 
> And I realize now that throtl_start_new_slice() will just clear
> the carryover_bytes, I tested in my VM and with following changes,
> throtl/001 never fail with CONFIG_HZ_100.

If carryover_bytes can cover this issue, I think it is preferred.

> 
> Thanks,
> Kuai
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 8d149aff9fd0..4fc005af82e0 100644
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
> @@ -727,10 +728,8 @@ static unsigned long tg_within_bps_limit(struct
> throtl_grp *tg, struct bio *bio,
> 
>         /* Calc approx time to dispatch */
>         extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
> -       jiffy_wait = div64_u64(extra_bytes * HZ, bps_limit);
> -
> -       if (!jiffy_wait)
> -               jiffy_wait = 1;
> +       jiffy_wait = div64_u64_rem(extra_bytes * HZ, bps_limit,
> &carryover_bytes);
> +       tg->carryover_bytes[rw] -= div64_u64(carryover_bytes, HZ);

Can you explain a bit why `carryover_bytes/HZ` is subtracted instead of
carryover_bytes?

Also tg_within_bps_limit() may return 0 now, which isn't expected.


Thanks, 
Ming

