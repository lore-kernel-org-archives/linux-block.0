Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579CB11C92;
	Mon, 12 Aug 2024 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471416; cv=none; b=dwf3/e9vnbKIEE2ADcMIH0+oN3sPumeJ9RKZzd/f7wpShyRAQegBGHQj8PvGfqMgldzacZoVktRZb8FCBh0njzpQu8UDcqurelaQBQ+I9ibc6GMOBnjFTazlZLStereaXyMQOZIaDkmjc+/KCFdqbfqJfeO3vlXKjN+wmoZ6klc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471416; c=relaxed/simple;
	bh=mNhqE5gg6GonYn7gRji/mmpLvAAcv2kW3DdfCyvo6Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PApoJ8Egr4QREODT90SUaafGyXnY5j50GuYQhRmFE0GO79vAd38XkgQUSrm5rL1iI2DeYUsv1IA6RWaMcO/vGY9k++a1iXj+LkZYM5ywr2syAlaLSn1mktHLLzFHkVgx53/cuyu+bYCJLUc+HBrLBIdXpJ5OOF/66Qn4NmYct0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wgm4Y2Fy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wgm4Y2Fy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B181C32782;
	Mon, 12 Aug 2024 14:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723471415;
	bh=mNhqE5gg6GonYn7gRji/mmpLvAAcv2kW3DdfCyvo6Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wgm4Y2FysWteo2f2FA8VsChMIfTIaW665HFPe5q6AS0d4dRMNus5+FbWVUYRDKwZI
	 2hfUvBdUAQBBLK9ntiLtRTFDIeXCjax5mWaBX/M2f0FJ42WB0sTDqDxKp1gtsH/E2o
	 Bpqct28A+N8kny87E1ijs+rk7SOpJIeAy069JMEY=
Date: Mon, 12 Aug 2024 16:03:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, kbusch@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.10 13/16] block: change rq_integrity_vec to
 respect the iterator
Message-ID: <2024081223-thriving-yo-yo-0787@gregkh>
References: <20240728004739.1698541-1-sashal@kernel.org>
 <20240728004739.1698541-13-sashal@kernel.org>
 <7f38f5bc-6bd2-4e3a-92e6-c232761fafc6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f38f5bc-6bd2-4e3a-92e6-c232761fafc6@kernel.org>

On Mon, Aug 12, 2024 at 03:51:12PM +0200, Matthieu Baerts wrote:
> Hi Sasha, Greg,
> 
> On 28/07/2024 02:47, Sasha Levin wrote:
> > From: Mikulas Patocka <mpatocka@redhat.com>
> > 
> > [ Upstream commit cf546dd289e0f6d2594c25e2fb4e19ee67c6d988 ]
> > 
> > If we allocate a bio that is larger than NVMe maximum request size,
> > attach integrity metadata to it and send it to the NVMe subsystem, the
> > integrity metadata will be corrupted.
> 
> (...)
> 
> > diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
> > index 7428cb43952da..d16dd24719841 100644
> > --- a/include/linux/blk-integrity.h
> > +++ b/include/linux/blk-integrity.h
> > @@ -100,14 +100,13 @@ static inline bool blk_integrity_rq(struct request *rq)
> >  }
> >  
> >  /*
> > - * Return the first bvec that contains integrity data.  Only drivers that are
> > - * limited to a single integrity segment should use this helper.
> > + * Return the current bvec that contains the integrity data. bip_iter may be
> > + * advanced to iterate over the integrity data.
> >   */
> > -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> > +static inline struct bio_vec rq_integrity_vec(struct request *rq)
> >  {
> > -	if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
> > -		return NULL;
> > -	return rq->bio->bi_integrity->bip_vec;
> > +	return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
> > +				 rq->bio->bi_integrity->bip_iter);
> >  }
> >  #else /* CONFIG_BLK_DEV_INTEGRITY */
> >  static inline int blk_rq_count_integrity_sg(struct request_queue *q,
> > @@ -169,7 +168,8 @@ static inline int blk_integrity_rq(struct request *rq)
> >  
> >  static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> >  {
> > -	return NULL;
> > +	/* the optimizer will remove all calls to this function */
> > +	return (struct bio_vec){ };
> 
> If CONFIG_BLK_DEV_INTEGRITY is not defined, there is a compilation error
> here in v6.10 with the recently queued patches because the signature has
> not been updated:
> 
> > In file included from block/bdev.c:15:                                                                                                                                             
> > include/linux/blk-integrity.h: In function 'rq_integrity_vec':
> > include/linux/blk-integrity.h:172:16: error: incompatible types when returning type 'struct bio_vec' but 'struct bio_vec *' was expected
> >   172 |         return (struct bio_vec){ };                 
> >       |                ^
> 
> Could it be possible to backport the following fix to v6.10 as well please?
> 
>   69b6517687a4 ("block: use the right type for stub rq_integrity_vec()")
> 
> It is also needed for v6.6 and v6.1.

Now queued up, thanks!

greg k-h
