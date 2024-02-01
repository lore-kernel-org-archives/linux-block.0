Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAD55CDE5
	for <linux-block@vger.kernel.org>; Thu,  1 Feb 2024 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794814; cv=none; b=uvLYVH5VFm+uBuxcMEvJWOTjJeVdfXer2lsS/QkYTljhBwhvigOshagnFBXz/1QtFsFtSiRiWhF3n1JRzgkco9BjxxdBeep6xjxEHHavEUoAcQdc2Zw2T5tiwffLETHmEJRRFg3EC6TGjxwkqSYKrUJ+PJqah6yOVajW+jpahuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794814; c=relaxed/simple;
	bh=XQbH904LAY+JQnudw6Wgq/v8lL7Lc6EeA9b9hd2uu0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VI6D9VvU0F0jU+Bst6IxShMHQDwILAYxfPNNqIv4Kea2WmiV7o1pdrpRQLeZf510nknH7ls1UhThlNcNMul7asfkIv7f3vRfmjXHeHXHD9w5ANqy28mBiPJNBDsEUOzjL6VzMMx9mEuoYf9ACzC324xg2Wa5TgK5MDOIGQZDED8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jqOUokEP; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jqOUokEP"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so157667a12.0
        for <linux-block@vger.kernel.org>; Thu, 01 Feb 2024 05:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706794810; x=1707399610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a9Tl8kuFfclMhhTVxm/oWitPhp2Nx4l75IVTGKrZREI=;
        b=jqOUokEP1liSRU6wpAT99bMInX56YYE3zPIj+9K8Oxoib0Ob59of5prr1iq1nKJLSU
         rgDNHFTcLG4Th0xaEwmO2d5XCqm5GSbhM7anSBmiWb4y5kJ7Z/IIMouoNdrkzmA/vAha
         XaqkI2lQ7LhMSM3/iLvfaR9w+E02UqIwQ+dMVosPFjMmr9njfXiaATFkqexwA5Kdi9yO
         bETHUBD2Mmgj76Ihhdizw+7UnsGePA2igQBvpPBtA/8v9ruads6CuGPPZmMJSfAMX64N
         0rAiXyCtsnZmR94WGOYCSMic1ims5NhPuosgaLTzDfwHMgv/iIDlAkhUz9kEl5A3wsiX
         C9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706794810; x=1707399610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9Tl8kuFfclMhhTVxm/oWitPhp2Nx4l75IVTGKrZREI=;
        b=TPFlLxSw0AcwsvdXMswqeWc4ToUYrhNoSw2PDzV8i+Jc2dEkN2tqOkOFYmk8VMxvrJ
         ik3XqhKQeJwJdxDsngesoOWhS5DgkmAO7WAVKEfyY/aT3DSKOsrnUPBOdpCWPl4qTGD0
         OYniuF+hsqWQUxp9diqGXLDqdaGJYk76k9Pipg3qOYQYftt0WNK+/iovr3ep5HtyJSuG
         2/URPqPxOo4c+88O5rABaUKuT1/fdvHbB+yn9+nyNP4j4Y4UpVtpTh+rmrEDLoEcETif
         0d5EfCIKTw6ZRkeFbmMyfwvRMLtt/3ek5bkiPYuv7RmXpwQfSUHGuvRpt3FJT3YtgDEJ
         I2iQ==
X-Forwarded-Encrypted: i=0; AJvYcCVkbB4Uf5GLWgzOGP0v1otKo3/+m1Utq+c3Lx97ohM65uVEY3Ilxmm1lCBDJDNxIHZ/brbTOXrpiP/oA93Gky8c5/wXEHqU8hy0dxY=
X-Gm-Message-State: AOJu0YyzxHVheNHDmtABtrmilYKWBtyoRz9eqXJB+N2Z7QuZcCed3RpO
	ogFWMbT76K2iXDgHWk1e/feZM8FDhVl1A1Zk7TcN2rzeM18/gpHFCaxbkh2x5hA=
