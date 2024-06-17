Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910FB9474;
	Mon, 17 Jun 2024 03:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718596207; cv=none; b=dTKAErRH5IpqvVyTHfJ5LNw9D6+8iVYUYhEn991lWMv0eAjB4z6T77blm+i4sYFnKc7ecUh5ccwwsTs0Zr8sVcZsWRWA8WeDujS9xsZyKmLn/Kj9kkcjj6IMWrnpL9VOfMmQhmi4MDyE3HCnZVqXutK5o370y4lIyc6fq6D1lsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718596207; c=relaxed/simple;
	bh=/QLWBi+wAZR91DzwWnusNXqvdNQW97k9Owp3Blc8EAk=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=K8Lm+impr2M/4Wi7a+fvRVEK1RlNNXVxbhfeI4Iy52VZzqY3K8wUDWLO1i6GX85Y8XfJHyWoODpwOPUzicgT8HvQbKrqaV/FChyRtPu3DWTmdIqnrGlX+TNy9Um6oY1Un24/cp8m6Z3JcFdE6DUpVL/Qf+QcqWYebITXuLhPWdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W2bPK60BpznVgf;
	Mon, 17 Jun 2024 11:45:09 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id D07E914011B;
	Mon, 17 Jun 2024 11:50:00 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 11:50:00 +0800
Subject: Re: [PATCH] block: bio-integrity: fix potential null-ptr-deref in
 bio_integrity_free
To: Ming Lei <ming.lei@redhat.com>
References: <20240606062655.2185006-1-yebin@huaweicloud.com>
 <ZmJQwvBXfm3zw+Xs@fedora> <6662632D.7020000@huaweicloud.com>
 <ZmJj5C4gz+gT9C4m@fedora> <6667BAED.7060809@huawei.com>
 <ZmfEn4ieO9EK/0z5@fedora>
CC: yebin <yebin@huaweicloud.com>, <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yi Zhang
	<yi.zhang@redhat.com>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <666FB267.7080809@huawei.com>
