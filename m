Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF4D28314A
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649420; cv=none; b=STfV24hFdmV9tYyIEfMLCKbkPwmS4hCWvQ7asTaFq8ebk+NOVxQ09IDzfv9ITcsYh3qoudJZyowDVOv+1u/wE8/c6kcaz5a3SLpesJq4r6P/xCz0jGqWr0TyQP1MohV3PPaadyiTiHdZyllCn/QOeHJcBx1PTXzBPdszEK8fzT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649420; c=relaxed/simple;
	bh=zR+8aAQMpGlSGz0t5RpWSSfmxivnCbCkRAhWEzYsTYc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fSLGAOX940q5Xm61W+itQxsRCTbWl1huQgzSDd5fn58lVXYAX2rO1t3P7Cm1uWok8ygVL2V8que8OTk937kKpxWokn9lqs8gNhWNloWEvKMViBE7g+NFCSMxLugPzytG9bbr225qUkLVhh7VXxKf8zGcIv4KG/tjedrdIFXs2MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U93JaJV2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U93JaJV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A942C4CEEE;
	Wed, 11 Jun 2025 13:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749649420;
	bh=zR+8aAQMpGlSGz0t5RpWSSfmxivnCbCkRAhWEzYsTYc=;
	h=Date:From:Subject:Reply-To:To:Cc:References:In-Reply-To:From;
	b=U93JaJV2B/yzKXABGFMjzQbCDd4o3jHnexKaFSp9C/R9qfA86z7QbRSfw7aXtM3Y+
	 OyyrhFyvUOBdWcnW4ipHfzagAH4XOWPG/oSAj0xsOJyahSFXs/tOu4wgPtkGEMzWtl
	 UNJrEw7OVRMLU72st04yK/IccIzvmQ90+NEIQekzse3pG4lkGS6Ya47AjwV3I+ADIZ
	 stPRi69eVDik6/U9q/Sz+ZMy209jzG+ncnplz8kLN3PFbnDFPmQx2S8SgX6eJmXpKC
	 grijeIbua3IHEXxV4VHDzRZe0GqyK+Pb3VF2vV5SmrUCeqQc9mYxLQja5muj113H5s
	 0eVXqZy0Ha9/A==
Message-ID: <c5d5abc0-9aec-42ba-b21a-a4ac2b34d03c@kernel.org>
Date: Wed, 11 Jun 2025 15:43:36 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 4/9] nvme-pci: refactor nvme_pci_use_sgls
Reply-To: Daniel Gomez <da.gomez@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-5-hch@lst.de>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <20250610050713.2046316-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/06/2025 07.06, Christoph Hellwig wrote:
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
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 449a9950b46c..0b85c11d3c96 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c

...

> @@ -886,7 +897,9 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  		goto out_free_sg;
>  	}
>  
> -	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
> +	if (use_sgl == SGL_FORCED ||
> +	    (use_sgl == SGL_SUPPORTED &&

FORCED implies SUPPORTED, what about simplifying to:

if (use_sgl >= SGL_SUPPORTED)

or just do:

if (use_sgl)
