Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59821367;
	Sun, 13 Jul 2025 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752385962; cv=none; b=Sesv7ZCoEQYy3Ljo7GnSa56QtNesnvDS662N7xUwB00pixWzv+URTT6rUJzIkmGoibHcBVDhdCJyrV91R/MLVqKDtYPzyGPWI0un0ObcVP1uhOtM+sBcuxz4ujPe0d8Oxvb8X1aGbQwJyXz+ghwyKl0x6qCHxUlfl7eSDEnacHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752385962; c=relaxed/simple;
	bh=GhDzbwNHGtxtIhspi9ej4WtdLYl0UwaV5DvSgWGJu/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHdgstLWf1/NSbHZ4LS/YEfRAFGb42pCXG15DT/yvSiQCIhP4JWjCoFDfgCs1yqScboRSnxDD6lGOaeHBswDAluklpORCcxCg4ZaEO3ytaI3EesYKbiPj/lnxfQw+cDKKps56jRSQO63zQptH5u/RfdjxLt2W1cd7PyymdpKnWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYUyPLc2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYUyPLc2"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235a3dd4f0dso21285915ad.0;
        Sat, 12 Jul 2025 22:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752385960; x=1752990760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pBb4G5WTwy/TsInw+HkF37iU/w2ZZ7t4IPWePnbcVD4=;
        b=JYUyPLc2ianUjmVlqKwrB87Dh2ryQWrplPOVk4ceW9FsSPe1wMfPJo12QcCRcoPwzk
         1aktSeuvHDf6/PpjVej6zBwLR0/MTY6GpS9pxsIODXrwUzXgAPsrMjtYKzwOUQ0oa93s
         EGCoDS5hNAuGyzvu8tgGmFQOSZKfPLkwnvlrToH1iwIxVFuQ9yfJ7hbyyISjS3WSGMfn
         gh4qWoIJhDG0TNc2NMM77k0SUKZg1+XClNnXzmG8kOfY+KLWvXn5Qdg8Jp3D8blSPr3K
         1fTaG/hUvMa67ETTKfvWRNV/THNEBfiGn672NZLxxrpjk9CIYDeSDZEcXaii0JYCnx+6
         7hDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752385960; x=1752990760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBb4G5WTwy/TsInw+HkF37iU/w2ZZ7t4IPWePnbcVD4=;
        b=OCXw7+Qhed2tz895U6LJudSNAZsuZswMI5w1/GUB2C7QnyfvJfxVLyM14gG00hGJCt
         0kZUtVwK0aQuEcgJJLGJg5m5KvA5PL9f9wI8SJdYWCmZIeU1iiEVYDpMgtxs+c8miIsB
         PKLxN9im6rdRS5CGp+6jnF1DpIsb5qklYgrVc75kweHUCfKoJrmaEiBgFDoMgAk5Qiwu
         mFUVxySKCgs2p9UZgxbev3bFGeUTwrhxPi3wBYiHDrx1KfefrImF/KOla17zdeBHXRZS
         szF57mDOenXkbctzhA2YolHF9lwbo+2aphVefYY3eCdXO5sC0l/hZnNC85AljLsGdbbb
         w9Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWcNiHCVL2ve9fpx8TOvyY5yaoaCN5vYZEPa02g4I9Ds+PV1IuICbeGDG1RnE0anvwqC0oMF6Br2b567AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpSCLl8ebVizEKw2TwSvj/AVRnQfwVhIXGoCz2F9l7VKLSq5dn
	rp7dY2WjT7lS2xGNDr/D5/6b+A698bp96zLYbfCzF7qhZ3y4tAY4OSZQ
X-Gm-Gg: ASbGncs/4yscx8qhLDd8LaZ0TDtBa6nancoru12xp5FdiIi5L5COlmmCawqHNSLnhxe
	2wg+y4wjRBfY6SDOIZjHWQmD3OvVmJN1VlJZq74j/MCerPe8WplnVxqaY4NSKuW6hriQSpcXGPI
	FGLt9JaSnCIcdAWLgIpGMGmvEl2ZZUOnQtW+L3Arh2tKPbBabEr3V6UjkYts6MTmDT826P6NG/A
	1AI3P6YH4CdBT1N8X9seDjGvLaj1SmJDbfmylwIW3S5cRb+ZA11xiN3pGdeVDij6jIiX9M+Fpvy
	lNFlijG1OFYXQg7oB1/ujXnOGbodxEPW1xgs8jaB44qy0VM5g4V3OcD6MQ3wQom4uTA/XAqt+R9
	agLwfQJkDQ619Bc6ym2PigEii05VWVK1kqfKB5ZN94VozvAm9gQZZzG87+pgl4vPkqao1hflYY2
	ee9g==
X-Google-Smtp-Source: AGHT+IHpkJ22xsSD44YG86JZ0DqajuNO4X03Hv3zWOHJ1V4ZfpV4xQaShwbANNP2MbUAKAJio3wLkw==
X-Received: by 2002:a17:902:fa06:b0:235:c973:ba20 with SMTP id d9443c01a7336-23dede969aemr93463115ad.49.1752385959965;
        Sat, 12 Jul 2025 22:52:39 -0700 (PDT)
