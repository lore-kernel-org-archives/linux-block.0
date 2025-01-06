Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1A91DE8A3
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736185109; cv=none; b=IV57PfzZelVtO0m0iNaZLo1nhJ0x/VqwknoDf6ole6L7qRKselMF3Go6FxI2YygDeV1Mv/FoKZGMEUlDOCTWkg1001/iLcFO3PEujCrGTONtHcpRIsML+Ic8cpKR443Uu7DCGv6+odwqlM7bUMbS7Ov8uK7wDkKbICgeTLk5320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736185109; c=relaxed/simple;
	bh=HqQac98koGpcRgVnk5OiMEOukBwu/l0C/Cj6lo8XlWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYW1toWQidtyVtSvT+vpbo5bul2Pg+T7L92kzegMWBHzUO+BGNovpZTqAYeOGUOCcyf1ofifPxnoT8/kNR2iFQ/uYHXqmsAacCD/ZUXFbN7I0fz4qYxuoCXF9zTd8sVaJYb4X/kdTYbvbJGVupQmGzFDuPqvuj7OnftWrT0M9XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jSyove1j; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jSyove1j"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-844cd85f5ebso1214592539f.3
        for <linux-block@vger.kernel.org>; Mon, 06 Jan 2025 09:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736185105; x=1736789905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iI+FdqOkp7p0tMgScSl2cpO3Y8DqvIOewTTctuZpJRU=;
        b=jSyove1jiXLGNgIA9VNUCneUdBS94wEddOqvyDq0/bv/Gq4Vkpboz9idCtazqBXSUl
         JYobb03JJqrNBzGSFKLEjz9RQ8bjxto4SL8gbpczP39nJUUCpE0RqMEWEcLRWCGzB2Ds
         IEuI/r+UvwmQTs5MWQZDQltl+VIZNrQmvzod3wjC43EIHSnYsrvbwDfAaRAih1Vk3NIu
         hufmLw3MvuGAwiBRetK9zJ0LHMXW57GfW/Grgv5ABMlckNVepj8wqMid0ms6ILC3MmlT
         0DjDy65XRZW2ic5d5long4z/f5ATfRHzQFaBK5xTnJIr6TjhMFHAcyUhSJQBUH4VB10R
         tLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736185105; x=1736789905;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iI+FdqOkp7p0tMgScSl2cpO3Y8DqvIOewTTctuZpJRU=;
        b=qRGY73+4kkgaL1Z0R+VkmcON6FSrY/NE/srWmNdg/NeD8Aa1FgbJxDQcvHuCBoPSeo
         adxhLfg7KGM64vw+0Y5tgxC/y+48OXbRwT6EE4SPf1cUhEoasW0wzeewlulhw3hoKKN/
         oVxj0qO6TAlVaSpchYs/fh138xChZOmLu7Z3K/6kkRbwVLiVuiUnSlLbg8Gu9nvW3WCb
         nQJRgwkLwN/id10EPbYoIDaDBMrD/IplDWZufksQfx/+dHDE0MvemK+KuhiVii41APUZ
         v9KtTUvQLTD+2CRoBN6ltsLa//Mc5gA/yIaWQVxvkvgzoqMlkb3FGnuKc19AN9WtGzDO
         aZ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUveV0IojR6A2wCft7ojPBBaLIlUjpS81JJgcupDkGNiKJ4mOa1I5J9zqURnEuANpCojwezA3GDxnufHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLFw6t7wsbdxWQ2xL/TYME9FgRqfAC+xjYV2TOhhQqy0F4yzBC
	ivUV+xhr7z2UW+5XHwwgVkQu0z0xk2DjZe3DcalgWu7Ikx4ljb/0fHKnmkrWJ00=
X-Gm-Gg: ASbGncsNHTD8hzZbAn6MAEEfXbeXE4W5vH7tI7x6cfR3wR5v87SrhQk+77gNXFNvcfW
	c0KdtZ29dusOBAcS+oe44W3C7DzPKwpWEwCDK4DypjOv7iK3SXGf9opktc+ezK2sI/NZjkDKKM4
	gzvSt7sCLaWRu0M3H2X1qLo3ENoC2pwQyTZ6ULiO9F20ZVmTpVIvYTqUjMKCJiV598qnjE7S7q4
	tMpQmgO+xlvoaTHh1QdXQQWesinSQAoHUu2xTzb4Xeyjd8DIEr8
X-Google-Smtp-Source: AGHT+IE+M7llGM1dqEPL/7mTw9fKwD2HpWdKBfq92HMdOtSPt16XiOAuToSRSCnj7hDqwCo6YeHhSQ==
X-Received: by 2002:a05:6602:3428:b0:841:950b:386d with SMTP id ca18e2360f4ac-8499e49a2d0mr6107779439f.3.1736185105522;
        Mon, 06 Jan 2025 09:38:25 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8498d7c81ebsm900865139f.3.2025.01.06.09.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 09:38:24 -0800 (PST)
Message-ID: <5f57ff26-2c87-45fa-bb91-4f68492bac85@kernel.dk>
Date: Mon, 6 Jan 2025 10:38:24 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] New zoned loop block device driver
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
References: <20250106142439.216598-1-dlemoal@kernel.org>
 <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk>
 <20250106152118.GB27324@lst.de>
 <98be988f-5f6a-489d-b0e1-2f783c5b8a32@kernel.dk>
 <20250106153252.GA27739@lst.de>
 <0f2eea00-e5e9-4cd1-8fe6-89ed0c2b262b@kernel.dk>
 <20250106154433.GA28074@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250106154433.GA28074@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/25 8:44 AM, Christoph Hellwig wrote:
> On Mon, Jan 06, 2025 at 08:38:26AM -0700, Jens Axboe wrote:
>> On 1/6/25 8:32 AM, Christoph Hellwig wrote:
>>> On Mon, Jan 06, 2025 at 08:24:06AM -0700, Jens Axboe wrote:
>>>> A lot more code where?
>>>
>>> Very good and relevant question.  Some random new repo that no one knows
>>> about?  Not very helpful.  xfstests itself?  Maybe, but that would just
>>> means other users have to fork it.
>>
>> Why would they have to fork it? Just put it in xfstests itself. These
>> are very weak reasons, imho.
> 
> Because that way other users can't use it.  Damien has already mentioned
> some.

If it's actually useful to others, then it can become a standalone
thing. Really nothing new there.

> And someone would actually have to write that hypothetical thing.

That is certainly true.

>>>> Not in the kernel. And now we're stuck with a new
>>>> driver for a relatively niche use case. Seems like a bad tradeoff to me.
>>>
>>> Seriously, if you can't Damien and me to maintain a little driver
>>> using completely standard interfaces without any magic you'll have
>>> different problems keepign the block layer alive :)
>>
>> Asking "why do we need this driver, when we can accomplish the same with
>> existing stuff"
> 
> There is no "existing stuff"

Right, that's true on both sides now. Yes this kernel driver has been
written, but in practice there is no existing stuff.

>> is a valid question, and I'm a bit puzzled why we can't
>> just have a reasonable discussion about this.
> 
> I think this is a valid and reasonable discussion.  But maybe we're
> just not on the same page.  I don't know anything existing and usable,
> maybe I've just not found it?

Not that I'm aware of, it was just a suggestion/thought that we could
utilize an existing driver for this, rather than have a separate one.
Yes the proposed one is pretty simple and not large, and maintaining it
isn't a big deal, but it's still a new driver and hence why I was asking
"why can't we just use ublk for this". That also keeps the code mostly
in userspace which is nice, rather than needing kernel changes for new
features, changes, etc.

-- 
Jens Axboe
