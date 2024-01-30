Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858913F9E9
	for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603103; cv=none; b=lTTH3BsxUgnJ13DDx5o0jGzipWhh+xLnpLc5HhT8sIWLAqgA4TDaqIiO7J/U5OyziWO4xUiIrQqwcOIJrQFyZ1avCpUaC4q1TehiiDEx0bCQFd1c75Rt+4/QFMoGWhvT8KLvdPEQzAiptZ+UYie8n4q7N6vU0sliDodJw0a84mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603103; c=relaxed/simple;
	bh=jmHU8LtALvJycorobiRkDffdVcefZp0gDMXqGIwIU0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1F8fKqz1cE4nblC9SXHm6Wq2y9jN7DGYNBf4p51cAaJp7s3275W2DlPEE+6sqzGMdLbaCrhAJBToOxAoSqOXbcxPTEV+2y+AcgsVYs4INP+n3+IH+Yb4B/DlJEmHMI11bPPPbtgDMmj8QHaF5TzM3IvZv7uw/HE8RwlXmx+Nyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jHvUoduq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jHvUoduq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jmHU8LtALvJycorobiRkDffdVcefZp0gDMXqGIwIU0A=; b=jHvUoduqnCOauqN/mcUJMuhOk5
	gRbCUJtVTmOKzgbU0tmbeZMfP/VhqDv1c59T0E75iZ0IUo+KQbO2UoQD6muQY3y8+XrDW74baOimY
	jCyt4SGWqMj6SLepfaLwLLRUr4CYDxWg0+0cXHqUKrnj4/BA/8FfsYkyDizCsfaXxjuSTAhFadk6p
	NPTlZfzBfUho0d+xt5hsj+gED9aQX7DuMqdhlZ2rfBsDk+UgPk1p6RkoxTwI7UACv6Uv7Qamdcwod
	uxwQlm8YyF3Ymfo1Wtc6dUupXkPOhHDFPH82u96yHdF8FrbvXS2ZV9ZqOfkbquogeqxxvVktHC8Nh
	BRemcUCQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUjQU-0000000Fh7T-0Mnl;
	Tue, 30 Jan 2024 08:25:02 +0000
Date: Tue, 30 Jan 2024 00:25:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/1] block: optimise in irq bio put caching
Message-ID: <ZbiyXksHZjJLrTJ-@infradead.org>
References: <dc78cadc0a057509dfb0f7fb2ce31affaefeb0c7.1705627291.git.asml.silence@gmail.com>
 <ef594ed3-e9b2-46de-a729-b0de03b92c28@gmail.com>
 <ZbffN7htVJQvSsZI@infradead.org>
 <5336cae7-05a6-40b6-b8c6-7586b741bea7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5336cae7-05a6-40b6-b8c6-7586b741bea7@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jan 29, 2024 at 06:00:28PM +0000, Pavel Begunkov wrote:
> How come considering it's jumping to a return? I can switch
> the bio_free() and goto blocks so it's a jump forward, if
> that's a preference

We generally jump to the end unless it is a loop implemented using
goto as that is the natural reading flow.

