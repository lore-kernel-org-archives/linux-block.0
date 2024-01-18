Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09258A5C
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 00:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705538573; cv=none; b=GsBdhECHULoxiIiFzCjs0xOo5ZCeGSVC18NMvKMeYiebLfpSCAY0F36At3cJ3RKr7GEVhPZ/4opjRVy/pAlPSWcxeCS9tAiQGs8Ke0gmedAM83FFNjrRGxV3Y0Q6R8qXslWVEGL90GAIL0/DrvsofPSxiiwXMmIrn8UcAVcjnq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705538573; c=relaxed/simple;
	bh=QMWu8wjex2MF/jHzLygaU1PcdMcieJUJnYWusngkPow=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=j4GYOf1TWn7p/d6sE25uCnLjl0cdGAES4Z2JaVl4eKYWFI6FEnNxx+xB/zd0XhzUH0K/8RiPBqyCR92qftfF2OFer5G/vl3SKLCnDvl2SHzlw/oFIoRTnNtnUDqLMmonMvEpUey+iYZDJNirx96Lo6ZS7KWvfCuPZ+PgRTuo+OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SpOuOlZz; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SpOuOlZz"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bed82030faso66977039f.1
        for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 16:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705538570; x=1706143370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FG4Zm7CAtcnjduN+LxFRfeYRTiMSCzl2syqW6Cg8J1c=;
        b=SpOuOlZzviGk37cGXSEtWBvTA4CnjlExBN7WAtMoBpHslLsnJPS8y4pTZmI+0CRHd+
         9KGp6ao/tI1nL/+NS8QdMUNaldHxPUfY5jHICXTTtwTxU5RLE2Yg8en6L84TPrc2Jyn1
         TiC4qBf75mXwB1UFPFEDuj1KdXlJbDjJvnMaEHNr4k44jnVSisMrrtezrA7xdwoguhhv
         ycwUKnTKiSVhmLxRAG3TLjYVT/rVpcv0L3g6xvCOnSvQs+fj+huy/Dw3txB+N71So0wg
         SerIY1gMmaqzf2IGQZU5p1FxI8KZ4YW/ZXAGFZvR8YHIi+may1nBFPbhsRlSiDEAksdt
         2Z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705538570; x=1706143370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FG4Zm7CAtcnjduN+LxFRfeYRTiMSCzl2syqW6Cg8J1c=;
        b=VUhYBnOucw+bBYlxLjLFujj0yni1Z9iPlaLBF4/ssVkBWHMWDoj9/I8N/5EeavneyQ
         bh5iY64uqRfflf+eEuH6lTyCEDym2LahE0rQ4wCnNDAc9mLuy2X/zyCHMcDqtULvfBTg
         gddOUm1T3o1oyhFZ1neOjXUySztuqgCrMj/Cv8+EUIgS61Z5LDbY1+jM9YaT33n3FTBJ
         +RnogHkL+woSMojN7ZPwBu8MLU1sfzhcEZDq8e6JGnGFNgPKwNH6B9KR13X5JuR4JwJt
         0D9of+8sEuf2zgH7nqbGxH2qarox8ekaWiwmcyFHcwgvLwev9SxDTqx1wIPUgXAzn+H6
         zEaA==
X-Gm-Message-State: AOJu0Yw5pJN/MzzgPzsUQSGR9CaJfqDWpqnFKE5WHxfwm5HL+uswImY+
	38BvbGgxq63Q9yd3iDOdJDbArLgZbAbiu4iEjVtvEJHGSNMS0KZ/8JepgXXHS1A=
X-Google-Smtp-Source: AGHT+IFGchJpPnccB7isRFn/p46Slms2dH/kxBcnF4iOxIjjlX8qYmgIHiIQq/SK4rI8fR+fMFtByg==
X-Received: by 2002:a6b:7301:0:b0:7bf:60bc:7f1e with SMTP id e1-20020a6b7301000000b007bf60bc7f1emr269240ioh.1.1705538570121;
        Wed, 17 Jan 2024 16:42:50 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i22-20020a05663813d600b0046e57c0e834sm709306jaj.27.2024.01.17.16.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 16:42:49 -0800 (PST)
Message-ID: <e19746ce-fdea-4372-bc26-1ee7b1a9a22d@kernel.dk>
Date: Wed, 17 Jan 2024 17:42:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Improving Zoned Storage Support
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Damien Le Moal
 <dlemoal@kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <5b3e6a01-1039-4b68-8f02-386f3cc9ddd1@acm.org>
 <cc6999c2-2d53-4340-8e2b-c50cae1e5c3a@kernel.org>
 <43cc2e4c-1dce-40ab-b4dc-1aadbeb65371@acm.org>
 <c38ab7b2-63aa-4a0c-9fa6-96be304d8df1@kernel.dk>
 <2955b44a-68c0-4d95-8ff1-da38ef99810f@acm.org>
 <9af03351-a04a-4e61-a6d8-b58236b041a3@kernel.dk>
 <c6dfb4f5-10f9-461e-8743-b730a8384f95@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c6dfb4f5-10f9-461e-8743-b730a8384f95@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/17/24 5:38 PM, Bart Van Assche wrote:
> On 1/17/24 10:43, Jens Axboe wrote:
>> Do we care? Maybe not, if we accept that an IO scheduler is just for
>> "slower devices". But let's not go around spouting some 200K number as
>> if it's gospel, when it depends on so many factors like IO workload,
>> system used, etc.
> I've never seen more than 200K IOPS in a single-threaded test. Since
> your tests report higher IOPS numbers, I assume that you are submitting
> I/O from multiple CPU cores at the same time.

Single core, using mq-deadline (with the poc patch, but number without
you can already find in a previous reply):

axboe@7950x ~/g/fio (master)> cat /sys/block/nvme0n1/queue/scheduler
none [mq-deadline] 
axboe@7950x ~/g/fio (master)> sudo t/io_uring -p1 -d128 -b512 -s32 -c32 -F1 -B1 -R1 -X1 -n1 /dev/nvme0n1

submitter=0, tid=1957, file=/dev/nvme0n1, node=-1
polled=1, fixedbufs=1/0, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
IOPS=5.10M, BW=2.49GiB/s, IOS/call=32/31
IOPS=5.10M, BW=2.49GiB/s, IOS/call=32/32
IOPS=5.10M, BW=2.49GiB/s, IOS/call=31/31

Using non-polled IO, the number is around 4M.

-- 
Jens Axboe

