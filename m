Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E82779DA
	for <linux-block@vger.kernel.org>; Thu, 27 Nov 2025 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764208244; cv=none; b=e1TR3v0Pf6LhlxLkBiJf4Blax3fdcOisrxEDc8p7mzyHjpOLqv3xRMslzYY9D9iwR0zrp+vo0KBTHy9QbMxhVUD+doTFnITLXqcZVVFMTXCagtYE49TYSdK3Xc7NmCVWKA7PNyvLORpZKMbER1PURzVUW4IsB2jjoKtLnWVsrGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764208244; c=relaxed/simple;
	bh=Kn8akwjvxQixSNIaZQZD+vOsmkmEcSvpVN4ZCWhW3Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQQvwD78YfzPVjvhU3BdvQk+vbhM94dCklU11X1GzYLlv6qBtKH6wZeYc7uul35PaS7mJno15a/eaEdq2Wgb6vYi89C5n/fvsEctPTLTKfl3ybGCD086n9TC+ycCS8+Kbki0exqT50QvpoocWhpK9wfBJERH8hVEI4VJqrQYYVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZLW59N5O; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZLW59N5O"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-297dc3e299bso3652675ad.1
        for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 17:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764208242; x=1764813042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/8VvJO1fOJXpELiWZc7e5hc+hqhu/RgL1JwlVxJq5Ew=;
        b=ZLW59N5OIjkEaNUZcfAwBu6HI+G3NucvBEEWy3IqSbMgxTFEv2qKlUMXMnITh6He14
         b99UuIL++7e3XIFrO1dsgTcSn9kwe/pgH1IgPQm5MQVII0hG9UJZJN+7O3NehHedLRgw
         1EVoXYs3M1+xE7zFzAIMtEuF3Val5E1NMG2ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764208242; x=1764813042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8VvJO1fOJXpELiWZc7e5hc+hqhu/RgL1JwlVxJq5Ew=;
        b=c+OQt6EQ+FbOSElLjCc8UbegAPNarro8N7v7pEY46roM23lH8Vw7PLATH58+siuWAa
         sBPM+dkE2rilXCMg9stANSWOqpb8Wgo0Suv1Rm9OzxZYuwUi1IHKoClOFGpyJKvwtaUv
         PA+598f35vabGI7M6reoby/A+1ZMig2xYywRpaXVNZI3I75YLjNia3b7ObxEA3HFlpKa
         bMb9G4SM/HyZ1dIKtnsrBv6s1yezwufsnzfkFZI4A+zGlQG5Pk1sPbgnhZSyUpVG0y+F
         UDMyNY2zJoyvrG13FVWJ7Dxe88lm5K9Ju6dPLlTeLGfWBg5uMfmYvj3tdoTXGkPc0Nau
         wdsw==
X-Forwarded-Encrypted: i=1; AJvYcCVjUjAnpGLPB/nCpiGqjkCh+sO4GfHjnQh+OwwtgiF/H/Wmw6npcpkvJvQ73X7/8n2ZVXYHG5x90nc2og==@vger.kernel.org
X-Gm-Message-State: AOJu0YyggNqwKuqPQ/rY9a3AtGqIDq1zFSMl/z1AUocxYT9ogFmor5MA
	mo12sWt+rsvP6MdCAGSGE2KUhRXbVtstZRCiiqnl5tPFjDKFf2zPCivnmf4rR8fD5w==
X-Gm-Gg: ASbGncunIj49yxMLnNutLdiNQglHnx5z5xf9MES2vktDBLCG0zeB7cWfar5y41buPSF
	NNIweWjBF5VBq/r10vLH49GCbS55VQyWw+rY3imbo2t/Yk9gAH5ZPtEua7kAzBj84qE4X0sK5BV
	NtFlFTL0ADzVFAv/ENO7tDApoIcS2KrKWeOpvv/w7IwpnKljZ1rmWR6Dd4M79r6i1AbZc8QGK90
	nAphU3sq7nYHBqVnWw5J4vWaw68T6pBIF4nQ/uKHQV7H21Qb8VD/pZUVOXfSr93AYMdHmpn8cA6
	Q9EWG9RyJJiSPk5j7aEyldZ593sZvfy643y1aW2KVbN2yQ5n54OT1tQCGSnSmrNMK0XukETZl6w
	ADT4kWR2WZN8dcCVfAxOYSmgOwAhz1BplFUkje738M4l7mVNWbLL1kxiIOOpavPwNqZgtqq4uYj
	ESxKojw9JBmij9y8HJ8kIu1heoB8byOxqCvy8rkGUG0adrRi3PcxI=
X-Google-Smtp-Source: AGHT+IHgcQADT0S/SAt3jzLtpA4/Qm7H0Zc6Dpw6NUnQ+j3x+NaoXUXDfxPAeyfQ6JN34fKPqB0urg==
X-Received: by 2002:a17:903:1105:b0:23f:fa79:15d0 with SMTP id d9443c01a7336-29bab1a156fmr97898715ad.46.1764208241899;
        Wed, 26 Nov 2025 17:50:41 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:b300:d0d2:5451:288e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b29d706sm207330405ad.80.2025.11.26.17.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:50:41 -0800 (PST)
Date: Thu, 27 Nov 2025 10:50:36 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	Heiko Carstens <hca@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zram: Remove KMSG_COMPONENT macro
Message-ID: <4q7n6k623tz5xvg3or7l5pcuiq2kd2gk4gezzfmnw5eelvou6e@kgsakiwwztxn>
References: <20251126143602.2207435-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126143602.2207435-1-hca@linux.ibm.com>

Adding Andrew (message id: 20251126143602.2207435-1-hca@linux.ibm.com)

On (25/11/26 15:36), Heiko Carstens wrote:
> The KMSG_COMPONENT macro is a leftover of the s390 specific "kernel message
> catalog" from 2008 [1] which never made it upstream.
> 
> The macro was added to s390 code to allow for an out-of-tree patch which
> used this to generate unique message ids. Also this out-of-tree doesn't
> exist anymore.
> 
> The pattern of how the KMSG_COMPONENT is used was partially also used for
> non s390 specific code, for whatever reasons.
> 
> Remove the macro in order to get rid of a pointless indirection.
> 
> [1] https://lwn.net/Articles/292650/
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Sergey Senozhatsky Sergey Senozhatsky <senozhatsky@chromium.org>

> ---
>  drivers/block/zram/zram_drv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index a43074657531..4ea0d435a24e 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -12,8 +12,7 @@
>   *
>   */
>  
> -#define KMSG_COMPONENT "zram"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "zram: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> -- 
> 2.51.0
> 
