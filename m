Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40EC522F
	for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 05:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750226199; cv=none; b=kZmRhYCb+wOto2k3IETMb+tNXMvx5RPO0yv01jVxPUNUQA3mdnkpyiMM+XJEjl+4OZr8Wt2CpJBSxBPfL7xgoXf2HcDynLWQN6qj+IL9i9U/7/8SIz2PrO+rpMGibh0BaJwBtB2DMFBnd4zqaiSBAFCXPKjJkrccG5hY7LFFaj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750226199; c=relaxed/simple;
	bh=TXe/4LOe48SD/e205lz/1b7Cy5Tcw7k2ZxHTycQfLb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8k5Zu6x9fgxZ6CLfZHXBqCeIOJVkgo43cYmoN3pKu3JvTUbbBMBqzJn4WwxM7BqQnqr6qqmKBEkOyRDlEfEnz2QnQyjxyDtUkj4T3wbdnD0GiotZPnvd2qpJFZm2Ta34EbYO/d3yb6UhYmZ4s4iWXvjKaiqRVAopGrHaAPsigM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNvRw4bl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNvRw4bl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E34C4CEE7;
	Wed, 18 Jun 2025 05:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750226199;
	bh=TXe/4LOe48SD/e205lz/1b7Cy5Tcw7k2ZxHTycQfLb4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cNvRw4blXZEEVPMujI/9VJmrtIvqTTIkuuL9NpQd+AeMhV9KGJhMSiufLZPt4QSyv
	 Z8CLu4XJ59PDB8FNsIEfCoqLdpiyEWBO6DMt2nLevE7+HPd1+GQaV4bGBAsJ2h9WrZ
	 dX6Kt8aECGrcIpcL5hY3+3rCQvEHHkQiuD0FLW4QUikJ1kHlkVeNn36iCJykdH9kcr
	 PBlzAv3pMNOx9FkltOXrkZAekR7rMRlJCkKbbK9uYKXEhf4H3kyL/euD37eS6yHpx5
	 an67thRu/9Ew0HkldLESifA6CmIh8gkLpS/hYfB9F0VpPp/k27yuLGaKbblFVaL5/k
	 +K12pWRqeL7Sw==
Message-ID: <d18b6d7a-b2eb-4eb5-a526-a5619e50a1a0@kernel.org>
Date: Wed, 18 Jun 2025 14:56:37 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: don't use submit_bio_noacct_nocheck in
 blk_zone_wplug_bio_work
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
 axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20250611044416.2351850-1-hch@lst.de>
 <ea187ee4-378e-4c59-afdd-3ecd8ed57243@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ea187ee4-378e-4c59-afdd-3ecd8ed57243@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/25 05:09, Bart Van Assche wrote:
> On 6/10/25 9:44 PM, Christoph Hellwig wrote:
>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>> index 8f15d1aa6eb8..45c91016cef3 100644
>> --- a/block/blk-zoned.c
>> +++ b/block/blk-zoned.c
>> @@ -1306,7 +1306,6 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
>>   	spin_unlock_irqrestore(&zwplug->lock, flags);
>>   
>>   	bdev = bio->bi_bdev;
>> -	submit_bio_noacct_nocheck(bio);
>>   
>>   	/*
>>   	 * blk-mq devices will reuse the extra reference on the request queue
>> @@ -1314,8 +1313,12 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
>>   	 * path for BIO-based devices will not do that. So drop this extra
>>   	 * reference here.
>>   	 */
>> -	if (bdev_test_flag(bdev, BD_HAS_SUBMIT_BIO))
>> +	if (bdev_test_flag(bdev, BD_HAS_SUBMIT_BIO)) {
>> +		bdev->bd_disk->fops->submit_bio(bio);
>>   		blk_queue_exit(bdev->bd_disk->queue);
>> +	} else {
>> +		blk_mq_submit_bio(bio);
>> +	}
>>   
>>   put_zwplug:
>>   	/* Drop the reference we took in disk_zone_wplug_schedule_bio_work(). */
> 
> This patch is necessary but not sufficient. With this patch applied, if
> I run the deadlock reproducer (tests/zbd/013) with Jens' for-next
> branch, the deadlock shown below is reported. The first call stack shows
> the familiar queue_ra_store() invocation. The second call stack is new
> and shows a dm_split_and_process_bio() invocation.

That function may call bio_split_to_limits() which trigger the call chain

__bio_split_to_limits() -> bio_split_xxx() -> bio_submit_split() ->
submit_bio_noacct() -> submit_bio_noacct_nocheck()

And we then should endup doing:

	if (current->bio_list)
		bio_list_add(&current->bio_list[0], bio);

Since this is a split from within the original submitter context... Well, I
think we should be. If we endup calling again __submit_bio_noacct() directly
here, we would be reentering the submission path, at the risk of a stack
overflow, which is what the current->bio_list tries to avoid.
So I am confused why you endup seeing this issue... Can you check exactly the
path that is being followed ? (your backtrace does not seem to have everything)

Depending on the BIO, dm_split_and_process_bio may also trigger the path:

__split_and_process_bio() -> __map_bio() -> dm_submit_bio_remap() ->
submit_bio_noacct()

But that should be for submission of cloned BIOs to the block device used as the
backing dev of the DM device. So that should not cause an issue since that is a
different bdev. Or is this maybe confusing lockdep ?

> 
> sysrq: Show Blocked State
> task:check           state:D stack:27208 pid:2728  tgid:2728  ppid:2697 
>   task_flags:0x480040 flags:0x00004002
> Call Trace:
>   __schedule+0x8be/0x1c10
>   schedule+0xdd/0x270
>   blk_mq_freeze_queue_wait+0xfd/0x140
>   blk_mq_freeze_queue_nomemsave+0x1e/0x30
>   queue_ra_store+0x155/0x2a0
>   queue_attr_store+0x24d/0x2d0
>   sysfs_kf_write+0xdc/0x120
>   kernfs_fop_write_iter+0x39f/0x5a0
>   vfs_write+0x4fa/0x1300
>   ksys_write+0x109/0x1f0
>   __x64_sys_write+0x76/0xb0
>   x64_sys_call+0x276/0x17d0
>   do_syscall_64+0x94/0x3a0
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
> task:kworker/52:2H   state:D stack:26528 pid:2873  tgid:2873  ppid:2 
>   task_flags:0x4208060 flags:0x00004000
> Workqueue: dm-0_zwplugs blk_zone_wplug_bio_work
> Call Trace:
>   __schedule+0x8be/0x1c10
>   schedule+0xdd/0x270
>   __bio_queue_enter+0x32d/0x7c0
>   __submit_bio+0x1dd/0x6c0
>   __submit_bio_noacct+0x147/0x580
>   submit_bio_noacct_nocheck+0x4de/0x620
>   submit_bio_noacct+0x8f4/0x1a50
>   dm_split_and_process_bio+0x8a1/0x1c00 [dm_mod 
> 14a6a78a54cd51bfc1d6559d48b0c80b677774ec]
>   dm_submit_bio+0x137/0x490 [dm_mod 
> 14a6a78a54cd51bfc1d6559d48b0c80b677774ec]
>   blk_zone_wplug_bio_work+0x455/0x630
>   process_one_work+0xe29/0x1420
>   worker_thread+0x5ed/0xff0
>   kthread+0x3cd/0x840
>   ret_from_fork+0x412/0x520
>   ret_from_fork_asm+0x11/0x20
> 
> Bart.
> 


-- 
Damien Le Moal
Western Digital Research
