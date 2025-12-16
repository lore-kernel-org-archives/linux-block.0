Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13796223328
	for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 02:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765851794; cv=none; b=CxqkgbHp9EeVh6PlslV9hG/iSHP0HkQcXHv17YRpgg6aPNppfKCJC3Fe+Ol3XrApL3RSGfdtuAQZXk0/rerPquSW9kgLpjO4mhs5CdJ0zE9vje/kWjQ2LY6+79S8SSmq6eOSuq243SkvqcnEbmr+80M/G/HumH2kADx/1uf4SMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765851794; c=relaxed/simple;
	bh=Ng3XKtYzcqs3QyB0tnd5OjYA830AFLZFWFUSOxyXL2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgQboerMFqFA3VEcyQYWdvPcFokg7uNiBC1wAgd2t6kly6qeCvrL38RWgJeieQQNKKmxmGdhOZzVRiinPK7u/U+bBD0RPYY9wOGCGARK+G27jp9VLOnvN6ymFc0jHjieH3x0zVzn8PIKfJXRIxq0oL5UVINTmyqYdkqmD2V9ZB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dwFKVww1; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dwFKVww1"
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7c75387bb27so1785292a34.1
        for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 18:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765851790; x=1766456590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=97NP7q40hxg4C4aKfTESLyYY7arcjR+J9fUfN3qZbks=;
        b=dwFKVww1TTDVt3I17gX7q8URKllnAr6RKGHcaWTFtb1LJ8KZuhNexDAqcDfcg2k9N4
         gGYRFivMfLj7sqPtvxw+BRPanwpVXWm3s4BN/ftMEqGcz3Ldw2jL6KYPWZ1fB9W3R4C2
         esA2xKwIPmWQb26SrPRfjzPRklqjFkUSYJs2LMx+cwDHhAMd8cPSdNjMWI5C1Ss5OmT6
         d4V4YluAXjWWxBFfQLLwZBah9lKA+XeRCQDpX0Qtu/Mkjr071HnphW34mNBVptV34X/A
         9ZmFaEDGZCoNZSun5NvejHWLOOZYWaikZVAgWZcCMUy6LDeU/a88m/6LDWoH6ptQ/kh8
         wH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765851790; x=1766456590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97NP7q40hxg4C4aKfTESLyYY7arcjR+J9fUfN3qZbks=;
        b=f2ccuZYx5HJ8lBFyoSfW5wN0h1cJ6eZ6lIDWdPHXWSiIn4DaW6iGQm0JtVeP0JPMku
         TnzPMD/Kjsd1/01m4LN5xbTpDlAQBuHymVXkw7qNN7t16KPJCmL83G9qiDbvgUdVNbo/
         iF0g9Jh8DEQTXLLP9JzR6lmVZ1ZB/8IG9wM4qHYObPbnpgbO7BXU0FzLqc/xwDNwtaKW
         3NoZ3NpPeBWWmMEri48yT+PrDP7d7SZqcsxSdv8FhauMW1Nmqcvfwt/fH9HkU1DZkzhm
         9rJiNaczctmJbl4VK3ui2S48pbfDq12rTu1x5K0NesQo9iraAYrSHiYjjrgXUS7yKCpK
         Rgkw==
X-Forwarded-Encrypted: i=1; AJvYcCXgKDExEeb1LHAQFOXeY/il/L7QyThMqhJP13DTSOCipKBtJ970rmevozs+7bvSVrDF7Nkwm46KlxqGpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGSNcRh1Gwp/yfurGYSm5X3qsfXlQCNd9p9if4Y/rla0rPm7cg
	w9s/Oj+o+Y3o/RfKdOorcslGfdyjhJR95pweBCIlUEQTRYQiX/A+N4I3xgNMzmUwkQ7HH/Y47+I
	NX3BLn8EGoA==
