Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E4D770FC
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783827; cv=none; b=LbEmHuaBgQjfARLvaV1wFHzvYqWLEHjdHzOQZfgkM5/pt9FzYtPXtPqCfOY8wcc+dSGkZcOoox1AAJ43rRsqNMMNTNLrDn3OL3sLArflCY0GiFp0fU/y4d5vulzeNMkFgfZPar9We1n89Rbot/HjJ9vuCdXxcDiHeLTEn/M/7z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783827; c=relaxed/simple;
	bh=C1htsWk1K7ECTA0zdGVMMlCTLIzINZiyGUcbq/ApuJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCc54tj+Eiz4OEfVYM0F3MJsajsghkdOUFh58+eTjrSK02rHm5IBcej13mRei4pwH93PTNxC2RRWaDr2D85+GYx1eQ+PmbIxlWdc9KTNoY9tqLamzH2z1GcR9R9G7ME0qrEI3v5rd2/XTBD6fsTztRqiGiE1TwPZbMcqRA5n250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FCaLtpHj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCaLtpHj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718783824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=odD4vwLp/eEhGHMf/30MERzu56slA+VufjXzyUq24Sc=;
	b=FCaLtpHjhuNLbm4T/MrONNN+doaf0sI55nKEkYjlx4ghdB161dFAe+PxRY5axOxEZQz7Nl
	mVWP8XZJJwg646M5Yd1ikTgF+PPq8KIZC5r+A5Jz3pZrj0nFeQWwmb+gkYuDO7SJF7Xenu
	TvxzoleR9HffbCkEGCbG+R7MJywMakU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-dTrvpzZ2O9qgf9nkWhfVAg-1; Wed,
 19 Jun 2024 03:57:01 -0400
X-MC-Unique: dTrvpzZ2O9qgf9nkWhfVAg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B40A519560AD;
	Wed, 19 Jun 2024 07:56:54 +0000 (UTC)
Received: from fedora (unknown [10.72.112.148])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A03419560B0;
	Wed, 19 Jun 2024 07:56:48 +0000 (UTC)
Date: Wed, 19 Jun 2024 15:56:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Christoph Hellwig <hch@infradead.org>, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] block: check bio alignment in blk_mq_submit_bio
Message-ID: <ZnKPO0qUfuHPOdEi@fedora>
References: <20240619033443.3017568-1-ming.lei@redhat.com>
 <7ed12f7e-f59a-4f6f-975b-ce7bb21652de@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ed12f7e-f59a-4f6f-975b-ce7bb21652de@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Jun 19, 2024 at 01:14:02PM +0900, Damien Le Moal wrote:
> On 6/19/24 12:34, Ming Lei wrote:
> > IO logical block size is one fundamental queue limit, and every IO has
> > to be aligned with logical block size because our bio split can't deal
> > with unaligned bio.
> > 
> > The check has to be done with queue usage counter grabbed because device
> > reconfiguration may change logical block size, and we can prevent the
> > reconfiguration from happening by holding queue usage counter.
> > 
> > logical_block_size stays in the 1st cache line of queue_limits, and this
> > cache line is always fetched in fast path via bio_may_exceed_limits(),
> > so IO perf won't be affected by this check.
> > 
> > Cc: Yi Zhang <yi.zhang@redhat.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Ye Bin <yebin10@huawei.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 3b4df8e5ac9e..7bb50b6b9567 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2914,6 +2914,21 @@ static void blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
> >  	INIT_LIST_HEAD(&rq->queuelist);
> >  }
> >  
> > +static bool bio_unaligned(const struct bio *bio,
> > +		const struct request_queue *q)
> > +{
> > +	unsigned int bs = queue_logical_block_size(q);
> > +
> > +	if (bio->bi_iter.bi_size & (bs - 1))
> > +		return true;
> > +
> > +	if (bio->bi_iter.bi_size &&
> > +	    ((bio->bi_iter.bi_sector << SECTOR_SHIFT) & (bs - 1)))
> 
> Hmmm... Some BIO operations have a 0 size but do specify a sector (e.g. zone
> management operations).

If we add the check for all type of IO, it requires ->bi_sector to
be meaningful for zero size bio. I am not sure if it is always true,
such as RESET_ALL.

> So this seems incorrect to me...

It is correct, but only cover bio with real ->bi_sector & ->bi_size.


Thanks,
Ming

