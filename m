Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E164C1114
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754443718; cv=none; b=VtD1A8dM5jW/Y7SbY+Ex6l3r0Vq6IJL4L+JWsS7MBHzsRhx0PT2FVVDpmf24wko81KW/+h6m1tT5ocIkx+mYia7REoevqh4NRGyCSnUGC+JhVZTjIsxkNE8qZB6JK9KYoUGJXvcqdNr3vqljsEw0iSUqxws7o7qS1/6GJLFNOoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754443718; c=relaxed/simple;
	bh=lRKk+phCLV48iAWOf+aO5ccdNiYyBpp1Ila8n/e0yRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RiSGBY0fQ/AV5+1DM8rRTXacVYYXKiuDSY1tWraIte65nKGnlfFymweuYlOJkyGHSNUIgk1EDV/ZuXeQXpQw2wE4FAn0znl1Mx8ZqwzypgY3DGlCQ+2l2F/drGjuNDsVjbh4pyyu0LIYv0VNW0ZdAYE6xoIBmTf6ZQvxhGDPqJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JnbPRxf9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JnbPRxf9"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-240418cbb8bso41947925ad.2
        for <linux-block@vger.kernel.org>; Tue, 05 Aug 2025 18:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754443712; x=1755048512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dR8f9WAPM4/xqRMdiWByyDW4drGPcjJxFYeDPPSyWik=;
        b=JnbPRxf9eDL82o7ktc7bqOFhDnDyoVObnlAl5AZjB1eAj17nSXIq6dVoYO2kONfxSL
         a74FKG3gCIvU+Ftbxs00jEaD5PS6aEHt51bugaTFSJOVC2wZwJTPlx6/ziXFwjkmJQAa
         s2To5FfjLl0Kx6o+iQQ5tgKByj9Ek+98HPUKFhj6RNrs3Dw9XA9bNuWUOyHXdxsQKGbZ
         dIaPUlPXFL5e6Do2fEnFv9ZHo5CH9QkoqFrwisW/q9LFWANkUwzThTRVkGKbD5dJdfmA
         gKMfDdtfOJFPOIgjJkBv9CET5TJo04ocFs69l0QxsJeWlqRRA3+v1XSAXK1Q2ukYzuO+
         IyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754443712; x=1755048512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dR8f9WAPM4/xqRMdiWByyDW4drGPcjJxFYeDPPSyWik=;
        b=JhwmhNugeQTuBoRUfOavdJb+4rwsIzD7F5J0e4VeQgUNM40S7L02dYQWEk9rBGAEYQ
         xnRTDqbBBvmgvTf3bi9KZqJ4lJpTA3Gwn9iF5LtnIbJpHF95El5v+zAM2oQ+lP139f18
         PCHE2khrbhDygvOKUvOVjq0CDl5ORdKe6eWzM9Ju6YurysgJlAV5/Kh2shGRfUnhgdiG
         QsQZDi3+1lIAEq22M4i+6+Q8T4z6hBFiX5w1s+ADw7EzTp9d+jc7BFWyJQQop5RKc8bx
         pomsnjjSy5RSDZORPS7iBGxec0ZrKOUhg91KilV+XQOJ2TjCC1ZPw4z0jDQV9o4kiaUK
         Fjww==
X-Gm-Message-State: AOJu0YyLeooLhXVCSgoeVGmlex6a40TYUkLmgXt0RFM/Zyx4q5e/3ZIm
	asOAH1M1Rzd8Mhbg8zRa+KklakCNl+hsOjilCZGWLAyELmSIRfK2zdNs3xhqASB+YlQ=
X-Gm-Gg: ASbGncvuJ0GdCdKI2Eukz1lv5LytVQnpaN9fdsqZFf1vcOIcYJsF36rvfGArofGB2mp
	QRSV6Sc9sDqjUTvDN21DqwvI+hUvAkHesKMB0HhXVvPjFvPPFUV6JjTN/hc3euEP+JLnq0eaUuI
	bYgbKk/YLP8rx/B/Gi3ADVK8B1oUkj9srTRGfRW3UU5EGkVXK8tLg16n2KODuF1++LbJ47RKUoR
	/3CDnUf97aRbQBJju+EHDcY2Toy81d+yUZpVKfGNekX60FwRq74BawJ2oNAYutyA/b2IWw5aW6c
	lb5Qgdh9PV+ru274QXrmNlRTvfhC0h3FWzH5AW2A/y4/5Sjoct0WtuJeJxjqmcgEO4o6oATYFst
	as3uiMoxsG1ore65qVlujwTpc1nNJhg8=
X-Google-Smtp-Source: AGHT+IEKG+H3OfFvDXzYwtFBxlaDPe0Bwg68IBlbHs7zKImYo1WY2YOFMBr/6Rrh07Bb+tFMxIOl7Q==
X-Received: by 2002:a17:903:1aae:b0:235:e1d6:4e22 with SMTP id d9443c01a7336-2429ee8b5acmr14545825ad.18.1754443711959;
        Tue, 05 Aug 2025 18:28:31 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24262926895sm77423905ad.70.2025.08.05.18.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 18:28:31 -0700 (PDT)
