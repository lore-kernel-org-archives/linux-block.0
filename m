Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923A221103
	for <linux-block@vger.kernel.org>; Mon, 19 Feb 2024 10:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708338751; cv=none; b=W7G/LVKijVHTor3toWQ4PSJiTHjt/rnKPi1ZYWZO66qSwUYTeiTl+QX1Z9dICmseWHCzvjmE1V0A+C1H690DvTTxp++Xy22JBZRbFgbL04ooLWJvMnmN9SyF2kfIoCfp5ztqk30d1C9Pq+eeS/+nQqnFg95/+r6+zHEmkJpgE+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708338751; c=relaxed/simple;
	bh=wLoygd2OsOBRoRIWfU9KWFMvPYEMS40VTg473IlKShA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFLwFhHeyg4A7fSgyLXZUfzU92zNdTl0y8xGVCoS4xIZxUDGWUfeBFzUmqSDUgGY7/bPAla8By/J/vqrMDMPKNvlmpXAbp3HYFhBDqqPnH+S00sIDCaGptDoBSLZ1RxPnUX60IoFnHKsgBtoR5Dl9B1aEdXOuyOtlYu/4ZwYkgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoFJXEP0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoFJXEP0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EBBC433C7;
	Mon, 19 Feb 2024 10:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708338751;
	bh=wLoygd2OsOBRoRIWfU9KWFMvPYEMS40VTg473IlKShA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HoFJXEP0eSifWcTa00S+0oHQd1Uz3/igYte+Bx+4E9/s6u1iOZ876WzPf7tM0vaGI
	 G7GIWT8bokrGrgs2KdwfeD1l2HrYdjgJSeLeZnZrv9aMrfOBrPbjOePpmnvSICtFTR
	 CmxR0IR4knpV3r5Zp7ovJZNkitpz47TgVSS/PBwwL7+2GdKMnoToVHFmSw6T4aNS5Q
	 WAYAp5uLY8Mw/UtAeyFTt+U6WxOXg3gRxn/oCaaXrHPBQOi3PuywZ17ARTSys+jkO7
	 navGVyaoHzebdk2LHQZPdh9KR0Avk22pmVgywiT8Kyc+mTACV97pu2NsijuVH/RLHy
	 kmiaKVwuOhDdw==
Message-ID: <7c57d3b1-d09b-4101-ac65-b6b2693b2969@kernel.org>
Date: Mon, 19 Feb 2024 19:32:29 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drop bio mode from null_blk and convert it to atomic queue limits
 v2
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20240219062949.3031759-1-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240219062949.3031759-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/19/24 15:29, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series drops the obsolete bio mode from the null_blk driver and
> then converts the driver to pass the queue limits to blk_mq_alloc_disk.
> 
> Note: this series sits on top of the "pass queue_limits to blk_alloc_disk
> for simple drivers" series now.
> 
> Changes since v1:
>  - add an incremental from Damien to make sure the zoned tunable are
>    properly taken into account
> 
> Diffstat:
>  main.c     |  502 +++++++++++++++----------------------------------------------
>  null_blk.h |   19 --
>  trace.h    |    5 
>  zoned.c    |   25 +--
>  4 files changed, 139 insertions(+), 412 deletions(-)
> 

For the series:

Tested-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

