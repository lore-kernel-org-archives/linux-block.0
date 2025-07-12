Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919AD199920;
	Sat, 12 Jul 2025 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752347804; cv=none; b=eZzBee8+ftXoLcQUy/8bXO22US8VoaRr4+SFyic5/1fTKJwgzLmBDFQiVhITCtrGaRKkdxv6Mna5S+moqkn0A1FM1juDxlkdL3zB9/PJKBT/wFqV/P/+kRX/vWFEJjeQXJ30bMe2Nl5X76lDeHH62qdKjpesgTFL+DCphmM1GPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752347804; c=relaxed/simple;
	bh=A2iwYtqlViyn1Bfa9lG8o2HlWL8f6t/AkwlnIEUPvec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F11ViNLAM8Rq8ZLR3KC37280CvZ2dK0ma6D2sRW4fZbYy/xOWQXW6PhyeQC2NzvxCfu3ihiWQUyM+sww95oXnVPVqEcxr4eSbnweP+sRdTlSyltES4M6OJQqq8BUqv8kqQidJ+RweKcauWsdwgDGcdglCB2K+1ETQFkd2CZXrH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-455b00339c8so11200945e9.3;
        Sat, 12 Jul 2025 12:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752347801; x=1752952601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m8ZsfYBHHbLmVPc2Fd9FFLMKfMGcOWFzJlUE6t1S3RI=;
        b=RWTRI07McxBtfpL9k8PoNFJQCIYJCN51aIjWewJkZ7UA1R6T2wa+HRayI8lGHywR6n
         n0znV1zWWLmjmliGLPI30zmBV5SWMPbUTGq4u5ajh39bxN6ijsg7NvGO0eKYYJBUybl1
         bFALpqBX5QjGs+IuDYLPqeX/vc0ElP8D6fVW0hCCjlXqU5XEOHgykUG34lkygVRthIgb
         mt9jrej8nP4At/Ga9mYuOr10xGnqzPJ+ZmaTOotimtUXWvw6PQuMSqzYzmvvUbjjFj9L
         Kc2HAceYhz0miR07f6o1Uiz724alRSgZGVHWiyzA3+WOYWEVfzy1JpIVdO3sgS19te8w
         tDwg==
X-Forwarded-Encrypted: i=1; AJvYcCVIzFk96o5T9VcE9CKuGy0FjCTf1sPHPJixXkfma5W5q0T+HAyJEUBNCUEdBg0DjpEe5JwrHucz/zp9Hh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyavOGjluac76uA0YBN59xq8828h7qWOm1rrjnVGj4+W26A6EIM
	B5ASK72bKos+1d6Rspcf3c+tkyPlHhHtjVnecrlx3ZgTE6GJoeCYwKoT
X-Gm-Gg: ASbGnctfUjah9XU8RNX/pNeZ+MEvFQVfG3LbnIZurAhpZDCpNKCwO0IxiWVgjYRyADR
	mPo1BZ+cg47w6kUIySYvblE4AowtLySFSdOhpFNTu+yjPWOlt+eyn+sMlsiHy12qny/w2uOKR/5
	ddY4pnYGtzJ2ENZtnQKfo7w0EVnu1iFW/D6lk8L5wps7U7dPuZl/JLQ1mBS1RwN7lOGs0j0hOUz
	AYzTSRD6shWgt7/RIRa1G40k3/csFE0tS489GscFkyaix5mkIj22C0Qu3dzobigEu9tUI5MNXzS
	6bAtWEs1U2DNqCNBgT9qDj4HPJIK3219zwyjPV37s6s9QjQFI2WIJf6BRUjATnaiHUAsbfV2/4E
	97LIXwJItGN4uPpXryQOmKDys1Oyuj1md3GsEPm2moNPVRRCDOoBGUc90zGf6+/ZG2nsOC+Ixyk
	aLtQ==
X-Google-Smtp-Source: AGHT+IHPJNT+N4u0WQvWt7vlyYK5XibL/c1kTJHMyaYioO1wKC7ScYHW83cBjhn5GE0zbnOudTjFOA==
X-Received: by 2002:a05:600c:1546:b0:456:58e:31af with SMTP id 5b1f17b1804b1-456058e33b9mr35829135e9.14.1752347800692;
        Sat, 12 Jul 2025 12:16:40 -0700 (PDT)
