Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E0013D53B;
	Mon,  7 Oct 2024 05:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728280420; cv=none; b=X97r9o/+3f05aVfzUN07VLtAx9sT9+XkPRuSoL+UiZCR3Bl/BqWLr5kVkzIdvIBKU3drL5v6LhLAgp1Kqk+awYtDvNAOd8nuHmOrMGl9io3+nEV6Gb4a5puVYJNdvC5/O0rA2qoBxym6P4R1PpF2nT2V1pEwI5QAMkPbqFepxKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728280420; c=relaxed/simple;
	bh=GTpbf4PnAyXDeI3xinJbGc0eBdWuYPahwhyGvKUhBeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjiqzABNUxrO9MjZiOpKVtxJ964xGy4zq2ap94hT7bJzAUf3z5uvsVBmbe6kWu+VIUYlfSwZcD9JThtwlA2sbztgRxgSjHg5Y+gLX8p/j7503pHpmk8NXf0kDV8MfR5OWsdWWZ/uDkWMxO+UffIvXkdKsGyeayd1MquQDg4uR/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pbdBrQss; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pbdBrQss"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YD8W05k8R6wsNrg2tPyH38WQ94pLhtkdK81iHeu5K9w=; b=pbdBrQssbKy8NWS3aSqnhtHkdT
	2JYE71X2EKzQIDxOnBXRKyOzbVsJlDpv6d+nm7wtQLw0ydvFYSz/Ww/IWTD+iIqbc3tFYUBSygRzh
	FnXpeuEbXllHFaBvMScxYu6fblYtIwmHBD+VVgV917NkIvocmx9SESt5CVUBQ01eJOpNNSiuD+jrw
	7dEqiNR/z8AfMgJ+j154Zcy5dZwX9Gp6zubQx054i2HFZLc3REwLSlIyznx8tMQmXMCafxUoEUvnQ
	ukxMTj06fryOZS3MnYteEc2VLB88WgRN3lY8S0chI8Vff6OI1/YYuJubAlTFWiDyccNGDYPpAF6z3
	OIbbRs8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxggc-00000001LOC-3pda;
	Mon, 07 Oct 2024 05:53:38 +0000
Date: Sun, 6 Oct 2024 22:53:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: SurajSonawane2415 <surajsonawane0215@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Fix elevator_get_default() to check for null
 q->tag_set
Message-ID: <ZwN3YvV_j_s0ULhT@infradead.org>
References: <20241004123922.35834-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004123922.35834-1-surajsonawane0215@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

>  static struct elevator_type *elevator_get_default(struct request_queue *q)
>  {
> -	if (q->tag_set && q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
> -		return NULL;
> +	if (q->tag_set) {

q->tag_set can't be NULL for a blk-mq queue.  So you can just remove
the q->tag_set check here and also in elv_support_iosched.

