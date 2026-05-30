Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3252F5A36
	for <linux-block@vger.kernel.org>; Sat, 30 May 2026 01:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780105451; cv=none; b=Vm3palgz4s66ZIucle2kqchnkA+hZmL3AcVEUayQN/YKpQRecnrXWx4vVuR8p+6YMPRcBJ/bC4gVx+6Za93Prb/UFFe4cwdJybsVadCOiCGldIzUUMZg+VzNWqkC4IvKlc2sP/IXdpHPHr+L5DfM/2Smy2zaqkyNJUYad2+pvLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780105451; c=relaxed/simple;
	bh=RoQnkjSAGQlltUOHi6qTBWzLW/MPRpTjVtIir1Bku8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhzwobvNmar14FXrFiLxNFT4iI0x/9FVwNdRZyKT2n4DF/NLfjL9S0Sqod2iZXaL0bYCLR9+ZsbDmy6XYK0r4XauYsNEIKyzPPEg1eqRVfWoZHYIAo9LA3XZ4vZvR0pIbQHf5ZLapQCukxbEJlqpR6jbEn3rCEChcam66PBuAk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=DxvId/bX; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="DxvId/bX"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40ef10ec84cso11932107fac.2
        for <linux-block@vger.kernel.org>; Fri, 29 May 2026 18:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1780105449; x=1780710249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+zTIztgsGKEhgjsVhvr5Rv5TrBYFcWsdOmt+WZ+x9w=;
        b=DxvId/bX6y9ovt3FpOHoF/jE8a+2ZK+wO1h+JJstdq1pihW80TGRlPSKVszpS7/Efj
         YeVhEK5WftrE6UJNCse0z0hN9zhj2hOcNgzoo94sO2+Ifq5Yd1XkVNUYxyfEpqbe2JtU
         BICSZC2kiX0GAWnMOs7u+/dJk0Gkpgz79rHqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780105449; x=1780710249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+zTIztgsGKEhgjsVhvr5Rv5TrBYFcWsdOmt+WZ+x9w=;
        b=PRWOdC3V464t584F0aZInM7arxmYF+1VwcWrhX2qJorGuAdWKIQHln7rETRP/2Zl0s
         +GmTc4LyxrtwTFl4IyHiGVxDhrvml9LwMRdlEWgVV86nPZ4OkeSrFW3QVOwyASxuD8U4
         N9OXIZ1j/8cUVCceRQCadp6rrphCBLVBP40zRjR0quaqcivefIE7b9UBCMaDpNJbRARv
         5Qm4R29T7HKziA/SdO0ceamKnNdS0JE7FPp9WxjRw5nX6n8grjyc5Y8mKnx4YZsSmQhF
         LY/epANJDFueXHXlVbYBwpgUyq2UqmR0fw2ZrI4qua0dsJsDwTSbk2eAcGX76byK3DOf
         BBxw==
X-Forwarded-Encrypted: i=1; AFNElJ87cJtFzGdntKf9ZOhn/WbBKp4KD4M74ENHMfcyerHZHNRY56MLJOSeZps89NMMpQg9c/i7auFXTBeIZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf7lpcKq44Jf7womrBAo3M6cQPZrCjeSlffSLkYHm5ybip+ZaE
	zvzd3iCKrwJAlubQKMyF57/yAldCS2f9aNF8KWGl+QfxDaozGQE28eEhITEgvCv1cA==
X-Gm-Gg: Acq92OHiTfsxAeizWWGQUTY0T/HR5fjQs/33htVAE1P/lM/edOMPPl3BthUqPTB5Wwu
	oS4Qb/2SJg4R9L0BdVS9rw0VYzj1MxwXWEm7S4e4V4BHdPlXeNMTVfegR5rNsQ/RaJ9Dte1NUTg
	a/IS6NhOiraEt8ltZLoTAGZJvVCaKI4WsHaPONllXrcDFyQTfrvjvfiZdE1WsTaI8BdZLproZeO
	32h8/GGUfIGuti1YHd3Weo3ztVr34qOTxey9rQtXtf7UJtGIiE0Xolstu8RggqTAWCrEGoQLeik
	KlMFt6YaDAk2pc2o0ndkHQ3ekU4hW/xyk/f5BhFBAKLeli7sX6gS4LBgYbjFKdsxdvpDZZVfQV4
	59l6BovmSOLYDgBOeiSALw7RC/li3FmFLvgXELP9I7Q96WKljHP6vOm4yJCsDRflTh40NjBrIZv
	aBhFrS8Z2xDlM4yzOE/BNj17tassWy
X-Received: by 2002:a05:6820:1996:b0:69d:795a:5e8b with SMTP id 006d021491bc7-69e105d4115mr948538eaf.60.1780105448859;
        Fri, 29 May 2026 18:44:08 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-43c94078170sm2262599fac.14.2026.05.29.18.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 18:44:08 -0700 (PDT)
Message-ID: <284d5062-460e-496c-b700-2275deb7f8bb@ieee.org>
Date: Fri, 29 May 2026 20:44:06 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rbd: check snap_count against RBD_MAX_SNAP_COUNT
To: Rosen Penev <rosenp@gmail.com>, linux-block@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@linux.dev>, Jens Axboe <axboe@kernel.dk>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "open list:RADOS BLOCK DEVICE (RBD)" <ceph-devel@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>
References: <20260530011255.52916-1-rosenp@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260530011255.52916-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/26 8:12 PM, Rosen Penev wrote:
> snap_count is u32 but the comparison is against a SIZE_MAX-derived value
> (~2^61 on 64-bit), which clang flags as always false with
> -Wtautological-constant-out-of-range-compare.
> 
> The proper check here should be that snap_count does not go over
> RBD_MAX_SNAP_COUNT.
> 
> Assisted-by: Opencode:Big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Looks good to me.

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
>   drivers/block/rbd.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 94709466ad19..25215c209484 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -6075,12 +6075,9 @@ static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev,
>   
>   	/*
>   	 * Make sure the reported number of snapshot ids wouldn't go
> -	 * beyond the end of our buffer.  But before checking that,
> -	 * make sure the computed size of the snapshot context we
> -	 * allocate is representable in a size_t.
> +	 * beyond the end of our buffer.
>   	 */
> -	if (snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
> -				 / sizeof (u64)) {
> +	if (snap_count > RBD_MAX_SNAP_COUNT) {
>   		ret = -EINVAL;
>   		goto out;
>   	}

