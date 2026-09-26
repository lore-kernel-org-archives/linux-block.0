Received: from mta1.migadu.com (out-89.mta1.migadu.com [95.215.58.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6184040F755
	for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790421671; cv=none; b=fi+vQfIfb+dab1HMh/CFCXqcnzZy2oTaq7+7b9M32k89/GKHbmGRALbmZPqp61L/kkeDza/ETiyTklUPpSxGf9vJCsD4H1egZbIZ+XAutRZQiWAZDTnSkS8KgrWklOdvyqToiXUngoCy5T9rnq6UgYQS/G48BsMqA1ulWD0J46c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790421671; c=relaxed/simple;
	bh=HjKR45CxxHM7MReG5NHgAHXPbtNS+4FrEkMTU3ObwCM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hgd9OBBbgeaj7A0nvs+8MRK7rBg1C7lRrcyURtDgtBtT+vDPadAjJlikvMdSAbK8QMplD5FBMGsbKbc4TTFscGW/XnVFdKWvdxbOgxtNz6hmNO5NA1wWRGOaw+OHSkwEnDOHF5SNmj5M4+CqBtzVC4r7Y98Q/CFs9lOJFqy/u+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wxv4Z7fp; arc=none smtp.client-ip=95.215.58.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wxv4Z7fp"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HjKR45CxxHM7MReG5NHgAHXPbtNS+4FrEkMTU3ObwCM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790421663; v=1; x=1791026463;
 b=Wxv4Z7fp+6Ns4pLtirvEiqc1aLn2ATgk1EufKJYZZ3TQC0ZXrYisb7DkdSa0ilnrt0324jw2
 T+ffboYkmqRm0z3amkSmOmMttG9yNncCQgzb4JJTRL327legX/jE1AGt1bMtKanoBzBr/HqCCH8
 QODNHGHEVBdZS7tZUi/CfBOs=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8c33f0ca767f52c0;
	Sat, 26 Sep 2026 11:21:03 +0000
X-Mizu-Trace-ID: 8c33f0ca767f52c0
X-Migadu-Flow: FLOW_OUT
Message-ID: <3c89b96c-29f6-4e9c-bbd0-4c5866636261@linux.dev>
Date: Sat, 26 Sep 2026 19:20:57 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, cuitao@kylinos.cn, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loop: defer the queue limits clear to a workqueue
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk, hch@lst.de,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20260924102027.2307044-1-cui.tao@linux.dev>
 <b6e08595-50f5-494b-ae5e-726513d8dae2@acm.org>
 <2df087b0-2a00-4e30-8e6c-d2f76e3ebd79@linux.dev>
 <bcf71ef1-427f-47ff-9880-c87ef0654259@acm.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <bcf71ef1-427f-47ff-9880-c87ef0654259@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Bart,

在 2026/9/26 00:22, Bart Van Assche 写道:
> On 9/24/26 6:29 PM, Tao Cui wrote:
>> 在 2026/9/25 02:01, Bart Van Assche 写道:
>>> On 9/24/26 3:20 AM, Tao Cui wrote:
>>>>        queue_limits_commit_update(lo->lo_queue, &lim);
>>>> +    mutex_unlock(&lo->clear_limits_lock);
>>>
>>> Since the mutex_lock(&lo->clear_limits_lock) call occurs after
>>> queue_limits_start_update(), please move the
>>> mutex_unlock(&lo->clear_limits_lock) call above the
>>> queue_limits_commit_update() call. This has no impact on
>>> correctness nor on the lock nesting order but makes the code
>>> easier to follow.
>>>
>>
>> On moving mutex_unlock() above queue_limits_commit_update(): with
>> the generation counters removed, the mutex is what keeps consuming
>> clear_limits_mode and committing the resulting queue limits atomic
>> with respect to a rebind. blk_mq_freeze_queue() is
>> reference-counted, so the workfn and loop_change_fd() can both hold
>> a freeze concurrently. If the workfn drops the mutex after consuming
>> a non-zero mode but before queue_limits_commit_update(),
>> loop_change_fd() could install a new backing file in that window,
>> and the pending clear would then be committed to the new file. Since
>> loop_change_fd() does not recompute the queue limits afterward, the
>> incorrectly cleared discard limits would persist until the next
>> reconfiguration.
>>
>> For that reason, I'd prefer to keep the mutex held until after
>> queue_limits_commit_update(). I can add a comment explaining this if
>> that would help.
> 
> This seems fragile to me. Can this race be solved by calling
> cancel_work_sync(&lo->clear_limits_work) before the backing file is
> changed?
> 

I looked into this, and that works. The freeze in loop_change_fd()
first drains all in-flight requests, so once it returns no further
clear_limits_work can be queued from the old backing file. Calling
cancel_work_sync() immediately afterwards ensures that any already
queued or running work has finished before the backing file
changes. I'll do the same in __loop_clr_fd().

With that, the mutex only protects clear_limits_mode, and
mutex_unlock() can move back above queue_limits_commit_update().
I'll send v6 with the generation counters removed and
mutex_unlock() moved above queue_limits_commit_update().

Thanks,
Tao.

> Thanks,
> 
> Bart.

