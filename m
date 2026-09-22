Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F405B1FC4;
	Tue, 22 Sep 2026 05:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790053799; cv=none; b=qvI7xYba5wChi9Us/rVRSJWClrKQ0Ohi7vtRQ4F2llM+6MTM1SbxB9jFGZT7SmOOJ+ivQuLBpgj8VN3bC80ZZHwY7kDCJJbZa20q5odZQqJByEqBNVh7xxwLRti+YyJpoiBgppj9bcsMwhs1bK06ruyYRj3gwnme8iwxeNUrhGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790053799; c=relaxed/simple;
	bh=Sl5+ibW9Ni5uZqI5D8DGq8p4oXB/YnA1+OvTct4KMs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jtue8wLyi6VTEoU3CKm2Upn45lILr2aOpIHuz+vk37z8nrwL/D1xsA3HXLz0Re8SCSok7U9PioUN/JuhS93L9KwFMBKnDeB0+fk6egWrEwXGDBJZ43+Xu/fx7Y9BeenbxN31iz2nL5Yvpn4HyaAf4TwnUghaHUhpq/WQn1Esfms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68M58RYZ087222;
	Tue, 22 Sep 2026 14:08:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68M58Rd3087213
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 22 Sep 2026 14:08:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <24ef93b9-7385-4dda-8912-f7c78f9705d1@I-love.SAKURA.ne.jp>
Date: Tue, 22 Sep 2026 14:08:27 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] block: Add run_todo() operation
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        linux-block <linux-block@vger.kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Foster
 <bfoster@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>, Hillf Danton <hdanton@sina.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
        rust-for-linux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nilay Shroff <nilay@linux.ibm.com>
References: <e615fb71-f386-4029-8ceb-22e375ad9e94@I-love.SAKURA.ne.jp>
 <afbf50a0-d409-45a3-8e95-99c04ca0e302@acm.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <afbf50a0-d409-45a3-8e95-99c04ca0e302@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav412.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/09/22 2:27, Bart Van Assche wrote:
> On 9/19/26 3:50 AM, Tetsuo Handa wrote:
>> Add run_todo() block device operation which provides a hook for performing
>> synchronous cleanup without disk->open_mutex held, which is needed by the
>> loop devices.
> 
> I like the "post_release()" name much better. I think it is more clear
> and more descriptive than "run_todo()".

I think post_release() is misleading because post_release() is also called
when disk->fops->open() in blkdev_get_whole() failed (and therefore
bdev->bd_disk->fops->release() in blkdev_put_whole() from blkdev_get_whole()
was not called).

> 
>> diff --git a/block/bdev.c b/block/bdev.c
>> index cd8323083740..8f09aafbae11 100644
>> --- a/block/bdev.c
>> +++ b/block/bdev.c
>> @@ -974,6 +974,8 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
>>       bool unblock_events = true;
>>       struct gendisk *disk = bdev->bd_disk;
>>       int ret;
>> +    struct module *fops_owner = NULL;
>> +    void (*run_todo)(struct gendisk *disk) = NULL;
>>         if (holder) {
>>           mode |= BLK_OPEN_EXCL;
>> @@ -996,6 +998,7 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
>>       ret = -EBUSY;
>>       if (!bdev_may_open(bdev, mode))
>>           goto put_module;
>> +    run_todo = disk->fops->run_todo;
>>       if (bdev_is_partition(bdev))
>>           ret = blkdev_get_part(bdev, mode);
>>       else
>> @@ -1037,12 +1040,15 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
>>         return 0;
>>   put_module:
>> -    module_put(disk->fops->owner);
>> +    fops_owner = disk->fops->owner;
>>   abort_claiming:
>>       if (holder)
>>           bd_abort_claiming(bdev, holder);
>>       mutex_unlock(&disk->open_mutex);
>>       disk_unblock_events(disk);
>> +    if (run_todo)
>> +        run_todo(disk);
>> +    module_put(fops_owner);
>>       return ret;
>>   }
> The above changes introduce a bug: these changes cause module_put()
> to be called if try_module_get() fails. I think that's wrong.

No, this change is safe. module_put(NULL) is no-op, fops_owner is initialized with NULL,
and fops_owner might become non-NULL at the put_module label.
