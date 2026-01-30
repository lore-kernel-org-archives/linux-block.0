Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274A81DE8AD
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 05:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769752512; cv=none; b=lIL8bzv9u/qFzKpLPYKn434GSQHxDkjwr7FO+byf0UViMHhTSSud2W3+9kZGPC92Q8Na3ihIbCif+OPTXssgPbLtGXhOPxdfAy+dK+IDNLId21YTG14UpomroaMMBlt0rmJ+tZNq8KzBm8Rv3/cwj4WaxdTHKcwJkyyWeHgJfMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769752512; c=relaxed/simple;
	bh=j//8PudbaaT+si+cnwnagnGkNVscnL5fIk85ITnaBnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pb9Ot/ynMI4OHg0ID/dUjeUOtjwoIhen7ICxdshUKHjanCd5G1nVfc0FrUlGNLuz7eJcNOpKOIrblDmz7trydKmzFIxnpJNhpN0kIDoNPqfOcEb0N0bV+sdTsmUSGKcDbS9fFL+frGQkovYQbyjOycCwUKXXvzbJ97gQBUTNJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paK9V3gz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paK9V3gz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4369CC4CEF7;
	Fri, 30 Jan 2026 05:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769752511;
	bh=j//8PudbaaT+si+cnwnagnGkNVscnL5fIk85ITnaBnw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=paK9V3gzI0f40DnaC/h5XN02DUMy+xIwD+wLYTVTyRo7qnAaO1PU9nrlODUyzEFYN
	 j4Z4jrTECOuJPJc1h4Nuga+LoKDTja7Bef1+yDIRMNvAM6nJfjtGwI+mvODCwtlUlF
	 Dzf1UIZpOU/iS7s9htdtyNpQZzrCp5y8B10g/HsaYGBmLXBq+Axn4k4wQUxn+oy6h/
	 p8uRIHNUG1LooRdHf7kgU2yBp7tbjRdTmvKqdCv1ov8nE7XAaFgKwc0dS/2F30Haao
	 MsyUDmBLoVVtHV2OfElI2bK/LKmFd5YqNwwq3SYgqG/NzarPQxjDFUoUECaQbtXE4t
	 qqkr7B5iJjCsQ==
Message-ID: <1666d550-b948-443d-88a1-d5c98cf661ab@kernel.org>
Date: Fri, 30 Jan 2026 14:55:10 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: introduce blk_queue_rot()
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20260129072715.1107336-1-dlemoal@kernel.org>
 <20260129072715.1107336-3-dlemoal@kernel.org>
 <aXxEsA_HMLxLORZV@infradead.org>
 <fec8c581-a019-4ff0-9b3a-080d5145fc7d@kernel.org>
 <aXxHR6xpve-YHT_5@infradead.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aXxHR6xpve-YHT_5@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/30/26 14:53, Christoph Hellwig wrote:
> On Fri, Jan 30, 2026 at 02:50:12PM +0900, Damien Le Moal wrote:
>> On 1/30/26 14:42, Christoph Hellwig wrote:
>>> On Thu, Jan 29, 2026 at 04:27:15PM +0900, Damien Le Moal wrote:
>>>> To check if a request queue is for a rotational device, a double
>>>> negation is needed with the pattern "!blk_queue_nonrot(q)". Simplify
>>>> this with the introduction of the helper blk_queue_rot() which tests
>>>> if a requests queue limit has the BLK_FEAT_ROTATIONAL feature set.
>>>> All call sites of blk_queue_nonrot() are modified to use blk_queue_rot()
>>>> and blk_queue_nonrot() definition removed.
>>>
>>> Looks good, and I should have done that soon after inverting the
>>> underlying flag:
>>>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>
>>> We should also do the same with bdev_nonrot, maybe staged because
>>> of a lot of callers outside the block code.
>>
>> Yes, that is why I did not send a patch for that one as the changes are mostly
>> in file systems. Will send something later.
> 
> It might be a good idea to just add it and use in "block tree" code,
> and then we can convert other callers in the next merge window and
> eventually kill off bdev_nonrot.

Indeed, that will avoid potential problems with new use in linux-next.


-- 
Damien Le Moal
Western Digital Research
