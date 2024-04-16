Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F020F12AAE6
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277992; cv=none; b=lTlA0KVFAPZfAkIei9kw9XA4sUhCOwBV2NTQyTqTIJw2rSacpA6vtMqQ1Kj4NBQW0W5s6EX9cQZWl3NkoBPez+nr5EddMILuGPqOxqa5PePbFA4MS3VgVfe/i73p7XoY//liIWG7Xf68c9uqxS80yzWSH0/aQ1W5eT/38RdekhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277992; c=relaxed/simple;
	bh=tQt0h4/JJzNUSt7YJAw13nbwhiLd1bvHD0j7b+rfdIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkOwoOQagwnUu+89DwmCr6Pq+ObdAZOUv1pJQ2ZbcXgFmq+wFhGUOlNE9qYINHLBDQbW4xWPRw61YXdZi7hIKTCNRr3UhRQ+FcN3IGm6gEfJfch8yyA5WKCkvrNjDZP7HlsKef6NIE3JoipLbqwNef6H3QgLo7he+4vfH2EifDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Y0jDybLz; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Y0jDybLz"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso20741239f.0
        for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 07:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713277990; x=1713882790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4USUkCePqO/DUZZKKDjSqTMfiwj3FB1TFFvhdvW85WE=;
        b=Y0jDybLznBKfu4Gr4cWBmYDvU2Kf/t+w+kavoCMkvtciH9Rzz914YhuGxPpUicDGaN
         F5oVYS3H7yxGO86YBpdbU1cCt7ImshCUAy8oa+SJJwDoxvIeXysU4ywq881QulFxAgPA
         ioTlmJ9dqoF/d1tLeGfEJbbkbetW/+OooUEjGcLRthiY19ZZYzMzrs738idvIhRb25GX
         7HkhJy9lrZEVdIuWELzihj8aBr/nuwecaeSjjmUGj/wpqu+1AIBoC8cLblGoRqfDo0MF
         Y0N7vnOoPdL635dp+xt2ZNHtSfPaUW9p61i0PIMWM0BS07Q3NCIxwLfCOcsiBFYRqrEY
         2ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713277990; x=1713882790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4USUkCePqO/DUZZKKDjSqTMfiwj3FB1TFFvhdvW85WE=;
        b=IKXIlN1T5KCJN/9P68N3cf48q62YaMW/rSkOBiDoEZNYx7PdaPo87cDE/F5nnL41dY
         Sw/TynLQvN54Xqp+Oi3AY9Nv2SOvDRznRRcdg6lS8+o90IATSdnFYnxZArlsIwprgBzd
         YhM6KnHxvcJGvXc41SvyraM6VjJKtjIJ/u1G9JXakbkQwxKgdbWxByM8er7fW32NHHmc
         7s8AqimmTqCzlMGPwY8C0LU4nej+r2tfO0Vg1Phu8nOMwavNAGa52rWKTn3dELl8YlVV
         NE61DdXPvN902awrDvKupK5NrtCiEHj9BA1rXcdnkQkYfyKj+9shIeuLXprdr4RsbrDr
         k0xg==
X-Forwarded-Encrypted: i=1; AJvYcCXywK+cYrIqaWLBxQjcw9ubC2NmhLT4d4GlvGXm1N7EEpMMt6xJzCY9b8FJZ3w9hlknTqK6K/xN7EKohnPPjejcwtemJTt10IeDhqk=
X-Gm-Message-State: AOJu0YyORGDZO2Bmb6YE33g++B+IKcseQ5Y5Cw9PrQbdeuO5XByv+5MY
	NOG6L6B/8ZlsqY88NVwTkLqG+QaddXwnt6WiorPdlqixv/OC1wkkoGhQ2hk7ZL0=
