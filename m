Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E22381BA
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087413; cv=none; b=VKGhuTr4t4F61vHPp/FBg678AWAmgWvH5gsJHS7WReWIGrB2CbEHGzlAHQ6in9k1uybJnhnMSEHSbW2ylkbaCo3pV3TDSIr6ywx+4Ksbz0Lod1Havkid1V+ZNHoMZQY+g44ZggRMhINW9Rui5E/hO3JK5tHx5W4m4LxUvce3WVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087413; c=relaxed/simple;
	bh=79lvpZfIhzD8D4GxnvWIrfr/GVRDTL3NgA6kaY82knI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ra4R310uarYfrq1MZXFumOOa03fmk8ri7/JI21pWNx1q5p62mfvLcmbSrkPCw6ZfBBsbPfENyS2OzTBO2CoQ8RCCGITDINpv8PfKx05QiFjeIjg8vfbRL6l2j6z3f43Apqc8xywBt+YXun7hAvVPQ1TPR9lFj/nyT1BTzfur14Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TN46G+Lg; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TN46G+Lg"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76bd6e84eddso7850977b3a.0
        for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 05:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755087409; x=1755692209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T9HuHfAVojkKpHl/ZLpljLYmGL6VjE+WgaCEQ9lAUc4=;
        b=TN46G+Lg1Wcq/WRdzEWxX/xZ8+iwXMgw6Qlysp/GwA/IHfO1TAw17IBmViaMJw7Wet
         ngP7NywcKYDglHk1b7cibafiboFwHFZhnry+g+kIHctjNZDUBPWmlMW/mSHAINx0roRD
         wj9IbqTmL/bNaDV+XTodbV7mEfQ5q2wuMmK61hKd9aWgf7AD8+LtHdrHBC3GxsYDEwSU
         58jC4Fu6YwvRnHfwiTaQGwqYqD5QGwmyf7zDZv4X3PpcEgD6KoJnVWS3l1oxfpyh+jt1
         csgWocDOZazTLpdNFTBOi2O23wyjXFp6GN/dDDWdTKOjfdzv79ZTucOTFOghsasnoPX3
         SDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755087409; x=1755692209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9HuHfAVojkKpHl/ZLpljLYmGL6VjE+WgaCEQ9lAUc4=;
        b=mcqzP5F0J3I4xh1zltlSqNZ9cLDlnqV6wKeSCMMJ1iR8h5WlrqTwluGSaLL1QbOodV
         3HBtzlaPKdmoyNKVaf1DXb35kZ4iqaw0x7Mo+KEAwNPGqmVpnYC+1P7XpEmDqUFSFFto
         h11eIHEqVkwbx2O5lUeaDeZ2VcUC6yebIWDOo+EPO6fSfSZdAlwC47TUlbbz0Fmd8tr7
         3fuqRtNl7DdWWglvav07sDZVbTH9OcmdBGrMaOMFfz7QaoW/Tq3uO4ZWYVtevVeaYxuh
         F5eSREVkMlz3zqLjXVXYBUYjv3/9OHQM1d0OR/ZkgrTiSD7bXusnjjQSgMclFsFYenTM
         1uvg==
X-Gm-Message-State: AOJu0Yw1oiNGACl9b9LPLYu5a+P4wpWw3/ZwBSI8WZQC1Zg2LZrshMqh
	7KWp6/AAJAYJU6UKIR3bzTsD051fH04hI9Q/bQhnfE0hSAiCV6DJ6NHK2loGmHbiahU=
X-Gm-Gg: ASbGnctQhogKQpoUcY8OYwEtay/nRWmb8FsZ613IaYekUXLn05VvQamHi4/wX9rG2uj
	iuxOpSpMJCa4vuChUqJa3WpnNQRcAYThAExSmOdSuxl0PaQi+oRlTVdfg64zw9k1WCtBvyHHeUJ
	vAfHz0C/6yvUFKGCu+3SuF3esptUXfX6em7TUhYHH9xV5aOp0S2FDr8Pav0zSpqoO1UIU8SewvA
	uY14+qkgMIXN5Tr1GYPa69IihaEJEIohvEnW03uwgy4QbRZxRornoWq33sPShnggvhFf63+Q0MZ
	GuukQXkNmNQLddfHsn3gvTEHnjngP/lDYP/EvskccH8RBGrnLKTHyPD+i5+T/xXy6usFM5BuUrN
	6ZiKteJ+2mYmZN6wk/quI
