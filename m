Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WSLa365g"
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CA01A3
	for <linux-block@vger.kernel.org>; Tue, 28 Nov 2023 13:59:48 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-35cd93add9fso3182505ab.0
        for <linux-block@vger.kernel.org>; Tue, 28 Nov 2023 13:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701208788; x=1701813588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IqXh8h2TE9EqBfbi7m4c/BFMHO+IwfCong5cfxOFR/E=;
        b=WSLa365g2mqIEi0is0kQkWMUvC6BvhaaanbR5cVI6iHQI2DxvYhylWKRi691idP4ZK
         eYwMn84ysqp2ewUzffB4B3ZA+fQ7dQnbeDUMV3yeZiBzIH//KahTeV7vbzTLNDLiOLcJ
         0A0rS3cgR0O2dpSQimDzdnvBBJEKfuyIyoQ1prfGsuU3Rt2pN2ZowsoIT53uqZzi5qRF
         w7rUx8rbIijbqY+rTDdK+OQ8f4+0BI0W9c7RYucrQWYpVajb08IdQaK0hxhSVk7FbiUW
         11DQJ4l0JY2itQhHM0wxVnSv+HIqRlrcQ60DZmgs1VGmXMEY4lNour3XGjlwsQQq8vQD
         qeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701208788; x=1701813588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqXh8h2TE9EqBfbi7m4c/BFMHO+IwfCong5cfxOFR/E=;
        b=QQ9NP0MpvYjDAmSdYif0fdR9HoEz0IDuYZ7sCxztNm1sBeoX7PpT5N3QuV00h7oeHo
         Z8ahMPRiH3xrhxE/hQQgM8DXmcrN9z10RDMiQ4OwzPzkylmWd3deX3d85c1PSnHppuW2
         ydNPijVNFzQRY7G2y+nZ9zdjHo24i63D5bgBDgxqJQfKBMUpI1MB0jURFSZLhWuYo4h+
         CYZ8fC+2ZWMlmpA5wkbM9z7oYeh+i7ZOUIQwqn1g3YRp/5HNCdOxuSy7yXHoXww/R2bM
         ac0VfBriiUJtpNo0jSj13iM4zZPwkU6hemACVcd3vDylfibTJt8LIaZZk7kQI+L8uGe5
         Mdbw==
X-Gm-Message-State: AOJu0Yynb+P+ZLscuOa31QdyYsGLss6/zOEjLzKkQdnO6n9rECEVgoa/
	yhNr7XESa57fhvq27bz6jRdgVA==
X-Google-Smtp-Source: AGHT+IEVso2zBXyIILDyd1NKHjfwFmHQZ9RyRGvd8AQMvztNKwPP6rHt1yS8h8/sfYKGkxCFjt9tKg==
X-Received: by 2002:a92:c84b:0:b0:35c:baec:750c with SMTP id b11-20020a92c84b000000b0035cbaec750cmr8318971ilq.1.1701208787912;
        Tue, 28 Nov 2023 13:59:47 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id p15-20020a62ab0f000000b00694ebe2b0d4sm9483791pff.191.2023.11.28.13.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 13:59:47 -0800 (PST)
Message-ID: <66be0c42-2514-436b-bbef-3bd9ab123594@kernel.dk>
Date: Tue, 28 Nov 2023 14:59:45 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Merging raw block device writes
Content-Language: en-US
To: Michael Kelley <mhklinux@outlook.com>, "hch@lst.de" <hch@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <SN6PR02MB41575884C4898B59615B496AD4BFA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20231127065928.GA27811@lst.de>
 <f2735bdc-1234-4477-a579-90bafa7ae4ea@kernel.dk>
 <SN6PR02MB41578DD2B7A1F25336B0224BD4BCA@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <SN6PR02MB41578DD2B7A1F25336B0224BD4BCA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/23 12:29 PM, Michael Kelley wrote:
> From: Jens Axboe <axboe@kernel.dk> Sent: Monday, November 27, 2023 8:10 AM
>>
>> On 11/26/23 11:59 PM, hch@lst.de wrote:
>>> On Sat, Nov 25, 2023 at 05:38:28PM +0000, Michael Kelley wrote:
>>>> Hyper-V guests and the Azure cloud have a particular interest here
>>>> because Hyper-V guests uses SCSI as the standard interface to virtual
>>>> disks.  Azure cloud disks can be throttled to a limited number of IOPS,
>>>> so the number of in-flights I/Os can be relatively high, and
>>>> merging can be beneficial to staying within the throttle
>>>> limits.  Of the flip side, this problem hasn't generated complaints
>>>> over the last 18 months that I'm aware of, though that may be more
>>>> because commercial distros haven't been running 5.16 or later kernels
>>>> until relatively recently.
>>>
>>> I think the more important thing is that if you care about reducing
>>> the number of I/Os you probably should use an I/O scheduler.  Reducing
>>> the number of I/Os without an I/O scheduler isn't (and I'll argue
>>> shouldn't) be a concern for the non I/O scheduler.
>>
>> Yep fully agree.
>>
> 
> OK.  But there *is* intentional functionality in blk-mq to do merging
> even when there's no I/O scheduler.  If that functionality breaks, is
> that considered a bug and regression?  The functionality only affects
> performance and not correctness, so maybe it's a bit of a gray area.
> 
> It's all working again as of 6.5, so the only potential code action is to
> backport Christoph's commit to stable releases. But it still seems like
> there should be an explicit statement about what to expect going forward.
> Should the code for doing merging with no I/O scheduler be removed, or
> at least put on the deprecation path?

It's mostly a "you get what you get" thing. If we can do merging cheap
or for free, then we do that above the IO scheduler. It'd be great to
have some tests for this to ensure we don't regress, unknowingly.

But in general, if you want guaranteed good merging, then an IO
scheduler is the right choice.

-- 
Jens Axboe

