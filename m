Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E701724502D
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649902; cv=none; b=HvrtqhTTr2GA+axnSXidpdighuQxGbVjeuYQdFXWsEJ2w09eBAG5tb8E+qQmvwnqKhagLTVCF+3K8YGLKVcCQte7ilRWWN5uLnbZ5ZASq4T7wNQfs3WEHZRtDTnRT37mX1+KTCFMI29x1ISmpmdv5OSfWXA5bCloYRfypHbez3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649902; c=relaxed/simple;
	bh=pTNT3csct3F+DXtUUq5feh5suoNvLizdEEFy0X5wxY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kaM9vaTwRSpUoTthmQGXiKyafOINxMISZ3HdAJBGN3dRHUcWdNCQXZa+G7VEW15FtiUOpFja3XjAtSdGGwxuI2Vi9RyNdezWEnT1cj7eAedgl+lPBE2oB3dSrhgSJjgnfLZgfQS7a8xRbBFBgY69Eij62yRQnrVkStbD5eJnrqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiDWk8ZQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiDWk8ZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717A6C4CEE3;
	Wed, 11 Jun 2025 13:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749649901;
	bh=pTNT3csct3F+DXtUUq5feh5suoNvLizdEEFy0X5wxY0=;
	h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
	b=FiDWk8ZQXu1f9T2WlLZvgPdhPyl7ndgWnaOM672qFhCc81SnKG+Y1NqDqSJc37oRk
	 dw9/tGVGr+3+agdmttMBJoBS6wwCUNyefaBAnIO/5cwcLT72T9cGlEgkX2uluDFfRf
	 SC1qqHX7spc/X9KV2KDT+vUqqEwho0+EHSvGv0s4P/DixdpLYlcLF/Z167ZanJy8UR
	 Aqo0+WgjP6vYxMf5MhYre3hAabbzNwkEkHAcpbrAawshUgeuw0kWnOdKN7wSXkK+Og
	 c7OispYEwQO4rmoeHzU6dapkG+VohD0jY98ME97A1oSUS1IJBGbtA0X0l2KemyedaJ
	 wdfkVx7P/JLfw==
Message-ID: <231b647f-a173-4a8a-b0f4-a314446a520b@kernel.org>
Date: Wed, 11 Jun 2025 15:51:38 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] nvme-pci: rework the build time assert for
 NVME_MAX_NR_DESCRIPTORS
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-10-hch@lst.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250610050713.2046316-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/06/2025 07.06, Christoph Hellwig wrote:
> The current use of an always_inline helper is a bit convoluted.
> Instead use macros that represent the arithmerics used for building

Nit, typo here:

s/arithmerics/arithmetics/g

> up the PRP chain.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

These are my checks:

NVME_MAX_BYTES=8388608
NVME_CTRL_PAGE_SIZE=4096
MAX_PRP_RANGE=8396798
NVME_MAX_NR_DESCRIPTORS=5
PRPS_PER_PAGE=511.0
MAX_PRP_RANGE/NVME_CTRL_PAGE_SIZE=2049.99951171875
1+NVME_MAX_NR_DESCRIPTORS*PRPS_PER_PAGE=2556.0


Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
