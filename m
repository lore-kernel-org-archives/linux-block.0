Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FF21E894
	for <linux-block@vger.kernel.org>; Thu,  1 Feb 2024 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797880; cv=none; b=hQGWDqjgsMtsnnvJ2hBIpscISx/thJKaBuYam+/T1XyfpBNx/BhQEXJq7AuCPFh+namMh+8amgmQUi8sz5KD4/jSutAh7fjwPuisbfbnCbsZYfyniJQznI0Ksm+c9fwZtHuZe3TYcAaED/2i7EYAgwI/ShabIgKhw586DV+bza0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797880; c=relaxed/simple;
	bh=z/1qgTBjUJDYfxho5eXhrzlM37jcKxlm7QYoQEDlACI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTL2/7hpvQYs3HVDAzVcyi8U5/RjptY3OCk6cog/8mI8rNbV4MCo6/QaNbC1k9ElaCQeyH5LClwpKUseEjpLFQw28i/6Pc/oVG/VaRaUGKdnGzkc+q0OhqR1iLp6gZRjnuIwhIIgX9kuLQFIQGkcbaQys/PczXRv/6GWS1DOSbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=R6ip8Chs; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="R6ip8Chs"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cdbc42f5efso277356a12.0
        for <linux-block@vger.kernel.org>; Thu, 01 Feb 2024 06:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706797875; x=1707402675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/dTVX6pxClkgwrpo39ncDD6CaHIctKZeaWD9GIB9NW4=;
        b=R6ip8ChsgI9IB2FDMBP55qmaEwm2toCD5MvwoP/ExDBRaxh6vSeOqhsSAPheZjVIRw
         K/qs8vwxIYmjwEV3ccOeIDMyDwKK8wf3UOw+KqYgQ0ZXnZtBusn/jFzSvPA4N3St1zHt
         HbtDqzToL3iJ9XCcHtK4fcT0Oy1mPFj7cx0SAoIgJk5EwJ0yY0HKuG+DBbZuR4FRREtB
         hKYG22NVzGgYNmn4DVmFRSgUj7p62EYg0bimhZihfAFsKIVNel44E3mS0kYPzZhQktGj
         SiCWpuDHpBtE/zLcIdGyau+fkGbl154OUAsRRahDJeGXcSpLn1ikAWYIwS3idZLLg3wY
         JY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706797875; x=1707402675;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dTVX6pxClkgwrpo39ncDD6CaHIctKZeaWD9GIB9NW4=;
        b=MNPqGj/qOAQcZTwVBouwZ2N4WITUqDeU7ZWuKS3jirKAy6ybMgu5Oq0X4Usp6y+R4f
         owULHFNxAPyasmcPTBAqGt1H2scNU4WSuMS6XMz8/ivAdPaL3UqAXOT0zmk0CBBQl87U
         yKDze7mIuKt7xn9tQw9RyT/YewlFNo2iEFUhtQeM0+7eNQkiOkbc5wyKnEHC9+hw++zy
         kqJjM/MtJKT7QNucr+tXudDt/Hsuxn90rqv/U4iPqlV53jR0Hwl2qQ7GcDCUeNR1aptf
         2wmwfe0kp7dzRqx8eNGnLxI37+QS/rrg/JR7dtRkFjLQsEU7VVEm0w3jnAHR6Ecu0Kjc
         jWyA==
X-Forwarded-Encrypted: i=0; AJvYcCWQMA2i5/gS0zG2WuKtfMOulHgCoA1IzMtx9v4OcxuhveHQI6iIppQPvCQsVnevqyVtTMc5yBHJXgqYeTowqgrxHesieNDDY6JTmqs=
X-Gm-Message-State: AOJu0Ywqzudm3fs1oU8rnIzLlDbguDWFq9ftbz/UqYpPyy3uKdMt394J
	SjYQ/hhxMyzcBnmwdE09X6TdM2PT99GopIiWXO3umRcodBaak8/RNBdHVw27I2QERF+AbVPuNlO
	nMms=
