Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B52438889D
	for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 05:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789017979; cv=none; b=kW7HDBzsa40mPk/3Ca+rUR70sLx4gZyP9poWS7vAW0JNiL3XJwHDnwbg/t+3eSIIRdLrb+Yad3YP0D8HCt28Ve24BeJTgJ17NtL6ZUJpQCZ07CLMVuH7fnOSXcsHo9GsFtbBqwVGraCNrxJZQV1L85IeHnljqfsItA3bSaY4MDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789017979; c=relaxed/simple;
	bh=q3CrnAT3MjGuJytta8uiERU+xQw5lLxA7sDHYib6ThM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YifY6VByjdVeLOcsE+Rmd2o5JejugTwteYVITfMaeCZpPHxoJpdFp5Cn6Emsp2S/fEecCrMuPJv+K+g2loocYrrJK68RsLH1LQH7JnUtGnz7ahYzrBNMk+Vl33x6L0S1jumBwzLj0BjTvtIV/FJ3ALA8wwaYCKJiroBWKdGUwyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFZyMIpd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFZyMIpd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D0E1F000FF;
	Thu, 10 Sep 2026 05:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789017978;
	bh=/9gUU0K5Eyhpb10aRI8MTCqIb5zMAR40qk631u5sqms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dFZyMIpd8J2AhTlOxgPztczPXtREyUw4LNGZ8uiv9Tbs/DGzzGV0aKLd17MOoIvEi
	 HYCHAHof0stLOF4B/pAljy0CXIEIfOApiNo4MFTxqOMz3zyR8lRqNq2hDY6Nl9bOUJ
	 INEfUkOI2jHvQCEDaKDuK5KD7VC79andLqFlfZD3x1SSLvyvEp/flZoh6oabxNiE8R
	 6PLWKCj9+cKjWKuamy4En3PikXQVTZRXfdeJOkx/PQbtGASCDvXSdtEYiEpS12ooyc
	 QHD/9h0Qa+bL60iQ1oaEiCe16AWMYTj80KSl0/YfLH8gVFLgljHRfgx4U7kjnodMP9
	 R2fyUSEkivwOw==
Message-ID: <35a79f38-b8c5-4ffa-a0c3-5ecdf4a52d61@kernel.org>
Date: Thu, 10 Sep 2026 14:26:16 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/16] block: retry zone revalidation on capacity
 change
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20260908085745.1082697-1-dlemoal@kernel.org>
 <20260908085745.1082697-12-dlemoal@kernel.org>
 <20260910052403.GA27133@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260910052403.GA27133@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/26 14:24, Christoph Hellwig wrote:
> On Tue, Sep 08, 2026 at 05:57:40PM +0900, Damien Le Moal wrote:
>> When disk_revalidate_zone_resources() detects a capacity change, -ENODEV
>> is returned, failing the disk revalidation. However, since a capacity
>> change may happen due to a storage element removal being executed
>> concurrently to blk_revalidate_disk_zones(), we can simply retry the
>> revalidation to capture the new zone state with the new capacity without
>> failing the revalidation.
>>
>> Retrying the revalidation is driven by disk_revalidate_zone_resources()
>> returning -EAGAIN when a new valid capacity is detected. And to avoid
>> getting stuck in an infinite loop revalidating zones, retries are limited
>> to 2.
> 
> I thought our random pulled out the air retyr numbers was 3 :)

Retry=2 leads to 3 tries since the first one is a try and not a RE-try :)

> 
> Either way, this looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 


-- 
Damien Le Moal
Western Digital Research
