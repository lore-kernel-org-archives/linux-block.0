Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AB315E5D4
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464515; cv=none; b=PFTfnpsRGSakw35AobuOoAHBr/o18vIDDqCT4A+FNKuppDsqtEoAP9/r5tOnKm0U/6A1+0JuH4MdDofUnLTeslTLzRCSIKc7f6BTr03tJruM0wy2i9oMqNGE+dZZ4v2fYnxpyVmkcUT8L5+7RkJWeX/CIvhfvde5oHNiAvRmCco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464515; c=relaxed/simple;
	bh=oDP3FutbaoNCn7p8ULTbCrWb2mEMNTIcAomuR/RyqMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THyq8p8u43e+ptUp0DG6maXbwKt7JOBoNvMROlZA/AajsFWD3mEt+cc6SDR5l1mq/g6VGL3+NfTv+raQHFMqJzvMdBH0XGE0qkDO3P6d8SI3XXAr9uesglNmZjG3PTB8IWH9+g1rl1qofX5Q6s8Jvp7N2FpfY9+PKsvbhLhX3sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1mXEx93Q; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1mXEx93Q"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-844ce213af6so192426339f.1
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 11:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734464512; x=1735069312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vCCpRbRwYU03Lmj5wm24ASbJBhKwnWHlNsV6WWrTAp4=;
        b=1mXEx93QzFm/zcle3gTi9h4idDq3yQpZ8hXRuDyQA27sLDT28T9WR1ZBAqNMsWyxHy
         JETapTc/3Quoufc4P5TQ+OAle4YyLWpMuVHUD9TBjti9faSiegy0RnPWcHBlpxW78hBr
         Cz98ONp+Ay2WnE347VLxkaUGwHLA4pIcDHOAjM7mbCOkO+bKNul1NMvZdEgzf9NvmmPS
         rIEqawQOR3No5Igp9tDibukiUgqJ3K8qH3ZAzzFCm8KbgpVFdPnxLUvAlP5f3EU+QFgG
         maty4PBygNuHjd8lqzbDu9IpHSr627vMowE8X3iXOBDivZFuuu6JK4P/AUQFH6uL/FFE
         IWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734464512; x=1735069312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCCpRbRwYU03Lmj5wm24ASbJBhKwnWHlNsV6WWrTAp4=;
        b=EO5VPSKPGZFUm4TslO1ZWB+p0nu9Qg9qzuYgj1o+6N22MhApr1Tv8Z5N5G/ycfR6ZC
         bzul53GtGL2rF2UhC88fEBguRTYLYGrhi83UVqxVuf0VbI7hxZl45i2w4ixgMl/PeXv0
         Hr3q0aK/YXPEpsC+ozKLbNYf4FH3irpQ5u8p4QKUorGixpoUIBgpr2qMd3RidxxMRcm3
         uJFxmH8JPBzw0tkhGmln3lwEpRI67KsUpwLduWTln0ALebDbNXlE+6yqpjdBXNjMj1Pa
         nb6eDAi9tZTUDs5XS18Z6QJY8owvlpnYEse7Kya/1+M3xGKoFv9Tt3CLEAiV/HriZxYe
         YvsQ==
X-Gm-Message-State: AOJu0YwVjia0g8ZU6IBiCYJ95fdzR9t+KecM9Aro2pp0kHu/t5b+p7uT
	lSZk/2cTMiKUXzrYO49rd5vInl2rLmZ+nRPhIYw3+Y4+vGrXDTVnP/aEQDXAsOk=
X-Gm-Gg: ASbGncuxMIWlOan3dkv6cLr1PwJ7sGT2EPmOgDdTJ8u38eeZIepf/0BaYkbd4XkB7gq
	Xc5D9I/UYFjlraxssm8SHWWB0YgMFLwyk4PX5iYvCPuzZsDmuYkSQtj47UXfTpjjsjaedHgTsBR
	hqS/pC1A3OP/o1+CL1qGWdmH01GHdkCmkHC6yAFvlt+0vAnFobbVuVkukklu5Mgl28Lsy5uqi7b
	cBVGX8/gcyeFq5Pfgc/59xAmZVgPmqmKfjmb27k4MQnmUlQqydU
