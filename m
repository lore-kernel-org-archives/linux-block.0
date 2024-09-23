Received: from msa.smtpout.orange.fr (msa-210.smtpout.orange.fr [193.252.23.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90E219F137;
	Mon, 23 Sep 2024 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110159; cv=none; b=hGoTmRGyA7aimBUpMJAN+RM1oS1gSM3moGor4p8BDGjmC01h2nhb0COK4bU/fxhdshl94ubCfbz63np+0CvCU3qK4IZDjhl9e/37r0qVToqJ8aU+I4at/6jAsHUcd1KHIzZf/YM9jZthcWnef8uf69Of/pmTg31vVgi51slnBBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110159; c=relaxed/simple;
	bh=FICzON11Dy+gAxW32hX1s8LCXvSdOhsRQVHf8XJ7Mzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZyY3om2X5vmjTBwBfekD0J6hH0i+2k2zAc+4rOOM5iQ2YmGBwOLyP1HWbLkDqLy4eTVFlayZJJClC5HViFSnnyoRCVxbhjotfCVEwknURpV3BMeguNfkk8ip8Wdpqg75a2fcobEHCTZoKXEW7kICgE0tnspJs5E6ZaDOOBoXVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=eHw13xpe; arc=none smtp.client-ip=193.252.23.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="eHw13xpe"
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id smE1sbivSftTLsmE1sQI14; Mon, 23 Sep 2024 18:47:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1727110076;
	bh=zWX7l462UoWXZJBkgTkiyhgAoYwATUW37J8ldQiqwNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=eHw13xpe83Kj8V1k35HYSPEUWltzVwcHixYt1HwnhzSoOn0GUADHeP/GwhbGHvY3p
	 WGU8qeim1q+T9Ehy1h78FIeJihamWdNVIgxJ4uMxnZ3Pief1jly5GSq77WwYXH4aQK
	 H8Ezy4ujfLlSJbil9C6n33xsaFHtUhJYd62xHhZRM6P46wCJJNJBn9nXdUL0f3cBfW
	 u30oE09w/E59aDqON6lVB/qr+oYw00izuvoXl2Di/ubEsGNx7gAgygpmtbt6H9AoR9
	 SIbNvSScrz+J5iILmQgcQu9wFYR9oaW6NZVnUbUVACxZuvn3uGHwjBSzvd89S28Lg4
	 T9YzBB/WszLJQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 23 Sep 2024 18:47:56 +0200
X-ME-IP: 90.11.132.44
Message-ID: <9680600d-0bea-4339-bbf5-0ccc50d13551@wanadoo.fr>
Date: Mon, 23 Sep 2024 18:47:46 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zram: don't free statically defined names
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
 Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, stable@vger.kernel.org
References: <20240923080211.820185-1-andrej.skvortzov@gmail.com>
 <20240923153449.GC38742@google.com> <20240923154738.GE38742@google.com>
 <ZvGPWaXm26iq-8TI@skv.local> <20240923160708.GF38742@google.com>
 <ZvGar7f5IcMiFzKk@skv.local>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZvGar7f5IcMiFzKk@skv.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 23/09/2024 à 18:43, Andrey Skvortsov a écrit :
> On 24-09-24 01:07, Sergey Senozhatsky wrote:
>> On (24/09/23 18:55), Andrey Skvortsov wrote:
>> [..]
>>>> Ugh, I know what's happening.  You don't have CONFIG_ZRAM_MULTI_COMP
>>>> so that ZRAM_PRIMARY_COMP and ZRAM_SECONDARY_COMP are the same thing.
>>>> Yeah, that all makes sense now, I haven't thought about it.
>>>
>>> yes, I don't have CONFIG_ZRAM_MULTI_COMP set. I'll include your
>>> comment into commit description for v2.
>>
>> Thanks.
>>
>> Can you do it something like the diff below?  Let's iterate
>> ->comp_algs from ZRAM_PRIMARY_COMP.  I don't really mind the
>> "Do not free statically defined" comment, up to you.
>>
>> And the commit message probably can stay that: on !CONFIG_ZRAM_MULTI_COMP
>> systems ZRAM_SECONDARY_COMP can hold default_compressor, because it's
>> the same offset as ZRAM_PRIMARY_COMP, so we need to make sure that we
>> don't attempt to kfree() the statically defined comp name.
>>
>> ---
>>
>> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
>> index c3d245617083..ad9c9bc3ccfc 100644
>> --- a/drivers/block/zram/zram_drv.c
>> +++ b/drivers/block/zram/zram_drv.c
>> @@ -2115,8 +2115,10 @@ static void zram_destroy_comps(struct zram *zram)
>>                  zram->num_active_comps--;
>>          }
>>   
>> -       for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
>> -               kfree(zram->comp_algs[prio]);
>> +       for (prio = ZRAM_PRIMARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
>> +               /* Do not free statically defined compression algorithms */
>> +               if (zram->comp_algs[prio] != default_compressor)
>> +                       kfree(zram->comp_algs[prio]);
>>                  zram->comp_algs[prio] = NULL;
>>          }
> Sorry, I've seen you comment after I've sent v2. I'll do this in v3.
> 

Hi,

maybe kfree_const() to catch potential future cases and simplify code?

CJ

