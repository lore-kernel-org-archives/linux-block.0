Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921372EF2B5
	for <linux-block@vger.kernel.org>; Tue, 17 Jun 2025 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750182314; cv=none; b=oJ24Z0tmbd9lkTIYA6gy97pupkbXuFzkOsaVPBydXzDdkxZV+V+4209ZzgquAOx1KM9GJlLCNbmoEq46KC25qXdLIw+ZGvM3WtLscmgbMDFPK78qEmeUYpmHrm8Egps0Vgfdq47OlEsmF1y22qpoBWJWCi7JdiUeycWT1PipH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750182314; c=relaxed/simple;
	bh=mwuIS3TH6Iy2vwJYNmaVexGdaQqfvGHQnUF4HVL6WXY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cGZBhroO/U0HGGZecst7kvbGL10QW1YDUyV5d/7aGNRGZTBqCmlOH3FGU7yI114aOkXC11ag/HUBE5EYyhjkr7e6DZtLk+2XxvjYTEOx80mo7716IX7W/9BmFtBJy5iEdO1UqGyaPYr+aoLiJDz0Yyd2KiybNMJfYDFXd1RhjUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4nzq0Hl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4nzq0Hl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FBEC4CEE3;
	Tue, 17 Jun 2025 17:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750182314;
	bh=mwuIS3TH6Iy2vwJYNmaVexGdaQqfvGHQnUF4HVL6WXY=;
	h=Date:Reply-To:Subject:From:To:Cc:References:In-Reply-To:From;
	b=c4nzq0Hlzi9wxXW6ihJTpfUwpXJVjDnWYqP7qGYT2jvZoS6oyXzhOOHm2dUnbiqQW
	 1PFbYsfW1pG/d1RfuVapbQQYoxCfOAYulxUX/rpXFDt8khZ8/4nnF/asTQ4rWTvYYb
	 bdSpDDJJocUpEq3NQ3W3gddAmlvPSoPntEyPQOBdHa0erzhXBNq1fnZbxojgRdNWBn
	 kjnhJ1zfWfXD8rC6koeRkaxE0pLQ9yPY7dPqrqXBaAT6EUKBdfMtpULEFf+r2G6hyT
	 pSQBFnWBqL+T+0k7CPePUWDy4DIVosFTHSvI/z49yfevdQ7IM8b04L7NCvCgCpd7oE
	 UW0lUVBDc5A+A==
Message-ID: <4e3eec2b-bd74-452f-880f-b1ad4f35bd79@kernel.org>
Date: Tue, 17 Jun 2025 19:45:10 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
From: Daniel Gomez <da.gomez@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Leon Romanovsky <leon@kernel.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Logan Gunthorpe
 <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-8-hch@lst.de>
 <5c4f1a7f-b56f-4a97-a32e-fa2ded52922a@kernel.org>
 <20250612050256.GH12863@lst.de>
 <edf056c9-ab8d-4b55-9e61-25a29916d55c@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <edf056c9-ab8d-4b55-9e61-25a29916d55c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/06/2025 19.43, Daniel Gomez wrote:
> On 12/06/2025 07.02, Christoph Hellwig wrote:
>> On Wed, Jun 11, 2025 at 02:15:10PM +0200, Daniel Gomez wrote:
>>>>  #define NVME_MAX_SEGS \
>>>> -	min(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc), \
>>>> -	    (PAGE_SIZE / sizeof(struct scatterlist)))
>>>> +	(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc))
>>>
>>> The 8 MiB max transfer size is only reachable if host segments are at least 32k.
>>> But I think this limitation is only on the SGL side, right?
>>
>> Yes, PRPs don't really have the concept of segments to start with.
> 
> SGLs don't have the same MPS limitation we have in PRPs. So I think the correct
> calculation for NVME_MAX_SEGS is PAGE_SIZE / sizeof(struct nvme_sgl_desc).
> 

Please, ignore. I forgot I already made this point.
