Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D7B2417E0
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763564451; cv=none; b=b+JVc3EhlOavWJkMVTnNztDnevNSJGusyIGbqEfFr+fQ6KyBE4ExjbQXNYZinch0vBIRDIR92Ko1LQQcQ252+w2y2zhn7cW0K4ShK70siS9UYLi9bd3mFqqszFQecc2RTR9m5R9EjwOPPdkMG+I7xAKyzCIASEEQapWugJlSEOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763564451; c=relaxed/simple;
	bh=PL8of9GtehHgaXMkuBFODWqWv8v5OOatDSTf0gzt5ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rGajfJiCc7wqw1WwdBIBUEwCzITVKRc1tS9b5auGcosgssszWVTn8zhLOiwLT2IU7EW/DBNkCKCLErHFgu16SvV6dp31VjB9juOO6Ki7zNHCOHzfDNYn/dQZSL4DUTmPzxg52Ex0Gew10hXdcY3DkA0KJoCb35TocNcdNQaT3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mO/4AloG; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mO/4AloG"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-4331709968fso26049415ab.2
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 07:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763564446; x=1764169246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gNofE65NyBsebaxkB3nbF9isM5k3fFygNoV7Lvky7Gk=;
        b=mO/4AloGBf4FngnrY7PNIZpfEuaQgXf6ExZIbT/SqA33wYA6A9smv3PTc3jxrdMK4Z
         yMOXgFXLr/ZZAdhr563kjdJDmpdUmtXWg7tr8RW5XeMzx1HMk0FeVcapNdcABZlGBhUB
         K+bwa+afPvwlTMS5ioSGYZ2uUE18xuY6K8llr1Z1Hy+DIH90gv3K6V2EnX18p3MYz/vS
         YN5JTYJq0AN/PmHxbAs2K4vaI6EU45ybcuavNxOCqeoQPOMcpJrNBi3W91Pjm/FjhKIj
         zZ8wzolGRuCy2lwiak86BQ4lMQqBoPxSifpYcQPNwDSj4TjFbsZsVtItIFXisQYpq8bn
         qtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763564446; x=1764169246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gNofE65NyBsebaxkB3nbF9isM5k3fFygNoV7Lvky7Gk=;
        b=wG57P+D2o3gIrgkw2D7eJ5WSRTGBAFp371Ri3fd7U6JHdfrOQtjeqiTncwqR0ITQ09
         NSd4YqB4xry8ZStGQe+qn/8ggLjx3y4h0/ye4ZWPvtRef0Aca3WzWpteqKwdWM9n0gCF
         Z+YxQ45KrXjVqcIq5YsKPORc3Cw8Hc5Zn69gSk4QATxbQc8W/Lv6n4e0o323tvxfmvPN
         orn0JKaByBXejYe5D2xqeOT5B+A2GOkySPlflxRDC2EYVtypPkkswq5xHQkOlhPdBC5h
         pEHQ6fKiov3LsgyMWmIB6EmOKT4Zh/rgrsYBApl8NHUwUgGWP/Cdm0k64eKnJJMIsn1W
         IWpw==
X-Gm-Message-State: AOJu0YxlSnuODqr3On8ikzIdpA5s/5PVYe2y/9DiGMGN5ir7uxfjnplg
	TWbdnhmoIkAj2IblvzpBoGfhPsUKRXjM3ycTZysnNSXnXRCQqC/SLWNUHv5wNEZeZJwoAzTN+X/
	vjuau
X-Gm-Gg: ASbGncuSaeHFZz0H06DB1WCp14nn18FRB1/0Rnf+e5VtWvJ3tfMR24Pu84h/2A+Ho/r
	tpGsTdOTcs6UeO1OFXsJFwO1Sxd37fti2VeocNLKKEmroRgzjC9J1xV/Ec72ZdKNtDc9C3VEPNP
	Eni9MOEpJqlAs113ZT+9CaopfkKupEU9e66A3Xpt7F8eODXg3m90g4x6bCppnOx6km7qvO4qRHH
	WY6fPjoNcnjnnXUng7LB5F1VKhbgOs/LAxC2X7+BgXaS/hbb6UguMfGDnopLi5HB6bbPoWViQkT
	WH5XGjtHwrfA5Eh/UYhia0P5BHztWFq95KX/UlrFcVyTSRovsB12NmHUFyXIO7vFu29r20BmhYD
	3LYxKPEZt7ymh+tzbCEHlWMURuHvQFwhdR/d5mnzM+KT78UEGQeqgZm/r+K5PoH2R84Qjub7zlt
	FjoKSRGcnWMfCND4WRSQ==
