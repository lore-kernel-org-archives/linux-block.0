Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4B214A09E
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 04:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409105; cv=none; b=H3vBrvCuWWzoE7CAG8H5L8iZuQMML3bGT2EN6LF/wKsb0LdRzTPT86p3T3NsVhHPx45HRtPMsNB7SqhcS/M0U54/q3rHgMGRyAdgbGCiSoWSAeHzxL0lR/Ay5utrttKhZ1mo/fPzObchGzFRDo+KQBwXlAR9QslXe9D5wxtSPKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409105; c=relaxed/simple;
	bh=aN3wuaaLKiR/YzUEvNo3nhkAQs4Z/rS8DGbFflaxyYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNUA43cOg0VAZlDwfsRzzfC3PiKwtjSlNkXNpgccEpZywRKRFCouqKtHL5RWOSPdWLp/QmQ/BntKiz51HXR0ySbi1W/kJLJg6KK+Ph2PbzM6XQNhT/FGe230+8jgfU44gK8LgbZQMDq2VrYvO5ki137FyYL1hOPm80C/F84v9DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 05A2468BEB; Tue, 17 Dec 2024 05:18:20 +0100 (CET)
Date: Tue, 17 Dec 2024 05:18:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 2/2] blk-mq: Move more error handling into
 blk_mq_submit_bio()
Message-ID: <20241217041819.GB15286@lst.de>
References: <20241216201901.2670237-1-bvanassche@acm.org> <20241216201901.2670237-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216201901.2670237-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 16, 2024 at 12:19:01PM -0800, Bart Van Assche wrote:
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8d2aab4d9ba9..80eb91296142 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2971,8 +2971,6 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
>  	if (rq)
>  		return rq;
>  	rq_qos_cleanup(q, bio);
> -	if (bio->bi_opf & REQ_NOWAIT)
> -		bio_wouldblock_error(bio);
>  	return NULL;

Please turn this into:

	if (rq)
		rq_qos_cleanup(q, bio);
	return rq;

Otherwise this looks like a nice cleanup.

