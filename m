Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CC41FBEA8
	for <linux-block@vger.kernel.org>; Sat,  6 Jun 2026 23:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780790114; cv=none; b=RtOw/qqsvaacODrfrcvNHrPVHELxG23PWwRKIXg4hJ/kLArmYSsIY/sZhcB/6ZhUVfj3ZJLrALGXfmLy77ln9JLRbhZjEWM0r1TiYBAyPtLGEWGsnoSHKystNSFplux+3HWMo4IXkesav5krgZubzMISlr37BW5ZtvWNMu9NTfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780790114; c=relaxed/simple;
	bh=K8OYtNJC3IIZRMBqEi51lk43u3HkOmDMFO6SNuAuxjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8BWyvngjHbockD7OmnLUpN7FE6ixPl0pqYUp5uHBnub6d5+TKphE3TnWhJB41Gv4rZ+qOWrYIUeiYnvJlhOrgNyXF2Y54ywDqC9TSwkZsYtO3v2YDkU1bhzYW5wg/9vOKuVUnqNmYiH9rBJdatnkZ81GBGHRFj5FrjfQDW80dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=CjTBQgqW; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="CjTBQgqW"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4865e953031so3687372b6e.0
        for <linux-block@vger.kernel.org>; Sat, 06 Jun 2026 16:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1780790111; x=1781394911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wVY/Nc3kfIfRXZcic+3QshizwzyK0GaTXzlxRWeoy2E=;
        b=CjTBQgqWJ1AoG9moWTWz/rQBt2XUZTccRHRslxYYs8rDeuZpPFCHGbg9VlYWySgi/M
         v+skadR8BA+TmVHyxiH8MN2S9tpcYgaodi+e8NJUN4oT/9dw24a69wRaPWJqVTzFs5El
         /EI3L5s9ZNmjOQ3JMpDrqny+DSq7+oQcGwt20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780790111; x=1781394911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVY/Nc3kfIfRXZcic+3QshizwzyK0GaTXzlxRWeoy2E=;
        b=PdSEqprwCGkYF4fiem8kbN9FuwLPn2/q9KseEtQJHlpPSn2NY1mt9nvuJG9bIPIsNH
         PqRBDDeIH4Z7MMde6Gzd5mVaCg3SPPXIHZ937JG5x47ckxOVVjw01YjJhPIQbd9F/anR
         19uZtCSIgWQRc2E3h6hcYUJkoL+PND7B+nijRyBmfH2+2YMQPiDPspuQB91Z36HidAK9
         F9BW1VflOSQATa+he8S8WxhtW0lgprcMzygkUiv8m7q3V4ogilG77Yf3w9Fcs7SsvPRD
         2IEKlKmyCUhw+7WTr2uP+01InK/zEDN+DSNj0Dp2jj9mvA4el0Pml+4v2BnNf9YF5GVK
         5p+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/zYdEBMUErJGts3tNDYkf6BehkJmCkhay5qSQSEkk424ch51cVtjOSDK0WRnFFqNf3VgI730ZCiBETMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnhvWJjJ0GhEQAJ+qlijMSjWSwM7OFqX0wlmIRS+D/DbUcTA6w
	YX7PSifC3LwNqyXvGfwMp2ycZZP+UTWV2gNLgtSBRJZHzo3KutehWNXzbJ4SW3ZRSzOP+CFSRfF
	Udp6+XEzl
X-Gm-Gg: Acq92OE+vlUFeDpUNLZsXkoB2L2TCCG6zX3W1acCkMFW+RcLleLL2BJn+yN38aWnVOJ
	xdJKpXXDnO1Sh6qfkgWuzhCSNJA2hSxN86QuVTTgUy8Ow+8z5+U6Z+ZJMm4qzINrGhFawr82/gY
	9qvI3ub3Q6dFYsfVfv8nkSLZiidGAsL49e3VrMTj65lOtuaDr1R7m2Q2j4ZgBkvr0j0KhKVCPE2
	hdwHbnUv1pk2S9ZHkCTO8R9SMd6RrjQlzGXaiWb7GqiwoKOQYd3etyBe41j7MLsYtTOpRk5zl/W
	ZpatEiN2WCH7RrNRqOmK/8tNsbCeho9PVLzOPFZ1tF8mRbJgLCbOEnS7AY2CmtVh5XNO93HzD8q
	FFvCUz2vJvcPCgVliEPuxxdzBtCTjnwIskynk2ujd++vZxTaY43nNFEgW8yv6/I2CiXaFXAaL7r
	G1KZ688qcaQC1VA5bUv5GRm8k8u02A9x64Ab9630HhmTgqeqbaLBxx
X-Received: by 2002:a05:6808:15a5:b0:479:d674:dcca with SMTP id 5614622812f47-48692c881fbmr3789772b6e.4.1780790111555;
        Sat, 06 Jun 2026 16:55:11 -0700 (PDT)
Received: from [10.211.55.5] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4865b5a53bcsm10302924b6e.3.2026.06.06.16.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2026 16:55:10 -0700 (PDT)
Message-ID: <dcb49836-cebf-40b0-81b7-c06cf84b81a0@ieee.org>
Date: Sat, 6 Jun 2026 18:55:09 -0500
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] drivers/block/rbd: Use strscpy() to copy strings
 into arrays
To: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Jens Axboe <axboe@kernel.dk>
References: <20260606202744.5113-5-david.laight.linux@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260606202744.5113-5-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/6/26 3:27 PM, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Replacing strcpy() with strscpy() ensures than overflow of the target
> buffer cannot happen.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
> 
> They are mostly replaced by strscpy() or, when strlen() has just been
> called, with memcpy() (usually including the '\0').
> 
> Calls with copy string literals into arrays are left unchanged.
> They are safe and easily detected as such.
> 
> The changes were made by getting the compiler to detect the calls and
> then fixing the code by hand.
> 
> Note that all the changes are only compile tested.
> 
> Some Makefiles were changed to allow files to contain strcpy().
> As well as 'difficult to fix' files, this included 'show' functions
> as they really need to use sysfs_emit() or seq_printf().
> 
> All the patches are being sent individually to avoid very long cc lists.
> Apologies for the terse commit messages and likely unexpected tags.
> (There are about 100 patches in total.)
> 
>   drivers/block/rbd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 4065336ebd1f..632fa2d56ea0 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3672,7 +3672,7 @@ static void __rbd_lock(struct rbd_device *rbd_dev, const char *cookie)
>   	struct rbd_client_id cid = rbd_get_cid(rbd_dev);
>   
>   	rbd_dev->lock_state = RBD_LOCK_STATE_LOCKED;
> -	strcpy(rbd_dev->lock_cookie, cookie);
> +	strscpy(rbd_dev->lock_cookie, cookie);

This looks good.  The rbd_device->lock_cookie is a 32 byte
array.

Cookies passed in are always a 32 byte array (despite the
function only requiring a string pointer).

Reviewed-by: Alex Elder <elder@riscstar.com>

>   	rbd_set_owner_cid(rbd_dev, &cid);
>   	queue_work(rbd_dev->task_wq, &rbd_dev->acquired_lock_work);
>   }

