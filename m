Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3627605A;
	Sun, 13 Jul 2025 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752396459; cv=none; b=uP4H1oOpiZtVr3nAlnHVih5212XuywB1bBizob9EAn+5UTC/uwEIBZqT7l5F97u3Eofg03urbKXBZF9IuRllIJ0CyazgpsyVCaAOvG0YYrIkXC9RDv3PYObABNHq7fWH0+B8Z1O07o1nzWmnzXeiJLPWeTtxbzjG00X2O3qxul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752396459; c=relaxed/simple;
	bh=ErIV6F/dskQZ28y8ks2mRI8NQRW9+s4FE+z0oYKvTh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SH1ugcs1VmMp+Su4j2C7ucKQoI7GkjcEKxGeSTbZmmejpch7QihjvIEWA47iAQ10PMhWLJ5jXutsjtFylSIbMopwkp1/P0dgc9HXLB/FgDC7QtbWY6A/JGushHxTjLFvvh928fIS8NvUlMsNzDZHDiXhltP9/UR2DvC8QL36jYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso2665949f8f.1;
        Sun, 13 Jul 2025 01:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752396456; x=1753001256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YC0aDF4mhqUeP7qZP5FvgibZyhJSq7BXOGUgiIgLCXw=;
        b=PDgk4+jTiKnBBd0FHKmslPj/lVOP0oNtRvEp42r6fUzSaOPt0ab8GUHBcXV4Ry+qSu
         p/M3pR4PXy+zoi/e4Jd+VsPw6S3pjPccvEPdAF55ujLyZ3UtO8h6g7buZvoRjlAdxSlD
         rGLMOwHN3aBCFbdotZTAKx7wt5+mwPruy7X4pGKfRFxDHYNYTDQksNyIbrZpqDhqDF46
         pNjxttmNc28t+EZXjcAbnxpERCoySgad9ZN/T5NUZetfOqmE+JTS8RhKN2aUvk0IDicr
         dVSuACpttWsdkQ+tka+XgVZDkzkrdrSajoelknDktCMAKjAUr3No/1emZH2QmzIcny6I
         eU1w==
X-Forwarded-Encrypted: i=1; AJvYcCW/6WMGqSwFprpty1ixXdPpTnc6891BCf86GmrqB0aR/SbxmfsaLGxhyVo+qORFMaIiVK9pzIwq4osYULU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+WmcqDd3HX2rMfwOURSceAP2RpV0/xbIn4Po2KEgboeKJ/kR
	FiZ33m7a8ZgnaCEUGNdSzB9AFUJE5bQcfrD3uvKFp6vtVNtk9NsII9dh/mdYTw==
X-Gm-Gg: ASbGncv8HfQ5PA0scL9NJYfudfFdFVCA52anaZadO0XbpsjJI//JMUPybK2OaZXirkv
	qHjqq8eeAyqsbH5Y8UcYZNV/4YuWgKmIwq4vYu2h2pieD3fXEi9nUr9/GCoTycJ2UPXWkwGzMA1
	5mTbj0JW50UnRlJBJBqEkg2bkhVjXQUKcOowxKuAdKQX/9Sh7H4XSTCTRi16JCmkngsgmm/mhXo
	dEkOQz7xWNdlUMVVeprYb1qkEWb3MSqyXT9XUWpLoxU71OQ/Si1DrE7bR2xSDKDAurxA7ZGgfqR
	yYJ9TbFhpqfXlZz8j4muwuJEXesm6FbjU6+2jLGtrvWAkBk5LK96SN4LsXCrlrGcNGa7VDh+3Sd
	X+YumqhuXFIrPTxZpQZtd5czNb78dPMZM8iIXvRq9UFKQpLlNHDi1fzAOeCT1OQ==
X-Google-Smtp-Source: AGHT+IGhjnLJDazyUD9SqKbMiaLSv71+RFUeJoF9Qa5K33Ga1+ToP62KlsipLNNmPRkK2jOx3bh+hQ==
X-Received: by 2002:a05:6000:2004:b0:3b4:9dbd:eee9 with SMTP id ffacd0b85a97d-3b5f18d999emr7655106f8f.36.1752396455563;
        Sun, 13 Jul 2025 01:47:35 -0700 (PDT)
Received: from [10.68.32.38] (bba-92-99-24-62.alshamil.net.ae. [92.99.24.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1ecbsm9137306f8f.25.2025.07.13.01.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 01:47:35 -0700 (PDT)
Message-ID: <3625db90-8b5c-407f-bf8b-6c5919fec2ec@linux.com>
Date: Sun, 13 Jul 2025 12:47:29 +0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: efremov@linux.com
Subject: Re: [PATCH v2] block: floppy: Fix uninitialized use of outparam
To: Purva Yeshi <purvayeshi550@gmail.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250713070020.14530-1-purvayeshi550@gmail.com>
Content-Language: en-US
From: Denis Efremov <efremov@linux.com>
In-Reply-To: <20250713070020.14530-1-purvayeshi550@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/07/2025 11:00, Purva Yeshi wrote:
> Fix Smatch-detected error:
> drivers/block/floppy.c:3569 fd_locked_ioctl() error:
> uninitialized symbol 'outparam'.
> 
> Smatch may incorrectly warn about uninitialized use of 'outparam'
> in fd_locked_ioctl(), even though all _IOC_READ commands guarantee
> its initialization. Initialize outparam to NULL to make this explicit
> and suppress the false positive.
> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> ---
> V1 - https://lore.kernel.org/all/7dd94691-0b37-4855-be43-661f954275c8@gmail.com/T/#t
> V2 - Initialize outparam to NULL to suppress Smatch false positive.
> 
>  drivers/block/floppy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index e97432032f01..24be0c2c4075 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -3411,7 +3411,7 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
>  		struct floppy_max_errors max_errors;
>  		struct floppy_drive_params dp;
>  	} inparam;		/* parameters coming from user space */
> -	const void *outparam;	/* parameters passed back to user space */
> +	const void *outparam = NULL;	/* parameters passed back to user space */
>  
>  	/* convert compatibility eject ioctls into floppy eject ioctl.
>  	 * We do this in order to provide a means to eject floppy disks before

Reviewed-by: Denis Efremov <efremov@linux.com>

Denis
