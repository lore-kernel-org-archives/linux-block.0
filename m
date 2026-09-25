Received: from mta0.migadu.com (out-80.mta0.migadu.com [91.218.175.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D840C30E0EE
	for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 01:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790299776; cv=none; b=eqVjTS526dmTD7pVbw067vlEX5Ujjd0r8Iq3wepvBbMDZd9umwL0G69kCfer/3+fVMhTyVgGBRQBGmCEGGlNyv63sFhFzye727bAFA+PA8oDS7nH/k5ItBxiHRRl1WSzPNjBByzjGuMI/uJg0hMS3IpedZI2BGLk9AbA3jy67Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790299776; c=relaxed/simple;
	bh=dE4rLE15UVkW/FcpdWYDCqKhVBmziqyc83G34Mkj9Mk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IaB/oWA88Ll0XVOm0n7q/2BrdN7N5Q+2VSLAjhxOri1wSFroEgblDO6c9t50qPei+nqN8+78saNX8UKMuutyWKHsIYuD9lJf+7YTLza3rv4PMQFhoQyeLOU/SlU+k35wqpxptHs7aqj9n1IUK1r09yYx2BQVWFI4Bh1wFTk7dJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MQi/9DRW; arc=none smtp.client-ip=91.218.175.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MQi/9DRW"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dE4rLE15UVkW/FcpdWYDCqKhVBmziqyc83G34Mkj9Mk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790299771; v=1; x=1790904571;
 b=MQi/9DRWeHdw4ThHm5A7vm45QJ3/AdhzIXvn7up0JgOLvpw87ufrlTc7b2ZHjGpXK4zevUNG
 K3cxa/v99zaJD7NR9sO7djda4XMqXLHe/8REtdpZrz++ihjWjAFZyWcMUvSO5i3Ov6nUpBIEN6v
 ls4x+aEdWsbWtrHnn1MF6s1w=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c07214f194ab2ff9;
	Fri, 25 Sep 2026 01:29:31 +0000
X-Mizu-Trace-ID: c07214f194ab2ff9
X-Migadu-Flow: FLOW_OUT
Message-ID: <2df087b0-2a00-4e30-8e6c-d2f76e3ebd79@linux.dev>
Date: Fri, 25 Sep 2026 09:29:28 +0800
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
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <b6e08595-50f5-494b-ae5e-726513d8dae2@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Bart,

Thanks for the review. 

在 2026/9/25 02:01, Bart Van Assche 写道:
> On 9/24/26 3:20 AM, Tao Cui wrote:
>> +    memflags = blk_mq_freeze_queue(lo->lo_queue);
>> +    mutex_lock(&lo->clear_limits_lock);
>> +    if (lo->clear_limits_gen == lo->rebind_gen) {
>> +        mode = lo->clear_limits_mode;
>> +        lo->clear_limits_mode = 0;
>> +
>> +        if (mode & FALLOC_FL_ZERO_RANGE)
>> +            lim.max_write_zeroes_sectors = 0;
>> +
>> +        if (mode & FALLOC_FL_PUNCH_HOLE) {
>> +            lim.max_hw_discard_sectors = 0;
>> +            lim.discard_granularity = 0;
>> +        }
>> +    }
> 
> I propose to remove the member variables clear_limits_gen and
> rebind_gen. These member variables complicate verifying correctness
> of the code and IMHO are not necessary. If loop_clear_limits() races
> with loop_clear_limits_workfn(), the work will be rescheduled and
> loop_clear_limits_workfn() will be called another time.
> 

The generation counters were intended to prevent a clear request
queued for an old backing file from being applied after the loop
device had been rebound. However, you're right that resetting
clear_limits_mode in loop_assign_backing_file() and __loop_clr_fd()
under the same mutex already prevents that, so the generation
counters are redundant. I'll remove them.

>>       queue_limits_commit_update(lo->lo_queue, &lim);
>> +    mutex_unlock(&lo->clear_limits_lock);
> 
> Since the mutex_lock(&lo->clear_limits_lock) call occurs after
> queue_limits_start_update(), please move the
> mutex_unlock(&lo->clear_limits_lock) call above the
> queue_limits_commit_update() call. This has no impact on
> correctness nor on the lock nesting order but makes the code
> easier to follow.
> 

On moving mutex_unlock() above queue_limits_commit_update(): with
the generation counters removed, the mutex is what keeps consuming
clear_limits_mode and committing the resulting queue limits atomic
with respect to a rebind. blk_mq_freeze_queue() is
reference-counted, so the workfn and loop_change_fd() can both hold
a freeze concurrently. If the workfn drops the mutex after consuming
a non-zero mode but before queue_limits_commit_update(),
loop_change_fd() could install a new backing file in that window,
and the pending clear would then be committed to the new file. Since
loop_change_fd() does not recompute the queue limits afterward, the
incorrectly cleared discard limits would persist until the next
reconfiguration.

For that reason, I'd prefer to keep the mutex held until after
queue_limits_commit_update(). I can add a comment explaining this if
that would help.

Thanks,
Tao

> Thanks,
> 
> Bart.

