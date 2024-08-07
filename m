Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1DA1EA0A3
	for <linux-block@vger.kernel.org>; Wed,  7 Aug 2024 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039000; cv=none; b=WsAVv10x74blE2pqOMMxsm22yoUJF431PLbryMY1u5Ch3obMJA5ls40pMBV2lKisfmR2jZVoaMBrDYo20jBqaXuq109OSeLSg0oPslUo2mfivYWgNZmtMgLuhdTKc4sTxM4u5S9bVgjV3yv9n1KihKjcltfb/OtajNs4IGTRcSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039000; c=relaxed/simple;
	bh=oyMT0FbvyEUEWDumW0O7TOVW/E8QkS8/DViHTmTG7n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtdPNI3JBYcwaAvh1eEtCLbMnopYp2QwEqqu53bVTR4xa5sOlV0OsuEKADhxZIHW6EhUwbAw7EAvjB2ZwTC/BF4c09TXPa7nNEZkSNaWnFtM3vWTjpVi3qxroeu45s6a/vGRW79OGKSSWj2w4W7V1taIaLPP5gIlaBY6JA2FFJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=lc2oidqi; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="lc2oidqi"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-81f91171316so398626241.0
        for <linux-block@vger.kernel.org>; Wed, 07 Aug 2024 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723038997; x=1723643797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JuS59JADbTnnYXSWbhEozGqiA0xSa9BLnZ7t90LFaxE=;
        b=lc2oidqiHK/PZd850fOIITaMn2RGUlKb3BVv7MpS8fFZ9dNtTcJZuKMqQFSg089EE4
         Bns4dZxXHwAZY/CrtRqmIXTfryJxNj4Z6sp5udPe7C2X5SwMy3Ytixf24rK1ROPMHQ2Y
         Um9oo8nOQzmV1QHz2Fj6TEV7pAUfKGJnCzJ2ZDL7HJMbFAMMut4lPwPQZhmV6gDXM4kT
         2Ar14wycSF/0XZavqs4Y+ebs/yXryX8E5UCqq6VBVSM2eYFBKr/Rj3gtru7jUmHoY1XC
         mtKF7pFQMRnZgbU8b5uLtxHO3NEV+Pali+XanCikuJFbyZcgbAZ9TYIYSdqi0WBr2uEd
         yg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723038997; x=1723643797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuS59JADbTnnYXSWbhEozGqiA0xSa9BLnZ7t90LFaxE=;
        b=JAJ8eV2V7RNG4/vRtNuvLcHTyzOMdphO/iwauH+AexqPgr8Ui1v59QQU79BPMVen3H
         3JbIppV2eF3jL9qgyGdJkqKc2EL92F1KXl10NR4Vqk0J426nBDpMhzrTEb+zO0tIf6jZ
         rRnNHZ8OAvqSr9NC7Tds4tOaukUqwb5nKCp63lBFuL5nwfJszyRXbMrQBF7jO2oAnP/f
         cfMKm6FGj57+VeR0iZE6+0QHaOCSYbC0hFQXLhZuFIn3d3T6nUFe6aw3wY8KSXv3oNiN
         VZ2AtfHfopz1G1L+cbGMIbMTsXuK136/o8KGOk+mW/z+RIAzoSh6Sch5eGjlpfAQ5beE
         oy0g==
X-Forwarded-Encrypted: i=1; AJvYcCXzNvtzbARFMfsJuouWN5g7XPP8hPZoQrsX+YrNWx23E4gqimKG+9p/AhDSouowgZO1IDoZJOF00xCVyNSOKR4tFSX+TwK+2D4MyYY=
X-Gm-Message-State: AOJu0Yy6xSinwzt9ZcEdkUA5Q6c0oJwUn7542B0Q7LUTAd3UB7H4McT9
	cvSOpcTY+bheFd1yzYj5tr9AcIX/6hP4xw/O0ihicNTAOipzOdz9XAMpINxPAiaN8OcAaXbqmnU
	O
X-Google-Smtp-Source: AGHT+IEOWFTdrwiZrbHViifiqbdv+xNaB1znBNizFfr4dGmtnW/qOKfBByKDT2UtyQKnBsMQ2WkouQ==
X-Received: by 2002:a05:622a:4cc4:b0:446:5c58:805d with SMTP id d75a77b69052e-451c79d46dfmr52220451cf.19.1723038986722;
        Wed, 07 Aug 2024 06:56:26 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c870066csm5157471cf.4.2024.08.07.06.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:56:26 -0700 (PDT)
Date: Wed, 7 Aug 2024 09:56:25 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Wouter Verhelst <w@uter.be>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] nbd: correct the maximum value for discard sectors
Message-ID: <20240807135625.GA242945@perftesting>
References: <20240803130432.5952-1-w@uter.be>
 <20240806133058.268058-1-w@uter.be>
 <20240806133058.268058-3-w@uter.be>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806133058.268058-3-w@uter.be>

On Tue, Aug 06, 2024 at 03:30:56PM +0200, Wouter Verhelst wrote:
> The version of the NBD protocol implemented by the kernel driver
> currently has a 32 bit field for length values. As the NBD protocol uses
> bytes as a unit of length, length values larger than 2^32 bytes cannot
> be expressed.
> 
> Update the max_hw_discard_sectors field to match that.
> 
> Signed-off-by: Wouter Verhelst <w@uter.be>
> Fixes: 268283244c0f018dec8bf4a9c69ce50684561f46
> ---
>  drivers/block/nbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 20e9f9fdeaae..1457f0c8a4a4 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -339,7 +339,7 @@ static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
>  
>  	lim = queue_limits_start_update(nbd->disk->queue);
>  	if (nbd->config->flags & NBD_FLAG_SEND_TRIM)
> -		lim.max_hw_discard_sectors = UINT_MAX;
> +		lim.max_hw_discard_sectors = UINT_MAX / blksize;

We use 512 as the "sectors" measurement throughout the block layer, so our limit
is actually

UINT32_MAX >> 9

since we can only send at most UINT32_MAX as our length.  Fix it to be that for
both patches and you should be good.  Thanks,

Josef
