Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC18722D4E2
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749569852; cv=none; b=PrdhQoPxFz7fnGtZ1YdI9kZ7cMHBzIdgjm8uvHi7SfCoVpHdgpiFmRVJhjROd7enubAgrdthnmGX4S1GQWkHHZG76hEc5p62/kqfiT+ZApbAz/UmPotdUxPu86RcAYuRYf/xodtsjzAcZf4O4+ZbOlJyLmioMg40+A+GaOOqnf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749569852; c=relaxed/simple;
	bh=TAlAnZ3QKtHhtNUZqaBtjheUqmF+Moexcf4ler6YxJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sY2G6IlZR7QeWxOdlEci1Vw21ffDgjdGt0v4VJVD1ZOHrRG7VavgWmyYXR8QX+iLU1vGDjBTW7eSstm4zQHTyx2d/Fd+L5u7ANgA44WLsoZSSgBgXeVzkCgc/82eaWZWjIM9BFA3SszeygvglYgErwVfKqkWZ4eimHjFGJjMY30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcV7pfLQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcV7pfLQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FD2C4CEED;
	Tue, 10 Jun 2025 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749569852;
	bh=TAlAnZ3QKtHhtNUZqaBtjheUqmF+Moexcf4ler6YxJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KcV7pfLQVxJRnYH1e38OyW3r2QLZb0E7vokAVrfhjWBKUCe6drDnNbfNN+BGI1wjU
	 rFzDDzbvmN3d+9ECNbAD9rFl9BKL1eDLOFTbWKB1C2TWr9qAiDXoKXy0RdRPrlq+cl
	 KeultfRrXqLhMrQcYLhTjoKOvZFt2e7b4CDIuWvrFoCsazJUp/Uh+++JEltSHU3tNU
	 vK4yeSH2tvoI/0av4cjLnQicklMqZHEcjKcglRhZUvriN990qjbmexQ9XGkI8STxSV
	 +Ja/Kziv9GkRMVGp0UPD0EEI0yg76lM3vFa+7OK6BnT3KrhguOIi7MzVkp3drqJlb3
	 R+znKIHrCxf8g==
Date: Tue, 10 Jun 2025 09:37:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/9] block: don't merge different kinds of P2P transfers
 in a single bio
Message-ID: <aEhROl2D89kFX8C7@kbusch-mbp>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-2-hch@lst.de>

On Tue, Jun 10, 2025 at 07:06:39AM +0200, Christoph Hellwig wrote:
> To get out of the DMA mapping helpers having to check every segment for
> it's P2P status, ensure that bios either contain P2P transfers or non-P2P
> transfers, and that a P2P bio only contains ranges from a single device.

I may be out of the loop here. Is this an optimization to make something
easier for the DMA layer? I don't think there's any fundamental reason
why devices like nvme couldn't handle a command that uses memory mixed
among multiple devices and/or host memory, at least.
 
> This means we do the page zone access in the bio add path where it should
> be still page hot, and will only have do the fairly expensive P2P topology
> lookup once per bio down in the DMA mapping path, and only for already
> marked bios.
