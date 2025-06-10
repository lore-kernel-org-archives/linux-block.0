Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729572980B7
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561039; cv=none; b=TcYcXUdOyg/5Vlrc2FbeLS7yM+LSn0rnqkjtjWG8bikDr0PfCb+ArLsT+nGnqMY0DnUxRrpxckFnoZex3u4WhfexXUny24fphsyAHERx57/Y9Yk3XsU6dgAYP4P+eI2q4jrvFxXlbf7Q5MqfEt15u7jcOgsbZwQwfaBpwSEUog0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561039; c=relaxed/simple;
	bh=BcWdaNn+gD0RBwpLii90n/aNcuaDlEyZunddGwrP+os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lo8Iti2DaUaUIKmuvXsw89v4E3Be8Z8Cgkk4f7e2R82uBBW7wpfW+qkDCFfNXjMoWfyuzvNMpJbfnqePBpPp5caCA6lW2D/P8Rba7xpTY9xHJmJJsG+WRRZJayoy56biMheTNSlY6CS2vyMYgNlBBFJPQs87oyv78Rr6hI8K5Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3A4jbCj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3A4jbCj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34819C4CEED;
	Tue, 10 Jun 2025 13:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749561039;
	bh=BcWdaNn+gD0RBwpLii90n/aNcuaDlEyZunddGwrP+os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3A4jbCjAasEfmRLRMXd0iSqFUKYe8nEHUrtaKb5PX/LJOso/6yFX9hJ+Fs0WEeqM
	 m5X8f3UdOWx3qDyKJGSnY3ch67i9sLaYjBBJ2lXY1roxNK2ljjP8BCEKr4WQYSASb4
	 ffvVBA+R6kA6WAuLtVm6uiyUwXXICTjfMwUxyZjMar4/MzgCCX/ACfOH7kZWoKwG50
	 xPBQDKTw/N648uWwfmygUCQvcGjf6jQeE3lHXDoYURocmGtek6V7hYrnKqJUZXcG11
	 z9Ij2XUMOucMTZ13Kn9eoHbsrRl0ieIVWu9jUp3UtqgFr7tgFgcu6FknnBUHoathV7
	 8R/PfdWe069BA==
Date: Tue, 10 Jun 2025 16:10:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/9] nvme-pci: refactor nvme_pci_use_sgls
Message-ID: <20250610131034.GF10669@unreal>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-5-hch@lst.de>

On Tue, Jun 10, 2025 at 07:06:42AM +0200, Christoph Hellwig wrote:
> Move the average segment size into a separate helper, and return a
> tristate to distinguish the case where can use SGL vs where we have to
> use SGLs.  This will allow the simplify the code and make more efficient
> decisions in follow on changes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 41 +++++++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
