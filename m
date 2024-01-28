Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313F845958
	for <linux-block@vger.kernel.org>; Sun, 28 Jan 2024 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706485970; cv=none; b=QGRAQoQv4zAnJjqZMhIVG11lXatxo/9n2YQ+vYW164vmZBblrOHN/ntkbsXxSz6XBfsasHQxWIyNnHn7eEt6C6b+owOYnMmAG0ktYgp6YnSC+kApYn+XQR1n6AphKtve7p+wLv1LTpYHgIatobWBDg/quuPEhIk7gWvg47A0IBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706485970; c=relaxed/simple;
	bh=bO0f1yBoW1b7/dO8H1Xs0P3Ka/wbbAw+55nyWUPYe0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MGkZJvz+gKuP9uoMAoXhKxGZivfGYjIedbhhaA5+BsrTKa3ECblvcwaRmhTi8vzQ/e7tXOyVxiS1x9xRRj1kUVXJJ4zX0BhI7UE37erXt5b9+pfe0qCyu95hfyATsBiCLfgsTq+RN5fdApUqw2Yz6oBzDGqOx1jGazsLEcKs+9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pB0hCon/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pB0hCon/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3237AC433F1;
	Sun, 28 Jan 2024 23:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706485969;
	bh=bO0f1yBoW1b7/dO8H1Xs0P3Ka/wbbAw+55nyWUPYe0Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pB0hCon/Iff38uL7oD9iipaoEVdE4XHT4Oe6Op0j77gTE/3QIo1JMmPclUhMAm3wO
	 +DEmP+i4V+b6dzggW2YuJU2fWDYnwiEEd0gLxTia2fxN6btucUDe5FMw2dKEWExaar
	 ZH/2T6X39Om7UbQRYdMfyGZQgczGbVlUIC4UOstMT5qGUQQZze16QucAd/6xyQ6Ave
	 C8GAi2wRgfrpEihawEYoZf33YKqn4SgZErDBCEELeIVF5NTOw7B5bf+GnmAiXprnKT
	 9NIrvaj4ZDi/lHsH6vIIrWFBf3Yu2vG6+Konvbl5Tb1YkhXzFKmuxltTI0jfkhr0ab
	 TrHixkUNiZj9g==
Message-ID: <50fbe76b-d77d-4a7e-bda4-3a3b754fbd7e@kernel.org>
Date: Mon, 29 Jan 2024 08:52:48 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: clean up blk_mq_submit_bio
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20240124092658.2258309-1-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240124092658.2258309-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 18:26, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series tries to make the cached rq handling in blk_mq_submit_bio
> a little less messy and better documented.  Let me know what you think.
> 
> Diffstat:
>  blk-mq.c |  105 +++++++++++++++++++++++++++++++++------------------------------
>  1 file changed, 56 insertions(+), 49 deletions(-)
> 

For the series:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Tested-by: Damien Le Moal <dlemoal@kernel.org>

I actually need this one as it simplifies the zone write plugging I am working
on (as a better replacement for zone write locking).

-- 
Damien Le Moal
Western Digital Research

