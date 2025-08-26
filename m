Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AE22BDC25
	for <linux-block@vger.kernel.org>; Tue, 26 Aug 2025 05:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185281; cv=none; b=YRDCIOH5wqU4K4IE9EIe9l+YBbQASRZXZTrycqjhevQ1RnPPdxSq17ZSU6QfixqxPoC0SCO+1y4srrPKqRG9tMFbzN/HprmQlvOXZ72Jr9VgC8Uki5vVBalq8AFg3hh2HriLytLwzOBsPqStEvy38Tlq2+7czCswgXNdPuSS7Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185281; c=relaxed/simple;
	bh=liMdIvlrTNXXS9fOIXlY7Tt17v0UpsjYk7Ho7/pDZcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ynxcz6PGpqZKoDQYX4kSwGDN9JcYoDDkSckWbftB7Il4pvfTZaxsGUnV7PMlNvDWXrC7EE1I40s8HyOl2xiM/8Wu6RZLPWMqYBBiHlM1AGkFaTTDyNubmYYpiOxvsta6sDVWTQzrVt552kVL17OiGUdTunu+i9XLur34XuZKaGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSNLdXig; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSNLdXig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341B1C113D0;
	Tue, 26 Aug 2025 05:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756185281;
	bh=liMdIvlrTNXXS9fOIXlY7Tt17v0UpsjYk7Ho7/pDZcM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TSNLdXigi4BG6x1Ixd9/PElDtk3Ox5xG5DSNo4blOVkq9i9HsO8MtEJyoO0wUpHAn
	 kD3z0pOjcHiHfRhBhpe7pagK5ReDtzmV0NYB1uacRijLX8/3+VwIhwDgxwJsktLP8O
	 xQhM8NuNUVue0pUOEw0PrDPLhDCwT/BnvMJZaLVne8D2ryQonB0s33gT1DXK9bp1pP
	 It5rXgQTilGi4Szv37zjLuRjiLzRTO/r78F/vcSeLN3ZFTCI2rUILZCRhkFzerH5mm
	 2fDWYRPjM3zcP2SmcsIyUtvfpAhVbaxzd1e+AQooHjGhN9ANuLvWQT5yoNYkbHguIM
	 CdOGAYmPmws3A==
Message-ID: <619463f9-f685-4c84-963d-442fc6faf70f@kernel.org>
Date: Tue, 26 Aug 2025 14:14:38 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-zoned: Fix a lockdep complaint about recursive
 locking
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>
References: <20250825182720.1697203-1-bvanassche@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250825182720.1697203-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/25 03:27, Bart Van Assche wrote:
> If preparing a write bio fails then blk_zone_wplug_bio_work() calls
> bio_endio() with zwplug->lock held. If a device mapper driver is stacked
> on top of the zoned block device then this results in nested locking of
> zwplug->lock. The resulting lockdep complaint is a false positive
> because this is nested locking and not recursive locking. Suppress this
> false positive by calling blk_zone_wplug_bio_io_error() without holding
> zwplug->lock. This is safe because no code in
> blk_zone_wplug_bio_io_error() depends on zwplug->lock being held. This
> patch suppresses the following lockdep complaint:

Looks OK.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