Received: from ?IPV6:2409:4090:20a4:5c0c:1e40:3e52:2edc:d779? ([2409:4090:20a4:5c0c:1e40:3e52:2edc:d779])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42847casm77426895ad.14.2025.07.12.22.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jul 2025 22:52:39 -0700 (PDT)
Message-ID: <7dd94691-0b37-4855-be43-661f954275c8@gmail.com>
Date: Sun, 13 Jul 2025 11:22:35 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: floppy: fix uninitialized use of outparam in
 fd_locked_ioctl
To: efremov@linux.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250706072213.14954-1-purvayeshi550@gmail.com>
 <1d255c16-46fb-413d-b25a-0f1fea682a33@linux.com>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <1d255c16-46fb-413d-b25a-0f1fea682a33@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/07/25 00:46, Denis Efremov wrote:
> Hello,
> 
> Thank you for the report!
> 
> On 06/07/2025 11:22, Purva Yeshi wrote:
>> Fix Smatch-detected error:
>> drivers/block/floppy.c:3569 fd_locked_ioctl() error:
>> uninitialized symbol 'outparam'.
>>
> 
> This a false-positive diagnostic. Smatch doesn't see the dependency
> between FDGET... commands and _IOC_READ.

Hi Denis,

Thank you for the detailed explanation and for reviewing patch.

> 
>> Use the outparam pointer only after it is explicitly initialized.
>> Previously, fd_copyout() was called unconditionally after the switch-case
>> statement, assuming outparam would always be set when _IOC_READ was active.
> 
>          if (_IOC_DIR(cmd) & _IOC_READ)
>                  return fd_copyout((void __user *)param, outparam, size);
> 
> and all FDGET... macro are defined as _IOR(...).

Yes, I see it now.
All FDGET... commands that would enter the _IOC_READ block do initialize 
`outparam`, so it's guaranteed to be safe.

> 
>> However, not all paths ensured this, which led to potential use of an
>> uninitialized pointer.
> 
> Not all paths, but commands that fall under _IOC_READ condition.

Got it.

> 
>>
>> Move fd_copyout() calls directly into the relevant case blocks immediately
>> after outparam is set. This ensures it is only called when safe and
>> applicable.
> 
> If you want to suppress this "error" you can just initialize outparam
> to NULL.

I’ll update the patch to just initialize `outparam` to NULL to suppress 
the warning.

I’ll send a v2 patch soon.

> 
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>> ---
>>   drivers/block/floppy.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
>> index e97432032f01..34ef756bb3b7 100644
>> --- a/drivers/block/floppy.c
>> +++ b/drivers/block/floppy.c
>> @@ -3482,6 +3482,7 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
>>   		memcpy(&inparam.g, outparam,
>>   				offsetof(struct floppy_struct, name));
>>   		outparam = &inparam.g;
>> +		return fd_copyout((void __user *)param, outparam, size);
>>   		break;
>>   	case FDMSGON:
>>   		drive_params[drive].flags |= FTD_MSG;
>> @@ -3515,6 +3516,7 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
>>   		return 0;
>>   	case FDGETMAXERRS:
>>   		outparam = &drive_params[drive].max_errors;
>> +		return fd_copyout((void __user *)param, outparam, size);
>>   		break;
>>   	case FDSETMAXERRS:
>>   		drive_params[drive].max_errors = inparam.max_errors;
>> @@ -3522,6 +3524,7 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
>>   	case FDGETDRVTYP:
>>   		outparam = drive_name(type, drive);
>>   		SUPBOUND(size, strlen((const char *)outparam) + 1);
>> +		return fd_copyout((void __user *)param, outparam, size);
>>   		break;
>>   	case FDSETDRVPRM:
>>   		if (!valid_floppy_drive_params(inparam.dp.autodetect,
>> @@ -3531,6 +3534,7 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
>>   		break;
>>   	case FDGETDRVPRM:
>>   		outparam = &drive_params[drive];
>> +		return fd_copyout((void __user *)param, outparam, size);
>>   		break;
>>   	case FDPOLLDRVSTAT:
>>   		if (lock_fdc(drive))
>> @@ -3541,17 +3545,20 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
>>   		fallthrough;
>>   	case FDGETDRVSTAT:
>>   		outparam = &drive_state[drive];
>> +		return fd_copyout((void __user *)param, outparam, size);
>>   		break;
>>   	case FDRESET:
>>   		return user_reset_fdc(drive, (int)param, true);
>>   	case FDGETFDCSTAT:
>>   		outparam = &fdc_state[FDC(drive)];
>> +		return fd_copyout((void __user *)param, outparam, size);
>>   		break;
>>   	case FDWERRORCLR:
>>   		memset(&write_errors[drive], 0, sizeof(write_errors[drive]));
>>   		return 0;
>>   	case FDWERRORGET:
>>   		outparam = &write_errors[drive];
>> +		return fd_copyout((void __user *)param, outparam, size);
>>   		break;
>>   	case FDRAWCMD:
>>   		return floppy_raw_cmd_ioctl(type, drive, cmd, (void __user *)param);
>> @@ -3565,9 +3572,6 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
>>   		return -EINVAL;
>>   	}
>>   
>> -	if (_IOC_DIR(cmd) & _IOC_READ)
>> -		return fd_copyout((void __user *)param, outparam, size);
>> -
>>   	return 0;
>>   }
>>   
> 
> Thanks,
> Denis

Best regards,
Purva Yeshi

> 

