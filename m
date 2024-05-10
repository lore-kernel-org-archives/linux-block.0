Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB3213D252
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379965; cv=none; b=WvkGOFaWGMXT6NTKrWO/NikXAaOGW6tFt7egxuIG8nSNXcdM7MnQcV2Z8qQEEF5w/nL4LwSR8RltZ2fzaNTUfLpPcLHkecdJnv6mZg5On5aX/i7e/5zYYppF7mLZD0BMHuSPNLpEvPpFEKow0EDMnatOfgQ+4ool+f9+51pmIx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379965; c=relaxed/simple;
	bh=5ncCUehpw+c9II2Mi/fn3Jk4VqQDsYfVKekFisijDGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCfbVuWlFC4dw/6ytA1tXlNStPF7tF7IxnhLk5GX1gmmSswSwtmu9cmNkCXFywacfIgh2BP6MNJMWEziI5mpzLNKxqdVW/XsLDlE0Ji9hTz4k4pTAENIQdihV17kpvlZadR2tD5gnPcZa/DeqE3ezlaOByLPkSmo9nSjDxHNITE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MHxa5dB+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MHxa5dB+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mDWdy40phobtDo1EYqidBkOvRKcJzKGMzhog4C78HJY=; b=MHxa5dB+sqNtijGkFw4AHM8W4V
	Ddagdkvy3FPcGX2jB4RsXpDirYH5okbQr+z4gYtCZy4iANrrAJFQZM2ZzA+pUL0tPEyDI0XFMZCDr
	/l/jaaJCIMuzMCGjtTa2Ta+kMs0dW2Xnx1gLUrsKWwbkv231ptMD9MxDwPvVEHPNRpqXI2+0qOblU
	oMWecHC92bU5Z22yYjnp+T5RMFK9FPQVqjZ38tsCf1xCPdJp8N2Z1DgQoKXwvlzdFHrr/x7asCSyL
	WjKmtHp6qxkw0EztiB/HY8yKqaqNw3EZ+Thstfbgw/kns3PFDllJkj9zk+XdZ/TyIXOOB8TF7A7Kv
	y48RNoCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Ygh-000000044WW-2w7P;
	Fri, 10 May 2024 22:25:59 +0000
Date: Fri, 10 May 2024 23:25:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/5] block/bdev: lift restrictions on supported blocksize
Message-ID: <Zj6e95dncIn-Zrlh@casper.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-4-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510102906.51844-4-hare@kernel.org>

On Fri, May 10, 2024 at 12:29:04PM +0200, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> We now can support blocksizes larger than PAGE_SIZE, so lift
> the restriction.

Do we need to make this conditional on a CONFIG option?  Not all
architectures support THP yet ... which means they don't support
large folios.  We should fix that, but it is well below the cutoff line
on my todo list.