Date: Mon, 17 Jun 2024 11:49:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZmfEn4ieO9EK/0z5@fedora>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2024/6/11 11:29, Ming Lei wrote:
> On Tue, Jun 11, 2024 at 10:48:13AM +0800, yebin (H) wrote:
>>
>> On 2024/6/7 9:35, Ming Lei wrote:
>>> On Fri, Jun 07, 2024 at 09:32:29AM +0800, yebin wrote:
>>>> On 2024/6/7 8:13, Ming Lei wrote:
>>>>> On Thu, Jun 06, 2024 at 02:26:55PM +0800, Ye Bin wrote:
>>>>>> From: Ye Bin <yebin10@huawei.com>
>>>>>>
>>>>>> There's a issue as follows when do format NVME with IO:
>>>>>> BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
>>>>>> PGD 101727f067 P4D 1011fae067 PUD fbed78067 PMD 0
>>>>>> Oops: 0000 [#1] SMP NOPTI
>>>>>> RIP: 0010:kfree+0x4f/0x160
>>>>>> RSP: 0018:ff705a800912b910 EFLAGS: 00010247
>>>>>> RAX: 0000000000000000 RBX: 0d06d30000000000 RCX: ff4fb320260ad990
>>>>>> RDX: ff4fb30ee7acba40 RSI: 0000000000000000 RDI: 00b04cff80000000
>>>>>> RBP: ff4fb30ee7acba40 R08: 0000000000000200 R09: ff705a800912bb60
>>>>>> R10: 0000000000000000 R11: ff4fb3103b67c750 R12: ffffffff9a62d566
>>>>>> R13: ff4fb30aa0530000 R14: 0000000000000000 R15: 000000000000000a
>>>>>> FS:  00007f4399b6b700(0000) GS:ff4fb31040140000(0000) knlGS:0000000000000000
>>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>> CR2: 0000000000000008 CR3: 0000001014cd4002 CR4: 0000000000761ee0
>>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>>> DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
>>>>>> PKRU: 55555554
>>>>>> Call Trace:
>>>>>>     bio_integrity_free+0xa6/0xb0
>>>>>>     __bio_integrity_endio+0x8c/0xa0
>>>>>>     bio_endio+0x2b/0x130
>>>>>>     blk_update_request+0x78/0x2b0
>>>>>>     blk_mq_end_request+0x1a/0x140
>>>>>>     blk_mq_try_issue_directly+0x5d/0xc0
>>>>>>     blk_mq_make_request+0x46b/0x540
>>>>>>     generic_make_request+0x121/0x300
>>>>>>     submit_bio+0x6c/0x140
>>>>>>     __blkdev_direct_IO_simple+0x1ca/0x3a0
>>>>>>     blkdev_direct_IO+0x3d9/0x460
>>>>>>     generic_file_read_iter+0xb4/0xc60
>>>>>>     new_sync_read+0x121/0x170
>>>>>>     vfs_read+0x89/0x130
>>>>>>     ksys_read+0x52/0xc0
>>>>>>     do_syscall_64+0x5d/0x1d0
>>>>>>     entry_SYSCALL_64_after_hwframe+0x65/0xca
>>>>>>
>>>>>> Assuming a 512 byte directIO is issued, the initial logical block size of
>>>>>> the state block device is 512 bytes, and then modified to 4096 bytes.
>>>>>> Above issue may happen as follows:
>>>>>>             Direct read                    format NVME
>>>>>> __blkdev_direct_IO_simple(iocb, iter, nr_pages);
>>>>>>      if ((pos | iov_iter_alignment(iter)) & (bdev_logical_block_size(bdev) - 1))
>>>>>> 	-->The logical block size is 512, and the IO issued is 512 bytes,
>>>>>> 	   which can be checked
>>>>>>        return -EINVAL;
>>>>>>      submit_bio(&bio);
>>>>>>                                          nvme_dev_ioctl
>>>>>>                                            case NVME_IOCTL_RESCAN:
>>>>>>                                              nvme_queue_scan(ctrl);
>>>>>>                                                 ...
>>>>>>                                                nvme_update_disk_info(disk, ns, id);
>>>>>>                                                  blk_queue_logical_block_size(disk->queue, bs);
>>>>>>                                                    --> 512->4096
>>>>>>         blk_queue_enter(q, flags)
>>>>>>         blk_mq_make_request(q, bio)
>>>>>>           bio_integrity_prep(bio)
>>>>>> 	 len = bio_integrity_bytes(bi, bio_sectors(bio));
>>>>>> 	   -->At this point, because the logical block size has increased to
>>>>>> 	      4096 bytes, the calculated 'len' here is 0
>>>>>>             buf = kmalloc(len, GFP_NOIO | q->bounce_gfp);
>>>>>> 	   -->Passed in len=0 and returned buf=16
>>>>>>             end = (((unsigned long) buf) + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
>>>>>>             start = ((unsigned long) buf) >> PAGE_SHIFT;
>>>>>>             nr_pages = end - start;  -->nr_pages == 1
>>>>>>             bip->bip_flags |= BIP_BLOCK_INTEGRITY;
>>>>>>             for (i = 0 ; i < nr_pages ; i++) {
>>>>>>               if (len <= 0)
>>>>>>                  -->Not initializing the bip_vec of bio_integrity, will result
>>>>>> 		 in null pointer access during subsequent releases. Even if
>>>>>> 		 initialized, it will still cause subsequent releases access
>>>>>> 		 null pointer because the buffer address is incorrect.
>>>>>>                 break;
>>>>>>
>>>>>> Firstly, it is unreasonable to format NVME in the presence of IO. It is also
>>>>>> possible to see IO smaller than the logical block size in the block layer for
>>>>>> this type of concurrency. It is expected that this type of IO device will
>>>>>> return an error, so exception handling should also be done for this type of
>>>>>> IO to prevent null pointer access from causing system crashes.
>>>>> Actually unaligned IO handling is one mess for nvme hardware. Yes, IO may fail,
>>>>> but it is observed that meta buffer is overwrite by DMA in read IO.
>>>>>
>>>>> Ye and Yi, can you test the following patch in your 'nvme format' & IO workload?
>>>>>
>>>>>
>>>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>>>> index 82c3ae22d76d..a41ab4a3a398 100644
>>>>> --- a/block/blk-core.c
>>>>> +++ b/block/blk-core.c
>>>>> @@ -336,6 +336,19 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
>>>>>     	return 0;
>>>>>     }
>>>>> +static bool bio_unaligned(struct bio *bio)
>>>>> +{
>>>>> +	unsigned int bs = bdev_logical_block_size(bio->bi_bdev);
>>>>> +
>>>>> +	if (bio->bi_iter.bi_size & (bs - 1))
>>>>> +	        return true;
>>>>> +
>>>>> +	if ((bio->bi_iter.bi_sector << SECTOR_SHIFT) & (bs - 1))
>>>>> +	        return true;
>>>>> +
>>>>> +	return false;
>>>>> +}
>>>> I think this judgment is a bit incorrect. It should not be sufficient to
>>>> only determine whether
>>>> the length and starting sector are logically block aligned.
>>> Can you explain why the two are not enough? Other limits should be handled
>>> by bio split.
>> If logical block size is 512 bytes, BIO has 4 segments, each segment length
>> is 512 bytes,
>> bio->bi_iter.bi_sector == 0. If logical block size change to 4096 bytes,
>> bio_unaligned() will
>> return false.
> Yes, this IO is still 4096 aligned in block size level.
>
> It is just that each bvec buffer isn't page-aligned, for nvme, if virt_boundary
> is set, this bio will be split. However, we don't add logical block size
> check in submit_bio_noacct() yet, 512byte bio still can be sent to
> device.
>
>> I'm not sure if the example I gave is appropriate?
> Absolutely it is one good example.
>
> BTW, Yi have tested both your patch and my patch which checks lbs in
> blk_queue_enter(), looks slab corruption still can be triggered with
> either one.
Yes, my patch only solves the integrity process in a single point to 
avoid affecting
the normal IO process. I am not sure if other processes will have 
similar issues.
>
> Yi, can you test the following patch?
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 82c3ae22d76d..c47e69795c86 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -336,6 +336,19 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
>   	return 0;
>   }
>   
> +static inline bool bio_unaligned(struct bio *bio)
> +{
> +	unsigned int bs = bdev_logical_block_size(bio->bi_bdev);
> +
> +	if (bio->bi_iter.bi_size & (bs - 1))
> +	        return true;
> +
> +	if ((bio->bi_iter.bi_sector << SECTOR_SHIFT) & (bs - 1))
> +	        return true;
> +
> +	return false;
> +}
> +
>   int __bio_queue_enter(struct request_queue *q, struct bio *bio)
>   {
>   	while (!blk_try_enter_queue(q, false)) {
> @@ -362,6 +375,15 @@ int __bio_queue_enter(struct request_queue *q, struct bio *bio)
>   			   test_bit(GD_DEAD, &disk->state));
>   		if (test_bit(GD_DEAD, &disk->state))
>   			goto dead;
> +		/*
> +		 * Not like other queue limits, logical block size is one
> +		 * fundamental limit which can't be covered by bio split.
> +		 *
> +		 * Device reconfiguration may happen and logical block size
> +		 * is changed, so fail the IO if that is true.
> +		 */
> +		if (bio_unaligned(bio))
> +			goto dead;
>   	}
>   
>   	return 0;
> @@ -765,6 +787,8 @@ void submit_bio_noacct(struct bio *bio)
>   
>   	if (should_fail_bio(bio))
>   		goto end_io;
> +	if (bio->bi_iter.bi_size && bio_unaligned(bio))
> +		goto end_io;
I think this check should be added after the bio_queue_enter() call. 
Early judgment should be unreliable.
>   	bio_check_ro(bio);
>   	if (!bio_flagged(bio, BIO_REMAPPED)) {
>   		if (unlikely(bio_check_eod(bio)))
>
>
> Thanks,
> Ming
>
>
> .
>

