Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A6D17A305
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561344; cv=none; b=oFvSRL88jf843jnFMnft92oThCYNObT2B8S5JgF52iNuwKbH0wfjhOdZk5WmdfAwh+2YxFs6ZR21sRnfnjugbgZAvbjkOyA6u41Q2z05X9NYXMc1avZQrSBRY6lDnKJ75xe0CkP/Cb+i2hoW3rxoDsOq8p5LhcYqfh2t6onG45o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561344; c=relaxed/simple;
	bh=KqhRqVFkbAu/zx0zq5YPd4/MLPzkapeG5ZRQvM2tBbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+D3phBQgqsV75nEHH9xhVr+IGCGTtaY71jJfDez/fK9vKHK0dyziqmyeFzAcZy5BokFUHqt3bCy6wpS4lpT5hMWUnyb10lZLZjwZs5iPEAPhOD9ovYNP38TibfRoSSbKlxoobWmUiCzqraoD+4L9vQGP2vMMn9mrI240Q6Iz5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPOyo+kB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPOyo+kB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C5BC4CEED;
	Tue, 10 Jun 2025 13:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749561344;
	bh=KqhRqVFkbAu/zx0zq5YPd4/MLPzkapeG5ZRQvM2tBbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IPOyo+kBK8aA7px7AxJJ+VWHpbstYaKb4hw+SwiT4UzuSkeDjjOrN6ghOOMJV7vhB
	 /4uxm8fXaalrQqYYXhv4jyk4LoBkgxagazq2CmRY18elzfddYvfLDNbsQa+S3XspHq
	 EYLAk2tNzxszUk1az9NJplo4uL7L/qCg/y60CrsN8vYrBXlW6hqPctJKx8tWHyDANm
	 F6iRlq8I4A2kyviCCmPzWAgbJDBy3LIz35pMcEe7suKylYsLXbmiONU4eW0PnhcB5V
	 Q9pH2Tf5s7Kr/c5KGBtHTQxBnkhx68lire1Ne7/gbuJNC/kj/EO8H6aZg0m9T9I3Wq
	 rwFlSHWKDMgow==
Date: Tue, 10 Jun 2025 16:15:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-pci: remove superfluous arguments
Message-ID: <20250610131540.GH10669@unreal>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-7-hch@lst.de>

On Tue, Jun 10, 2025 at 07:06:44AM +0200, Christoph Hellwig wrote:
> The call chain in the prep_rq and completion paths passes around a lot
> of nvme_dev, nvme_queue and nvme_command arguments that can be trivially
> derived from the passed in struct request.  Remove them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 97 +++++++++++++++++++----------------------
>  1 file changed, 46 insertions(+), 51 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
