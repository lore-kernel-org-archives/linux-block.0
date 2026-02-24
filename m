Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519A01DDA24
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 22:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771971404; cv=none; b=b2TM6dcaYQAq18HsWrvTs6OWB+tuprY3qeMd/I8mqNlMkU0yEAkMeLdyq+PDsaJUXVjnZh9Zb3SBq5TWUuq37+IzG93vW+5gTXLtnBtXiT+EOJgroSvBLv6Nq+HF3lUsR6cn13NPy6lgiQMEEcGob1hPi2SNUDTR2pzAZKNGCIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771971404; c=relaxed/simple;
	bh=j9lSlJU2+OsqTqIjpCn3QVzBqBAP7IDmfUSujDPTd0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jd0RAmM+692cETg4F8kN1W7B4LMScvXOejJpLJ5CcjYoVIABtJ7XSN3p1392dWCIOK/z2KPRCJNN6zp/mqsXiCurrtVr/KqkPd559443Qgd7StC8XCim6sTWfFH7z5EL7NCySC8mrflS/AXnqZAOhUUOjBj0IHZEYhX3bhGd9ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FNp81mJG; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FNp81mJG"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d19d3c7208so4538360a34.0
        for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 14:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771971401; x=1772576201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ubZqz82sxna5IeTLJkYx3kHdwVhH+lBv89Or4Yv1MOw=;
        b=FNp81mJGoKfTvINeIj2j7G1GqP+gvGtoF/M7b3HhQe0XNUTFe9Cava2XMy3wrJ28Ga
         KaRgmRG1VMAcdiDHWhhnOprfp7QI0mrQEDnXwIEvaJyD3u4rzOg9ZIsGWBOVtSBrEbZE
         P1SmNTr0FtZ0S+rxHAyM3w44F1bjRggSUknZFQzMiEarXbwInYWdr5EC5FROA+fY2Gqb
         T9YU2VVmInbhVhDRoh+5DWpGGH3KMbZuU9DurHmGagWSoKxaSohxXENaG1dch0zI9dcI
         rV8Z9meSzDNXIPnv+6q+lI+bbtVGbCjdhZVJsrHNZQEp5lFP2TPqazhKwpQy0evmIUA9
         6BfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771971401; x=1772576201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubZqz82sxna5IeTLJkYx3kHdwVhH+lBv89Or4Yv1MOw=;
        b=T4U0517ptWUHfe79vTnuhEhW37KJrOXlc3ZkEUhNT8aQbjeJi2XjO4QaxqOogRfWON
         18eiPw60W6gH1HUXhnoU2uqzY+9NSzBlk6rqLBTyKTWiig7xirhMVKIOrVBQXMfwrvnz
         ZriG6c9JCM/lmrz4HhUe6Dj9oDfm0XMfnCczLsM1rQHYgrC7pkORP2FSpyR37Z61XZSJ
         K8oKhYmduyxotMcPJl2kQNnWSgJxfW4E3N3ERPQ2iYHGr0Vm7w6YPbV7ci/fCimtejPq
         X7EY9bbo6gDzEjgE95LnyyOlveVpRPKb9e7iXjQ2hXnWkJL4XLwePAbEKwah3Zf0UkSn
         BOwg==
X-Forwarded-Encrypted: i=1; AJvYcCWn2ZcE59ZXByaXOhl0QRxOy2IuJF+tMT2iIPKLLZKD6IG4e4RGYHCpkSc3W84Ccfzzhlt3hCm8J4g/Xg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEWkTIbTXiPGt8MLqzJi1UiUDgxOZt6Bxxqz9/UdTMZ49WW5MA
	S7e1z38kljh4Vf3zyz+scNuFS8g6GijgWb1RtfWHAaBJT3IDrPTgDXy1O+ip4MroHj0=
X-Gm-Gg: AZuq6aJ6gAAo5zpXzPexlmjjGvtGypTzttzqoZYDboBxKH07T+TdPOj932M8V/VhUj6
	hog+3tLOIiZaPWmrY6vEnqEyeb7hHV3hHRj+oNC5A77ouA6scqB2nnpVNAvZm1a3BTB9L+u0C3B
	k1HJ+MVpuEmwMJDuMxudxMYoqm5h0gl0KpYbnJ7iYbPr8RWM4D4WMBrUYEGpBOaw7o0rlaYjysy
	ry8lZg+Yy8yhUPsUJ5fzRqVhbOE5EGwCaPP2TBukisErxMF9bMiMPBJf88LtM9IG0i7xVIi4Q1F
	XU+MibF21Vo6v8SmMhlD0twQhtI33GMgGxd8WBeJUjSB+l0H3vJaII8uhdD+qT2pyM5QDu97tYA
	WV50LBh9B3QxAd9u1fgBQintHhEKLekz+Dr5R/Ox6D8yl5aWoi28WEbwOs88RqAOndCI+q0CYlN
	vaaYsl9yod9akHciP/n9DHBiuOjo3XczBLbHkADYuUpCCfCnFNZVQbvA3dPZKu1sqRA3tOcECIS
	R0K1PiXew==
X-Received: by 2002:a05:6820:2d0b:b0:659:9a49:904d with SMTP id 006d021491bc7-679c427d30bmr7437288eaf.24.1771971401291;
        Tue, 24 Feb 2026 14:16:41 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679c5630827sm9176307eaf.3.2026.02.24.14.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 14:16:40 -0800 (PST)
Message-ID: <745ef6a2-758c-484e-ab12-9aa2d64ae5d7@kernel.dk>
Date: Tue, 24 Feb 2026 15:16:39 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: simplify blk_mq_finish_request()
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20260224215855.1709335-1-dlemoal@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260224215855.1709335-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/24/26 2:58 PM, Damien Le Moal wrote:
> Remove the local q variable as it is not necessary. This also removes a
> useless pointer dereference when RQF_USE_SCHED is not set for a request.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  block/blk-mq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 9af8c3dec3f6..55a255750ad1 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -781,12 +781,10 @@ EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
>  
>  static void blk_mq_finish_request(struct request *rq)
>  {
> -	struct request_queue *q = rq->q;
> -
>  	blk_zone_finish_request(rq);
>  
>  	if (rq->rq_flags & RQF_USE_SCHED) {
> -		q->elevator->type->ops.finish_request(rq);
> +		rq->q->elevator->type->ops.finish_request(rq);
>  		/*
>  		 * For postflush request that may need to be
>  		 * completed twice, we should clear this flag

This will compile to the same code...

-- 
Jens Axboe

