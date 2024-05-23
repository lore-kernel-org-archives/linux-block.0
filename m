Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF905B662
	for <linux-block@vger.kernel.org>; Thu, 23 May 2024 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477087; cv=none; b=ZrcJsW3PPdmBCFazqzhDgkI5+bS9Y7J+1kQPkJGqFCqgM7SKeXh8efjg6QuJrwo3Y8AAN7i6rUBGU8Zhrl3j0U61bqhcVHB10vkfhE3qRJYclVnpHMCBgSti97Qsw6+UMmj2oT2fhAiwyAyT+MDx+IWcf7Aox09XTHiE/6hAimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477087; c=relaxed/simple;
	bh=P3lOaAotD/IS58Nkd8Xq0/fTsAfdaPjBo22XNLtqYTU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i7tu4RpEgceM+3Zf7VgSt/lXA0e4Y1SK1VHnr3Nvpzn1bG1sz3ReBKG8y3DfqUBsdqj/7dLCIIv/T/07a5m16tu+Bh5qg2iWX2/cbmaZoau32lMlP2kb9H2Z8ZaMQoA1YsRrRjv0t0lNS1XZibXy5PC+w4l+o0wKqMeHud2VmbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQZY4xTZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQZY4xTZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716477084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlprbK58nwyOmwVZuXr7wxf2tJsNU+Mc3YyYZDX1w9A=;
	b=gQZY4xTZPV4G59b9WgQwRpyfNAgMYcL5pvkbAwEh1Gpwm6sJVNjlpKzYVfIjQx8hXWZTGa
	sBhz/3ntXlvl7oB9MExxMwXplhTsw625Wb2fwT8VbOa7sa4x2UHNCvdoGYwhHS1fw/9abv
	7I1g1sdJpfRdSLtDMAWE90a6REDBhAU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-tdPq2P7SNYqQ3h5KviEWVw-1; Thu,
 23 May 2024 11:11:17 -0400
X-MC-Unique: tdPq2P7SNYqQ3h5KviEWVw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B757380212E;
	Thu, 23 May 2024 15:11:17 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 037DD401405;
	Thu, 23 May 2024 15:11:17 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id E2FF630C1C33; Thu, 23 May 2024 15:11:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id DFC1D3FB4F;
	Thu, 23 May 2024 17:11:16 +0200 (CEST)
Date: Thu, 23 May 2024 17:11:16 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@kernel.org>, 
    Milan Broz <gmazyland@gmail.com>, linux-block@vger.kernel.org, 
    dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] block: change rq_integrity_vec to respect the
 iterator
In-Reply-To: <b1ca89ae-1500-4c3c-bd8a-74e081aa8dd3@kernel.dk>
Message-ID: <798720bc-bc69-1e1c-8436-474e8a9fb0e8@redhat.com>
References: <f85e3824-5545-f541-c96d-4352585288a@redhat.com> <c366231-e146-5a2b-1d8a-5936fb2047ca@redhat.com> <8522af2f-fb97-4d0b-9e38-868c572da18a@kernel.dk> <7060a917-6537-4334-4961-601a182bca54@redhat.com>
 <b1ca89ae-1500-4c3c-bd8a-74e081aa8dd3@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10



On Thu, 23 May 2024, Jens Axboe wrote:

> On 5/23/24 8:58 AM, Mikulas Patocka wrote:

> > Here I'm resending the patch with the function rq_integrity_vec removed if 
> > CONFIG_BLK_DEV_INTEGRITY is not defined.
> 
> That looks better - but can you please just post a full new series,
> that's a lot easier to deal with and look at than adding a v2 of one
> patch in the thread.

OK, I'll post both patches.

> > @@ -853,16 +855,20 @@ static blk_status_t nvme_prep_rq(struct
> >  			goto out_free_cmd;
> >  	}
> >  
> > +#ifdef CONFIG_BLK_DEV_INTEGRITY
> >  	if (blk_integrity_rq(req)) {
> >  		ret = nvme_map_metadata(dev, req, &iod->cmd);
> >  		if (ret)
> >  			goto out_unmap_data;
> >  	}
> > +#endif
> 
> 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) && blk_integrity_rq(req)) {
> 
> ?

That wouldn't work, because the calls to rq_integrity_vec need to be 
eliminated by the preprocessor.

Should I change rq_integrity_vec to this? Then, we could get rid of the 
ifdefs and let the optimizer remove all calls to rq_integrity_vec.
static inline struct bio_vec rq_integrity_vec(struct request *rq)
{
	struct bio_vec bv = { };
	return bv;
}

> > @@ -962,12 +968,14 @@ static __always_inline void nvme_pci_unm
> >  	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
> >  	struct nvme_dev *dev = nvmeq->dev;
> >  
> > +#ifdef CONFIG_BLK_DEV_INTEGRITY
> >  	if (blk_integrity_rq(req)) {
> >  	        struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> 
> Ditto
> 
> > Index: linux-2.6/include/linux/blk-integrity.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/blk-integrity.h
> > +++ linux-2.6/include/linux/blk-integrity.h
> > @@ -109,11 +109,11 @@ static inline bool blk_integrity_rq(stru
> >   * Return the first bvec that contains integrity data.  Only drivers that are
> >   * limited to a single integrity segment should use this helper.
> >   */
> > -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> > +static inline struct bio_vec rq_integrity_vec(struct request *rq)
> >  {
> > -	if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
> > -		return NULL;
> > -	return rq->bio->bi_integrity->bip_vec;
> > +	WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1);
> > +	return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
> > +				 rq->bio->bi_integrity->bip_iter);
> >  }
> 
> Not clear why the return on integrity segments > 1 is removed?

Because we can't return NULL. But I can leave it there, print a warning 
and return the first vector.

Mikulas

> -- 
> Jens Axboe
> 

