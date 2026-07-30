Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC73444C4E2
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428541; cv=none; b=n24Zkl+n/EMaPqP7XoISFsDuSStmP22XXyrB1g63AzTnZTD5H/iLgAYNP0qaJ6Jem7ZSGiEmb4qVKdVCiCXArPMp3+1BmGwqZlISXEEoshbcfOiuLHavAVqJxIH8IPiOCg8wORJcnqoRGM/JhX1lOJl9W7vVORykusDG95POOpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428541; c=relaxed/simple;
	bh=LzrA83SNg0xwZHckZyesHpd9prkk7E8+AsPKLw0gsqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hD8xttqtWhlDzYmk8V3i+0sJpPU1UvVmcKpAPgihbXpD5Glrbi8GEBOsPz2Qg7UtQYQSLp81OdlAHXmo72aIOKmrv09VIr0GCdTAxN5srTU1YWP/HG+BYrM3iAt5Otyv4Xre8kcmmJHAMDSezSKIoH9K01JwYCRrEFvyfSzRPDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=BGH7Flfc; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="BGH7Flfc"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-45171f2f608so44810fac.1
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 09:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785428538; x=1786033338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2TO7rhJEb0t2mz700nvgDIByTqbVS2Yz6f37I4sh7O8=;
        b=BGH7FlfcbOvegIPbdSDyqXgjaiAYZcJO2cLiIFkujKg3lO2MakP06pbodxSiu9wx9w
         UeglvZjGhS4N7TOOaWh78vcYzMVwYpdBdYBlnL+syvrSMoYJHjAFpPHML+b5+siBHggR
         38wgCNPwuNNZj1Y31bUuVb2SBuNir6tbslxyLcKDaWcWtmzhPwq6FYluSO7TNAWH5LVU
         4osnY03JcoBYxasXIfKk1c1/GdUdlK6ka7kfqCkS0k4XElSy2ZO+FL3P6M+afFiHllc7
         /9iJf6qpy1MGmhiDonE/OIfhgO7NGlQn6Uo+UV2a3y6gNm2VBpceBVTVPG3Ge5lw6NOD
         TeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785428538; x=1786033338;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2TO7rhJEb0t2mz700nvgDIByTqbVS2Yz6f37I4sh7O8=;
        b=XeWYGbEpWPuOl5nCB1o7tfERS4BFFn32bWRKZPc++52QJkiBPkj+JkF2IRWCa9fFYu
         Eg2krpHx8LLPlMWFenfBxRY/F4+ctfeH3AMyo9c2syrBcAYDfBkdZEYZX2A0EecnDzHw
         78rMGH35G3X5e0ZnlH//q43NOOFKA4hCyhRere+jHMVhCrfTe9vHJpHOvoYBJDheGutN
         MHBhb8E5kT7yFI3EomLMRgpWcFsDaMUWZ9g31+fk1/vVeraENN0DVOG9bbP51IWU35kQ
         UD7WYJK2vD5IfR+sa/8Cab9Kru7YN+F9dzahJDs+GRMza1gYA2eyiNmtmYOmTVpQnQRf
         vNbA==
X-Forwarded-Encrypted: i=1; AHgh+Rpmb2hkGuPIvrnnNGb5YYUpeGcqMEMR0XjDlb8Kll7NnmHyvRz3gIahei9XxBeR4INcyY40ve3aHM27Ug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7o+sI0yApuczKKmfgeIwvI2VY5JIEZ3S3Pk7v5bIuXinZ/oCk
	VPhHkxhVObNhetWNxoPyIh/oyCF9kG2BfpBy/SHdAHKsHf86prOr8pYdXcwOVSclJ/o=
