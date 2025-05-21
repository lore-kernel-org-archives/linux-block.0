Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1EC2222C7
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747844004; cv=none; b=rbmdT+Uxhb+vHHENx+KKuybNovnZfwhaRnfuNTFe4UgHvvUJ0CqpwdO1EQ8Xg+KSbp7tzJeqZaAUIvJRXk6dtcUZdRFdoi58LV/deklFpNpNSggvBHNJKvgKVWgBLJACijdSunGxmipZcVkzDBn15kb1JXjwVQCeH5kLVuLMhgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747844004; c=relaxed/simple;
	bh=lPoOgx8R64qihDb4cAMlaD6CYJKuPNvQP6o9vTkl6GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7JGJv6xOS1rdyjEI/Ado1pmEgbRhn9ePmQqKIzhIHnVsmlG1lZrkdvJ9AEg+UgNdcHb7LZMj6/cygDZI7cY+hJSvdpCtRTyiperMZ89XW9FQNUZnO/OeUmqmwLnWY9flZ6T5th4AZSGBLvUTquiaQ1ACkded4h3pBKZMrsZRWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=x32GKpD6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x32GKpD6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lPoOgx8R64qihDb4cAMlaD6CYJKuPNvQP6o9vTkl6GU=; b=x32GKpD6Y/PpkmypZYSGH+dSPl
	q2H3bXANWDJnPectEF2R6/ZSnZypymVHcxnuAh2LKLho/qf/VSJRpkOnzsgOPq2QG/TWEAeuRIHQf
	a3qlEyZ1fqfXcSWE9fvi69bAJ8zSDheh2jS0wDwztUznSRz6ZYCi+mbStq5fRbkWEv5p6bpZRRZtd
	FO63loiOiSQurA3jztDd34TMjpwr+L5qknDba/ThqLHtX0DUn08Gm1TmK0nZ7CX0nBdNX7PyhxrlS
	qCyGR8lLnL9NmK47lXrsTqTgzWEU8FuZ4YYdwQh1fFje1s6F/vz2rGx6VbqYZT0XPc7i64OglKwu7
	c8wzbcpw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHm4G-0000000GR5C-3sAx;
	Wed, 21 May 2025 16:13:20 +0000
Date: Wed, 21 May 2025 09:13:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ye Chey <yechey@ai-sast.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH] pktcdvd: fix missing bio_alloc_clone NULL check in
 pkt_make_request_read
Message-ID: <aC37oAvMagTbRoPt@infradead.org>
References: <20250521123019.25282-1-yechey@ai-sast.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521123019.25282-1-yechey@ai-sast.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 21, 2025 at 08:30:19PM +0800, Ye Chey wrote:
> The bio_alloc_clone() call in pkt_make_request_read() lacks NULL check,
> which could lead to NULL pointer dereference. Add NULL check and handle
> allocation failure by calling bio_io_error().

Please explain in detail how this could ever lead to a path in
bio_alloc_clone that could return NULL and how you came to that
conclusion.
