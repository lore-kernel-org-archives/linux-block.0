Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE18B1F869F
	for <linux-block@vger.kernel.org>; Fri, 21 Feb 2025 03:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740107829; cv=none; b=XLOKTjQdgze8FQsJXRSqR6x+IGzRY8VRty/YUodThokwGlMnpkdBOEdBWi7qfvaqZur9FNxFtWlpxY5LFSvu/XavAmT9IWT0fBCip40s276HNq7hF9Xq4+J53otmRcSGjmWEVwhypqR+g7v+nIXQ9LMhcIzGYbkpyA4Kjf63Lz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740107829; c=relaxed/simple;
	bh=wimKtDX7fsLTdA+2xIy7zgM/8Hx7HJ2LWDMQ4dsmD2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Itfli4r3lKoLZJt4AXcW5XMS/Oeb5Qkx8i8fbQuKQ9a0/D8l0MV69jf1LaScmypU8tv1TmsD/mhvtmThTiBawK0CgXZxNiTIV6ZxI4KaSq94vynXzHpzq0+tvRYlEVrxvATzctv+1iUe9gF5qpsU0ycRhviwlHXATHMMvoaWOZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJLyMLiW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJLyMLiW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740107826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMiinAYwAXLKfqxagW2PdixWVGaP2H2PVIXuInVXmw4=;
	b=DJLyMLiWPnegjLnYkl2BM6ELdO8kpmnc4AQkWytG7XrJPhhW/tObDoJyoWpcro8IdxOuXO
	fwFbRxEURIO4pn16RCKSQogkJmvLmdL6D92gaceJjK/KJdl7VnyR4cfbKla+HF5KVjGtca
	3xxEgjDrfM/N5bYH6vvgVlDnEEsw34Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-PNM3_5GQNZWZI5D909FkEA-1; Thu,
 20 Feb 2025 22:17:05 -0500
X-MC-Unique: PNM3_5GQNZWZI5D909FkEA-1
X-Mimecast-MFC-AGG-ID: PNM3_5GQNZWZI5D909FkEA_1740107824
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CACAE19357B1;
	Fri, 21 Feb 2025 03:17:03 +0000 (UTC)
Received: from fedora (unknown [10.72.120.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 853FA1800352;
	Fri, 21 Feb 2025 03:16:59 +0000 (UTC)
Date: Fri, 21 Feb 2025 11:16:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] block: throttle: don't add one extra jiffy mistakenly
 for bps limit
Message-ID: <Z7fwJXHcq5CKanNK@fedora>
References: <20250220111735.1187999-1-ming.lei@redhat.com>
 <a8f10a51-c9c8-0d1a-296d-f1f542bf8523@huaweicloud.com>
 <Z7frGxuMCTLwH9BW@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7frGxuMCTLwH9BW@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Feb 21, 2025 at 10:55:23AM +0800, Ming Lei wrote:
> Hi Yukuai,
> 
> On Thu, Feb 20, 2025 at 09:38:12PM +0800, Yu Kuai wrote:
> > Hi,
> > 
> > 在 2025/02/20 19:17, Ming Lei 写道:
> > > When the current bio needs to be throttled because of bps limit, the wait
> > > time for the extra bytes may be less than 1 jiffy, tg_within_bps_limit()
> > > adds one extra 1 jiffy.
> > > 
> > > However, when taking roundup time into account, the extra 1 jiffy
> > > may become not necessary, then bps limit becomes not accurate. This way
> > > causes blktests throtl/001 failure in case of CONFIG_HZ_100=y.
> > > 
> > > Fix it by not adding the 1 jiffy in case that the roundup time can
> > > cover it.
> > > 
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: Yu Kuai <yukuai3@huawei.com>
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >   block/blk-throttle.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> > > index 8d149aff9fd0..8348972c517b 100644
> > > --- a/block/blk-throttle.c
> > > +++ b/block/blk-throttle.c
> > > @@ -729,14 +729,14 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
> > >   	extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
> > >   	jiffy_wait = div64_u64(extra_bytes * HZ, bps_limit);
> > > -	if (!jiffy_wait)
> > > -		jiffy_wait = 1;
> > > -
> > >   	/*
> > >   	 * This wait time is without taking into consideration the rounding
> > >   	 * up we did. Add that time also.
> > >   	 */
> > >   	jiffy_wait = jiffy_wait + (jiffy_elapsed_rnd - jiffy_elapsed);
> > > +	if (!jiffy_wait)
> > > +		jiffy_wait = 1;
> > 
> > Just wonder, will wait (0, 1) less jiffies is better than wait (0, 1)
> > more jiffies.
> > 
> > How about following changes?
> > 
> > Thanks,
> > Kuai
> > 
> > diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> > index 8d149aff9fd0..f8430baf3544 100644
> > --- a/block/blk-throttle.c
> > +++ b/block/blk-throttle.c
> > @@ -703,6 +703,7 @@ static unsigned long tg_within_bps_limit(struct
> > throtl_grp *tg, struct bio *bio,
> >                                 u64 bps_limit)
> >  {
> >         bool rw = bio_data_dir(bio);
> > +       long long carryover_bytes;
> >         long long bytes_allowed;
> >         u64 extra_bytes;
> >         unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
> > @@ -727,10 +728,11 @@ static unsigned long tg_within_bps_limit(struct
> > throtl_grp *tg, struct bio *bio,
> > 
> >         /* Calc approx time to dispatch */
> >         extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
> > -       jiffy_wait = div64_u64(extra_bytes * HZ, bps_limit);
> > +       jiffy_wait = div64_u64_rem(extra_bytes * HZ, bps_limit,
> > carryover_bytes);
> > 
> 
> &carryover_bytes
> 
> > +       /* carryover_bytes is dispatched without waiting */
> >         if (!jiffy_wait)
> > -               jiffy_wait = 1;
> > +               tg->carryover_bytes[rw] -= carryover_bytes;

Not sure ->carryover_bytes[] can be used here, the comment said
clearly it is only for updating config.

Neither it is good to add one extra, nor add one less, maybe
DIV64_U64_ROUND_CLOSEST() is better?

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 8d149aff9fd0..5791612b3543 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -727,16 +727,16 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 
 	/* Calc approx time to dispatch */
 	extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
-	jiffy_wait = div64_u64(extra_bytes * HZ, bps_limit);
-
-	if (!jiffy_wait)
-		jiffy_wait = 1;
+	jiffy_wait = DIV64_U64_ROUND_CLOSEST(extra_bytes * HZ, bps_limit);
 
 	/*
 	 * This wait time is without taking into consideration the rounding
 	 * up we did. Add that time also.
 	 */
 	jiffy_wait = jiffy_wait + (jiffy_elapsed_rnd - jiffy_elapsed);
+	if (!jiffy_wait)
+		jiffy_wait = 1;
+
 	return jiffy_wait;
 }
 


Thanks,
Ming

