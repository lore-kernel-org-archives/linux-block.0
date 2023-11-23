Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SzNidn5P"
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5ED127
	for <linux-block@vger.kernel.org>; Thu, 23 Nov 2023 12:19:10 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6bbfb8f7ac4so278614b3a.0
        for <linux-block@vger.kernel.org>; Thu, 23 Nov 2023 12:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700770750; x=1701375550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nt4HweOaDmopB3JIJVksfBwuA3lFwoXLlJJUWVT3C2c=;
        b=SzNidn5PVaKXcMxzDDZoiT3u+pMHAOAcrFWTYvbq1fxMmm+FkxgOHfWdy1kzuKOe8I
         XE4BXJwq/i0GQ7Y8kV5MM+yBpbyycO6mLe+IuQcQk+wGjUEMDB1qN0uE0+GwvDabalNX
         TdNXjHfZ5dCQrznLtGzsN7VTJaTjMOI11upkiURXvj8KdsgjoVobl1AZ9mH+S9qVH1vh
         dU+O8KP4KFEZJ4lVljPTFztNJcc9mlkN8e/62zfGAtLvfWAIZsuHiXBHVCtdJizhhV/n
         eE2RkBr4IURkJinQWkzt3FAcYMJinDvLk0ij5WKruHIv7LZ4h79xxTvV8kQYYC9EdKcb
         vBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700770750; x=1701375550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nt4HweOaDmopB3JIJVksfBwuA3lFwoXLlJJUWVT3C2c=;
        b=qHBoQwjPVxMWcpgzVZi139uiC/+ZjWOIeZ2mWPrrdcCBEcFCNnWt6rJa58UklkUOiW
         cBoJpdS5EQPRpDSD+5+lJBfWvWczL6rvDuFuKA0XNrMVvjbRTT3YN18DsUB7XrIPSYzJ
         a4m9dJNTMC1o2gRLg0B2jKxRO7t+R4lRkByHwrtOic9d2P4dUHIf2C4rXbOR35IHqsFx
         9FnECJeC5TmDYAmo295nQL43qtdC6UXdwdjr4+zdvT4Fr4beMPwSySAxATx4nOHneRCa
         WWbxnwJBfS1P/cpxltRyb/UUpX8QNb9a9sJjSiQDGz6F7gTS/Ps2e6QM8Eo47sbE920u
         3jfg==
X-Gm-Message-State: AOJu0YwPsSnZlu53JeT+pbsKs/HHw1Lxf395QoVw691fjCRSMXcNNrDl
	EdrYj21msuIO/bYN3Nl1MUgJPQ==
X-Google-Smtp-Source: AGHT+IEO9EwI2F5aKWTxCLX74qe12blCE5JIaGeSPXliwwQ0EIhrPRr3riiejFH91xyp07xqBzKDnA==
X-Received: by 2002:a05:6a20:7d9b:b0:18b:4a07:c6df with SMTP id v27-20020a056a207d9b00b0018b4a07c6dfmr826760pzj.1.1700770750017;
        Thu, 23 Nov 2023 12:19:10 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id j26-20020a62b61a000000b006cbb7e27091sm1646044pff.175.2023.11.23.12.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 12:19:09 -0800 (PST)
Message-ID: <37d9ca26-2ec2-4c51-8d33-a736f54ef93f@kernel.dk>
Date: Thu, 23 Nov 2023 13:19:08 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: skip QUEUE_FLAG_STATS and rq-qos for passthrough
 io
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 "kundan.kumar" <kundan.kumar@samsung.com>
Cc: kbusch@kernel.org, linux-block@vger.kernel.org
References: <CGME20231123103102epcas5p2aee268735dc9e0c357e6d3b98d16fe21@epcas5p2.samsung.com>
 <20231123102431.6804-1-kundan.kumar@samsung.com>
 <20231123153007.GA3853@lst.de>
 <85be66ad-0203-6f81-8be0-1190842c9273@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <85be66ad-0203-6f81-8be0-1190842c9273@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/23 11:12 AM, Kanchan Joshi wrote:
> On 11/23/2023 9:00 PM, Christoph Hellwig wrote:
>> The rest looks good, but that stats overhead seems pretty horrible..
> 
> On my setup
> Before[1]: 7.06M
> After[2]: 8.29M
> 
> [1]
> # taskset -c 2,3 t/io_uring -b512 -d256 -c32 -s32 -p1 -F1 -B1 -O0 -n2 
> -u1 -r4 /dev/ng0n1 /dev/ng1n1
> submitter=0, tid=2076, file=/dev/ng0n1, node=-1
> submitter=1, tid=2077, file=/dev/ng1n1, node=-1
> polled=1, fixedbufs=1/0, register_files=1, buffered=1, QD=256
> Engine=io_uring, sq_ring=256, cq_ring=256
> polled=1, fixedbufs=1/0, register_files=1, buffered=1, QD=256
> Engine=io_uring, sq_ring=256, cq_ring=256
> IOPS=6.95M, BW=3.39GiB/s, IOS/call=32/31
> IOPS=7.06M, BW=3.45GiB/s, IOS/call=32/32
> IOPS=7.06M, BW=3.45GiB/s, IOS/call=32/31
> Exiting on timeout
> Maximum IOPS=7.06M
> 
> [2]
>   # taskset -c 2,3 t/io_uring -b512 -d256 -c32 -s32 -p1 -F1 -B1 -O0 -n2 
> -u1 -r4 /dev/ng0n1 /dev/ng1n1
> submitter=0, tid=2123, file=/dev/ng0n1, node=-1
> submitter=1, tid=2124, file=/dev/ng1n1, node=-1
> polled=1, fixedbufs=1/0, register_files=1, buffered=1, QD=256
> Engine=io_uring, sq_ring=256, cq_ring=256
> IOPS=8.27M, BW=4.04GiB/s, IOS/call=32/31
> IOPS=8.29M, BW=4.05GiB/s, IOS/call=32/31
> IOPS=8.29M, BW=4.05GiB/s, IOS/call=31/31
> Exiting on timeout
> Maximum IOPS=8.29M

It's all really down to how expensive getting the current time is on
your box, some will be better and some worse

One idea that has been bounced around in the past is to have a
blk_ktime_get_ns() and have it be something ala:

u64 blk_ktime_get_ns(void)
{
	struct blk_plug *plug = current->plug;

	if (!plug)
		return ktime_get_ns();

	if (!plug->ktime_valid)
		plug->ktime = ktime_get_ns();

	return plug->ktime;
}

in freestyle form, with the idea being that we don't care granularity to
the extent that we'd need a new stamp every time.

If the task is scheduled out, the plug is flushed anyway, which should
invalidate the stamp. For preemption this isn't true iirc, so we'd need
some kind of blk_flush_plug_ts() or something for that case to
invalidate it.

Hopefully this could then also get away from passing in a cached value
that we do in various spots, exactly because all of this time stamping
is expensive. It's also a bit of a game of whack-a-mole, as users get
added and distro kernels tend to turn on basically everything anyway.

-- 
Jens Axboe

