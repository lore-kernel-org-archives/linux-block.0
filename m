Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57802EE289
	for <linux-block@vger.kernel.org>; Tue, 17 Jun 2025 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750182210; cv=none; b=Zy6jy1uaFVuoxSCxHpiH9RNMHN4gffjyFkmjSA4NqAPJ/mn0Gq+6ERgwZ+S2vEJhcqOs38MCoIbMjujehOrpmFIqF8M9eysTUtNFEVL3q3Ok8eLbDwJ+a35jt0OYdJf7SID2KcWeo4y/v9tc97nctIQVAN++Cizihxkid201hoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750182210; c=relaxed/simple;
	bh=tL4Obeun7WLXku3bH1nDHcp84HwzWMUN+lnTlkMMSaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0WOX73ULW1EDcWHaRWn16lIi5Gvz2P/1GckRI+vd1NnmStSxLwso0HnqTOhR16eJi/3C/sApveE02KU7prLRmE0wwwF+uO1r7iZuhmbTmB7Le1HB49aIO86Z1hu+UC2nHnnINBiIr2ksKWcNWBRk2ifArboD9JQp2FtVT5eUhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3KJB7CY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3KJB7CY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495F1C4CEE3;
	Tue, 17 Jun 2025 17:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750182210;
	bh=tL4Obeun7WLXku3bH1nDHcp84HwzWMUN+lnTlkMMSaM=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G3KJB7CYWESu9oKkyxh952HvUEkc2yvJy7mVv7U1sQ53lysK+HIcOn200qbVO4eiO
	 SmqEMiuxrTy0gVYVtIXAkPx6iBgsSKLIH1GOtYak2EXgGOMiS3mKiFjcWwmX3nHzQh
	 hS2Agh/lVKp1SjC5lnYKL1RpLYFaZgzJDolq7XArOOZMOByIul5BqEmtEPN/45emWr
	 /3bmhJcLjahZqv0n7CFMn9smTftFNlTzxono7jas7ElmGaW0M9UYxX4VZD7QWwEZPd
	 irs/7gCLn5w00nzfo/CJVVgMYT/DJFy5J5JkPciY08RjWauefhr1dRDXkt2kYdaVbo
	 hp6lfnJhGakQg==
Message-ID: <edf056c9-ab8d-4b55-9e61-25a29916d55c@kernel.org>
Date: Tue, 17 Jun 2025 19:43:26 +0200
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

SGLs don't have the same MPS limitation we have in PRPs. So I think the correct
calculation for NVME_MAX_SEGS is PAGE_SIZE / sizeof(struct nvme_sgl_desc).
