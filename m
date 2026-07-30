Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFC83F12CA
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402860; cv=none; b=SoA6SlTZfHYoPxIRrnsMqMwPkZMi47ogbEAsT1VIxB94o5uUigZCDS8k+XLBozQL9l39fNYJA1hy3LBReP5NY0a/EHTNgpOHNbCLOEK3Im5y0UgfMzVK3ev0jTbmpxhT+5QEXCr8kfL51+zcaH9Nud2j3AeMYRXLo49nO6xFAIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402860; c=relaxed/simple;
	bh=Vbi+sRul55x9Sa0QAe2UD/ngAw4vcjj7j4PUpqMZPIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZPzw0i7UFEPEyOEesPg+K55WerwRBvUlx6hMYgvdrZNZ3N2ZTit+mccP/ceh5hAy8EQUnxOyZSK7QcUshB3xtCRtcym/SYO1XeIJybQ5jJDa87MXhwn9zWdZNk5+OSRoLaqShiI5kbKyJ7R1s/zz0O2NNhx5cZx6iZhZq9hA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEl3snk+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEl3snk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B9C1F000E9;
	Thu, 30 Jul 2026 09:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785402858;
	bh=7XBH3w556YDNcho0sCbpxtkRdKKQZzmE4r/iWtAJFjQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jEl3snk+d+23eGajDaTMpzVz8kz4R4/Y37w63V3dVoEaVnw0S7bg5RAWaP0/FjRFM
	 Texbt9kcxwmy/iZjRKpy44MTNfPAhSEBBGH2gPNXMkMUtODqz4LojwSh88sUs6vkuK
	 X4nlVqd0WSdyufmZN+qfQRPSUh14EBhs19aJKKAfKI2yCNVMwKiokFeYs7ys2VhngU
	 N2jRjnzmW6dvyp0Tadh0WNVpZBiV2k30/XvUCMwwWm/bLEoVj19SdiiSOOY5OhbZoO
	 9yKWtyWX+XH8M70WtzfSUWP9zTKQp/T0L3dHxo5kKiNsBxQigMc73G11RmGMhRGSky
	 gcyE6KtdN8LIg==
Message-ID: <35801c38-aa18-466c-b115-4d6479e1c54a@kernel.org>
Date: Thu, 30 Jul 2026 18:14:16 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] zloop: zero out only the unread tail of short reads
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>
References: <20260730072633.1831826-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260730072633.1831826-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/07/30 16:26, Shin'ichiro Kawasaki wrote:
> zloop_complete_rq() handles a short read from a zone's backing file by
> zero-filling every bio in the request. This is correct when the entire
> request is beyond the written part of the zone. When a read request
> straddles the boundary between written and unwritten data, read_iter()
> returns a partial byte count and zloop then zeroes the whole request
> even for the partially read area with valid data.
> 
> Such an unexpected zero data read was observed with fio test script
> t/zbd/test-zbd-support and its test case 69, failing with "bad magic
> header 0".
> 
> Avoid the unexpected zero data read by zeroing out only the unread tail
> part. When read data size cmd->ret is smaller than the request size,
> call the new helper function zloop_fill_zero_rq() that walks through
> each bio_vec and fills zeros from the specified start offset.
> 
> Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
