Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B9018CC12;
	Tue,  8 Oct 2024 12:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389180; cv=none; b=WgsiBjbRph92/slTET69fzD/O1K4GtEt1BIOHlHyBtAqDYB1bs6oDHJDTg6SNrU7+66+iSOcHlh2MLQiM44dJi0TOCz/8ErV/MclQTGGMU3P6uphQvdARCOXZIVUjDxnaPZycNFLc3EaPJqEMCZ9fHQcVb/NNbg9/3w22oIrlZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389180; c=relaxed/simple;
	bh=+ScpvZ0QlXeAxwNbtaVwiaX3zMKD+MJlTzqcwjHPd+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfpDRi1Q5rjvDWmhn4ZffGxpjjDZpirxI4fpWItqsAvgOQN14DHQlllwa2JzKavpnq7unFbOzn1mOQ4gSUfXT2X7DJfRTPz0aigKor3ggm847gS7gfy+VjH5MPTghJeOYyW5IrAECQnQUC7hxxBR9gbbz+ISAsZSDmEPdoF+7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AO+O5Wu5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AO+O5Wu5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0tWy0SL76XgWSi76ucMclQdZ5OChNy3Mlnv8Xk/2uik=; b=AO+O5Wu5i3+CiGysJHU7d1V8VN
	qxzMmxQlBXSaUXSscR/ZJdFzg5jGCCcpa1V09567ZclIGoHq9KCwBEsWVqC1gEjhCJZwS559hXaLZ
	1DZyMupKv+eh/CBKOAXnfcslZMn9I5qUsiDuBDsnasO74UJu5vvjtU7Wj/adVHZcHiB9/qGMET2HM
	gkG0WUNTwzGGdjz0zgX2gSzkRzlbShtL2Fi56rL7L3KUhsNkE+ht87abCQZBJ46+TTD2LI8xJS9NF
	oOyAh9gTq2oJIFcmNZsfum5BIXiVpwFVK1tVBUgf1a007OGLhhnf6dVHQUlG+HRvPNMzd3aYZmSpw
	iTN/AkhQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy8yp-00000005k6k-1WKG;
	Tue, 08 Oct 2024 12:06:19 +0000
Date: Tue, 8 Oct 2024 05:06:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: SurajSonawane2415 <surajsonawane0215@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH v3] block: Fix uninitialized symbol 'bio' in
 blk_rq_prep_clone
Message-ID: <ZwUgO-ASFxcSa1b6@infradead.org>
References: <20241004100842.9052-1-surajsonawane0215@gmail.com>
 <20241008120413.16402-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008120413.16402-1-surajsonawane0215@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +		struct bio *bio = bio_alloc_clone(rq->q->disk->part0, bio_src, gfp_mask,
>  				      bs);

Overly long line here, plus now pretty weird positioning of the bs
argument.

Should be something like:

		struct bio *bio = bio_alloc_clone(rq->q->disk->part0, bio_src,
				gfp_mask, bs);

