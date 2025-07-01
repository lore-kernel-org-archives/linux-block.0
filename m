Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F150F275874
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378478; cv=none; b=KLRwRlZPWiUWcPl7goSbFw5jsT+1cpboFpj8M/wFWltFrdyxu+Vz5Wa7+EncaOYTHxhoxBBH1XmH59IWdG1ZULzEPPrr/7/NqRSTG+515RspfQohdtS5ruKOHHFaMROC/VuSpTzJFQqP077ynQx/k8EwAp3YWPAWtvKIEig//wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378478; c=relaxed/simple;
	bh=ltEx6jvo6nYVWdnOQsoJw/R1uj9wItt+k2vwzOvAp4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OEU2C9QMDcExw+Z50kAC+iqF9EVQ2smejYBAknQJnCkNk9eKbhl9C8t0IhhmaNRU6i3828AfXxE+of1clJNoTB6wBZdrPoqWn7/PiYIXgHH8V6/x3Ad9GXAVWwoK+DgtaJkyeNnmIUh3cCj0Jvi0sVJ4yZALmZmWhjyHYEWf8ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=l8d0axci; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="l8d0axci"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-87694a21617so76890839f.1
        for <linux-block@vger.kernel.org>; Tue, 01 Jul 2025 07:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751378475; x=1751983275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23lX53iztVdwKzQA/gaISc5zdHS2upabAhTnbt71HPQ=;
        b=l8d0axcifn19z27nPBKYoL6EGp4Y5q+yei5PC1gg7mhAVE+0XuG+Ud7vBYWwJ9pxtu
         br3gVU5YCtALUejwMy3pTtVuZHz7XhFsq9jWxm0PPsK6KLAj2sGaETMY7z/cjtjAJHtu
         Rx1+BrB1HSj1FTR3js+dgTeKZUzXb28IpxVMlN8y7WEI7dQxUGbo3cAdE/bIVJB+bSOE
         s8ntgfZATZ6AwZZ0D4ap3wRPp+2ftSD7mf21eehIWMriIUEkMWYabmv9d0C/jJof6vy7
         gXcBtVFWHSzOvnS+HTWwhl1Ln/VyKlKdSFFVTzNOjAFKBba3wNFJwGDo2vhWQ8DkO/LU
         72PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751378475; x=1751983275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23lX53iztVdwKzQA/gaISc5zdHS2upabAhTnbt71HPQ=;
        b=QXonyZeO0ydYJEofRTm+t92/RpH8gdDZMIoncFMnxTJREcykDs1P013Lerxoh0kWww
         REAUUgNF5Sgmh7WrYHOoc6HUnpxl7GHQcoBh9j8Hn7IMo5I8dGLNN1/uBJY4xYmwsT+q
         IIwUfNCewDm2p/K3vKoFb6OqnXPkZR4vsjZ0TY67ih+SltvjCpMyR8HHDGqo9aac1nui
         lkynLHsQNzdmUPzrBClDxxu8syiSyHDrCCunMSONz3SNSL+1rPS+ZWGOFL7jxTLTpjon
         AbvdMdL29ZZCwnv/bwWUQJb0AfFZjoRUU1ebdPeKF4si8aphLhvrOnTbLVmGeBUhYjFo
         +5Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWkZOA+g1vNMqaZVhiHFOG/sxqJCbAWwH/7OUtigxJpNSBt+l6WRni22p8wAMsUdDZF+zGKOXJNOIEW/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwE588eH6tQXdmCiNQmS43XtPHUarX5N4eMSxLW2+fI3tbG4pGb
	o9V9lto9/ipNiJO6nALhOtBG0edGDyVWwqX30Y6wVqtDnCdmjdQ3ixh9BwlCCla0tT0HBeSGICi
	96QmA
X-Gm-Gg: ASbGnctH+J0go70iQM784KgQLkyVPekG0phag5jyx+vBresMXI/7StCmDtUTqUkNmQJ
	tx/IZMyMI4y4uJNKa/fFYIqneXBWuHqvwUThnhq3EhmQ6XbMCJa8t1RnSEncbvJ8qqRZ8LGZmQI
	NhWKXITrbkzyNUA1wdsQdMD4MWBWmnWk2xEnTw/8FqmePuMrbWJw7oSZTAeutN3wt6CEYZJo98y
	0bgBZseF/wBsCWyPEstweKlqescHF9wgCefPKExswP3togA9Z4VWcyv8WHfAo/JsGt+7YBYHCCA
	ki9KuQD+fYOzC3JaCWe95nL4s7nijsKvLEc+rQgIu0aBnTelR156PCQP5YY=
