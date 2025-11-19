Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A41330DED7
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 05:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763530909; cv=none; b=hXBMCVeCfi23fq0Ej9bUDMKS4ppaPU4M8ah9WCfhHKHhanjKiDAd1JJZpinvUnZY3RZgR0vkvKbbY81P2nTVHWyYWdoRFajE0IEr0dR0PeV50hR1whFBNbHUHybHPxdnQBVsoiMCO31N2O0Jsgrc7RXRrMF1ftvGjqSnnRsed04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763530909; c=relaxed/simple;
	bh=E9LDpxaUiKgQAsW8+8nGY0SfnyJlUG2gKjKExtYYRgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiJ3tLGn5FpvZc61wO4/7vsat9gF2t5Ji2DyTxvFsIbYtLkjuvZlh7X99J1VBCvc2z5pCgfFik80QaFZTSTbjw3gkjrPh+UQ9T0sUSAbbzb0jj/FE343iJL89k/Njm4QXWSLcHBlvkFecI6m/JqsZikBkijyJmduG/kXfBBMshA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=olHshNZw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="olHshNZw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E9LDpxaUiKgQAsW8+8nGY0SfnyJlUG2gKjKExtYYRgE=; b=olHshNZwbDnLbsBsruRiBkB7b3
	QJ0NtJv+fuXRuexR63M5Hp8ONW77u4rXM19AX0E2bdJiVmGjGEd7k7LAaf8imtw60Kw05naqoJ4zr
	hF97Y7fB7i0Oi/BPVIL8kXOiC+Hsh1yeXgaDE2cVdHASv7mq7COysHENiDWN37wK5grXd5DV2LeKA
	e764uxAdnih7nOSkmKN8D3wKS2jPYNBoVYG77jOnuZIEI2JgBwqUXbv21u/EAhOcWmkoNzVlZSne4
	b8DSqmFW7qB2B35Rj2NQmRp+w0pki2WGdZ5KyoEVbXSk5fClyIlhA2j3ZiPbT7ij0ZeyLP/sFWrXt
	Qj7PS4XQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLawq-00000002MYA-0CzA;
	Wed, 19 Nov 2025 05:41:44 +0000
Date: Tue, 18 Nov 2025 21:41:44 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] MAINTAINERS: add missing block layer user API header
 files
Message-ID: <aR1YmE-v1jRwmQl6@infradead.org>
References: <20251119030220.1611413-1-dlemoal@kernel.org>
 <20251119030220.1611413-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119030220.1611413-2-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 19, 2025 at 12:02:19PM +0900, Damien Le Moal wrote:
> Add the missing user API header files related to the block layer to the
> list of matching file patterns for Jen's block layer entry.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

