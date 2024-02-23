Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB1D82D80
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705183; cv=none; b=R6P16RhcIikxTRpQ6i+BxyZjWHQD0JIQ+XHBhzZNVNcNrsqGqlZOgCUak+H5yJZEele9YG0h5cAT8kAq62Sab2sN8j7xkg0cTQLq5hGqu6n9NKSoQsT9O+lebA+4iVx9mrxGUNMKZneYSM22axA/3Inf2hcw+LAnkx/8YXQV2jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705183; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJZ7SJeDA5eFA3yL6sY7WDfrWPeBOWlrU7DsQmAEItPT8XwleP6qqxc+6tpYO/aCdSQYwoSdDU4zukMoRDWsBk4X9qj2SNwZSRX4YRjFp5SRlZ0ZSoobNN6uyvuiTqvTDo3sLHRMXTHaSUilNxVNPQy/ePvVaxEwPLmGQljGg1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uYyLiW7K; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uYyLiW7K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=uYyLiW7KXJ/n8Z+J7+1nIsNKrJ
	QEwaXIdOCRphR890j1yO2NzPRelEvIY79ahoxK/MJzWXX6odo00UuwIrEYmyCYO7MyTfBPbUGKmdj
	s2g327M/hib2JRIbVKwqpgHJe/Kz/fg9FL39DtPqeXc7tQ5DqK8XHX9qibd0depfBz+y7Eobpykp9
	Jm3EyR7Rd7SwghQhnM44q1G6l62TaD2RKpA4KoqcfLDsHVbDwRkkR+SzXj3wNW8BrsAIuuS/fZ8pk
	m/9HjfMVrnKC50k/R7C61EqIS7gyBgxQnT8ZsZCeiHSuHyBOG4A7B9nXptaoKCx+ulzwFehKpbdDC
	i5mz3LOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdYGy-0000000ACYm-3leG;
	Fri, 23 Feb 2024 16:19:40 +0000
Date: Fri, 23 Feb 2024 08:19:40 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.org, ming.lei@redhat.com,
	nilay@linux.ibm.com, chaitanyak@nvidia.com,
	Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>
Subject: Re: [PATCHv4 4/4] blk-lib: check for kill signal
Message-ID: <ZdjFnN6mN-rFHkL9@infradead.org>
References: <20240223155910.3622666-1-kbusch@meta.com>
 <20240223155910.3622666-5-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223155910.3622666-5-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
