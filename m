Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6C6183CA6
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730982; cv=none; b=MnyBKppzHLJTkvD1xvxW/UJoTeypLBUEjAPHqkIPDnk1ZBJKT6A+1DU4X+liRX8jyxvjc9RHkqxYNISFRoqJBzzi4/2DR0Do6UdI7HoBJeLMpJQo/h+vqj+ZzzsQ0WaCztFM3znTreRm81O9JGFWoI7aeOIdOw1wV7uKIdHAnWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730982; c=relaxed/simple;
	bh=R7fiw18KFaC+ydgxJ99RdUFN4AZj6Eiraj7ACYY5yZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIv0v8JI2DYQfZfC1VOommWWnfTbPIET5Q+S//VYz6fwqfrAGiEQkj/SKVV46k+uGMD0mKlkm7zxCkzgKbRj3gp5jHcsUBN0CirQnUjSCqP9Zp/n548QiaIEOwFllmq9B2KlBn5itNOtG3voI1oxPM0OmF9OyRXu8qwvGkOCjqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sRgDlUB2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sRgDlUB2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R9iXmNo70wFagHxjbWOlzebsUOjkG7VJgtdusCP+k38=; b=sRgDlUB2nTuSJCTLuvTdbpeefK
	CgSP/+eSxWrnM1yzv2yFmIRVE9NhhWykyoFUT3YVAb6nwHCtsiV3jJpw4t85Ha5yYYw4qvSpJ6ZWy
	QMnXfP95V5IWFwYsq/IkWc6jFkhxWyFp2gOtAwGXV10uAwZtXaZZ0CFJKhhDhkRjzn/iR6kv65Zj0
	iCsoVSsY855gSnGz9wPolKbmRuwTN6wqVmzsmCPS0cNvpK+vHQq1i+lwfwr4MqETu0qp61BH6zPRk
	qm1RCCQ5nZRoqbF7RedDasX14+3+BhwLXBIUjmLgNWEyvuwQ+9NQ4YRcD8F6jIVgZsVG+AdwnNqBU
	7tQLdY4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPgxQ-0000000DF7X-1dX9;
	Thu, 12 Jun 2025 12:23:00 +0000
Date: Thu, 12 Jun 2025 05:23:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: use plug request list tail for one-shot backmerge
 attempt
Message-ID: <aErGpBWAMPyT2un9@infradead.org>
References: <4856d1fc-543d-4622-9872-6ca66e8e7352@kernel.dk>
 <82020a7f-adbc-4b3e-8edd-99aba5172510@amazon.com>
 <f4ed489d-af31-4ca0-bfc1-a340034c61f5@kernel.dk>
 <aEpkIxvuTWgY5BnO@infradead.org>
 <045d300e-9b52-4ead-8664-2cea6354f5bf@kernel.dk>
 <aErAYSg6f10p_WJK@infradead.org>
 <505e4900-b814-47cd-9572-c0172fa0d01e@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <505e4900-b814-47cd-9572-c0172fa0d01e@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 12, 2025 at 06:21:14AM -0600, Jens Axboe wrote:
> It's certainly going to make the cached handling more expensive, as the
> doubly linked behavior there is just pointless. Generally LIFO behavior
> there is preferable. I'd strongly suggest we use the doubly linked side
> for dispatch, and retain singly linked for cached + completion. If not
> I'm 100% sure we're going to be revisiting this again down the line, and
> redo those parts yet again.

Yeah.  For cached requests and completions it might even make sense
to have a simple fixed size array FIFO buffer..

