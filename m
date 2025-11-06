Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF92E34D3A3
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 04:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762402537; cv=none; b=OhmVn19SaPCOnC1UhfuFIA8sV/lt5SFOpJbJ52pEULRwa8hT511mV7qbKWYqpApBmEQC4zS5N46kTg9M/5LISOnVockzYxu5gJLSTeYwHDmngL/VbdThJx8zw5yR0FbTuEqt+SWUyWb9q8irRdBD2/aL3o2rClNOcfZweyQRrVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762402537; c=relaxed/simple;
	bh=/sOH+pgI1B7Zksc65FcyMsf/zxNQTubm6OwAU648qY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=im/I0SlsI7yGBcjnWQAi14nvzDou5h19u7JilFjrSacVXTSny3bqhgyN0wujWQQWAIi5iCcPsD314z3fg6KR2pspXCwx3wn9Xv90hcUyIuwtr8RK3wTLea1eOAb9rLkTenRdZ3OEC+yCi0o4n+JUXXJjhNrsM6t9+CO7N4DFrhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+GjAkc0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+GjAkc0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84337C4CEFB;
	Thu,  6 Nov 2025 04:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762402536;
	bh=/sOH+pgI1B7Zksc65FcyMsf/zxNQTubm6OwAU648qY8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o+GjAkc0Nu+87w+iDyIudEWXQlWjCif6XyqoQxEgFZ89D4SjitgBcI/Dox/n3BsiN
	 cxiISJERCJLK8Nsbk2j4wk2xcJQgH1KqDrzL3IIL5LOcSnEVIt3wxILTBLCTaHg8Yg
	 et91SV4z0eMJaKwos5l1Popy/srn8aO0K6CHZmVplle0k9N+Cqe4TBHUnJJxtoSPUP
	 Sdr04kPtfVwYO8G7RNELiQDjpruGexiziSdZCKN33qRH9lbnkvMooqhsWMgkIsX+zG
	 ePnDR9I/6FCexABMqbOB6FM9bVsOvdgar3dYjpamEXibgSoP/r43kr1unBk8pgmktm
	 vVMd3NbfA5Cxw==
Message-ID: <2f396cf1-3f8f-43a8-923d-b073f73f2cd7@kernel.org>
Date: Thu, 6 Nov 2025 13:11:42 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/4] null_blk: relaxed memory alignments
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, hch@lst.de,
 axboe@kernel.dk, hans.holmberg@wdc.com
Cc: Keith Busch <kbusch@kernel.org>
References: <20251106015447.1372926-1-kbusch@meta.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251106015447.1372926-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/25 10:54 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The direct-io can work with arbitrary memory alignemnts, based on what
> the block device's queue limits report. This series enhances the
> null_blk driver by removing the software limitations that required
> block size memory and length alignment.
> 
> Note, funny thing I noticed: this patch could allow null_blk to use
> byte aligned memory, but the queue limits doesn't have a way to express
> that. The smallest we can set the mask is 1, meaning 2-byte alignment,
> because setting the mask to 0 is overridden by the default 511 mask. I'm
> pretty sure at least some drivers are depending on the default, so can't
> really change that.

Maybe we could special case UINT_MAX for the no restriction case ?


-- 
Damien Le Moal
Western Digital Research
