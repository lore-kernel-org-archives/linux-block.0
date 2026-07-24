Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77936376A17
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784899755; cv=none; b=m8gVWiwVVNSXne5JG0deMm1iPTJ1XNU+FpQy8O3Qc9Lfda1NZiAHcsxS/IWARq0KXMVcPm4j298C5LqqbXEF7LBawaix9TOsazjZMAXGHnExvIdO+sYUtcvpQZLF6J3oZbjmiW0T3hrC4/Jfj/skn1jQwehGHPJo7gOCLm4pzpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784899755; c=relaxed/simple;
	bh=yz+/AVCcs7dGYmuHmNbbQKIC/lt8UMfpEiho0iyjYiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OEmE2gUjTtAQrFosChjyGENOIMLbNXe8gLlNrvpvzhBrD0jBaTBeeORqrWbW0+79QdFsEbSBHDXalRnNUnBoq1kNMdJ1dqEdKcXApfz9IlrxzAKoZfzmmXn70Y1KTny0bx2J1EjokJX9aoxMjbWfrtasXc01iN2vW0D+JRBfyD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-471eeac43bfso436573f8f.3
        for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 06:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784899752; x=1785504552;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aHuHrzO50Iy6z0MvBYXW3ZKFWlwXidTBEpMxTWDNph4=;
        b=cROUJeFEz0mqdstIMSyN1rfqGLt304xvu6v7+9H2DNkw/Mm13XfFGOeSSKsnaMa73M
         jfaYbwAYCyPHml2Qr+ZNba7S1aSkwADy4dZ1Z86gWUymsEZSFi/Gw889rtGCHWrp7Qvr
         DM01KtViA/fGCxrI2X7HvlibIyXGiwV78DLCbJpq4jagzuITMmEIJvB2dG0Qq8rKXFNe
         XyuBpxhdcNz9CAw+KOeoRQOj+vL2sLe9ofua0TEivPu3mEuYsL84OoaRTJW6x1/wcy9v
         8JPhDf+u2YTaOv1SAn+ofFjv/wMsLv42KyKyCMDfxhxrgLVIviRRSdz/8O1PnzjpOR7o
         yQpA==
X-Forwarded-Encrypted: i=1; AHgh+Ro+ODyFVWgYIs68lWV7I9ba8iLTiGqcHR7IRiWDs5QILk6hTqNhr9PsTveMqjldphGRxLnzoeiAzmO8mw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo1WvsR1nuKE6VJUu7Ih5EUV+VxpsKeEerS3/f3alL7MK8R2CT
	lW7D67sBa94EI73wyQh03ijwv78bgOK/uC+Lm+MdKL0CsTNozwM6Y0Vr
X-Gm-Gg: AR+sD11KdaVB/OzE0gl1zARY3A22luMKtca2wc2vu5E7o3KenQ7JeBGCOpZon1bHeZB
	EVuZbhxqk9RcS2FBCdwnjZyhCj5AdNSlL+1yPo/sRNj/9EH44qVJQ1XXR/eWORa8l/m4TGY4o6l
	rwE5l7gpTJ+ujq8BpO1+FfGm03WrHOb7wNIPF3QWywG6cCoanJK67Un/hmkUsODGWK8zJWVTfYJ
	iqntUrdlHKie/UAQBBKWHyQvtyg8E7FzElB/tSjk4LB5N9HV4Zs0eHYflofyrmNoxMj1S2kogGr
	wFQfjeDx1sxSuzqt1piytOW0Tw7cRAmhXEyjRl+IcfSM+iHGiKlUk3FojERdG4ReORfGr5yAEDH
	JmwTkcnT10ZrJvrgqnD15nnQlMDq61/p+MC3SyFinJmtLJA8WleP/VWyGvsjR3GEKPAZgO9MZRA
	==
X-Received: by 2002:a5d:64c4:0:b0:47f:9ac6:ca5b with SMTP id ffacd0b85a97d-47f9ac6ccbdmr2258907f8f.37.1784899751418;
        Fri, 24 Jul 2026 06:29:11 -0700 (PDT)
Received: from [10.68.32.41] ([5.194.84.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c7880dsm25036785f8f.37.2026.07.24.06.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 06:29:10 -0700 (PDT)
Message-ID: <b70879c2-4dac-4068-8a98-ef1d28168234@linux.com>
Date: Fri, 24 Jul 2026 17:29:07 +0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: efremov@linux.com
Subject: Re: [PATCH] floppy: unregister platform device on add_disk failure
To: Guangshuo Li <lgs201920130244@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260708105703.747262-1-lgs201920130244@gmail.com>
Content-Language: en-US, ru-RU
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <20260708105703.747262-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Thank you for the patch.

On 08/07/2026 14:57, Guangshuo Li wrote:
> The change referenced by the Fixes tag reverted a previous fix because
> that fix added incorrect cleanup for the platform_device_register()
> failure path.
> 
> However, reverting the whole change also removed the cleanup for a later
> failure path. If platform_device_register() succeeds but device_add_disk()
> fails, the current floppy platform device has already been registered and
> registered[drive] has been set.
> 
> The common out_remove_drives path uses while (drive--), so it starts from
> the previous drive and does not unregister the current one. As a result,
> the platform device registered for the failing drive is leaked.
> 
> Unregister the current platform device directly on the device_add_disk()
> failure path, where platform_device_register() is known to have
> succeeded. Leave the platform_device_register() failure path unchanged.
> 
> Fixes: 895a9b37917d ("Revert "floppy: fix reference leak on platform_device_register() failure"")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Denis Efremov (Oracle) <efremov@linux.com>

I would also add
Fixes: 47d34aa2d211 ("floppy: add error handling support for add_disk()")
Cc: stable@vger.kernel.org

> ---
>  drivers/block/floppy.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index f04397b8e381..7a34af534460 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -4729,8 +4729,11 @@ static int __init do_floppy_init(void)
>  
>  		err = device_add_disk(&floppy_device[drive].dev,
>  				      disks[drive][0], NULL);
> -		if (err)
> +		if (err) {
> +			platform_device_unregister(&floppy_device[drive]);
> +			registered[drive] = false;
>  			goto out_remove_drives;
> +		}
>  	}
>  
>  	return 0;

Thanks,
Denis