X-Google-Smtp-Source: AGHT+IG15pfH9XhQR7RtgSfKcQP+LxZE45lwoPhGe8NBz6c0mc008gbEHDA3nAUyzI2hn2O/86/JBg==
X-Received: by 2002:a05:6e02:12c9:b0:434:6f6a:fba4 with SMTP id e9e14a558f8ab-4359fdbbe05mr26565415ab.5.1763564445371;
        Wed, 19 Nov 2025 07:00:45 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd31124csm7303565173.41.2025.11.19.07.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 07:00:44 -0800 (PST)
Message-ID: <8cc33afa-8017-4e24-96d0-9c580c992301@kernel.dk>
Date: Wed, 19 Nov 2025 08:00:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix floppy for PAGE_SIZE != 4KB
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
Cc: linux-block@vger.kernel.org, efremov@linux.com,
 Nick Bowler <nbowler@draconx.ca>
References: <b1e17016-3d4d-4fac-b5b0-97db357d0749@kernel.dk>
 <20251114.172543.20704181754788128.rene@exactco.de>
 <fec67c88-53f5-4482-aeef-86e1213d187e@kernel.dk>
 <20251114.192119.1776060250519701367.rene@exactco.de>
 <708B7962-86CD-489B-AC33-4B929F2902B6@exactco.de>
 <c8cbccc1-964c-43ce-a992-624d2efcfd4a@kernel.dk>
 <57be21424d0e23142ea67ca9de3ca4ca033e1ee7.camel@physik.fu-berlin.de>
 <900D7C37-DF73-49D5-950D-81D84D6DA9CD@exactco.de>
 <4d3482372549a7746c639299c50319bad6b4b6c7.camel@physik.fu-berlin.de>
 <1E5D751F-0DCE-4AE2-9DC5-4D9EF0D8FA8E@exactco.de>
 <792a2d8cc1204c5b3fee76826ab24569c1fa152e.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <792a2d8cc1204c5b3fee76826ab24569c1fa152e.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 2:39 AM, John Paul Adrian Glaubitz wrote:
> Hi,
> 
> On Wed, 2025-11-19 at 10:24 +0100, Ren? Rebe wrote:
>> Hi,
>>
>>> On 19. Nov 2025, at 10:22, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:
>>>
>>> On Wed, 2025-11-19 at 10:12 +0100, Ren? Rebe wrote:
>>>>>> Yep we can do that. It'd be great if we could augment the change with
>>>>>> what commit broke it, so it can get backported to stable kernels as
>>>>>> well. Was it:
>>>>>>
>>>>>> commit fe4ec12e1865a2114056b799e4869bf4c30e47df
>>>>>> Author: Christoph Hellwig <hch@lst.de>
>>>>>> Date:   Fri Jun 26 10:01:52 2020 +0200
>>>>>>
>>>>>>   floppy: use block_size
>>>>>
>>>>> Yes, Nick Bowler (CC'ed) bisected it to this commit in [1].
>>>>
>>>> Nice, thanks!
>>>>
>>>> Carefully, it appears to be another commit though:
>>>>
>>>>> I bisected the failure to this old commit:
>>>>>
>>>>>  commit 74d46992e0d9dee7f1f376de0d56d31614c8a17a
>>>>>  Author: Christoph Hellwig <hch@lst.de>
>>>>>  Date:   Wed Aug 23 19:10:32 2017 +0200
>>>>>        block: replace bi_bdev with a gendisk pointer and partitions index
>>>
>>> Yes, you're right. I was briefly distracted when writing this mail.
>>
>> No worries, just checking. Should I send a new patch with the Fixes:
>> or can Jens just add it?
> 
> Jens picked the patch up for his block tree already [1], but he could still take
> a version 2 from you and force-push the new patch to his tree.
> 
> The proper tag would be:
> 
> Fixes: 74d46992e0d9 ("block: replace bi_bdev with a gendisk pointer and partitions index")
> 
> It's up to Jens in any case.

Yeah not doing that for something that went unfixed for 8 years. It's
clearly not that important. Rene will see stable bot rejects as the
author, so I'd suggest just watching for those in a few weeks and
sending in a modified patch. It should go into 5.4, 5.10, 5.15, 6.1,
6.6, and 6.12. Possibly 6.17 unless that gets deprecated before then.

-- 
Jens Axboe
