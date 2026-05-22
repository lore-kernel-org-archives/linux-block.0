Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF5E3438AD
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779440629; cv=none; b=tSJuXYHswzAstLkSHheCkigm9duV7tkleVono+nScTv3dBzI5PJBMmmMceV2Eyw0ldqhihuJmm3ATsEuuQJ5HYuiI4rLpLqSs3tv/h5lg1Tl2Hdmmh6oYxBIoRO0wKXN35683fxZcOWknlRpxJaqkBv+u4MB2Wz9DflKkk5YWmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779440629; c=relaxed/simple;
	bh=rE5qbF74J/MKMn97iKB1KyH0B8m/7B7nsIog11qhmng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwx2ODZG7fksGBd1sDu/x4Y92T47x67VzvxcqslRfjVwDHfEeCG2XR+YSy8q4lAuxsrJxw5JkUZWJ7CXhO6UqbMUwDWGrtydRta/1Qjil3R852tW/pzsODAon5ivRMCsXy0HcsWVqWiJ1+Gh4cHrcuIo5tGif9qU0cJ/m5kF1Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C591568AFE; Fri, 22 May 2026 11:03:41 +0200 (CEST)
Date: Fri, 22 May 2026 11:03:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	tom.leiming@gmail.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3] blk-mq: pop cached request if it is usable
Message-ID: <20260522090340.GA7331@lst.de>
References: <20260521190253.242065-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521190253.242065-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +static struct request *blk_mq_get_cached_request(struct blk_plug *plug,
>  		struct request_queue *q, blk_opf_t opf)
>  {
>  	enum hctx_type type = blk_mq_get_hctx_type(opf);
> @@ -3093,27 +3093,10 @@ static struct request *blk_mq_peek_cached_request(struct blk_plug *plug,
>  		return NULL;
>  	if (op_is_flush(rq->cmd_flags) != op_is_flush(opf))
>  		return NULL;
> +	rq_list_pop(&plug->cached_rqs);
>  	return rq;
>  }

Please add a comment about not sleeping between the peek and pop as
in my earlier patch here.

> @@ -3257,12 +3243,10 @@ void blk_mq_submit_bio(struct bio *bio)
>  	return;
>  
>  queue_exit:
> -	/*
> -	 * Don't drop the queue reference if we were trying to use a cached
> -	 * request and thus didn't acquire one.
> -	 */
>  	if (!rq)
>  		blk_queue_exit(q);
> +	else
> +		blk_mq_free_request(rq);
>  }

I think keeping a comment here would be nice, a would be avoid
the inversion of the condition for a trivial if/else.

But on a higher level, I really think you should add it back to the
batch list here, otherwise we're doing lots of roundtrips through
blk_mq_free_request for trivially mergable sequential I/O.

