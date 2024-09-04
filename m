Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DE91D47D1
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458735; cv=none; b=t3mW8DXiqqJ9Uj8VtAs387xGW3j/UtKQ2enCV+wPQhcUgXrHRJcTriGO5CfuVcQKAxsFCbQ/iST7y00kgvxGqYZifIi/+8QQfFV8dUY6I1uO3IPZxgTTm7hJ54nGQzojBo4t6D0axHn0ASkHD2YCDIsgqyhrSZ2wfHeS+X4W+6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458735; c=relaxed/simple;
	bh=A0kTi4k4bUyrtrFXRsgvXgLx2hhA8lbn3TJegRj9D8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RcH4hOpBoMMiKet3nZy1I70yY2WDJC+/yWCkcecG1AtRMPZXmE70KtFDYcMVbdgJkLN9V0vHfpceIbAlLCyioOnUzCP4huTPTYbsOo5cp9CLHctO6QtQh4Z/1zSiDpejkng3rRnQ+jmczCpEpQqmIZfCdXlkcMGtFkY3U4g6n1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ayZH4Jx7; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ayZH4Jx7"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39f49600297so16854845ab.1
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2024 07:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725458730; x=1726063530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B0r8nJJDH09LCl698U9W4TMqb46etw7giO9fbZgwWYE=;
        b=ayZH4Jx7yrEfFC+/9ZQ3F9d3MJWAE1aLHs93bKvpn+b4KJVqh0ddSY1ZdEwOrtyeeG
         Q+7kj3QaHqFduPfLeSRkJ2UK6ZX7wM6B5dqwugK/5qVH9Vmraye07b+yYNWsvyIoKUn4
         2jb7Ct3OuCP60AKl8XifFg645hdN5onltgxaA5PjdKaD8mlAR8hbcLr+NACB6w2GePjg
         h2qDwgq129MfPQSQGMMVWrPbXihkTu4dusa0T9yLLEZ2sKh3uKFJBfw5QyKXQPSuBawc
         KjsoMIZnHEBClp2BXaZ91CmZyhsKVZAyYJ2ytHJDPybLI8kgcaZWWLSZlNn666R8yrpc
         b+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725458730; x=1726063530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0r8nJJDH09LCl698U9W4TMqb46etw7giO9fbZgwWYE=;
        b=r4weH/90sjWpeCrMvrSRXMG+ZV6vNh7ziFlSPiuBGaD0CyJOf4oAujMnS5dLguIniX
         H1aZyPez4ORmIYJIHpbcneCkX9bAbVV4LxqQgxIJQKAD6i7lQvlvIH7yvCU8lYKwJzZg
         93vFxU7z/W34RbyqqRLSjnEpENovpAIVrRTNyrovDk3tlZEnkhlv3N24A9AA9Uwud7Wg
         tPqvPzC4hiP1thT7rFdNQt6VfJMByCjl1a1b1iyqVhyRFEmQai/u1a8lWqdAAaAwILpA
         5xmW/JGXj6BZO+4ANEGAESY1+wjw807Ya2hVX5rHFC+8NXDocwG1hHFbLWvKRIQrxiHR
         GuWg==
X-Gm-Message-State: AOJu0YyJfznluBYznd0I1Lyzch7vFWDZggtO9qWNwVXicKhTxLChuecg
	mkpgmns4LM79bjyG0c81xr2V/aLNfBMq9OfWSoLTDGqsWSurLpjbZOZ6WdyOPlU=
X-Google-Smtp-Source: AGHT+IG32oDStmB81VpxQ3wF+YzRTmz/4eOfUw1tbarF0Noog+ICx63m7hLHvtUzIXL5PYjYtS7QuA==
X-Received: by 2002:a92:c24d:0:b0:3a0:4447:c941 with SMTP id e9e14a558f8ab-3a04447d23bmr9074915ab.21.1725458730158;
        Wed, 04 Sep 2024 07:05:30 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a04331fceesm1521955ab.60.2024.09.04.07.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 07:05:29 -0700 (PDT)
Message-ID: <dea642a2-85f8-445b-ab84-a07d41acf2e2@kernel.dk>
Date: Wed, 4 Sep 2024 08:05:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: move the BFQ io scheduler to orphan state
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Paolo Valente <paolo.valente@unimore.it>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <6fe53222-876c-4deb-b4e1-453eb689a9f3@kernel.dk>
 <CAPDyKFoo1m5VXd529cGbAHY24w8hXpA6C9zYh-WU2m2RYXjyYw@mail.gmail.com>
 <d8d1758d-b653-41e3-9d98-d3e6619a85e9@kernel.dk>
 <CAPDyKFp4aPXF6xuuQf6EhGgndv_=91wsT33DgCDZzG6tyqG9ow@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAPDyKFp4aPXF6xuuQf6EhGgndv_=91wsT33DgCDZzG6tyqG9ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/24 7:59 AM, Ulf Hansson wrote:
> + Paolo
> 
> On Wed, 4 Sept 2024 at 15:47, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 9/4/24 7:27 AM, Ulf Hansson wrote:
>>> On Tue, 3 Sept 2024 at 17:54, Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> Nobody is maintaining this code, and it just falls under the umbrella
>>>> of block layer code. But at least mark it as such, in case anyone wants
>>>> to care more deeply about it and assume the responsibility of doing so.
>>>>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>> I haven't spoken to Paolo recently (just dropped him an email), but I
>>> was under the impression that he intended to keep an eye on the BFQ
>>> scheduler.
>>
>> But he hasn't, it's been a long time since he was involved. I've been
>> applying patches on an as-needed basis, but effectively nobody has
>> been maintaining it for probably 2 years at this point.
> 
> I don't think we should expect him to do active development, but
> rather just to keep an eye on it from maintenance point of view.

I never expect active development, there may not be a need for it. But
basic maintenance is definitely the maintainers role. As that hasn't
been happening for quite a while, I'd consider it orphaned.

>>> BTW, why didn't you cc him?
>>
>> That was an oversight, I think because I haven't seen anything from
>> him in a long time to assumed he was awol.
> 
> I looked at the last year or so at the linux-block mailing-list and it
> seems most patches for bfq aren't being sent to his email. :-(
> 
> Ohh well, let's see what we can do about this. Surely BFQ is being
> used out there, so it would really be a pity if nobody takes good care
> of it.

Probably not a whole lot I think, at least on the prod side experiences
with BFQ haven't been good. So there's definitely fixes to do, and I was
happy to see fixes being sent in recently to address some concerns.
Someone with actual customers using it and finding issues, or someone
actually using it.

-- 
Jens Axboe

