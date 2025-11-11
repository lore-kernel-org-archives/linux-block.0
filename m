Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949B230FC15;
	Tue, 11 Nov 2025 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870245; cv=none; b=cknZahS4TOPaCgUluvf4qpl0id+/X9OCFPCLcf4k2o8ySDROYJAgsB4GaDPwg69hXit2gdK4iMqxyIhXNImHQSsvqMehF/EEho96r/U9sIBzR+6Bq7Nsg3UW61wiAnSTi+FZmcrqwo9uoJseG1RPnoqobf23apaPj6iPU+13sTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870245; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coVEpvvqCbVW7iA6rYUL7FylFmCEAj3z33+zGYgc2k80NvPzwnwNE8kIGn6yTOkY8WmDPq0b72jv2/l9AlnE7+MzBSkRNcUOXUiTSU4wJNPQdfmHzu61vaDBNtl8HGUiXCPVdrUeNaQoeXXEMh+EIO3gMCGtE1LxuDh5bP1jCi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C53FEejr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C53FEejr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=C53FEejrDrI3DTYLMmRjMqTK+v
	dCWwRfDTfVbJKBC98Zlg7FXv2GhAxh9RINZOnVuoOFFjIgFO2+u2O7HvdUy06mdIBTe3G5femdHgX
	fmOj2UfgyIVnyMbYNkWKMiCFiGPuFIg8MntHfxqdVcvRk/AB16YNP6yh9JLuAcrjbDV5nfPxtNSpr
	Ll/pNmf5YHAlFIXslPU2ObG2/IILjuXcGzU+dKknFGqh2AUqSa91S/+T6qyEHUGtkyJ9R4JBf2CZ+
	BsSGL1QF5DnEX1HJaIk++e3ea++rJBplp0srf14H2QDVx3mM9Df5pAXagzBsldA2YehOLqad6U+SB
	CXD8dQMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIp51-00000007IHL-0eKD;
	Tue, 11 Nov 2025 14:10:43 +0000
Date: Tue, 11 Nov 2025 06:10:43 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq-dma: fix kernel-doc function name for integrity
 DMA  iterator
Message-ID: <aRND42us1y_uuhUm@infradead.org>
References: <20251111115810.2320857-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111115810.2320857-1-kriish.sharma2006@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