Received: from [10.68.32.38] (bba-92-99-24-62.alshamil.net.ae. [92.99.24.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc9298sm7948149f8f.44.2025.07.12.12.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jul 2025 12:16:40 -0700 (PDT)
Message-ID: <1d255c16-46fb-413d-b25a-0f1fea682a33@linux.com>
Date: Sat, 12 Jul 2025 23:16:38 +0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: efremov@linux.com
Subject: Re: [PATCH] block: floppy: fix uninitialized use of outparam in
 fd_locked_ioctl
To: Purva Yeshi <purvayeshi550@gmail.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250706072213.14954-1-purvayeshi550@gmail.com>
Content-Language: en-US
From: Denis Efremov <efremov@linux.com>
In-Reply-To: <20250706072213.14954-1-purvayeshi550@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Thank you for the report!

On 06/07/2025 11:22, Purva Yeshi wrote:
> Fix Smatch-detected error:
> drivers/block/floppy.c:3569 fd_locked_ioctl() error:
> uninitialized symbol 'outparam'.
> 

This a false-positive diagnostic. Smatch doesn't see the dependency
between FDGET... commands and _IOC_READ.

> Use the outparam pointer only after it is explicitly initialized.
> Previously, fd_copyout() was called unconditionally after the switch-case
> statement, assuming outparam would always be set when _IOC_READ was active.

        if (_IOC_DIR(cmd) & _IOC_READ)
                return fd_copyout((void __user *)param, outparam, size);

and all FDGET... macro are defined as _IOR(...).

> However, not all paths ensured this, which led to potential use of an
> uninitialized pointer.

Not all paths, but commands that fall under _IOC_READ condition. 

> 
> Move fd_copyout() calls directly into the relevant case blocks immediately
> after outparam is set. This ensures it is only called when safe and
> applicable.

If you want to suppress this "error" you can just initialize outparam
to NULL.

> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> ---
>  drivers/block/floppy.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index e97432032f01..34ef756bb3b7 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -3482,6 +3482,7 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
>  		memcpy(&inparam.g, outparam,
>  				offsetof(struct floppy_struct, name));
>  		outparam = &inparam.g;
> +		return fd_copyout((void __user *)param, outparam, size);
>  		break;
>  	case FDMSGON:
>  		drive_params[drive].flags |= FTD_MSG;
> @@ -3515,6 +3516,7 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
>  		return 0;
>  	case FDGETMAXERRS:
>  		outparam = &drive_params[drive].max_errors;
> +		return fd_copyout((void __user *)param, outparam, size);
>  		break;
>  	case FDSETMAXERRS:
>  		drive_params[drive].max_errors = inparam.max_errors;
> @@ -3522,6 +3524,7 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
>  	case FDGETDRVTYP:
>  		outparam = drive_name(type, drive);
>  		SUPBOUND(size, strlen((const char *)outparam) + 1);
> +		return fd_copyout((void __user *)param, outparam, size);
>  		break;
>  	case FDSETDRVPRM:
>  		if (!valid_floppy_drive_params(inparam.dp.autodetect,
> @@ -3531,6 +3534,7 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
>  		break;
>  	case FDGETDRVPRM:
>  		outparam = &drive_params[drive];
> +		return fd_copyout((void __user *)param, outparam, size);
>  		break;
>  	case FDPOLLDRVSTAT:
>  		if (lock_fdc(drive))
> @@ -3541,17 +3545,20 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
>  		fallthrough;
>  	case FDGETDRVSTAT:
>  		outparam = &drive_state[drive];
> +		return fd_copyout((void __user *)param, outparam, size);
>  		break;
>  	case FDRESET:
>  		return user_reset_fdc(drive, (int)param, true);
>  	case FDGETFDCSTAT:
>  		outparam = &fdc_state[FDC(drive)];
> +		return fd_copyout((void __user *)param, outparam, size);
>  		break;
>  	case FDWERRORCLR:
>  		memset(&write_errors[drive], 0, sizeof(write_errors[drive]));
>  		return 0;
>  	case FDWERRORGET:
>  		outparam = &write_errors[drive];
> +		return fd_copyout((void __user *)param, outparam, size);
>  		break;
>  	case FDRAWCMD:
>  		return floppy_raw_cmd_ioctl(type, drive, cmd, (void __user *)param);
> @@ -3565,9 +3572,6 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
>  		return -EINVAL;
>  	}
>  
> -	if (_IOC_DIR(cmd) & _IOC_READ)
> -		return fd_copyout((void __user *)param, outparam, size);
> -
>  	return 0;
>  }
>  

Thanks,
Denis

