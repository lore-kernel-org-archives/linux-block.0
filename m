Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDF03904CB;
	Wed,  7 Jan 2026 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800201; cv=none; b=S7fHzlGU5ld7rZSidL35jSdjB7ZcqcDdc0OxsBPOMca/YLl2k/+PwlX5V828K7eirgtSzSamVbcjy+8EbmbNj2OO5kr9aSDcy03aFNTPLxEwZBbkYmk6zTneew5om1+vLlUnMM3EO/S7o8QHsaFm+wPaQoQbYZDqgd4944tELu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800201; c=relaxed/simple;
	bh=LsdsmqrfYXEoY2v6SHArFNaOnPqmJYQopIP9RzqLcP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqFIPZqHYtgdwC+WDq8Fcu2HHPzgEpc6J5UUhkTYvdO6lu1aDwIA5JS1OnP49KOCdIbaiHKvPWR1ZF0F0sAr0s4I5Sq8i6krjRb7MeMx25ANWpQyeTvNOf3XLaAcegE07Ii7l22Z+JZ9LqZW03DNRjuYpWSu6nCNWmFvsLRMboM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 60E48227A87; Wed,  7 Jan 2026 16:36:36 +0100 (CET)
Date: Wed, 7 Jan 2026 16:36:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Leon Romanovsky <leon@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v3 0/2] block: Generalize physical entry definition
Message-ID: <20260107153636.GA19836@lst.de>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com> <20260104151517.GA563680@unreal> <258e49de-7af3-4a35-852a-8f26fcb7ddbd@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <258e49de-7af3-4a35-852a-8f26fcb7ddbd@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 06, 2026 at 05:46:21AM -0700, Jens Axboe wrote:
> > Can we please progress with this simple series?
> 
> If Keith/Christoph are happy with it?

Fine with me.
