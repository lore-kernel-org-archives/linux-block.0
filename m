Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916521C5D57;
	Thu, 18 Dec 2025 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766047876; cv=none; b=X3mAF7OtRmxSgt3IpPU+nLW8kyqIliMMxxq4JT2Iu8PG9Ps1TzCnqCAiGUR7THNZ4UjaibU36j/LNPX22pM8caH5xc0Sbl61GjsFnSu7yRBEEKwDUZlnLKCj7N/0NxuC5NAv1W4mA7bKh4zQ49lZIgASOAItykdFpLkiNw/nuvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766047876; c=relaxed/simple;
	bh=56Seml4Ef12S7CTaQcFC4CLScg+lXs/wpJ5AR54xjiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJUulgojuEicFm03+cv+YABNdG1lcmn4WEk3IxG0zfMqTc2ZTLWt3PJSr/R1KPYMVFDpdCyxnn56qnZH6MEgZkBQi8fp2uUXaMbGB00TKrbzBmZZVXpeO6ESMpzxn2M6tjBeM2Y33AMO9uBFNJT8LX8xmJClC2JuoNBZyQHYLQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UyBQA6ws; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UyBQA6ws"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OlZNDl+T+oBBKs0mVFiUwWGKXtBykVXfE37BjFm/ncU=; b=UyBQA6wsjxfXN73qRapDXj5O7c
	OpwLqKENF1LzTLDjLZcr+krzNq0H+gDlP9FxLkvV5bf+NZOOc79yOoep/+CPNx8Xgj1kHQ7kZHZY+
	Phmjo30llo3Q9iEBxvjKHmQ15xKPpXWQ4raQk3BlJAmB7PhNCK8zYoYUrm9tK3E/uFPWig3YB4IVX
	jCpzaVY5V53tpy4srwb1+vhBX5zdL8mWW3UFlHL1eYPesCY0JGa1kHhenFyVKFB9Nwlmtp7nwhFl1
	M4CVpwTqy6WzJBh79Fnm6UuaPAtjP2AF292mpLxeneQPkdbmD8kbrs/FO2EylNY1FAGzBJG26BfTg
	jD3dTZFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW9j8-0000000864L-0XsK;
	Thu, 18 Dec 2025 08:51:14 +0000
Date: Thu, 18 Dec 2025 00:51:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Michael Liang <mliang@purestorage.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: always clear rq->bio in blk_complete_request()
Message-ID: <aUPAgtbWVql9SkoG@infradead.org>
References: <20251217171853.2648851-1-mliang@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217171853.2648851-1-mliang@purestorage.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Dec 17, 2025 at 10:18:53AM -0700, Michael Liang wrote:
> Commit ab3e1d3bbab9 ("block: allow end_io based requests in the
> completion batch handling") changed blk_complete_request() so that
> rq->bio and rq->__data_len are only cleared when ->end_io is NULL.
> 
> This conditional clearing is incorrect. The block layer guarantees that
> all bios attached to the request are fully completed and released before
> blk_complete_request() is called. Leaving rq->bio pointing to already
> completed bios results in stale pointers that may be reused immediately
> by a bioset allocator.

Passthrough commands keep an extra reference on the bio and need the
pointer to call blk_rq_unmap_user from the completion handler.