X-Google-Smtp-Source: AGHT+IFw9K1O3lKafKcofcTeqHyWqk9t02ES2N7eBu525aHQTvzKt/oN04taiEnwdq3lggzDtRhSIQ==
X-Received: by 2002:a05:6a00:db:b0:6d9:383b:d91a with SMTP id e27-20020a056a0000db00b006d9383bd91amr2611229pfj.1.1706794810223;
        Thu, 01 Feb 2024 05:40:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXnSmrFf/l4827XxqXZcZoGtOvAf3BxO2fj6nMCEbrz64sCPLcYAKXtfcWd7LW1BDCtH/XycBlmSJ77679Bx9Xw/cidzoMONCOIsCnzi27CH9VaC1U4hL2IUQtw5ohwaWDY0yTP6cc0LxoB35qfetucXHyOUjq1wwIhB2itYtPu0vDcw32p54vvkbv7PiLFTpxTTN4gSpwi4soudTXxcIUbRRFrCq1vHrGOaGtPM2tMAsOdqn3b6YVwWwxWDWTYGgylda7LZm+5V/Xy4OFMcFOyDL6TVn4jtMx1F7TlIEr1nvQtJsJGSWhXHy4ybMc6rJf8mKqEJDcMJYsU3FDVOA==
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id h21-20020a056a00219500b006dd8985e7c6sm11737980pfi.1.2024.02.01.05.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 05:40:09 -0800 (PST)
Message-ID: <d15a1759-1abf-47aa-8766-88c531023164@kernel.dk>
Date: Thu, 1 Feb 2024 06:40:07 -0700
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
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZbtFqxCMkItFr6/5@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/1/24 12:18 AM, Oliver Sang wrote:
> hi, Jens Axboe,
> 
> On Wed, Jan 31, 2024 at 11:42:46AM -0700, Jens Axboe wrote:
>> On 1/31/24 11:17 AM, Bart Van Assche wrote:
>>> On 1/31/24 07:42, kernel test robot wrote:
>>>> kernel test robot noticed a -72.9% regression of fio.write_iops on:
>>>>
>>>>
>>>> commit: 574e7779cf583171acb5bf6365047bb0941b387c ("block/mq-deadline: use separate insertion lists")
>>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>>>
>>>> testcase: fio-basic
>>>> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
>>>> parameters:
>>>>
>>>>     runtime: 300s
>>>>     disk: 1HDD
>>>>     fs: xfs
>>>>     nr_task: 100%
>>>>     test_size: 128G
>>>>     rw: write
>>>>     bs: 4k
>>>>     ioengine: io_uring
>>>>     direct: direct
>>>>     cpufreq_governor: performance
>>>
>>> The actual test is available in this file:
>>> https://download.01.org/0day-ci/archive/20240131/202401312320.a335db14-oliver.sang@intel.com/repro-script
>>>
>>> I haven't found anything in that file for disabling merging. Merging
>>> requests decreases IOPS. Does this perhaps mean that this test is
>>> broken?
>>
>> It's hard to know as nothing in this email or links include the actual
>> output of the job...
> 
> I attached a dmesg and 2 outputs while running tests on 574e7779cf.
> not sure if they are helpful?

Both fio outputs is all I need, but I only see one of them attached?

>> But if it's fio IOPS, then those are application side and don't
>> necessarily correlate to drive IOPS due to merging. Eg for fio iops,
>> if it does 4k sequential and we merge to 128k, then the fio perceived
>> iops will be 32 times larger than the device side.
>>
>> I'll take a look, but seems like there might be something there. By
>> inserting into the other list, the request is also not available for
>> merging. And the test in question does single IOs at the time.
> 
> if you have any debug patch want us to run, please just let us know.
> it will be our great pleasure!

Thanks, might take you up on that, probably won't have time for this
until next week however.

-- 
Jens Axboe