X-Google-Smtp-Source: AGHT+IF8Jmqtfi8X8iPOcq5IWML3BXDc92yGJfVvflZ1WCtSWW4tKFn1U/8wkOkcu4B+12D+BH9isA==
X-Received: by 2002:a05:6602:6b84:b0:843:e9c1:930b with SMTP id ca18e2360f4ac-84758608e0fmr17745539f.14.1734464511981;
        Tue, 17 Dec 2024 11:41:51 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e0f384c8sm1807209173.76.2024.12.17.11.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 11:41:50 -0800 (PST)
Message-ID: <eb61f282-0e23-428a-8e6a-77c24cfd0e83@kernel.dk>
Date: Tue, 17 Dec 2024 12:41:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche
 <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
 <20241217041515.GA15100@lst.de>
 <b8af6e10-6a00-4553-9a8c-32d5d0301082@kernel.org>
 <bf847491-e18a-4685-8fa2-66e31c41f8e8@kernel.dk>
 <79a93f9d-12e1-4aed-8d6c-f475cdcd6aab@kernel.org>
 <96e900ed-4984-4fbe-a74d-06a15fd7f3f7@kernel.dk>
 <3eb6ba65-daf8-4d8f-a37f-61bea129b165@kernel.org>
 <63aae174-a478-48ea-8a74-ab348e21ab65@acm.org>
 <83bfb006-0a7d-4ce0-8a94-01590fb3bbbb@kernel.org>
 <548e98ee-b46e-476a-9d4a-05a60c78b068@kernel.dk>
 <5fb36d77-44cc-4ad7-8d64-b819bc7ae42a@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5fb36d77-44cc-4ad7-8d64-b819bc7ae42a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/24 12:37 PM, Damien Le Moal wrote:
> On 2024/12/17 11:33, Jens Axboe wrote:
>> On 12/17/24 12:28 PM, Damien Le Moal wrote:
>>> On 2024/12/17 11:25, Bart Van Assche wrote:
>>>> On 12/17/24 11:20 AM, Damien Le Moal wrote:
>>>>> For a simple fio "--zonemode=zbd --rw=randwrite --numjobs=X" for X > 1
>>>>
>>>> Please note that this e-mail thread started by discussing a testcase
>>>> with --numjobs=1.
>>>
>>> I missed that. Then io_uring should be fine and behave the same way as libaio.
>>> Since it seems to not be working, we may have a bug beyond the recently fixed
>>> REQ_NOWAIT handling I think. That needs to be looked at.
>>
>> Inflight collision, yes that's what I was getting at - there seems to be
>> another bug here, and misunderstandings on how io_uring works is causing
>> it to be ignored and/or not understood.
> 
> OK. Will dig into this because I definitely do not fully understand where the
> issue is.

As per earlier replies, it's either -EAGAIN being mishandled, OR it's
driving more IOs than the device supports. For the latter case, io_uring
will NOT block, but libaio will. This means that libaio will sit there
waiting on previous IO to complete, and then issue the next one.
io_uring will punt that IO to io-wq, and then all bets are off in terms
of ordering if you have multiple of these threads blocking on tags and
doing issues. The test case looks like it's freezing the queue, which
means you don't even need more than QD number of IOs inflight. When that
happens, guess what libaio does? That's right, it blocks waiting on the
queue, and io_uring will not block but rather punt those IOs to io-wq.
If you have QD=2, then you now have 2 threads doing IO submission, and
either of them could wake and submit before the other.

Like Christoph alluded to in his first reply, driving more than 1
request inflight is going to be trouble, potentially.

-- 
Jens Axboe