X-Gm-Gg: AR+sD12FXmFFg17Xc3IFv81tWUKsk+DRV3lteH/UuZQxKcPtbYk2SlXjesX7QhpaMJi
	GESCWA5KC9M+nwKuwSFYftcEiSJfOPGURzbgxMk/+qQySCWKyMgaH37UgP6MztT/BWigDTGghq/
	hLik+AzqlzvbR3T9MqWT866MKSFWQ0qPFaEuMl+6zW17b6iAp3k/t+Agc6bbX2VkTQSUDvRXu2Y
	zcYclmxdb1prvO/ZaoBwIzwa+QTxJ+0kXbELuj/M86EQcnb1OOcvzezdflT4S3eF634XU7jWTKy
	Ig8JmsEIngkBJ9OevgBbty+J/QotCmw5alh0rY7WpVqYMOnidip2vEWlQa27DM/HI7LwH+lXzsQ
	o3xkhJMQDEOlSRlfn2HZMV1A22yTedwZ009kVzw/ZW8WfROavG7vDq/4W4w0JhEagBEDaVqfTPh
	MAfAqKIO/JCcPit1KFsyydaX0zBeZzauAREwX4275M9R63vjvNqjtksFSVK4hOnLY+1TxclkdYr
	8OEgJzGdsWUJTudfr5z8gwslxWXydm6Atj0/Zy7YfSbkHDgdA7guMgS
X-Received: by 2002:a05:6870:d361:b0:456:4c3f:7e03 with SMTP id 586e51a60fabf-458c0e12897mr2206023fac.18.1785428537794;
        Thu, 30 Jul 2026 09:22:17 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458c257c4d0sm2482546fac.2.2026.07.30.09.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:22:17 -0700 (PDT)
Message-ID: <e85ec957-d648-4d6a-bcfe-09dd2d21d090@kernel.dk>
Date: Thu, 30 Jul 2026 10:22:15 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/5] block: validate direct I/O memory alignment
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, dm-devel@lists.linux.dev, brauner@kernel.org,
 djwong@kernel.org, viro@zeniv.linux.org.uk, regressions@lists.linux.dev,
 torvalds@linux-foundation.org
References: <20260720201057.1862857-1-kbusch@meta.com>
 <ampRQyXDbGgeg49V@kbusch-mbp>
 <fbe9e74d-c389-46f4-9874-3e9ffd9c91d3@kernel.dk>
 <ampce7mxSmxAwAiu@kbusch-mbp> <20260730112626.GA24827@lst.de>
 <amtJDCtczVyX1baB@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <amtJDCtczVyX1baB@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/26 6:52 AM, Keith Busch wrote:
> On Thu, Jul 30, 2026 at 01:26:26PM +0200, Christoph Hellwig wrote:
>> On Wed, Jul 29, 2026 at 02:03:07PM -0600, Keith Busch wrote:
>>>>> Hi Jens, have you had a chance to look at this one yet? This addresses
>>>>> previous issues with certain device mappers under direct io.
>>>>
>>>> I they look fine, but at this point we should toss them into 7.3. Yes
>>>> I know there are regressions around this, but from 6.1x days. And the
>>>> series doesn't apply to the current block-7.2 anyway.
>>>
>>> This series is kind of old at this point, but yes, it's not fixing a new
>>> regression either. I'm okay if this goes to the next window, and I will
>>> handle the stable follow-up.
>>
>> Honestly, I think that'a a reall bad idea.  This is a regression in 6.18,
>> and while it took a while for people to hit this with their a little
>> more complicated lvm/md setups, it has stopped real systems from being
>> used.  We need to fix this ASAP.
> 
> This should have gone in several weeks ago, IMO. You can most readily
> hit a problem running qemu against one of those lvm setups. We're just
> so late in this release cycle that I'm not pushing hard for 7.2, but I
> would support that choice too.

Exactly, it's been floating for a bit, and the last week is surely on
me. But merging at the time it was posted would've been late for fairly
substantial changes.

Hence why I think 7.3 is just the better choice. We're talking weeks in
difference on when it gets to stable anyway, which is what matters.

-- 
Jens Axboe