X-Gm-Gg: AY/fxX49i8nh+OMLF57KNZiSxMrl3Z8npPMbSySzHmITrtEsuSwqQzjZ47/CX7Tqqp0
	Onr8JLv4pe5lz0PBbgdymbqpa9Z/f3/FeCAslEsy+XSNKJueZzjmO9jCjbvU7QExcqNybpGqMMB
	yytJI0Lr4nOzwoJ+59aviJBJiNf/jUszryPCe0+tY6Cv/RcVZ5A3JNmm/gxosHfIW6Osvmo78SB
	1M0uXmUgDP0RWz6UrSTZirvjDsbKTcZ9QPDLbVRgrMTBG2phjh5SwZKVqfEi9ZEpZ3BSkCAlh3e
	dvG7W0M9tjhl+tcemFQX54KMVq7ELPEf6q/uqSstJ8OfQ5Wn2n/RzAIUhPL6sqSL77/0HQtJE21
	9JfUhXy2tfUC7p19j1YC9b16vlInnTu79rcT3ezs4z6uBMnATMHAtRT6ClQgPO1lfZ5ujaQVC9E
	URdTvj2gMM
X-Google-Smtp-Source: AGHT+IGw49EXJuZm3frjyR11xkPH+vdqLYoeS1FUPQDYXLmra5UiAdf2Xx2U8pJgwATRG6fINRGdEA==
X-Received: by 2002:a05:6830:4990:b0:7c6:d001:afb2 with SMTP id 46e09a7af769-7cae8398d7emr6145680a34.35.1765851789989;
        Mon, 15 Dec 2025 18:23:09 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb1ff4desm11006188a34.7.2025.12.15.18.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 18:23:09 -0800 (PST)
Message-ID: <09d2d256-2eba-41ea-a397-dca4df5d5a2a@kernel.dk>
Date: Mon, 15 Dec 2025 19:23:07 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: retiring laptop_mode? was Re: [PATCH] mm: vmscan: always allow
 writeback during memcg reclaim
To: Johannes Weiner <hannes@cmpxchg.org>,
 Christoph Hellwig <hch@infradead.org>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20251213083639.364539-1-kartikey406@gmail.com>
 <20251215041200.GB905277@cmpxchg.org> <aT-xv1BNYabnZB_n@infradead.org>
 <20251215200838.GC905277@cmpxchg.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251215200838.GC905277@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/25 1:08 PM, Johannes Weiner wrote:
> On Sun, Dec 14, 2025 at 10:59:11PM -0800, Christoph Hellwig wrote:
>> On Sun, Dec 14, 2025 at 11:12:00PM -0500, Johannes Weiner wrote:
>>> That reasoning doesn't make sense to me. Reclaim is always in response
>>> to an allocation need. The laptop_mode idea applies to cgroup reclaim
>>> as much as any other reclaim.
>>>
>>> Now obviously all of this is pretty dated. Reclaim doesn't do
>>> filesystem writes anymore, and I'm not sure there are a whole lot of
>>> laptops with rotational drives left, either. Also I doubt anybody is
>>> still using zone_reclaim_mode (which is where the may_unmap is from).
>>
>> Yeah.  I wonder if we should retire laptop_mode.  It was a cute hack
>> back then, but it has it's ugly fingers in way to many places and
>> should be mostly obsolete by how writeback works these days.
> 
> Yes, that makes sense to me. How about the below?
> 
> It doesn't actually get rid of the reclaim toggles - I added comments
> for the other usecases. But it's a nice diffstat nonetheless.
> 
> Debated whether to add some sort of deprecation sysctl handler, but at
> least systemd-sysctl just prints a warning and still applies other
> settings from the same config file.
> 
> ---
> 
> From 868f67e9d0d4465a6c22d8a147084944e7569c8d Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Mon, 15 Dec 2025 12:57:53 -0500
> Subject: [PATCH] mm/block/fs: remove laptop_mode
> 
> Laptop mode was introduced to save battery, by delaying and
> consolidating writes and maximize the time rotating hard drives
> wouldn't have to spin. Needless to say, this is a scenario of the
> (in)glorious past.
> 
> The footprint of the feature is small, but nevertheless it's a
> complicating factor in mm, block, filesystems. Developers don't think
> about it, and the decision-making in reclaim looks dubious. It likely
> hasn't been tested in years while the surrounding code has evolved.

From a quick glance, looks good to me:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