Message-ID: <d4d21177-e49e-4959-b68c-707a15dccf73@kernel.dk>
Date: Tue, 5 Aug 2025 19:28:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block: blk-rq-qos: replace static key with atomic
 bitop
To: Nilay Shroff <nilay@linux.ibm.com>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, kch@nvidia.com, shinichiro.kawasaki@wdc.com,
 hch@lst.de, gjoyce@ibm.com
References: <20250804122125.3271397-1-nilay@linux.ibm.com>
 <aJC4tDUsk42Nb9Df@fedora>
 <682f0f43-733a-4c04-91ed-5665815128bc@linux.ibm.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <682f0f43-733a-4c04-91ed-5665815128bc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/4/25 10:58 PM, Nilay Shroff wrote:
> 
> 
> On 8/4/25 7:12 PM, Ming Lei wrote:
>> On Mon, Aug 04, 2025 at 05:51:09PM +0530, Nilay Shroff wrote:
>>> This patchset replaces the use of a static key in the I/O path (rq_qos_
>>> xxx()) with an atomic queue flag (QUEUE_FLAG_QOS_ENABLED). This change
>>> is made to eliminate a potential deadlock introduced by the use of static
>>> keys in the blk-rq-qos infrastructure, as reported by lockdep during 
>>> blktests block/005[1].
>>>
>>> The original static key approach was introduced to avoid unnecessary
>>> dereferencing of q->rq_qos when no blk-rq-qos module (e.g., blk-wbt or
>>> blk-iolatency) is configured. While efficient, enabling a static key at
>>> runtime requires taking cpu_hotplug_lock and jump_label_mutex, which 
>>> becomes problematic if the queue is already frozen — causing a reverse
>>> dependency on ->freeze_lock. This results in a lockdep splat indicating
>>> a potential deadlock.
>>>
>>> To resolve this, we now gate q->rq_qos access with a q->queue_flags
>>> bitop (QUEUE_FLAG_QOS_ENABLED), avoiding the static key and the associated
>>> locking altogether.
>>>
>>> I compared both static key and atomic bitop implementations using ftrace
>>> function graph tracer over ~50 invocations of rq_qos_issue() while ensuring
>>> blk-wbt/blk-iolatency were disabled (i.e., no QoS functionality). For
>>> easy comparision, I made rq_qos_issue() noinline. The comparision was
>>> made on PowerPC machine.
>>>
>>> Static Key (disabled : QoS is not configured):
>>> 5d0: 00 00 00 60     nop    # patched in by static key framework (not taken)
>>> 5d4: 20 00 80 4e     blr    # return (branch to link register)
>>>
>>> Only a nop and blr (branch to link register) are executed — very lightweight.
>>>
>>> atomic bitop (QoS is not configured):
>>> 5d0: 20 00 23 e9     ld      r9,32(r3)     # load q->queue_flags
>>> 5d4: 00 80 29 71     andi.   r9,r9,32768   # check QUEUE_FLAG_QOS_ENABLED (bit 15)
>>> 5d8: 20 00 82 4d     beqlr                 # return if bit not set
>>>
>>> This performs an ld and and andi. before returning. Slightly more work, 
>>> but q->queue_flags is typically hot in cache during I/O submission.
>>>
>>> With Static Key (disabled):
>>> Duration (us): min=0.668 max=0.816 avg≈0.750
>>>
>>> With atomic bitop QUEUE_FLAG_QOS_ENABLED (bit not set):
>>> Duration (us): min=0.684 max=0.834 avg≈0.759
>>>
>>> As expected, both versions are almost similar in cost. The added latency
>>> from an extra ld and andi. is in the range of ~9ns.
>>>
>>> There're two patches in the series. The first patch replaces static key
>>> with QUEUE_FLAG_QOS_ENABLED. The second patch ensures that we disable
>>> the QUEUE_FLAG_QOS_ENABLED when the queue no longer has any associated
>>> rq_qos policies.
>>>
>>> As usual, feedback and review comments are welcome!
>>>
>>> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
>>
>>
>> Another approach is to call memalloc_noio_save() in cpu hotplug code...
>>
> Yes that would help fix this. However per the general usage of GFP_NOIO scope in 
> kernel, it is used when we're performing memory allocations in a context where I/O
> must not be initiated, because doing so could cause deadlocks or recursion. 
> 
> So we typically, use GFP_NOIO in a code path that is already doing I/O, such as:
> - In block layer context: during request submission 
> - Filesystem writeback, or swap-out.
> - Memory reclaim or writeback triggered by memory pressure.
> 
> The cpu hotplug code may not be running in any of the above context. So
> IMO, adding memalloc_noio_save() in the cpu hotplug code would not be 
> a good idea, isn't it?

Please heed Ming's advice, moving this from a static key to an atomic
queue flags ops is pointless, may as well kill it at that point.

I see v2 is out now with the exact same approach.

-- 
Jens Axboe

