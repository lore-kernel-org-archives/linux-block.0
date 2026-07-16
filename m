Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0433DA5DE
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193815; cv=none; b=UMCbGHnecGURKkbbnYLfDVOLiKzG7aGKuI56rK5If8oPlIWsaUopokASGxSfA+RSQYgb90gr4yJt/ZZHwtJIs4Ha7fe8J39OUao4HEmVqZMrdN2xRi9aHN9vHsrAHYGwc/wbRCIYLcgYZ4zSgn9N8kb0MFMgSaprqDG84TR7fgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193815; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b01neHgRlUZrwywLGZ1DrQcGxjSaXePJoyi5T4hE2q4stMx++DzNSTCNfkhrjUWXnN4PVzl5yMUXvRiQZowzot0HdiUaqcSB5LJYQ0Anue3Nf+qG5OwnBKkthfUf7uLikMU2KA2ZvjxZthvrBerH2yOIebHE5xtKHdVEPdoRGIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tlnquTJF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tlnquTJF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=tlnquTJFKON47kcoszzmrdk7PR
	jVMRbzoVpY61qwHsBd4f2guiPEH6DXApXP+CTGcyjEnOTgqnjkkaD+1qjzTAPJYU86bnzSK/Cj0ae
	ySl9OKMNG0/K/KPE7CqfzzyWaPzRvodcrWdHF+I4eF+HSgPY6qjYnfUvQ0FFSIZBZrfAqnOjLDHpN
	Lk/LWnLO6CJ7UydlP+RBZLnQwEtMR47fLYMFSJ1Bq1BfBuV27rCtSjc6nDAtW4znB8Sd1TVicCNl8
	SpdUNkYH1MFoweHjVvdzv+w7j1vIzBvAFX6Fz127jZ/m1vrKohurh4Qpvr37dLD5qGzoFwgIxaclz
	E3BwMC7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkIJa-0000000Gqnh-0fy1;
	Thu, 16 Jul 2026 09:23:34 +0000
Date: Thu, 16 Jul 2026 02:23:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jackie Liu <liu.yun@linux.dev>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: free copied pages when blk_rq_map_kern() fails
Message-ID: <alijFlJyjLXSLny_@infradead.org>
References: <20260715073518.96042-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715073518.96042-1-liu.yun@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