X-Google-Smtp-Source: AGHT+IGpiNyXbIeUJXQ0nkGsBoO5jb6UJe8lAO5yRDp+yo5rw0L6traVCY85hTRH2GKKsJLJxPN/iw==
X-Received: by 2002:a05:6a00:1301:b0:736:2a73:6756 with SMTP id d2e1a72fcca58-76e20fcfc0emr3796268b3a.21.1755087409278;
        Wed, 13 Aug 2025 05:16:49 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e10282114sm4432115b3a.75.2025.08.13.05.16.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 05:16:47 -0700 (PDT)
Message-ID: <d8fcf9bf-6b90-444a-8a26-658cee9e7f58@kernel.dk>
Date: Wed, 13 Aug 2025 06:16:46 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block: blk-rq-qos: replace static key with atomic
 bitop
To: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, kch@nvidia.com, shinichiro.kawasaki@wdc.com,
 hch@lst.de, gjoyce@ibm.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250804122125.3271397-1-nilay@linux.ibm.com>
 <aJC4tDUsk42Nb9Df@fedora>
 <682f0f43-733a-4c04-91ed-5665815128bc@linux.ibm.com>
 <d4d21177-e49e-4959-b68c-707a15dccf73@kernel.dk>
 <e00a3951-2cc8-3634-788e-8a174bdc6a8f@huaweicloud.com>
 <06b0f3f6-1419-4b01-85a5-fe3bb38a6c63@linux.ibm.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <06b0f3f6-1419-4b01-85a5-fe3bb38a6c63@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 5:20 AM, Nilay Shroff wrote:
