Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19E737DE80
	for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776942379; cv=none; b=oxEbqA92Uea34oDYiaqFyYFwka0elOrvp6CsICs4ujZUHXa+vL9Z0bN2GbBwm7yGnt690IoduEoy5C8ysKPrj/APGtetim7madpBN2ZPeyIatwH6MOviD284uDb7mA38Oa7akaJZdH9GHkWC/hfpDBk6mDizt12ZJAnWz7/8C5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776942379; c=relaxed/simple;
	bh=WuGbQUl6upA5vm2V0Qt0E3v6mLBMgPg026w2N5bkFJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZpG3IGSEuhlhiQQEtU5RZnAAqjdz1mKFmebcJ3t4iEieagyr+q54RkJ6RWMmjJdkgUdVOfZxcT0QQKZH0AtLDn4QjZ4o3JLWaJgd7sZsycXD5seQfpPPeDVGBKvDIxdzZdOyX7kvGPuWkkkFqyVLcw28mLxEVQyZwB2CeOt/tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=WneiHKWi; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="WneiHKWi"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dd73b7c757so905179a34.0
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 04:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776942377; x=1777547177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R7TrFCQcg8Ms6iW9sdur5t8Q93cQEF3dtFZPdGVKIQY=;
        b=WneiHKWijiXnQLcboKFHNqqAykDgBCKTTLryL0VxNmRBU3ZurbUtBWKZJQTiTP6sGF
         Ru+uxeXyaeQCAKZ4d/wQ324UHHB7K3RFzFResHZaA1JKu1zeRFLJkzfmMP3FUL6JXq+d
         uWe40uiPp+6C3mpyE27MS0zAdPYNDZn+q/EPkNoJYd21PFj2QihSqhlRDpTgUuceC4Dv
         S442OTa/BUbI8eGDhIJWZR4ZrHUdPGTEL3aYkZCLFuxMuDDrRNErrSAVqny0A5IPjaPY
         h1D77+NtgE8Vt1CIhRoUVL73iOoO6DK6egp3XMmjNg7Kp7hq9ozkQQI4zg3Ep7OpgJ0E
         JrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776942377; x=1777547177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R7TrFCQcg8Ms6iW9sdur5t8Q93cQEF3dtFZPdGVKIQY=;
        b=c5BZN85UKpfLu7ML4e5wuPzt9XHw76JWhcDqlItIYZO7VHQr9czRnr0XnGST4D9jxj
         fIb9c+iUf8BoEWmHDncv/Y3eCacUfPqH9EECTL3iGkhDZydxRv22fgzormvIU2WkCI5a
         Ul/+KOtyro308kNcny+MfpNFjS+7Ec3DsAqhJvfhjL+BOMndXZK/brI9mCLLWNPMcV4/
         YO/bxyG+o6XlauMGyb2PTlbdwj4lZRQ17CQadLoGwhLXIIG++dBnPsxfzEb/ktNDCYa1
         eccILgT4ERaZEBB6MkFYO5Vpbc8z/EZ0dxh0sTvWXoE0mxKsjYIYMT2PCt2aF2oMFYtH
         PkCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9njnLsU/Sft4Qy8f1yEq5txsWvKEEnWwJrv2EQCXBAJ4fRo45Ea0SodogDsGeoBl3UKiQeSbLz+kKaWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqO//cPZ1lK4SvB3EVGFxztiHc2vZAEyfUMEuirTQfHWzSLNeA
	GchdWIlwG3xbMhni2AQ/n7av9O/zruIKiZ80dLXtQmqJiyYCA8Pq3p/9Z4GaXpO3n94=
X-Gm-Gg: AeBDiesxcMzDqPh9vW6zBGuJBgyD+mCCSNpGqcGZ905hUtvIT11bJgE6+nApA3HQavs
	5rpVGk95NGgE4hrT9RZTvBgyqjLg1JEyQoQRLJWxpsCXy4/YqkH0ONoqRd6XO5nldjgALnG3ZXr
	wHW4yh6nOXQJSFqZFsFdsIr/i6EzIiDW/PbKtvLMz6g+jY4c8dVAvSJRaXCdMT7SBzx2NwraUqS
	OmofatSgx/e1Yjryn6JqxkwULwigENMVUOF2RwlCXrEEbrRKVoG70lO904tPcq3aTPYF/UmqhOb
	wWXFjfBDSExZJBMxew4NvBgW4tGwD/UrooULvdRp87Njn0H28AdlSarBEC9wJxoOSbgNuP0mHOU
	tmL6pofgn5zUzWUIUT6OaqNH9zTXvhm3RMG0JCSNBG/4RsXGfLWYI30GL/gBGNTlSpPrPCY6lvJ
	QoVysqQUsBCO4P75n7f2mXdr8zzSDVTrlKbzHevXf+Cm7YLtg8lLYWBS3gVINkEn/fir6FN0qZi
	b2bs3Xan7XM494qqrevTXtxaaVPlyI=
X-Received: by 2002:a05:6830:67db:b0:7de:4a4f:1b02 with SMTP id 46e09a7af769-7de4a4f22efmr1163965a34.0.1776942376760;
        Thu, 23 Apr 2026 04:06:16 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd5408b5asm7232533a34.11.2026.04.23.04.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 04:06:16 -0700 (PDT)
Message-ID: <f661cf47-18bb-44f2-8764-c9f0b4fb68b1@kernel.dk>
Date: Thu, 23 Apr 2026 05:06:14 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] floppy: fix reference leak on
 platform_device_register() failure
To: Jiri Slaby <jirislaby@kernel.org>, Denis Efremov <efremov@linux.com>,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org
References: <20260415145708.3331818-1-lgs201920130244@gmail.com>
 <177645836617.906013.5675762942401997007.b4-ty@b4>
 <897f442d-4e04-4b70-b716-38fd10b8af36@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <897f442d-4e04-4b70-b716-38fd10b8af36@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/26 11:11 PM, Jiri Slaby wrote:
> On 17. 04. 26, 22:39, Jens Axboe wrote:
>>
>> On Wed, 15 Apr 2026 22:57:08 +0800, Guangshuo Li wrote:
>>> When platform_device_register() fails in do_floppy_init(), the embedded
>>> struct device in floppy_device[drive] has already been initialized by
>>> device_initialize(), but the failure path jumps to out_remove_drives
>>> without dropping the device reference for the current drive.
>>>
>>> Previously registered floppy devices are cleaned up in out_remove_drives,
>>> but the device for the drive that fails registration is not, leading to
>>> a reference leak.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/1] floppy: fix reference leak on platform_device_register() failure
>>        commit: e784f2ea0b4fd0e7b70028ff8218f22456c5dcf8
> 
> The patch is likely wrong. Given the pdev is static, the struct device
> has no ->release, so releasing it will trigger a warning. AFAIR, the
> consensus was to fix platform_device_register() proper.

Thanks for letting me know, I'll revert this change for now.

-- 
Jens Axboe
