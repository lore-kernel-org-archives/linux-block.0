Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED46519E819
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769752215; cv=none; b=XkxMyXnEAVpwZusBcte4n/st+f0QavR5blZWzYqmHfdpTDLXqJIXu/EK2ynMO/SgFC1aI0lUQ1d5X9CyCQf3iJF0hPEbKnfflzzvYKfTXoAQpe6ehH1syaGmevmiDa2rzUtqHzAc0vD8WShKDq9+kCCsQf1TbBpfT0nfBjQrd1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769752215; c=relaxed/simple;
	bh=/3OfAuRGEM6nfsbi/XGMWqEPFL7NFuJFdIW5oLknHTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9YPObjaQPC0fHzWcRIiiQdZZ7WN6HLkfJ+HNFhyx7CdDY9yVXM9eMyc8cWu+gAdQSEn9EuwP3LlgV71KdKs8fIrY5Djp9Ir4iOtV/BahuueeQayhjjQbVJwSLRyEsx1D3khWUmrdAxeaAU8Gjismh+YL5B1Au2xGom4RUK6vWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OInpnQw0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OInpnQw0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DB1C4CEF7;
	Fri, 30 Jan 2026 05:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769752214;
	bh=/3OfAuRGEM6nfsbi/XGMWqEPFL7NFuJFdIW5oLknHTQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OInpnQw0KAqI7QA4yQ0CC1UxW47YTkvcewkEhQmoHp1CEdevD5vaNizckuP+32B5V
	 8s5zBfhtaqXXie/kVFAnSunm9zYvvPLSNpLapRdut2NXpFRdip1WtSGi5NCmFdpg+I
	 0Fk5NOcG+pzPp0fyrH9akx9MYIe3ozffKstti61pKjlnBKGoYQ0LubWubh0YW/SJNy
	 X3vfWH6wqz+wszqCCugIZ0r95PIasr8GLNukpyhCJa7d0Sa5LND/Jy8epOcQI4A9dt
	 I/xiVmjSSXIjXwh9Fky7XLazZI6yUoo4f2dFU+uPCVrE1NOACz1uT3jyTll5pJ84L3
	 dG0PKc36MKvrw==
Message-ID: <fec8c581-a019-4ff0-9b3a-080d5145fc7d@kernel.org>
Date: Fri, 30 Jan 2026 14:50:12 +0900
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
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aXxEsA_HMLxLORZV@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/30/26 14:42, Christoph Hellwig wrote:
> On Thu, Jan 29, 2026 at 04:27:15PM +0900, Damien Le Moal wrote:
>> To check if a request queue is for a rotational device, a double
>> negation is needed with the pattern "!blk_queue_nonrot(q)". Simplify
>> this with the introduction of the helper blk_queue_rot() which tests
>> if a requests queue limit has the BLK_FEAT_ROTATIONAL feature set.
>> All call sites of blk_queue_nonrot() are modified to use blk_queue_rot()
>> and blk_queue_nonrot() definition removed.
> 
> Looks good, and I should have done that soon after inverting the
> underlying flag:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> We should also do the same with bdev_nonrot, maybe staged because
> of a lot of callers outside the block code.

Yes, that is why I did not send a patch for that one as the changes are mostly
in file systems. Will send something later.


-- 
Damien Le Moal
Western Digital Research
