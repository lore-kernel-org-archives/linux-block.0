Received: from mta1.migadu.com (out-142.mta1.migadu.com [95.215.58.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C28331EB2
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 02:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790647712; cv=none; b=cD1FXdaJ7dKvIrfFQjv08DnYx0XOIRpOIbjgPKqGU8Ue+dW/wcqZlmkRHjfx1vuVRNhKpnPgok5+KMozshRf5APFHG8HnC2yA5Edx8H7nBQY25uZW5XFfGZNdjh9m4r3rGF021EQenKTVOIpmp2092EN/hg6jxXko/GDfdFDq5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790647712; c=relaxed/simple;
	bh=yWN2pXrEgudmQV5/KdTupS8SIlaev88MpOoEz+dBiaU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jzrm7QIzfU2QrcPS8+IPKuhnMcIUNUUXuwLOLpfJ32P6QwU1cq0DHDq1TMjl4Fa6Zm+Hbtr75C+mcIlA1I94cF3j/o7u673zFav0bp98Rb3B4czIc7NrLbKnTRn4PoC9Rjmb/CjaWmkwW3X9b9qQyke9GhQejqriVak6k8XZaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=scCFfK1M; arc=none smtp.client-ip=95.215.58.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="scCFfK1M"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yWN2pXrEgudmQV5/KdTupS8SIlaev88MpOoEz+dBiaU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790647709; v=1; x=1791252509;
 b=scCFfK1MaLIyE9QrxVj0gSe29W34FqlGKfmJ+a6ZA1fIr5i9ebkRDoFRVsmC8HYw/+Sl/jcW
 utXy9776ew2+mSCA5eYO7mph2er9EqtMaLe8BOV4sao6YX9W0vcXFs0+jKzWh7ZRjtgIJOPwL4E
 LldtzF2wHPi/wVdPwyY0GnfU=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 754af4c4803bea6d;
	Tue, 29 Sep 2026 02:08:28 +0000
X-Mizu-Trace-ID: 754af4c4803bea6d
X-Migadu-Flow: FLOW_OUT
Message-ID: <edfc22ef-799d-4f70-8668-bde0caf67bcf@linux.dev>
Date: Tue, 29 Sep 2026 10:08:20 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, cuitao@kylinos.cn, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] loop: defer the queue limits clear to a workqueue
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk, hch@lst.de,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20260928093512.3153646-1-cui.tao@linux.dev>
 <df36224b-7fcb-45c4-ab78-d7e726bfeb9d@acm.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <df36224b-7fcb-45c4-ab78-d7e726bfeb9d@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Bart,

在 2026/9/29 01:26, Bart Van Assche 写道:
> On 9/28/26 2:35 AM, Tao Cui wrote:
>> @@ -1148,6 +1182,16 @@ static void __loop_clr_fd(struct loop_device *lo)
>>       lo->lo_backing_file = NULL;
>>       spin_unlock_irq(&lo->lo_lock);
>>   +    /*
>> +     * Invalidate any clear that was scheduled against the old backing
>> +     * file.  Unbinding cannot race with in-flight I/O, so cancelling
>> +     * here leaves no work item behind.
>> +     */
> 
> This comment is wrong - asynchronous I/O can still be in progress here.

You are right, asynchronous I/O can still be in flight in
__loop_clr_fd(). I'll fix the comment.
> See also
> https://lore.kernel.org/linux-block/69960302-1535-441a-be4e-d652766d65c2@I-love.SAKURA.ne.jp/
> 
> Should this patch perhaps be rebased on top of Tetsuo's series?
> 
On rebasing on top of Tetsuo's series: since you recommend it, I
can rebase this patch on top of it - the cancel inside
__loop_clr_fd() just moves along with the new structure, and the
I/O flush there makes that cancel airtight. 

>> @@ -1783,7 +1827,9 @@ static void lo_free_disk(struct gendisk *disk)
>>           destroy_workqueue(lo->workqueue);
>>       loop_free_idle_workers(lo, true);
>>       timer_shutdown_sync(&lo->timer);
>> +    cancel_work_sync(&lo->clear_limits_work);
>>       mutex_destroy(&lo->lo_mutex);
>> +    mutex_destroy(&lo->clear_limits_lock);
>>       kfree(lo);
>>   }
> 
> Is the above new cancel_work_sync() call really necessary?
> 
>> @@ -2140,6 +2188,12 @@ static int loop_add(int i)
>>     static void loop_remove(struct loop_device *lo)
>>   {
>> +    /*
>> +     * Cancel early: the queue may already be in RCU-delayed freeing
>> +     * by the time lo_free_disk() cancels the work item.
>> +     */
>> +    cancel_work_sync(&lo->clear_limits_work);
>> +
>>       /* Make this loop device unreachable from pathname. */
>>       del_gendisk(lo->lo_disk);
>>       blk_mq_free_tag_set(&lo->tag_set);
> 
> Is the above new cancel_work_sync() call necessary since there is
> already an identical call in __loop_clr_fd()?
> 
On the cancel in loop_remove(): i think this one is needed because
asynchronous I/O may still complete after __loop_clr_fd() has run
and queue the work item. Since the queue becomes eligible for
RCU-delayed freeing before lo_free_disk() is reached,
cancel_work_sync() before del_gendisk() ensures no pending
clear_limits_work remains against that queue.

I'll send v7 with the comment fixed and the redundant cancel removed once Tetsuo's series has landed.

Thanks,
Tao.
> Thanks,
> 
> Bart.

