Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104973CC9EE
	for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776262563; cv=none; b=UcaBrvzMp7T9Q+nt0nElK/+OCfQtkXglzenZRg0CJzjZcRgHa67Kw/rCxe72adkBHvjvf0TY54zjSYPC8O7cU3v6uZJ7f2O/F8ounvughUjfwjxUHHJA7HRt2NoMtFom+H3kbGdnc75f0l1sKRV49Pf0MLlgx/WWyutjNT6omzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776262563; c=relaxed/simple;
	bh=Pdy7Mh+hnfOvCQDqW76dEUcz37KcOEmwFbjUwviC6ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nu1zCIKgxhJHBHET+6C6N7m9QM9TWxWbL2+CNgDz7rGnv6qe8IFQ3E7lSnJj+ab79WK9OCXO3Vwzd0F9Q5O7GrpqYLtThR8BmuH3pOMmrAn7sm6XwPCFjz+iAY49ZDaUNGGuxsijKPgCQb6DRIkkUltaV/Xq2BXj6Te+PHRemf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a3d1561e38so4963196e87.0
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 07:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776262560; x=1776867360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9GVK3912ykSKoEN3+mlTPV6LfdyMXA4vXMmtRCWPRU=;
        b=WrGfnb0Fs6M/qUBEzKsRSPlKpVUzgpphzI4I+hTP5dH+gxTrtiMSdssH6kT4WtnxyJ
         hBqIHyP/mYuFVOkE42x5nNvfLNxK6UQ0/DleiEltcSp9LNE8nYjWGEUO0BwTDvhC4oYv
         r45VUGu07BIdpSDOQ1+ADPFy+9bTvrAphFd9dqzGnUsLNiOp14uyatUU/pUNIBNq4oRL
         bWKrk6r/wtMZDmDRyIIBGYerDuykbT6cHXcCtFRg/VO8Ev6KL9x1h+O7WyZx0LpEgIOa
         /tlZl3zTpZZBHTwgNNoNhcivSRR0/OUVx3UFB4JyTYX7bjKbknpdgTD0RrE3NS9avwUB
         3n2Q==
X-Forwarded-Encrypted: i=1; AFNElJ9gZSEZMZ45acfw5ucFqXgJv4di/pTLf3qc47g4TaGxutVooP8M7KkyvzJ5D8cCTc7YAllpWre+HGJ/ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoHZ2GjMBge2ZV0SkMzq1JZbcnh9885zAhCJeku47X9gJnZDDe
	LmN6M2FU5Vv8Dbj6yCsnTuWIMTdgOmdBbXslOnfR/VJouxCT1YkBq9Ab
X-Gm-Gg: AeBDies50HKH3louPGYgTToGyHWnfsgfAv1yK90Qn94/lYtFII+UTHFEv1GzkirUC2l
	yI9Y3pl6KsBjAf7nstGfZh+nN76Ss9HxsznwrXt8tSt2I/pUcB+4GcXpBLfS/XlMO2jrk7q5r7c
	XiRCrLjr/7O+vyUYreOYWPYmR/pTubn63ouqUQlxyZA0d4rGuIl/PGiPMsJ8P+bDokJzLW7IL3W
	BalmVAIpu78oeKy7oxB9ciR/vfDIO0kEGxUOh6WjnGYMzXCxph2uMBcqOJhGrb9ILCDspPuJ/yb
	zHjL+Xyeni+rR+7tYC+sanNd3W8PzW0XxC8onC24/GaWLcXa2kcxWcn9LvzPP7pb5U6QVqD2Hk8
	z3Ehk+T/0M3SIbuqP7VyianICBmxD8SGvRJXQ9lZnFZXfMhEanr+aMyDUXFx6/VKZ6OJIXckd/1
	9UgtdOQYwAoiAajVTzdKfbiVal2hawf9Gv+/np0GgH5I4tbiEwOZ9QHodieQxX0rulsioUuxxro
	xP6jNU=
X-Received: by 2002:a05:6512:6cb:b0:5a4:50:ac71 with SMTP id 2adb3069b0e04-5a40050adafmr3650399e87.13.1776262559949;
        Wed, 15 Apr 2026 07:15:59 -0700 (PDT)
Received: from [10.68.32.41] (bba-86-97-226-202.alshamil.net.ae. [86.97.226.202])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a40a2e71absm503650e87.46.2026.04.15.07.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 07:15:59 -0700 (PDT)
Message-ID: <376f0e18-fae3-45d7-b3bf-885e963e6b51@linux.com>
Date: Wed, 15 Apr 2026 18:15:56 +0400
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
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Greg Kroah-Hartman <gregkh@suse.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260413153114.3040093-1-lgs201920130244@gmail.com>
 <8afc6b6b-399e-4f77-82e8-3c0e717f765e@linux.com>
 <CANUHTR9MQ8GGpgtGDgRCmjQL_D0jW4E-2OER4Q784xbGd+nJSw@mail.gmail.com>
Content-Language: en-US, ru-RU
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <CANUHTR9MQ8GGpgtGDgRCmjQL_D0jW4E-2OER4Q784xbGd+nJSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/04/2026 17:54, Guangshuo Li wrote:
> Hi Denis,
> 
> Thank you for the review.
> 
> On Wed, 15 Apr 2026 at 21:00, Denis Efremov (Oracle) <efremov@linux.com> wrote:
>>
>> 1. Let's use platform_device_put()
>>
>>>                       goto out_remove_drives;
>>> +             }
>>>
>>>               registered[drive] = true;
>>>
> 
> My understanding is:
> 
> For the platform_device_register() failure case, we should use
> platform_device_put() instead of put_device(), so the failure path
> would look like:
> 
> err = platform_device_register(&floppy_device[drive]);
> if (err) {
>         platform_device_put(&floppy_device[drive]);
>         goto out_remove_drives;
> }
> registered[drive] = true;

Yes, correct.

> 
>>                 err = device_add_disk(&floppy_device[drive].dev,
>>                                       disks[drive][0], NULL);
>>                 if (err)
>>                         goto out_remove_drives;
>>
>> 2. We also need to fix this case.
>>
>> platform_device_unregister()
>> registered[drive] = false;
>> goto ...
>>
>> Thanks,
>> Denis
> We also need to handle the device_add_disk() failure case for the
> current drive, since out_remove_drives only cleans up previously
> registered drives. So this path should explicitly unregister the
> current platform device before jumping to the common cleanup path, for
> example:
> 
> err = device_add_disk(&floppy_device[drive].dev, disks[drive][0], NULL);
> if (err) {
>         platform_device_unregister(&floppy_device[drive]);
>         registered[drive] = false;
>         goto out_remove_drives;
> }
> 
> 
> Is my understanding correct? If so, I will prepare and send a v2
> following this pattern.

Yes, correct. Please, send v2.

> 
> Thanks,
> Guangshuo

