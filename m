Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5381C1BC9E2
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 05:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750915454; cv=none; b=F8+I54WRTt0/bOcCnMxyfNCawOHChkLT7y91EUb2QOaIVbJkRuCyGYslwysPUJiPwn5NAz2ZxOFm7xOV00onZ7s1guyLGKPoXMXNpt6o5jo/AVNKKfvAP0L62HI2WW3TYubzdIoKf4DdKB+dyGjG2CR0mHqP4Gl0wJxwGsBH/c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750915454; c=relaxed/simple;
	bh=3D+fUxUolpaqSsCJOydvmNJ08CWChTeH4GGRNaQm6N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYvTyLRzwfdofWzdKrQm4LeqLSLvXtiWvqffK/Y2/aUKRlBgkboT+avadZld3YuRAGlnENcf1ziBHM5fDtSL2FLx/QmNlLdqF5gO/wpbKV7nsMxbxbiNgWEXQRIZ/EEmlxYTuu1u87/lgkk4ittfaa0M8mYd1KAIovpu1Wx3hNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M9s/Waww; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M9s/Waww"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rL2WU5GcVIkaa/Y4wfoSt6XRVx/aLCAsTtOeCJ2AuFA=; b=M9s/WawwuDSfaJQny0Uspb/ud0
	yOc5j7GbL/GKY6vsp7ZUEm5pBLt3xF36GbzA5xYziSlU7Gsso1LUUSMchFmO/dkQRtKdGMKyiJnqf
	3/55QIYGRAFDfmWpNWiTpshhBshqvO3w21CAsuOo10pJ292rWMzvuLPojtmbbjf/inyo/aXPAGA88
	ZMBEq8dL+ZgS2+YLYlW+ZHWKsm4CGzXo9hFt4+fOaearTrL2eIij7iZr9jBWCp/JYD7xHW+7tBIQP
	TCx0mYWHfgixAv+Mpp+Xd8IL0XOE6gYMeaUpUObzAQEq+xtCvjgEqbbrPVd9nRi5tBCALE//rfatJ
	afoXY7hQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUf5m-0000000Adjy-2yUH;
	Thu, 26 Jun 2025 05:24:10 +0000
Date: Wed, 25 Jun 2025 22:24:10 -0700
From: Christop Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>, Keith Busch <kbusch@kernel.org>,
	Christop Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/3] block: Introduce the
 BLK_FEAT_CALLS_BIO_SPLIT_TO_LIMITS flag
Message-ID: <aFzZetTrpv1wXU5t@infradead.org>
References: <20250625234259.1985366-1-bvanassche@acm.org>
 <20250625234259.1985366-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625234259.1985366-3-bvanassche@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 25, 2025 at 04:42:58PM -0700, Bart Van Assche wrote:
> Introduce a flag that indicates whether or not bio_split_to_limits() is
> called while processing a bio. Set this flag from inside
> blk_mq_alloc_queue() because bio_split_to_limits() is called for all
> request-based block drivers. This patch prepares for modifying when
> __submit_bio() calls blk_crypto_bio_prep().

I don't see how this is a good idea.  bio based drivers are a thin
abstraction that the block should not know anything about. 