X-Google-Smtp-Source: AGHT+IH7s/tbao9vydR4ZOjiMA3DZDvHBP/HWhYsSP7tBBODe9ykCLvPJfEwE0xkWIrIZy9LIkMfSQ==
X-Received: by 2002:a5e:dc02:0:b0:86a:441:25ca with SMTP id ca18e2360f4ac-876b910a0dfmr389475139f.6.1751378474803;
        Tue, 01 Jul 2025 07:01:14 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-502048d3f57sm2471449173.57.2025.07.01.07.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 07:01:13 -0700 (PDT)
Message-ID: <bcb75734-7f72-4b9a-86ea-6d607b29556f@kernel.dk>
Date: Tue, 1 Jul 2025 08:01:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] brd: fix sleeping function called from invalid context
 in brd_insert_page()
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de
Cc: penguin-kernel@I-love.SAKURA.ne.jp, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250630112828.421219-1-yukuai1@huaweicloud.com>
 <eb41cab3-5946-4fe3-a1be-843dd6fca159@kernel.dk>
 <a2dc2566-44e1-4460-bbff-bb813f4655d9@kernel.dk>
 <773a49cf-3908-85d2-5693-5cbd6530a933@huaweicloud.com>
 <c28dd90a-3777-49fa-a662-32c61da22860@kernel.dk>
 <c76c61ac-9335-b116-31dd-5ecfb32dd7dd@huaweicloud.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c76c61ac-9335-b116-31dd-5ecfb32dd7dd@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/1/25 1:38 AM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/07/01 11:00, Jens Axboe 写道:
>> On 6/30/25 7:28 PM, Yu Kuai wrote:
>>> Hi,
>>>
>>> ? 2025/06/30 23:28, Jens Axboe ??:
>>>> On 6/30/25 9:24 AM, Jens Axboe wrote:
>>>>> On 6/30/25 5:28 AM, Yu Kuai wrote:
>>>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>>>
>>>>>> __xa_cmpxchg() is called with rcu_read_lock(), and it will allocate
>>>>>> memory if necessary.
>>>>>>
>>>>>> Fix the problem by moving rcu_read_lock() after __xa_cmpxchg(), meanwhile,
>>>>>> it still should be held before xa_unlock(), prevent returned page to be
>>>>>> freed by concurrent discard.
>>>>>
>>>>> The rcu locking in there is a bit of a mess, imho. What _exactly_ is the
>>>>> rcu read side locking protecting? Is it only needed around the lookup
>>>>> and insert? We even hold it over the kmap and copy, which seems very
>>>>> heavy handed.
>>>>
>>>> Gah it's holding the page alive too. Can't we just grab a ref to the
>>>> page when inserting it, and drop that at free time? It would be a lot
>>>> better to have only the lookup be RCU protected, having the full
>>>> copies under it seems kind of crazy.
>>>
>>> In this case, we must grab a ref to the page for each read/write as
>>> well, I choose RCU because I think it has less performance overhead than
>>> page ref, which is atomic. BTW, I thought copy at most one page is
>>> lightweight, if this is not true, I agree page ref is better.
>>
>> Right, you'd need to grab a ref. I do think that is (by far) the better
>> solution. Yes if you microbenchmark I'm sure the current approach will
>> look fine, but it's a heavy section inside an rcu read lock and will
>> hold off the grace period.
>>
>> So yeah, I do think it'd be a lot better to do proper page references on
>> lookup+free, and have just the lookup be behind rcu.
>>
> 
> Ok, and just to be sure, since the rcu is introduced before the fixed
> tag, do you think it's better to do cleanups after this patch, I prefer
> this way, or fix this problem directly by page ref?

Yeah probably best to do the simple fix, and then base the further work
on that.

-- 
Jens Axboe

