Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F909537E5
	for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732517262; cv=none; b=gZPYIZ5u+lZpCg1m84askBMJ4arZnksrEq+QwH1upcTl8iOZkh/E2iw/WQSVQM2H7jKz/s7sq+rTDJN5oQCAn4oRyhh+SXaVi4UmZTUFEp+eS595qJMsPNGzF+X0wcLsjtLGDQTtUVrufn73c7ljUYzQNpKQz6P3dtfDdvIe4S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732517262; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQ0xH30rDtWmOTq0DcluWR+gJmRXhRQVe0Ty+ofzi9NLC4vqGqvcfxJGQycnsOZYDI/bNFpEyRnl/Y/MFrOOqr/5NPB9ROuQws+zjVHioAzdAZ2u9zpS4DOWQnJboxujEh9KgiDhUvC0qIzzAsA31jemXmY+8LSCGqYYL5epRvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6AA2D68D34; Mon, 25 Nov 2024 07:47:37 +0100 (CET)
Date: Mon, 25 Nov 2024 07:47:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
	chaitanyak@nvidia.com, yi.zhang@redhat.com,
	shinichiro.kawasaki@wdc.com, mlombard@redhat.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCHv2] nvmet: use kzalloc instead of ZERO_PAGE in
 nvme_execute_identify_ns_nvm()
Message-ID: <20241125064737.GB14937@lst.de>
References: <20241124125628.2532658-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124125628.2532658-1-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

