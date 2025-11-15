Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B88B49659
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763166653; cv=none; b=oDrDfVf9NNH88P2XihQzKREbJHBkGRPmqFOZR2QksuoxQc5RYPXb35+WNwH9q/88a+szh+rqtDWP5oGSUJdyYJe3U7TWhTKatvX8TuA3LgKVIPhZPToAAN3F6f6G8y/MXhdcLohH9Tr+h6zp6ngXLBodo5rKFGkvm4yen5T1CLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763166653; c=relaxed/simple;
	bh=CyMEE0IhMEpR9YVsIa3u+pNlkztUYvjK7VmUdpcgFgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkJJAvhMhN38mylEas78ZSQw0nH6mP7Ji0OWgaULJWi10QBAjyOQ1aSRw00kCtbtiehm0eKhUHViqgee0EmiT/d/IuQaVgCXPXt4vYlIEH3E7vNWkMfF90TEnUXa5P2aHQw4Mh15Lbk1GqjvRmdrhdkjQriCeyRCfI1y0mjzvyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sc2gA6Ay; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc2gA6Ay"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7ba49f92362so1481352b3a.1
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 16:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763166651; x=1763771451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UH8vhsrcxkR8/9lYYF2BxevjVQSKucRmVZ2xBoOxvos=;
        b=Sc2gA6Aynmw27WVCwjKxAuZspB2BXwhUNBXacYT7sB5nvnAgIpICM9S59SgvDZz+r1
         o5EpoyWAv2ia53IhHz5N3Y+OXsiAAcgiwGhEScNhGFheYSpjde12nU+d7BHVtGRmHN3s
         8Vdc51d3eFLG7iHuYZZFFJEcNaXDmfZLuUILFC9ROT+c8abRwsJpp2C5aW2Fpkaazz7t
         rsBU/ZOaUujLcrRQze6zMohdNKUy6Fq0Tf2M13lXyTswFGNLK5Etth4rKJCNinWLMW7J
         3X3wiVbhc2M9Nfn6OpKmYD13oJL7/2h1PQpHSINUgmx5V4lLjVnuKtCT9ohRH/p18+9k
         XC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763166651; x=1763771451;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UH8vhsrcxkR8/9lYYF2BxevjVQSKucRmVZ2xBoOxvos=;
        b=KgYZ9B590mpVvYXdkJIP64PSn2aKk5nr6W7gYTKclDdKyf9LaLzJ1nVyetuZL8nQNJ
         L7K6ayELKkaXFtjo1l2TWJBwBvWXaOLlNqzjYcqBkUYqp3Bt5BQeHxuZW78M+1OGXXhP
         zD/oTHbpf3fUyZfoc/MnWyLeWNgytJVK7cXTQa7CAM94x5q9qtVMNeE9ERpNl6ehZ28V
         hoTn9DBeUc8V+kvTQxb06EOM0yZEQhMeiCmckSv2UIPhkJbuywN2xXOCrhry58OXe6vd
         iCA8+0zukzyh3LZRPF1ry1OXKa5X+tsVicDK7AsaArtMQV2KaV1i36d2zEm6poRSwMRA
         w+YQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1R2lIXP78Qqc4PidtfoX6+XurCPLXVeQERGJ7deGN/xgornfSGEmk03Lc/r933jk63H0NABoIxhnQDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLHxlvzTjL9nmtPM8nMY5DdIm8QIfRZInRn5F0Z9spfKZC09+m
	6ySt6AWC87InejjreRP4lgHlQ9mKlU046pQ0O6/TkI9W6G5WVrGvCQF5
X-Gm-Gg: ASbGncsW/UacyuxLZHpT4Uf2zrJES+mO+iHI50q6D0xpOEggGa29YYdXakN/XTMKm5Q
	vKb329wC4RR/2Jrh4QFe0xKoovBeAssHxxRJOFHT4dzSw77gGk5rkDd6PxTOoXKn4BU8Dv7J7+H
	gZ7qQuqjoyCm8NmkULX+8ykGM4IKT1W1AwtqP61ZQe8SSTWj7D+gewHzB3ONxncTUdlPeETgU6j
	uKtkSYDFC/LEoBYxrJ4Oj17N2sdk9mFTM3JD6xns098rM1CEeFzPG7mO62BFYRj8H0E4t4o2zCA
	cOY4C3FoNaq+fLJi6WfjYPJRz0CvCEkj6wVN5G7yUg+NT4wabhDKmqLOhzWo8LHqQP/O/aqx7vl
	47fhQG/LgdzDDddM5KItKGfF6Dl3toq/fUirYDd1Uy94BipUuwNr47U7Etjcl33lMwzb7vm4P/D
	p0aI3h18wIkgCADUsoJi6CZR0piFzZ5nNh5P+U3mZxgY+PstZp
X-Google-Smtp-Source: AGHT+IFZxpPHepoqcAonLXGZsRugPd4gH5rofBqG3xvaEzmCYdG8AmIGMTOgZ+fIwFwh5r602aQDvQ==
X-Received: by 2002:a05:6a20:7f8e:b0:354:ce8b:4b9a with SMTP id adf61e73a8af0-35a4eb01f1bmr11973447637.6.1763166651263;
        Fri, 14 Nov 2025 16:30:51 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37703a0d9sm5647721a12.31.2025.11.14.16.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 16:30:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <aea2df71-a255-4980-a75d-4918a7b2eac6@roeck-us.net>
Date: Fri, 14 Nov 2025 16:30:49 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block/blk-throttle: Fix throttle slice time for SSDs
To: Jens Axboe <axboe@kernel.dk>, Khazhy Kumykov <khazhy@chromium.org>,
 Tejun Heo <tj@kernel.org>
Cc: yukuai@kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Yu Kuai <yukuai3@huawei.com>, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250730164832.1468375-1-linux@roeck-us.net>
 <20250730164832.1468375-2-linux@roeck-us.net>
 <1a1fe348-9ae5-4f3e-be9e-19fa88af513c@kernel.org>
 <2919c400-9626-4cf7-a889-63ab50e989af@roeck-us.net>
 <CACGdZYKFxdF5sv3RY19_ZafgwVSy35E0JmUvL-B95CskHUC2Yw@mail.gmail.com>
 <b9efd5cb-d3cc-48df-8dda-2b3d85e2190b@kernel.dk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <b9efd5cb-d3cc-48df-8dda-2b3d85e2190b@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/14/25 12:51, Jens Axboe wrote:
> On 11/14/25 1:26 PM, Khazhy Kumykov wrote:
>> On Wed, Jul 30, 2025 at 4:19 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> On 7/30/25 11:30, Yu Kuai wrote:
>>> I had combined it because it is another left-over from bf20ab538c81 and
>>> I don't know if enabling statistics has other side effects. But, sure,
>>> I can split it out if that is preferred. Let's wait for feedback from
>>> Jens and/or Tejun; I'll follow their guidance.
>>>
>>> Thanks,
>>> Guenter
>>>
>> noticed this one in our carry queue... any further guidance here? If
>> my opinion counts, since this is a fixup for a "remove feature X"
>> commit... I would have done it in one commit as well :)
> 
> I agree with Yu that a split of patch 1 would be appropriate.
> 

I completely forgot about this, sorry.

I was about to send a new version, but Khazy was faster.

Thanks!
Guenter

