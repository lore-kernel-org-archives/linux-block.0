Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FE738B12D
	for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258048; cv=none; b=WjXCMF26LjcQ/ehcWXYWeSnI6fjozvxVnRtf9A21NqLx/N1VTX5Vz9DzrpBLg4uXTl7TkdQzs6XhGxfajWZV8+AXw62v18S443dgX7Io/bx9iNrtcoBnsujMroELU4klM5N2r0O4KyQN1f/PIcLid4bsFZzbc25zqKQsbZ6vPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258048; c=relaxed/simple;
	bh=35BPFHRsAyeryQP2wvqeIo4z1K6AcrSpVNIQgcBWGjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3/Jp4Ice33aLvrouIKeH7DGo6ViWRzPlvZZTZhucAAv/iVgMDvt6KNioYNyaAPg5mtQYjnHepcibzUJLrCTeArdCMkrGC00vpi9nkwu0vRtr6aql91Sz29BjkoNvfuvEoa9iN15svNROtfpXiMlr4z2inTrN26M+jycRmgStEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38dd9f11a09so62128151fa.2
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 06:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776258045; x=1776862845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgomoS20HLCqI2HEt2xjHn1d0Vkw6fKblazGndW4B0c=;
        b=Ck7Kdc/jEv+/MH7IvMw2+t5FTMtYVI6tn3y7CmfuLBxHEdwq1b3/F7C09WHJw1bKFR
         jPmC0x17bfMkr6jXcscsPUfCzg7QQT2o8cKIiMfeImJLYhkSMVUpxNwUMGYuuY+48Idf
         1S2DiacdJejYVZcaAveoTNLV04LGxDswYXH0vNany+2NE1aSauX+7Oz/qOc0+N/jE5Kc
         l08X8hEDAAsWO6t2B/6+70Xpv59hxmpqKNZbBhoR1ZEWgYJnVr0KnybNxMpYrjaUZ26F
         VjdSIyXWVFrM62ip3ZupV9YD435knOtHc6SmWMWJ+gAAIiVrinks1N7PjOXCE9UBxZl0
         oMyQ==
X-Forwarded-Encrypted: i=1; AFNElJ9I/Tv9sAJsp2+3jThDUp1PF50cSUFy75tr84PM0NAF4KypsMvricQ21opcfEFubeK6Z37slB66D2h55Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1xTgqhlqqJ0vX0H+4hVDgX3jL2bMUgjFKOGpx2mMsEYpAgnmg
	sEJAIHvI/Tc7PWk9ZKIrc8JVGG1ouO2G47U+hdG2g3t8BJvvspuYNomo
X-Gm-Gg: AeBDieszm38B4mTCvUJ/uy9QDBASsy1OgfX/TOxzjb6AW66A8W/l9LO7wp8pk4tRTJV
	lVPH7mrPPaHgymcBuv5XadQvtqbHG/GjrVxJYCJZMGayNqL3bn5TCr1eb/e6NIKERxQX1hqm7S7
	WgtELRcBoi9B5sa3cusChUOTncbnvQv/lHy/RQRxilAJyVown49quNsWmynqf/BIMZlhfFeYs/1
	ZKUHdb63Jhtnb0qRnCVv9t2Z8uKD5Ky1Jbm2rHyAHOgm0bWmlNlnTx6tXHHKXE7F7k6vpSizWfE
	pDDCVGiZJC6nR4ynf9IHzsCdqSh2wTIOBit9l/FRwuqn81CobJo+X+kw7QMTEZWguaLZZVa/mzo
	DhLsLxejDcuK7tJDZ0cIWct4p/5CXTfRZGWQNk03L/yii9NKmaTMl7x37TNMmzP3MTKD6sMrLWG
	cA/u05Vx9FUja4aUPey2hwmxonn1us1lPKzaG1u7XQ7RAySO11KgaEwFPRdNwyPUkRXEgN
X-Received: by 2002:a2e:9fcb:0:b0:385:9b50:91a8 with SMTP id 38308e7fff4ca-38e4beea127mr72404191fa.15.1776258044331;
        Wed, 15 Apr 2026 06:00:44 -0700 (PDT)
Received: from [10.68.32.41] (bba-86-97-226-202.alshamil.net.ae. [86.97.226.202])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e9e9b83f4sm4070891fa.9.2026.04.15.06.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 06:00:43 -0700 (PDT)
Message-ID: <8afc6b6b-399e-4f77-82e8-3c0e717f765e@linux.com>
Date: Wed, 15 Apr 2026 17:00:39 +0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: efremov@linux.com
Subject: Re: [PATCH] floppy: fix reference leak on platform_device_register()
 failure
To: Guangshuo Li <lgs201920130244@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260413153114.3040093-1-lgs201920130244@gmail.com>
Content-Language: en-US, ru-RU
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <20260413153114.3040093-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Thank you for the patch,

On 13/04/2026 19:31, Guangshuo Li wrote:
> When platform_device_register() fails in do_floppy_init(), the embedded
> struct device in floppy_device[drive] has already been initialized by
> device_initialize(), but the failure path jumps to out_remove_drives
> without dropping the device reference for the current drive.
> 
> Previously registered floppy devices are cleaned up in out_remove_drives,
> but the device for the drive that fails registration is not, leading to
> a reference leak.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review. Fix this by calling put_device() for the
> current floppy device before jumping to the common cleanup path.
> 
> Fixes: 94fd0db7bfb4a ("[PATCH] Floppy: Add cmos attribute to floppy driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/block/floppy.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index c28786e0fe1c..d9afe495d5c2 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -4724,8 +4724,10 @@ static int __init do_floppy_init(void)
>  		floppy_device[drive].dev.groups = floppy_dev_groups;
>  
>  		err = platform_device_register(&floppy_device[drive]);
> -		if (err)
> +		if (err) {
> +			put_device(&floppy_device[drive].dev);

1. Let's use platform_device_put()

>  			goto out_remove_drives;
> +		}
>  
>  		registered[drive] = true;
>  

                err = device_add_disk(&floppy_device[drive].dev,
                                      disks[drive][0], NULL);
                if (err)
                        goto out_remove_drives;

2. We also need to fix this case.

platform_device_unregister()
registered[drive] = false;
goto ...

Thanks,
Denis
