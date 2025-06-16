Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA5A1EF375
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750059680; cv=none; b=QKryoVwre2rQ+3KLucyE8efn5IL/BfZAJ/gj3HmoOG2lbTe18no3qXGvAPAzLfTn4rdF4ahZCgrOL/rcJtM6LipRAjTBGdbTBMGXTFdDTqEkzuNJgdeG+5lkuIHZGbD/lKM82hQSj29T8KS0j6xt/9Bd5EeKSOQJ2K5JexgL4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750059680; c=relaxed/simple;
	bh=4qU8ClQ4yBhkxU4l0YkzThkfCL5eedXdhm9zUwLsjLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8KON8QzSmpslG9TZY0RXVQ+Q6PVVz6y8lbbSqGP6AmwtRta4mCyZ2jyNWg4pUpCB1TsD5b34z1DMEli0a1ZCe9PwzKZG9L5dI7qINzOX1//S05kFoqGNq66hPApEba2f7ryyIetXrrch8Am379LwiWD1wZ1/68jbTNI+AvbsU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJszM4j2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJszM4j2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF93C4CEEA;
	Mon, 16 Jun 2025 07:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750059679;
	bh=4qU8ClQ4yBhkxU4l0YkzThkfCL5eedXdhm9zUwLsjLI=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZJszM4j2hv9Uil+UZI6LuhLWN1rAsEhNnJzlcBky+ZwyAHyBu0gRXw6mZNTVNGYqI
	 /38AZCNfLxnNdA+vMoc7Nr7aqr/Wd2BfCdASh+yne76rfMSNK8pmqm5ZNJFNVIyZyW
	 9+f4zHKbG9bMQavXY5TuCDGapLgVH4S8rMb8jeiDlkiLPOE1TFL57zU099YZI+Gna+
	 TxDHzRKXqw7+CxCbZSXSlDLtD3qbZxV3VoLSjG9MDgzEu/CEuU89eDILrKJFt6kXLw
	 CGObaJdoKSgWabBQgmWjhsdlrEgljzgBTJp0hpE3NCdgULLaMhL4RGF5vGBrVDsFUa
	 fbe1Z30hcagKw==
Message-ID: <4af8a37c-68ca-4098-8572-27e4b8b35649@kernel.org>
Date: Mon, 16 Jun 2025 09:41:15 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
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
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250612050256.GH12863@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/06/2025 07.02, Christoph Hellwig wrote:
> On Wed, Jun 11, 2025 at 02:15:10PM +0200, Daniel Gomez wrote:
>>>  #define NVME_MAX_SEGS \
>>> -	min(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc), \
>>> -	    (PAGE_SIZE / sizeof(struct scatterlist)))
>>> +	(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc))
>>
>> The 8 MiB max transfer size is only reachable if host segments are at least 32k.
>> But I think this limitation is only on the SGL side, right?
> 
> Yes, PRPs don't really have the concept of segments to start with.
> 
>> Adding support to
>> multiple SGL segments should allow us to increase this limit 256 -> 2048.
>>
>> Is this correct?
> 
> Yes.  Note that plenty of hardware doesn't really like chained SGLs too
> much and you might get performance degradation.
>

I see the driver assumes better performance on SGLs over PRPs when I/Os are
greater than 32k (this is the default sgl threshold). But what if chaining SGL
is needed, i.e. my host segments are between 4k and 16k, would PRPs perform
better than chaining SGLs?

Also, if host segments are between 4k and 16k, PRPs would be able to support it
but this limit prevents that use case. I guess the question is if you see any
blocker to enable this path?
