Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E76352FEF
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436686; cv=none; b=EbM2EjWrKif03kbT+e4oNqr3gm68YiudY3PhJMO4xbf7kLwgdlsf4kA15ZfyGAE9K1xKG0qPy4vm/UQrcMTLGPY7rbi8FAWZeHtDCDWmVe58o7ETkQ0J7L6GmnKUU+HcPXd386MMeWjb+GeeTkgyzG7mF3W0jgnc6DmaYJaCKvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436686; c=relaxed/simple;
	bh=i2oFNz8KDQFEYrN95Tvu60S75H7pBtoWYl4ODsySMy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMK0WI9BxXIYp7syi8pt6bEsClDrQVxgg/jkhXt/vqsDZQyb8j97RH2vk6zXOMrLwNlHbgJm8Yex9vMb1/mr8ESVMPWYbFhwul4lmeYszPgi0ld/2pHwGV/65lIvXQ6sndvUOePgDQz5U5WngusHKa1IyYS4si8qC1DaB549rX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sSZUED4c; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sSZUED4c"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-88703c873d5so135766839f.3
        for <linux-block@vger.kernel.org>; Tue, 09 Sep 2025 09:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757436682; x=1758041482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nl6S7tZ9WVcfsH6+luPLSSFWeiL6zAI9kTl63dXqFSY=;
        b=sSZUED4cLQTw1GgnQiCeiroFIU44f7DwQ3znoZbMZQeMoLM+aAsoDibMzVRMc6i2si
         3RoB+1F32y09Tb2eaL60rz6G1JlScJyhiyNtI/WvVrfUMYNW5mBep0bahBL9JebcPuNq
         lxT4ULkNq/RsVG2Y0SDG/jWPhfLTQ5xN5iTSYgE2YeY2Xa71nBvnFhZVbQdFz+waYrXD
         ISvQWFW60V4YxYrOAHrJamEIAS4wvKBHS6mAG47JKjM/lszA6KnU9o9ENwxxyyH8lX+o
         DKyX4PYqFK6RAvVCKIllki4ZccGzUQEHVUm/EPAp9BmgBajuS3ObpA1GlELO1+ehlyDB
         i3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757436682; x=1758041482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nl6S7tZ9WVcfsH6+luPLSSFWeiL6zAI9kTl63dXqFSY=;
        b=BSnvwIvHMPB5pVch5Uy3xIWdsFytUl4cjTvfZLQIO4xvD4o7Z2Keom69M3xYR2ZNwo
         EyOz692UOLBAYqA7cZnFwycz0XU0ARdtCee/xZJa96B/pE7AAdgFnIrgzL6WIgSj/oMG
         JTiTv5dmpwGpgE3K7YyrzgWfylrJOezu2TAJR8k06Ys4B0UDE3jMHblubrQx15tV+E3W
         AvfDlEze04+1QSTEmsPM6JmBaOPmuDHUOM3wUpT948sNnt/YWXBr9TDxTTkFkkfi35E6
         MN7Tu402jXKJqKchVSHo+9VABM+mRFv+xTvdUbVLdOK+c7s672TdRZd+hw8FGVw/b14l
         enrw==
X-Forwarded-Encrypted: i=1; AJvYcCVj6xGAuGUf5V/hDYZaz3HIcWWwrWdeOZ5Dxt8LJmE6mYd912UKj2mHeSONGXwCtr8SzimM5z/Rs/n+/w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvf/0D6vJIhInkOt84M/FjY8DkiF4oD8KIhutc5PWNHZm7jPKf
	ZNDKCpHMFySyVXnHJ4MVWBrJAZ0sPRhdN8CKk2BjKk1XSfBdJrYL4qGv3/zoABKgpCA=
X-Gm-Gg: ASbGncs36CswaZaE6+e36e+UWcJnE+fKXT90bpPumM2dCnKIyz3AmWKiRuNfXxNsiwi
	AEqlmVqtIM/pFJG92QNWNuY1HOALhAoFlO1nE0nEKqqZfgmcKejxTGB41RupHl5CTt6KkNlqjX2
	vG8RkoOG/mkVPhhFPSB97Ui/LhTNLcwhrhd45/ti7Rc3r9evksKW0OZALwTSdsPVxT+GbbnTYN8
	rtmmvfX9xOoK7yyNaDYO/FSkxIFZQZeMvLcp9lzBjcGiVgs3TjZC3hMCssV16pKG8TtHUbru5VP
	KxOz6YtX+ZyQ1I8Z+Ptal/A4iFET2W+HG8Iksy/CYQdQkcy2BP9uAk1DZpEjT2h12NcMo931i+M
	pkezuWHdgu18cpQ7Bj2yZdosYGUBaQQ==
X-Google-Smtp-Source: AGHT+IGSoSy5k+n7jRykIgwPuKALtDfhjr9F5/3YPGRKRhiuxXTLI5fAMBHOqjizj8fvtQ0R5ZhMWA==
X-Received: by 2002:a92:ca46:0:b0:3f2:b471:e617 with SMTP id e9e14a558f8ab-3fd8778175amr175246755ab.25.1757436682088;
        Tue, 09 Sep 2025 09:51:22 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f0d3001sm9931691173.24.2025.09.09.09.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 09:51:21 -0700 (PDT)
Message-ID: <16a63a35-9a44-443a-8f59-e60afbfbfff3@kernel.dk>
Date: Tue, 9 Sep 2025 10:51:18 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-6.17-20250909
To: Yu Kuai <hailan@yukuai.org.cn>, Yu Kuai <yukuai1@huaweicloud.com>,
 linux-block@vger.kernel.org, inux-raid@vger.kernel.org, song@kernel.org
Cc: linan122@huawei.com, xni@redhat.com, colyli@kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250909082005.3005224-1-yukuai1@huaweicloud.com>
 <a56b2c76-e254-48bc-86a6-8beb47ac79ff@kernel.dk>
 <fdfcb000-916b-4599-b75c-1b4680accca7@yukuai.org.cn>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <fdfcb000-916b-4599-b75c-1b4680accca7@yukuai.org.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 10:44 AM, Yu Kuai wrote:
> Hi,
> 
> ? 2025/9/9 21:26, Jens Axboe ??:
>> On 9/9/25 2:20 AM, Yu Kuai wrote:
>>> Hi, Jens
>>>
>>> Please consider pulling following changes on your for-6.18/block branch,
>>> this pull request contains:
>>>
>>>   - add kconfig for internal bitmap;
>>>   - introduce new experimental feature lockless bitmap;
>> Can you write a bit of a better pull request letter? It'd be nice to get
>> an actual description of what the "lockless bitmap" is, and why it makes
>> sense to have it. This is pretty sparse...
> 
> Of course, details in be found in the patch 0 of the thread. I'll send a v2.

Please always write a decent message on why any pull request needs
merging.

>>>    https://kernel.googlesource.com/pub/scm/linux/kernel/git/mdraid/linux.git tags/md-6.18-20250909
>>>
>> and this is a new source for you, is the above tag signed?
> 
> I thought they are the same, I'll switch back in v2.

They are very much NOT the same. One is some random site, the other is
the official kernel infrastructure. If you don't use git.kernel.org,
I'm definitely not pulling anything that isn't signed by a key, and
that key in turn has been signed by other people I know.

-- 
Jens Axboe