> Hi Jens,
> 
> On 8/6/25 7:14 AM, Yu Kuai wrote:
>> Hi,
>>
>> ? 2025/08/06 9:28, Jens Axboe ??:
>>> On 8/4/25 10:58 PM, Nilay Shroff wrote:
>>>>
>>>>
>>>> On 8/4/25 7:12 PM, Ming Lei wrote:
>>>>> On Mon, Aug 04, 2025 at 05:51:09PM +0530, Nilay Shroff wrote:
>>>>>> This patchset replaces the use of a static key in the I/O path (rq_qos_
>>>>>> xxx()) with an atomic queue flag (QUEUE_FLAG_QOS_ENABLED). This change
>>>>>> is made to eliminate a potential deadlock introduced by the use of static
>>>>>> keys in the blk-rq-qos infrastructure, as reported by lockdep during
>>>>>> blktests block/005[1].
>>>>>>
>>>>>> The original static key approach was introduced to avoid unnecessary
>>>>>> dereferencing of q->rq_qos when no blk-rq-qos module (e.g., blk-wbt or
>>>>>> blk-iolatency) is configured. While efficient, enabling a static key at
>>>>>> runtime requires taking cpu_hotplug_lock and jump_label_mutex, which
>>>>>> becomes problematic if the queue is already frozen ? causing a reverse
>>>>>> dependency on ->freeze_lock. This results in a lockdep splat indicating
>>>>>> a potential deadlock.
>>>>>>
>>>>>> To resolve this, we now gate q->rq_qos access with a q->queue_flags
>>>>>> bitop (QUEUE_FLAG_QOS_ENABLED), avoiding the static key and the associated
>>>>>> locking altogether.
>>>>>>
>>>>>> I compared both static key and atomic bitop implementations using ftrace
>>>>>> function graph tracer over ~50 invocations of rq_qos_issue() while ensuring
>>>>>> blk-wbt/blk-iolatency were disabled (i.e., no QoS functionality). For
>>>>>> easy comparision, I made rq_qos_issue() noinline. The comparision was
>>>>>> made on PowerPC machine.
>>>>>>
>>>>>> Static Key (disabled : QoS is not configured):
>>>>>> 5d0: 00 00 00 60     nop    # patched in by static key framework (not taken)
>>>>>> 5d4: 20 00 80 4e     blr    # return (branch to link register)
>>>>>>
>>>>>> Only a nop and blr (branch to link register) are executed ? very lightweight.
>>>>>>
>>>>>> atomic bitop (QoS is not configured):
>>>>>> 5d0: 20 00 23 e9     ld      r9,32(r3)     # load q->queue_flags
>>>>>> 5d4: 00 80 29 71     andi.   r9,r9,32768   # check QUEUE_FLAG_QOS_ENABLED (bit 15)
>>>>>> 5d8: 20 00 82 4d     beqlr                 # return if bit not set
>>>>>>
>>>>>> This performs an ld and and andi. before returning. Slightly more work,
>>>>>> but q->queue_flags is typically hot in cache during I/O submission.
>>>>>>
>>>>>> With Static Key (disabled):
>>>>>> Duration (us): min=0.668 max=0.816 avg?0.750
>>>>>>
>>>>>> With atomic bitop QUEUE_FLAG_QOS_ENABLED (bit not set):
>>>>>> Duration (us): min=0.684 max=0.834 avg?0.759
>>>>>>
>>>>>> As expected, both versions are almost similar in cost. The added latency
>>>>>> from an extra ld and andi. is in the range of ~9ns.
>>>>>>
>>>>>> There're two patches in the series. The first patch replaces static key
>>>>>> with QUEUE_FLAG_QOS_ENABLED. The second patch ensures that we disable
>>>>>> the QUEUE_FLAG_QOS_ENABLED when the queue no longer has any associated
>>>>>> rq_qos policies.
>>>>>>
>>>>>> As usual, feedback and review comments are welcome!
>>>>>>
>>>>>> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
>>>>>
>>>>>
>>>>> Another approach is to call memalloc_noio_save() in cpu hotplug code...
>>>>>
>>>> Yes that would help fix this. However per the general usage of GFP_NOIO scope in
>>>> kernel, it is used when we're performing memory allocations in a context where I/O
>>>> must not be initiated, because doing so could cause deadlocks or recursion.
>>>>
>>>> So we typically, use GFP_NOIO in a code path that is already doing I/O, such as:
>>>> - In block layer context: during request submission
>>>> - Filesystem writeback, or swap-out.
>>>> - Memory reclaim or writeback triggered by memory pressure.
>>>>
>>>> The cpu hotplug code may not be running in any of the above context. So
>>>> IMO, adding memalloc_noio_save() in the cpu hotplug code would not be
>>>> a good idea, isn't it?
>>>
>>> Please heed Ming's advice, moving this from a static key to an atomic
>>> queue flags ops is pointless, may as well kill it at that point.
>>
>> Nilay already tested and replied this is a dead end :(
>>
>> I don't quite understand why it's pointless, if rq_qos is never enabled,
>> an atmoic queue_flag is still minor optimization, isn't it?
>>
>>>
>>> I see v2 is out now with the exact same approach.
>>>
> As mentioned earlier, I tried Ming's original recommendation, but it didn?t
> resolve the issue. In a separate thread, Ming agreed that using an atomic queue
> flag is a reasonable approach and would avoid the lockdep problem while still
> keeping a minor fast-path optimization.
> 
> That leaves us with two options:
> - Use an atomic queue flag, or
> - Remove the static key entirely.
> 
> So before I send v3, do you prefer the atomic queue flag approach, or
> would you rather see the static key removed altogether? My preference
> is for the atomic queue flag, as it maintains a lightweight check
> without the static key?s locking concerns. 

Atomic test is still going to be better than pointless calls into
rq-qos, so that's still a win. Hence retaining it is better than simply
killing it off entirely.

I wonder if it makes sense to combine with IS_ENABLED() as well. Though
with how distros enable everything under the sun, probably not going to
be that useful.

-- 
Jens Axboe
