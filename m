Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D06B3F9C4
	for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706549049; cv=none; b=UB6poN3U7uWRcuZvFYnFai8ieDB2ea99El/5y8ur74GSUDldLS7L3oafcwpPxrusrUtC6Chuna4XBP4bFceXl8z+cJZbjWhRMWKWowfFfXcI9waHryM/HFCKqFh6n36nU/lLEILG7QVopPlQDVkRS6e6SV/ak3Ye/EhtkOvTZBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706549049; c=relaxed/simple;
	bh=TekLeDIvE+nyMHGWVit5kNbtNiJebXIkvh/j5fEtBDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzqhX3TzF5PZrPle7IhhU1G2PgoBI50vgBz+5IgLZJV2ymIIBd5R+U4dhO9/oK7ljBklq8ilXi2ftJU8T1jV7uY5xx/dS5eQAg21jWlVAuaNzUSeSbRtpHzgF9oOUORAObnIZReycUxc4jAKzBnTwIaBTybjfzVUYsl03KW2LfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YEC7uChV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YEC7uChV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TekLeDIvE+nyMHGWVit5kNbtNiJebXIkvh/j5fEtBDQ=; b=YEC7uChVuZ9jEMMerMSWuVjvZY
	oOiONyTkAP3+YXe9IqprZRQ7hFRwN2B83UxlGpE3MkODKY2sJ8CP5vPg9hdba9FrbornPuPvRVxUz
	MeuC/nRKa8YfqdgItYNxFq4IdFdZyJX+EMMKns14kJqSWuBJwEa+qT1Em+N6788DouzqmJwvsVsiY
	gzwufUR5k0sWPeWOi3YMhF/5Z0hWt7eX6UaEiZznBQ9AzYm5j9Hsp6BD6a4GQRtlNaVSXmemq1FGo
	xssEb41IKbIhfN4bFa+uFuBnY0mpq8kD0i8UmfKLpymYcxKtg6QbJjXIJ8qimr9XCwFlnKGdaf3E9
	BVFLWkIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUVMd-0000000Diuu-0bMU;
	Mon, 29 Jan 2024 17:24:07 +0000
Date: Mon, 29 Jan 2024 09:24:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/1] block: optimise in irq bio put caching
Message-ID: <ZbffN7htVJQvSsZI@infradead.org>
References: <dc78cadc0a057509dfb0f7fb2ce31affaefeb0c7.1705627291.git.asml.silence@gmail.com>
 <ef594ed3-e9b2-46de-a729-b0de03b92c28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef594ed3-e9b2-46de-a729-b0de03b92c28@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jan 29, 2024 at 02:36:57PM +0000, Pavel Begunkov wrote:
> Let me know if there are any concerns with the patch

This seems to lose the case where non-polled bios are freed
form process context, which can be true with threadead interrupts
or various block remappers that defer I/O completions to workqueues,
and also a lot of file systems (but currentl the alloc cache isn't
used by file systems).

Also jumping backward for non-loop code flow is a nasty pattern.
