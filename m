Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6545530EF74
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480319; cv=none; b=Bl4p0zdPBxfznFcqgASw4nm1n2p5N4+Plm8oogYsUy4ph1KkyrWGM1YxUYaF7hACuBF1MjpBF0PTgRXtH6Suvv6BOloaTWZWlbHOzuLg8O7ob5olZm7y7PUz1YhbwS82xDZ3FdMCctb2LRjlOIyRrzqvgTOW6BSkDtb5ju2eCu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480319; c=relaxed/simple;
	bh=ddhhXoz77KjesXVjgaQTeH8VlxfAu4xqLht3inzcM0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFgqG43Qs6wuYo9NrXf12qob/2tmVzqUs3BcQc1twrfSDNuCtn1T2Yl11Nl+TzQYE/vko7akPgwnnK0wHx/O2kef8E2jBczgHdMLwa3rsS+vuF7GdnpA5wA0TL5OOyFv38F0LTs6wVxKDl9GzWxUiSLcO2ljHTwVcC00C7u68Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zyoZm3xE; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zyoZm3xE"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-9486354dcb2so244126839f.3
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 07:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763480315; x=1764085115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=syLOysko2PjVjP3rQi26J/xIpXqgxMSJ/fbRGh2rHe8=;
        b=zyoZm3xElDdD0CydnSjmTUxN+PySN2liUJgqb4BfR2YqWoEW6qvj01Z+kkc8DlE/ph
         JpHUe4jsA88iaAuyIbbnjCDAwDT24JuOBLmLY1vGcZAqgu58f9/GchqE8Wgu4N7DkLGP
         KNE6rKGOByuYBUsYiaI28ZvHodgae+IGLAa5DfKo8cfMRtXSgsrXtHUtwYrTm6XC8nJ7
         oBmsU1aMANjMAKx4tl12F6/gQ1vVMnHVFUuCSoNlUqYvl2ORSjl3nWpj1nkLyDTUOISM
         IbXBKQfVhjqn2mviwbysR3ZCm/oqe9Aonq3OLBNuG6jgnVvNTqVq9CJlriX997OTZ+DV
         5oLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480315; x=1764085115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=syLOysko2PjVjP3rQi26J/xIpXqgxMSJ/fbRGh2rHe8=;
        b=bqKELSsZVGR38sjtJWoIiA+dwIjlWTkz/KOt9/SJvwpAle4SSXUnWJZE/9sWWLUY7+
         SMNLpGPm1pZ+kztBIx7hTg/TWnhF17wzuvv8A0oAQB72OyyNhFX2fmegmVO2fK4yvxiB
         LYXydFMtzrRX/3ijLk39KK2UBwv24nWPcMnVv4xRqr5pqnYMQ68MwDlVYPgJ17l8KM95
         8Vk4ry5VVDC/eCNmWoPIQo1QLLHSDLcdkU07a3x7SRfZ1EpmSRHa1p3YjCIpHd+7pM28
         uFn0SMeBCTA1Yuwa6QTabj011u2zX/aCCJJihejIUPGyNdyxbqzFFlews6s6zEzuL1yg
         GvZw==
X-Gm-Message-State: AOJu0Yxa249ACn1U/XgtIT6V10vyB8ef6tgBzhUnXjU0m0WuRABIlhAv
	QdWF8iJ10WIE3jT3xPSs+JtryRDzWH0qCfK+Aoz7FiY6zqEZwg3h098Lj1fxr0yoXerh6pr4OmQ
	YCuf1
X-Gm-Gg: ASbGncuG+xk7Mz1fL/3IDrNlDsWGGohh6bhxbSCXiHb6oWtaF+3iGjOjT0roRI8wmXx
	DN+w0pZX1txjciTyslHI0J1hUOq25yH3s+e9ZQ8y4zyLU/6oAEJoleSaDS/MJvpPrRLX03nAQHt
	PIiXWCdvAGdxMOOepN1f4HBrFxjBYnFONpRGdAd3eMVyi7hQsKTcpN3moXZU6zZ0YKdTsYD8cHn
	aHeX65aRI6IRVyoYRQjpPAKweIuqCEKWuje9VvROrEl0CImK9u9/KQJkF8xjCC+qLoL+hZpgdsR
	KiVOeOWOOVnHlqN2BhzrwIsFe92g2zR2rQ2ZC6H0U3t1A5HaA2XMHEHK3+niyly8kP8QLIOcpJU
	oEP19TutkHoY2Yl+ZDJ643sCfVgz/LwixoILJuNcBKx4YTYl8WieBxZJfy/ZCZq75/bwxDkXqx6
	IoCSzh5ONEJvLA/QDy7aY=
X-Google-Smtp-Source: AGHT+IG+G5q8BqGr1HjnY1rqhGN5Fzm0jeXgWv7PL/8FNh3GYyFa52BvsydUtVPeKv5tIeHFxDxLqQ==
X-Received: by 2002:a05:6638:2503:b0:5a9:f65b:f9fb with SMTP id 8926c6da1cb9f-5b7c9de8b03mr14207077173.17.1763480315385;
        Tue, 18 Nov 2025 07:38:35 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd26e1b7sm6215121173.17.2025.11.18.07.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 07:38:34 -0800 (PST)
Message-ID: <866dbb8d-dfb4-422e-b20e-795111cd6349@kernel.dk>
Date: Tue, 18 Nov 2025 08:38:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme discard issue
To: Keith Busch <kbusch@kernel.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <26acdfdf-de13-430b-8c73-f890c7689a84@kernel.dk>
 <aRyPJtYJaEVRkBeM@kbusch-mbp>
 <0767437b-3861-479e-aee2-d4f5cce9f6eb@kernel.dk>
 <aRyR6MaF5-CoVRDW@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aRyR6MaF5-CoVRDW@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/25 8:34 AM, Keith Busch wrote:
> On Tue, Nov 18, 2025 at 08:28:16AM -0700, Jens Axboe wrote:
>> On 11/18/25 8:22 AM, Keith Busch wrote:
>>> On Tue, Nov 18, 2025 at 07:24:59AM -0700, Jens Axboe wrote:
>>>> commit 2516c246d01c23a5f5310e9ac78d9f8aad9b1d0e
>>>> Author: Keith Busch <kbusch@kernel.org>
>>>> Date:   Fri Nov 14 10:31:45 2025 -0800
>>>>
>>>>     block: consider discard merge last
>>>>
>>>> This was just doing an allmodconfig build, using XFS as per the trace
>>>> above. The fs is mounted:
>>>
>>> Huh, xfs was the only filesystem I tested, but obviously not enough. So
>>> the segment accounting is off now, I'll take a look.
>>
>> It's all very strange - reverted the above commit, and ran into other
>> issues. So may be something else entirely and your commit is fine. My
>> for-6.19/block branch seems fine (?!?), but merged into master it's not.
> 
> Interesting, I'll keep testing futher back too.

Thanks!

> But I do see a non-trivial problem with my patch, so I think you should
> either drop or revert it at this time. For the discard back merge case,
> ideally we'd just adjust the bio's bi_size and drop the second bio
> completely.
> 
> Anyway, sorry, that was my mistake. I was trying to get nvme to hit a
> previous bug from merging data-less bio's that nvme had dodged.

OK, I'll revert it for now. Done.

-- 
Jens Axboe
