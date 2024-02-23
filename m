Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86403125D9
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 06:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670791; cv=none; b=WKpOFwTPxFitTucPajlnZsfgrC2XJV/MlyFTLs5Unx1VLKvGc0x7bVQZAMB+nHsHizbl6VYuaW3uLlPL64JdtGN2x5MlotoXvxCU5vODBny4Zk+vClQ08lXMG4XmDa9PvIR+C/NJalNSAKOa8JhiJlweooyBumVfZun6L6YTXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670791; c=relaxed/simple;
	bh=iFf8WSAcsrelP5Dabc4N2QSsBhxwT56IYznykvV3CY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCx1NNGdHDiRyVMw7BqqvekoHOtPC/LQcQ9olv69eZxFwOkJ7OU4HH5qpBPshqFJvw3AdNZmVcBjp2rSwolx8sXLyxoEODeV7/v7so8p/GAaY52DhxNEHlbIwnI5US52k+4sn7okSvPcMQCG+fdk6e7zTJKlo/Vj8ZVK3j385zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PZ5K+DXK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PZ5K+DXK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hu6Pccwc3mkvsBw5QwRPDnL0S7LOdTpOIjsyybZd2bg=; b=PZ5K+DXKF5DvpKhWPeVHVf+I9+
	bctl/xSIX2pnWJS5TFZtFdu/1EbonymRGW2rZgKAD7hLqi0eghvoN0+0zSPeO2D45c5ol6WcK0b4R
	DpeItVfGUI8s9L0xFh7CQmDB5nGKxxJWJBtdJXo+SEOHUoaZj/pWaf91Jti6uTGx5TZQaj+Ie6WB3
	vKXDx2E2g02dWrlXMNrCs1fky74l3JkPtElIr41MdaXCpoDent+DdWb78ly6FZ78Dob1GRxQwPplH
	DDicXZI8vNBmRt51tXr2hKH7Ulls8HhMk9PFdnZVLGUiwNalZLN+PyqADVJXRO23oI+j7obIah04M
	OAdeVymw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdPKH-00000008DIo-3HQ5;
	Fri, 23 Feb 2024 06:46:29 +0000
Date: Thu, 22 Feb 2024 22:46:29 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.org, ming.lei@redhat.com,
	nilay@linux.ibm.com, chaitanyak@nvidia.com,
	Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>
Subject: Re: [PATCHv3 4/4] blk-lib: check for kill signal
Message-ID: <Zdg_RQ1xeu9O-K0Z@infradead.org>
References: <20240222191922.2130580-1-kbusch@meta.com>
 <20240222191922.2130580-5-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222191922.2130580-5-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +static void abort_bio(struct bio *bio)
> +{
> +	DECLARE_COMPLETION_ONSTACK_MAP(done,
> +			bio->bi_bdev->bd_disk->lockdep_map);
> +
> +	bio->bi_private = &done;
> +	bio->bi_end_io = abort_bio_endio;
> +	bio_endio(bio);
> +	blk_wait_io(&done);
> +}

Without seeing the context below this looks pretty weird, but once
seeing that we're waiting for the previously submitted bios it all
makes sense.  Please write a a good comment explaining this, and
maybe also use a name that is a bit more descriptive.
