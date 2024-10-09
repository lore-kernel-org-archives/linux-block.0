Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8496C1714BF;
	Wed,  9 Oct 2024 07:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728459014; cv=none; b=ku20yzq0/QhwDllxybRVSyWnXPEnT7r/IL8HPpO7DN1NqtFo0JLjtf0zeoyu/S92kCHr6HQSCzEErmAKVsCKBvOaWnWSKgfifCVFrNFaK9bQ2/TaeuTGv3j5eNYwSFvkyMa+Hi2SoQS/movFEMj9VglILW/O4QMJSVmhMp3hAck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728459014; c=relaxed/simple;
	bh=sD77VXVv/pjcG6ysY9JW74SVMfQ9FxEZyaAXx7A5bOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6G/gfny1B9YeYuIIxodZgnZ/qosB1uFX3MxKeAF6wO8vPszGQl8lFpfpoh1zsG6VmwhGiyM8lM/guPgv3pC9rcatzefi94reYoXKLb+rkYNLjb1XZm8xmLw4yWMf3ENF+QNNVUE5JKbolI9atAIkcziVgjbSVFjzvTccc0E6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X/1OjJ10; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X/1OjJ10"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6bniuV+7e4GUhR71+i8cLcynGmgsYHqr2R/KHbOAzMY=; b=X/1OjJ10iUd8tp/aY01zAbuVOy
	Yg1xb3LolvQvaBZCeDh8Mq7WAxjbcEQsyZTu4K/w3mKqwko5PdfzJWKikNLJ+s+Gn962QVMWOwb9C
	uZ1rEf2OlVSnDOgyCA+2JixSxDUhPOHyLntvpvY67nmaN1pRY6oNoCpaOVn924OHes2fA4zB1T+my
	aEOsM/P6xVHsGnQf5nuS2dTEBKKZvgYBESRQWIPsN66ETORXmoXLA8Y6zikZRmnTk5QbkVzUMHnkK
	RU/B7qgJ0KXyzPwqxQxmUq9w179+0U6f6l14Hv/0JLu/tV8lU0Uvjq1FkpGn0j/OvCYSN/KlXHliw
	bmWlY8kA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1syR99-00000008Evb-3T0L;
	Wed, 09 Oct 2024 07:30:11 +0000
Date: Wed, 9 Oct 2024 00:30:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: SurajSonawane2415 <surajsonawane0215@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH v4] block: Fix uninitialized symbol 'bio' in
 blk_rq_prep_clone
Message-ID: <ZwYxA1sfQdaj0Hy3@infradead.org>
References: <20241004100842.9052-1-surajsonawane0215@gmail.com>
 <20241008175215.23975-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008175215.23975-1-surajsonawane0215@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The patch itself looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

On Tue, Oct 08, 2024 at 11:22:15PM +0530, SurajSonawane2415 wrote:
> Fix the uninitialized symbol 'bio' in the function blk_rq_prep_clone
> to resolve the following error:
> block/blk-mq.c:3199 blk_rq_prep_clone() error: uninitialized symbol 'bio'.

To make this more readable I'd usually keep and empty line before
the actual error message.  But more importantly it would be useful
to explain what tool generated said error message, and maybe also add
a summary of the discussion why this function was in many ways
pretty horrible code.

