Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3411B337114
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763393017; cv=none; b=XMIsvM1VPrr6x7dll/EkTaBRG4J5qw/WJDuW2cd/qdLdCyE2OyhWw8tquI4gtkNGW3TP3686pNWJEB+M3ZAGTLz004FrnCrypVtUoCUA4FZiuN9P7ryC8DuuhDiyFAukgCClO48/Zmz2kdjCrny2mZAe7P11+Z0B2ewyImI+4GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763393017; c=relaxed/simple;
	bh=xS5tzg74wO36FvpZDrvP5hjlzCRPwA2xARqpXwX/w3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2KAf6SEDZoEDPffmvy3DgVirPKLa30n6gWu9G1F9x9LkAi9cX/vd1NACp5GBsBHqCjeTW2LtPf3M/9R+7MSDSZzmdATqt0iw2tNJ3+sykWfMgQmslNwcJPBDthzv8gvs5suLmek9K87C3viyZDSQk1Nfitmm9CIA8PoAmcLhME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rgHjwedg; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rgHjwedg"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-949022f1c85so72084039f.0
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 07:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763393013; x=1763997813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HKaqk3O11ga6Z5kFnUSa4tDsL6Xj/6nEJ1KOCN1E6t8=;
        b=rgHjwedgjUUtn1PBUccl8fuljtM3LYcNqFyb2SpLJpxiYpgT4wCzlEyWgQcUw6dVL+
         3pv4LEg25bR7jhs/6qEou0rWBrCd2RCgWHOKAEfYYjzpWRyRFeE1vXGs57A+WuYMzoVk
         CdRq+rb6CabTGR1scOCeha3pNlLWW3QJ7tMpWhRUWaFGkdDqhTbYaeGL6IWmY2/ptsu0
         50yA2bJKMfI51oCfZT/faj10+SZqRVQAyzfvqQLXqPVyzVgGKxXl7uuxOy65LykBSFCd
         5+5qFqMHIjaUFYGcSS7VJFmE557fpEuy6GjycGtWWdJsYh1abDtyazFWoWwO/BuFr3+O
         SWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763393013; x=1763997813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKaqk3O11ga6Z5kFnUSa4tDsL6Xj/6nEJ1KOCN1E6t8=;
        b=B8Hoz4XgKPNkKf40Sl5OllxhIWpiKc6lVjpITUiJGZr3NNYw+JQnKAjPMOAf7HjkBW
         0BDA8zM2oASY/3s63CWQgIXxsbh0KC+xT0DZcz97EXmlUKURAL8ZWVOl/Od83vDLG0Ve
         RJUG5IKgQ3Ebt4VhuxC6B/wM4+o5NvP0o/1BpSIBSDBd1FbrIwWVXRWawvxtFki5XSQJ
         /2/0YCZiZ3+nXOaQmRthUvJ3zduXCxz+zrqliKro5ST1bC/cNrieixSivkc3j42jFcp+
         tJEgRymQ45Of3SxgMKerjXggSqLE6FoqP9TYtjqSBGClorOkibZUbgsrG2vozIXnqcb8
         Whww==
X-Gm-Message-State: AOJu0YwCEVKv5/Hh417Dt1nTt+yWTa/swJ78ZwibNqOEGj1ulBYZcJiV
	dLPGHj6yo4NkmlxUCHzlT5TmrWuAd/TxAl2MSTo1LrT7vxbhov2HB3EvhOSkay4Hu6+aupUJvVo
	5u1EN
X-Gm-Gg: ASbGncuCGnlCVMvP4E+4Q11CMxapeRDc90F3sERCrDgSUI6tI4DXVQ5puk9mEWR30KC
	HSbRESPWx766JiYOHe2TEHrcLK7/4sCNqzCdjIt5WqBdfHq4bEk6pzA2EoRlT/rT12g/p6tpsLo
	HdpxzMrCrh0lwmunXfFLo/I+gr4lks03X4yt14OlMiQqH0Toub6KDsISPSoKVIzrgP+H4GdV56j
	E13cWcZbMNOwSOIROIrsXtWxZ1KOaZcQ7JmZ9ebnolKVNdx0QVYDUsLGxHlT2+iDblRlAjurGYN
	MbrJoLENX1vPx+1f6ns92wxGBzGUtFdzXlyzs9Dfo1IkPVhcnoDTR3NLV9b4+VmU0kAs6yQYLLB
	o9x+LGbLWxqzYqtXcd5RpsrWOhatsUEyyVGDKusgRtpd2DwHUCFpbIO+C/8Cpq1VMBj5F0TJ1Y2
	TTkEwfnZg=
X-Google-Smtp-Source: AGHT+IEqruXPREkKcAv5IjH/MXPgJ364JnUEFE8cIMtlFz0GlZrMB3FUcTcVoVNtbJN0tr/xowiE8A==
X-Received: by 2002:a05:6638:35a0:b0:5ab:833d:bd56 with SMTP id 8926c6da1cb9f-5b7c9de912emr10186881173.19.1763393013160;
        Mon, 17 Nov 2025 07:23:33 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd351101sm4877163173.60.2025.11.17.07.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 07:23:32 -0800 (PST)
Message-ID: <65dcdc8e-73e9-482c-8450-23d66a4e2557@kernel.dk>
Date: Mon, 17 Nov 2025 08:23:31 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix floppy for PAGE_SIZE != 4KB
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
Cc: linux-block@vger.kernel.org, efremov@linux.com
References: <b1e17016-3d4d-4fac-b5b0-97db357d0749@kernel.dk>
 <20251114.172543.20704181754788128.rene@exactco.de>
 <fec67c88-53f5-4482-aeef-86e1213d187e@kernel.dk>
 <20251114.192119.1776060250519701367.rene@exactco.de>
 <708B7962-86CD-489B-AC33-4B929F2902B6@exactco.de>
 <c8cbccc1-964c-43ce-a992-624d2efcfd4a@kernel.dk>
 <AB0440F0-7D27-44E4-A92A-D7761E062A76@exactco.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <AB0440F0-7D27-44E4-A92A-D7761E062A76@exactco.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/17/25 6:57 AM, René Rebe wrote:
> Hi,
> 
>> On 17. Nov 2025, at 14:23, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 11/17/25 2:56 AM, Ren? Rebe wrote:
> ...
>>> Any chance we can get my initial one liner constant PAGE_SIZE fix
>>> for this over a decade old bug in? I currently don?t have a budget
>>> to refactor the floppy driver probing for efficiency on bigger PAGE_SIZE
>>> configs I?m not even having a floppy controller on.
>>
>> Yep we can do that. It'd be great if we could augment the change with
>> what commit broke it, so it can get backported to stable kernels as
>> well. Was it:
>>
>> commit fe4ec12e1865a2114056b799e4869bf4c30e47df
>> Author: Christoph Hellwig <hch@lst.de>
>> Date:   Fri Jun 26 10:01:52 2020 +0200
>>
>>    floppy: use block_size
> 
> maybe, but I’m not 100% sure. Probably not the best answer
> for kernel driver development. It might have been broken in
> other ways for over a decade already. I would need to debug
> that to be sure, but then I could also see if I can make it easily
> work without changing the max size constant, ...

I'll just mark it for stable, then at least it'll go to most of
the ones we care about.

-- 
Jens Axboe

