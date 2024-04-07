Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C2D11181
	for <linux-block@vger.kernel.org>; Sun,  7 Apr 2024 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712519749; cv=none; b=s+y9XO1s/gxmID7IOhPP5VSR7sqazWiFgnzoMye8i3cDbLWSebjJxTEoXtwY0SxRvmnyKfuyCOC+rTLizJ3wdztIPyKWn7zJjnVHOPt2jlymhuV3cNT30Zku7c/AvJMTQAVI+F/wM8I7qyYWUXiX7ql1SpatuA5UN3LZYEwOjTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712519749; c=relaxed/simple;
	bh=v8kCyOI5UZILifWQEvZKNekcPc7lc42ThXOsB2sJhHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRuLi5nmENLJWVEQzb+E29laE7paakHnm04XSHrlm8RqMJ1pO8SsZxhLMtmtS5RA/Cbfe0Hj5fqHCUy9E0Re5bMggbeZhXROV4XCfTBk+K2duvNxziormbaO4aQCCs/+IqQzfOIruOGQbLbq3FBMMeB3mS84sibIDGG2HLRqvPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343c8d7064aso414680f8f.0
        for <linux-block@vger.kernel.org>; Sun, 07 Apr 2024 12:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712519746; x=1713124546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzOqCdNS/7KjSOCIXb9Qh7O9B2xLz1vt61F2iFBcJA0=;
        b=KSKdbiU1w7xjnP8W4H6A/zQx6d43BLKDo3GgPMM4rsKS83ebqkkda0MFwkRDwH3fpi
         oaRf2sGzqx5CRUnUSJl5oXP+hJPQjGCxf1vvi6dPg37pnqma3Tq2bJ4VPuM/bWHNQHMf
         PyyQlhCOPl16dgWgWXe6hpJLBEPEUGJK+lWhvI5bXTG6jCsHiqQ2HAoWlRHPPfe2CSYh
         6aS+lWJ5cPtdNfvG89K8D53gLaTgiAGaNTCNV4+AWNnVRNw+mvhzn6WIiN9XJLnGs9Bc
         pTfLnB+SNjAVTeFwpdMGmN6ag3GRYJZkyirm2ifoHXUVEpFfHTx9bWcCbMX4o4KuEPr9
         YAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxvK5/y3oaKLyrXlvCxSc9qVR+vBaSd+XDgMNX3d38vL5TUtP6GHJTfrrvmql1QRXbaW+MsBTZ34StIJMFnhAZvyM0o21knsvov1M=
X-Gm-Message-State: AOJu0Ywbx5C0zVb+J5VhKDkmfxLMgD/WRyCFORMjAigiDyo0ZcQ5iN6F
	DSsgKqskRv4SgCR6OlHMI3Io22XmLSzKX+u7XVnJ8bTVXExAVjU/
X-Google-Smtp-Source: AGHT+IFOw9RiCx4Vo7GZIMIZMEC0xFUC5n2BzsBdtK4VVBTn9A3eomE9lcqeQoEj/MmkJ74F3c9rJw==
X-Received: by 2002:a05:600c:3b8d:b0:416:6b86:861 with SMTP id n13-20020a05600c3b8d00b004166b860861mr865026wms.0.1712519745527;
        Sun, 07 Apr 2024 12:55:45 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id je6-20020a05600c1f8600b0041496734318sm14359460wmb.24.2024.04.07.12.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 12:55:45 -0700 (PDT)
Message-ID: <cd732ee4-4a53-46bd-a9f8-92237a3afbaf@grimberg.me>
Date: Sun, 7 Apr 2024 22:55:43 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/2] block,nvme: latency-based I/O scheduler
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20240403141756.88233-1-hare@kernel.org>
 <Zg8YNrSnZPjR4kan@kbusch-mbp.dhcp.thefacebook.com>
 <b255fca4-a9da-4364-a3af-eb699eeb4160@suse.de>
 <ZhAS0YKfV07qlUes@kbusch-mbp.dhcp.thefacebook.com>
 <46e26322-a677-4c27-bc22-e2c65ed9d03c@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <46e26322-a677-4c27-bc22-e2c65ed9d03c@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05/04/2024 18:36, Hannes Reinecke wrote:
> On 4/5/24 17:03, Keith Busch wrote:
>> On Fri, Apr 05, 2024 at 08:21:14AM +0200, Hannes Reinecke wrote:
>>> On 4/4/24 23:14, Keith Busch wrote:
>>>> On Wed, Apr 03, 2024 at 04:17:54PM +0200, Hannes Reinecke wrote:
>>>>> Hi all,
>>>>>
>>>>> there had been several attempts to implement a latency-based I/O
>>>>> scheduler for native nvme multipath, all of which had its issues.
>>>>>
>>>>> So time to start afresh, this time using the QoS framework
>>>>> already present in the block layer.
>>>>> It consists of two parts:
>>>>> - a new 'blk-nlatency' QoS module, which is just a simple per-node
>>>>>     latency tracker
>>>>> - a 'latency' nvme I/O policy
>>>> Whatever happened with the io-depth based path selector? That should
>>>> naturally align with the lower latency path, and that metric is 
>>>> cheaper
>>>> to track.
>>>
>>> Turns out that tracking queue depth (on the NVMe level) always requires
>>> an atomic, and with that a performance impact.
>>> The qos/blk-stat framework is already present, and as the numbers show
>>> actually leads to a performance improvement.
>>>
>>> So I'm not quite sure what the argument 'cheaper to track' buys us 
>>> here...
>>
>> I was considering the blk_stat framework compared to those atomic
>> operations. I usually don't enable stats because all the extra
>> ktime_get_ns() and indirect calls are relatively costly. If you're
>> enabling stats anyway though, then yeah, I guess I don't really have a
>> point and your idea here seems pretty reasonable.
>
> Pretty much. Of course you need stats to be enabled.
> And problem with the queue depth is that it's actually quite costly
> to compute; the while sbitmap thingie is precisely there to _avoid_
> having to track the queue depth.
> I can't really see how one could track the queue depth efficiently;
> the beauty of the blk_stat framework is that it's running async, and
> only calculated after I/O is completed.
> We could do a 'mock' queue depth by calculating the difference between
> submitted and completed I/O, but even then you'd have to inject a call
> in the hot path to track the number of submissions.
>
> In the end, the latency tracker did what I wanted to achieve (namely
> balance out uneven paths), _and_ got faster than round-robin, so I 
> didn't care about queue depth tracking.

Hey Hannes,

I think its a fair claim that a latency tracker is a valid proxy for 
io-depth tracker.

I think that we need Ewan to validate if this solves the original issue 
he was trying
to solve with his io-depth mpath selector. If so, I don't see any major 
issues with this
proposal.
