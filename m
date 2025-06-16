Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037DB285CB3
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750077468; cv=none; b=cOK52JzYP8AXTMMeZBz0h3ijByfR4Snk5IVbBsWRW9a6qasWU4Fszd2tfoKaOo7oVBna8R5BSiHDQq+bvFFaEUY9TKNzzbVxWIEReGe6tiL69hMd/EV2FAU/pJfWrQji7J3n+HcPmqV6DOFWNwl+83vv75autZndedQSM4VA2bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750077468; c=relaxed/simple;
	bh=X54pGA1PNRxdHTHaDj+xP5TwzrUJrhRYjQi48QEarW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atT8XJZ23tR6tlZAq/aW9TEdIMDTW2r/tz+DWWcz1xgniY6yJimDZ3gMeCNaVdyc5SSiagQuYHm/5gBuQO5HcpqIzbMMpGvVo9UuzOHs4U/wFtkqpmZNWAb66xHqlTHAQNa8NKMof3gbss+6YMtj98qmSqF1fzkpDykx6YBGNrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYkGNieb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYkGNieb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B86CC4CEEA;
	Mon, 16 Jun 2025 12:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750077467;
	bh=X54pGA1PNRxdHTHaDj+xP5TwzrUJrhRYjQi48QEarW4=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YYkGNiebf3E1gWCLa0EQzuguystPkqMpnRZ0617+6DwsUY1QYlUNPkTTlrhEIk6Dy
	 MaA9s1o0APVglEt9eq4jz+M22Z6lECOfZvq3m+/mFG3HiXUiKAoagAmUQH29bvBM1D
	 zI8m4KXoi5nV79exxe/yaM6kaxxrg0wzDDml2vFMMH6anZqaDqVVxkFfG69cYeBvOl
	 07xbV/dZwrNgs/Q4ZP+OzbqHczibwr+KzATxxUA/3uweKvEoWLZAsu9TruHEvDFfmW
	 OyzUYDKdPndmOmKjSrprQ6qGIS6F+oiMV+Pb4tF0d6VDEA65253OSR19rrlIJ20OdN
	 d+5TKCbjg6DyA==
Message-ID: <4973015e-ecb2-4bd9-ac26-05927fa8fbd4@kernel.org>
Date: Mon, 16 Jun 2025 14:37:43 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 2/9] block: add scatterlist-less DMA mapping helpers
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Leon Romanovsky <leon@kernel.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Logan Gunthorpe
 <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-3-hch@lst.de>
 <dab07466-a1fe-4fba-b3a8-60da853a48be@kernel.org>
 <20250616050247.GA860@lst.de>
 <2105172c-5540-40d0-9573-15001b745648@kernel.org>
 <20250616113141.GA21749@lst.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250616113141.GA21749@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/06/2025 13.31, Christoph Hellwig wrote:
> On Mon, Jun 16, 2025 at 08:43:22AM +0200, Daniel Gomez wrote:
>>>> This comment does not match with blk_rq_dma_map_iter_start(). It returns false
>>>> and status is BLK_STS_INVAL.
>>>
>>> I went over you comment a few times and still don't understand it.
>>
>> The way I read the comment is that status is only valid when
>> blk_rq_dma_map_iter_* returns false.
> 
> Yes.
> 
>> But blk_rq_dma_map_iter_start() can return false and an invalid status (in the
>> default switch case).
> 
> The status field is valid.  Your patch below leaves it uninitialized
> instead, which leaves me even more confused than the previous comment.
> 

status is initialized at line 160 after memset():

	iter->status = BLK_STS_OK;

So, what the patch does is (for blk_rq_dma_map_iter_start()):

1. Initialize status to valid (line 160)

	iter->status = BLK_STS_OK;
	
2. In the if/switch case default case (line 181-183):
	It sets the status to invalid and *iter_start() returns false:
	
		default:
			iter->status = BLK_STS_INVAL;
			return false;


Removing the invalid assignment "makes it" valid (because of the initialization)
and also matches with the blk_dma_iter data struct comment (lines 13-14 in
blk-mq-dma.h):

	/* Status code. Only valid when blk_rq_dma_map_iter_* returned false */
	blk_status_t			status;