X-Google-Smtp-Source: AGHT+IEFdSzzJPNEuBYNeCsLyyZ+pPblusmvyciDSgRZZSqKohbfOFFV+4drEx+cUWKBoEDWOFDJFg==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr13722190iov.2.1713277990087;
        Tue, 16 Apr 2024 07:33:10 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v7-20020a056638250700b0047f1ac1bfd2sm3909914jat.163.2024.04.16.07.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 07:33:09 -0700 (PDT)
Message-ID: <c3a6a639-bf15-4f8b-abbd-978d9836d93c@kernel.dk>
Date: Tue, 16 Apr 2024 08:33:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: API break, sysfs "capability" file
Content-Language: en-US
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <ZhQJf8mzq_wipkBH@gardel-login>
 <54e3c969-3ee8-40d8-91d9-9b9402001d27@leemhuis.info>
 <ZhQ6ZBmThBBy_eEX@kbusch-mbp.dhcp.thefacebook.com>
 <ZhRSVSmNmb_IjCCH@gardel-login>
 <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com>
 <ZhT5_fZ9SrM0053p@gardel-login> <20240409141531.GB21514@lst.de>
 <d7a2b07c-26eb-4d55-8aa7-137168bd0b49@kernel.dk>
 <Zh6IpqnSfGHXMjVa@gardel-login>
 <b74f99e8-5a50-4e93-987f-0bcfc0c27959@kernel.dk>
 <Zh6KZ7ynHuOd0mgQ@gardel-login>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zh6KZ7ynHuOd0mgQ@gardel-login>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/24 8:25 AM, Lennart Poettering wrote:
> On Di, 16.04.24 08:22, Jens Axboe (axboe@kernel.dk) wrote:
> 
>> On 4/16/24 8:18 AM, Lennart Poettering wrote:
>>> On Di, 09.04.24 09:17, Jens Axboe (axboe@kernel.dk) wrote:
>>>
>>>> On 4/9/24 8:15 AM, Christoph Hellwig wrote:
>>>>> On Tue, Apr 09, 2024 at 10:19:09AM +0200, Lennart Poettering wrote:
>>>>>> All I am looking for is a very simple test that returns me a boolean:
>>>>>> is there kernel-level partition scanning enabled on this device or
>>>>>> not.
>>>>>
>>>>> And we can add a trivial sysfs attribute for that.
>>>>
>>>> And I think we should. I don't know what was being smoked adding a sysfs
>>>> interface that exposed internal flag values - and honestly what was
>>>> being smoked to rely on that, but I think it's fair to say that the
>>>> majority of the fuckup here is on the kernel side.
>>>
>>> Yeah, it's a shitty interface, the kernel is rich in that. But it was
>>> excessively well documented, better in fact than almost all other
>>> kernel interfaces:
>>>
>>> ? https://www.kernel.org/doc/html/v5.16/block/capability.html ?
>>>
>>> If you document something on so much detail in the API docs, how do
>>> you expect this *not* to be relied on by userspace.
>>
>> This is _internal_ documentation, not user ABI documentation. The fact
>> that it's talking about internal flag values should make that clear,
>> though I can definitely see how that's just badly exposed along with
>> other things that document things that users/admins could care about.
> 
> The text begins with:
> 
>     "This file documents the sysfs file block/<disk>/capability."
> 
> So it makes very clear this is about the sysfs interface.
> 
> Are you saying that sysfs of the block layer should be considered an
> *internal* kernel API? That's a wild definition, if I may say so.

No I missed that - to me it's clearly internal documentation as it's
talking about the flags, but yeah you are right it's being presented as
sysfs documentation for the 'capability' file. That should never have
gone into the tree as ABI documentation.

Doesn't really change my conclusion from earlier. As mentioned, this is
clearly a kernel fuckup, and honestly since it's being presented as ABI,
we definitely need to rectify this and provide an alternative. Even
though I'm not a huge fan of it, might just be best to re-introduce
'capability' and just have conversions of the flags so we retain the
user side of it the same. That can then also go into stable, so we'll
end up with something that at least looks cohesive on the user side.

-- 
Jens Axboe