X-Google-Smtp-Source: AGHT+IGjr3PB2u1hCazqyl/UID6CCPDJrrHd/ws2fUwZZdQsBc8VTptmDs1ULWba0p866rTSTOBJpQ==
X-Received: by 2002:a6b:c9d8:0:b0:7bf:cc4d:ea53 with SMTP id z207-20020a6bc9d8000000b007bfcc4dea53mr5626454iof.0.1706797854684;
        Thu, 01 Feb 2024 06:30:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVkvQdv9mMB4YBGEqQrVv/NU9tOrIDvVNLdF8HpP1cvgR5XF4fhdQ9uPu6z/meAnFpyTizrBa0QM2ZrPid9NDyqCL4TPyhZQq+WdClsBrISSLctRgpAUSOGd2hX5C1NzHZBKbiKivk1f/Y6UWNeJWIR+W+UahWqqBKo0XYJM0fIE0rv7WYUsUrS4hmPJvXy6y+1m3bcePJRIV0fdgp0aU3YCTZWc9W5ZgFx7uxfVeIUnRuo1RFjznhexTesohTPph2bCdlcg1KpgWXXu8b18loX3FyMgLlr7HZVe2Q6KM7+AEWxgKHyuKBH60sdVVCx6HnS39bx0IYJuf+tSkN8WQ==
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g8-20020a6b7608000000b007bffb82bfcfsm2252911iom.11.2024.02.01.06.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 06:30:54 -0800 (PST)
Message-ID: <cf5236e6-a79b-455a-9afe-b5dbf27d33e9@kernel.dk>
Date: Thu, 1 Feb 2024 07:30:53 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [block/mq] 574e7779cf: fio.write_iops -72.9%
 regression
Content-Language: en-US
To: Oliver Sang <oliver.sang@intel.com>
Cc: Bart Van Assche <bvanassche@acm.org>, oe-lkp@lists.linux.dev,
 lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-block@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com,
 fengwei.yin@intel.com
References: <202401312320.a335db14-oliver.sang@intel.com>
 <da4c78c1-a9d4-4a57-9765-2e6c35fa1062@acm.org>
 <9d2f99d8-ecd2-413e-b910-18e05239a2b8@kernel.dk>
 <ZbtFqxCMkItFr6/5@xsang-OptiPlex-9020>
 <d15a1759-1abf-47aa-8766-88c531023164@kernel.dk>
 <ZbukvbmE3K8y+JdJ@xsang-OptiPlex-9020>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZbukvbmE3K8y+JdJ@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/1/24 7:03 AM, Oliver Sang wrote:
> hi, Jens Axboe,
> 
> On Thu, Feb 01, 2024 at 06:40:07AM -0700, Jens Axboe wrote:
>> On 2/1/24 12:18 AM, Oliver Sang wrote:
>>> hi, Jens Axboe,
>>>
>>> On Wed, Jan 31, 2024 at 11:42:46AM -0700, Jens Axboe wrote:
>>>> On 1/31/24 11:17 AM, Bart Van Assche wrote:
>>>>> On 1/31/24 07:42, kernel test robot wrote:
>>>>>> kernel test robot noticed a -72.9% regression of fio.write_iops on:
>>>>>>
>>>>>>
>>>>>> commit: 574e7779cf583171acb5bf6365047bb0941b387c ("block/mq-deadline: use separate insertion lists")
>>>>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>>>>>
>>>>>> testcase: fio-basic
>>>>>> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
>>>>>> parameters:
>>>>>>
>>>>>>     runtime: 300s
>>>>>>     disk: 1HDD
>>>>>>     fs: xfs
>>>>>>     nr_task: 100%
>>>>>>     test_size: 128G
>>>>>>     rw: write
>>>>>>     bs: 4k
>>>>>>     ioengine: io_uring
>>>>>>     direct: direct
>>>>>>     cpufreq_governor: performance
>>>>>
>>>>> The actual test is available in this file:
>>>>> https://download.01.org/0day-ci/archive/20240131/202401312320.a335db14-oliver.sang@intel.com/repro-script
>>>>>
>>>>> I haven't found anything in that file for disabling merging. Merging
>>>>> requests decreases IOPS. Does this perhaps mean that this test is
>>>>> broken?
>>>>
>>>> It's hard to know as nothing in this email or links include the actual
>>>> output of the job...
>>>
>>> I attached a dmesg and 2 outputs while running tests on 574e7779cf.
>>> not sure if they are helpful?
>>
>> Both fio outputs is all I need, but I only see one of them attached?
> 
> while we running fio, there are below logs captured:
> fio
> fio.output
> fio.task
> fio.time
> 
> I tar them in fio.tar.gz as attached.
> you can get them by 'tar xzvf fio.tar.gz'

Right, but I need BOTH outputs - one from before the commit and the one
on the commit. The report is a regression, hence there must be both a
good and a bad run output... This looks like just the same output again,
I can't really do much with just one output.

-- 
Jens Axboe

