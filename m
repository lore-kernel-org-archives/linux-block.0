Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C2A283C9C
	for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 04:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121270; cv=none; b=GRGC9X+4ijxxnl07WXnEYAEaXX8fT3v0lU83GxkbQJ4L48NsPHUgOUsU7dnFlWAbJn0jr3wffDalYEDxlQRpwC5bgcJfbCLLkwpJTzXqqlGs1qSvj6XXdgk5CJAOMAtlGQ6MdZ1CqVtRXwwx46cyRVkTzNoHjLxMzZNqe9p9aDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121270; c=relaxed/simple;
	bh=Dm2jR3IOKR7lAiGqnjyIXyjvPL0ysbC6IQjzaFJQj5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvQ0renD6ET8kvtL5vzJ1ez5aOeCQ/ZEafVbEjTuNqxcKb4Qw3UegcUd3j9IqY6EZvHwCmVJr2C8GeLDqJJRnmlsbkt/uq/PUjTtkAc0zbKgsAWZQHwQ0oqdzC551ECMIwP1HdmhUTFdw/PjZkkysZpndtMOwDf7k9kcqcvoaFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGXLXSOP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGXLXSOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E5EC4CEE3;
	Thu, 10 Jul 2025 04:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752121270;
	bh=Dm2jR3IOKR7lAiGqnjyIXyjvPL0ysbC6IQjzaFJQj5k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OGXLXSOPqiaPShBzZfTf2VirLTMm1J8BPf036PfmMj9FYK/88ViX1QIC+BLFjQAMS
	 1g/k3LIvSpcgETNzNV7FcGIudAiGT9H4ueup7RhU40A3ZAhru6EfBvC4uG3qkh7fcT
	 VSAMsfKlTKMqwDvOP/FpX2o+ffQGIVD9td3pK57LNU5opbfmbHX6rOqIApeNBdz2wo
	 orxePfS+4ivDAjgtDIREXFyjmjl2dz5oEhtQGbj7mMkcHzWYdGknxcnfZvRGjoFhSz
	 IILp6o7iYc7WC4TfNwHLCxHOUg3yi6aZzasYMFSwOcIsCfqxOmHcBfqjnw4HKf2puQ
	 MzqDe1WnLPJEw==
Message-ID: <a9624df9-5455-4b47-90dc-68e9590c45c7@kernel.org>
Date: Thu, 10 Jul 2025 13:18:54 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] block: add tracepoint for blk_zone_update_request_bio
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <20250709114704.70831-1-johannes.thumshirn@wdc.com>
 <20250709114704.70831-4-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250709114704.70831-4-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/25 8:47 PM, Johannes Thumshirn wrote:
> Add a tracepoint in blk_zone_update_request_bio() to trace the bio sector
> update on ZONE APPEND completions.
> 
> An example for this tracepoint is as follows:
> 
> <idle>-0 [001] d.h1.  381.746444: blk_zone_update_request_bio: 259,5 ZAS 131072 () 1048832 + 256 none,0,0 [swapper/1]
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
