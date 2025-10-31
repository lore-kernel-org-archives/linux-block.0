Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB70320380;
	Fri, 31 Oct 2025 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921901; cv=none; b=sNDDZYS30ndeW1k0tUBe5yn1Ag2UCom8nuoS9CQtiDm2+Q91kpRbqby4biMpJ472aBKFlabvydYMl7AeHiYO9C2OsjtzpTvccZbWZXwu6cYqWHhivc/AJD/aQcpe3ezxz6kw65OrDsLRRnqceqMsfIJl/iM9V0SNwORA+HDt5Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921901; c=relaxed/simple;
	bh=Gd5KBjx2srwmWtROjooqn9fjQrwaUhRPcZIt8Eqh+rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSAUUgcNG25SfZugYfJDeRB8rF0Qle7jYhhrjsoNDP+Y48+rhuJmzZNPp23kYMkFGRohKUD2eKRdUlUW2n+o134V4X0wKS6TEUkqOw5Tupl+esFtdYEVg2KZ7MLRYY1mKbK6hGhUfCTIY0whdgFAFrFb9iddEkeS1pRVdauqk4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HuKKeMF9; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HuKKeMF9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761921895; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PfnYeDOw3NuHK44krWvx1RX9+ezQqo1kKRV2b1ByzRE=;
	b=HuKKeMF9clBJikaLLZFn3CWI2aTtS6z7YzOAxuNbMitES689mwiLQFs5oL7sWyk1qsoUHoOKK5zxpMTSrPjyjAVBl6ClqwbM74cSDUSfAIdXH9LTTCnaV6de9GnERfbK10G4yf4Gv/LuMe4L9C/h2tj1Y0ejiHZSa2y3ZeJQiaE=
Received: from 30.180.79.37(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WrPDkzZ_1761921893 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Oct 2025 22:44:54 +0800
Message-ID: <83b9dac8-815e-4990-8cc7-5aaf4ba85f42@linux.alibaba.com>
Date: Fri, 31 Oct 2025 22:44:53 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: question about bd_inode hashing against device_add() // Re:
 [PATCH 03/11] block: call bdev_add later in device_add_disk
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
 Joseph Qi <joseph.qi@linux.alibaba.com>, guanghuifeng@linux.alibaba.com,
 zongyong.wzy@alibaba-inc.com, zyfjeff@linux.alibaba.com,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20210818144542.19305-1-hch@lst.de>
 <20210818144542.19305-4-hch@lst.de>
 <43375218-2a80-4a7a-b8bb-465f6419b595@linux.alibaba.com>
 <20251031090925.GA9379@lst.de>
 <ae38c5dc-da90-4fb3-bb72-61b66ab5a0d2@linux.alibaba.com>
 <20251031094552.GA10011@lst.de>
 <7d0d8480-13a2-449f-a46d-d9b164d44089@linux.alibaba.com>
 <2025103155-definite-stays-ebfe@gregkh>
 <2a9ab583-07fc-4147-949e-7c68feda82f2@linux.alibaba.com>
 <ec8b1c76-c211-49a5-a056-6a147faddd3b@linux.alibaba.com>
 <2025103106-proposal-jogging-a076@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2025103106-proposal-jogging-a076@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/10/31 22:34, Greg Kroah-Hartman wrote:
> On Fri, Oct 31, 2025 at 08:23:32PM +0800, Gao Xiang wrote:
>>
>>
>> On 2025/10/31 18:12, Gao Xiang wrote:
>>> Hi Greg,
>>>
>>> On 2025/10/31 17:58, Greg Kroah-Hartman wrote:
>>>> On Fri, Oct 31, 2025 at 05:54:10PM +0800, Gao Xiang wrote:
>>>>>
>>>>>
>>>>> On 2025/10/31 17:45, Christoph Hellwig wrote:
>>
>> ...
>>
>>>>>> But why does the device node
>>>>>> get created earlier?  My assumption was that it would only be
>>>>>> created by the KOBJ_ADD uevent.  Adding the device model maintainers
>>>>>> as my little dig through the core drivers/base/ code doesn't find
>>>>>> anything to the contrary, but maybe I don't fully understand it.
>>>>>
>>>>> AFAIK, device_add() is used to trigger devtmpfs file
>>>>> creation, and it can be observed if frequently
>>>>> hotpluging device in the VM and mount.  Currently
>>>>> I don't have time slot to build an easy reproducer,
>>>>> but I think it's a real issue anyway.
>>>>
>>>> As I say above, that's not normal, and you have to be root to do this,
>> I just spent time to reproduce with dynamic loop devices and
>> actually it's easy if msleep() is located artificiallly,
>> the diff as below:
>>
>> diff --git a/block/bdev.c b/block/bdev.c
>> index 810707cca970..a4273b5ad456 100644
>> --- a/block/bdev.c
>> +++ b/block/bdev.c
>> @@ -821,7 +821,7 @@ struct block_device *blkdev_get_no_open(dev_t dev, bool autoload)
>>   	struct inode *inode;
>>
>>   	inode = ilookup(blockdev_superblock, dev);
>> -	if (!inode && autoload && IS_ENABLED(CONFIG_BLOCK_LEGACY_AUTOLOAD)) {
>> +	if (0) {
>>   		blk_request_module(dev);
>>   		inode = ilookup(blockdev_superblock, dev);
>>   		if (inode)
>> diff --git a/block/genhd.c b/block/genhd.c
>> index 9bbc38d12792..3c9116fdc1ce 100644
>> --- a/block/genhd.c
>> +++ b/block/genhd.c
>> @@ -428,6 +428,8 @@ static void add_disk_final(struct gendisk *disk)
>>   	set_bit(GD_ADDED, &disk->state);
>>   }
>>
>> +#include <linux/delay.h>
>> +
>>   static int __add_disk(struct device *parent, struct gendisk *disk,
>>   		      const struct attribute_group **groups,
>>   		      struct fwnode_handle *fwnode)
>> @@ -497,6 +499,9 @@ static int __add_disk(struct device *parent, struct gendisk *disk,
>>   	if (ret)
>>   		goto out_free_ext_minor;
>>
>> +	if (disk->major == LOOP_MAJOR)
>> +		msleep(2500);           // delay 2.5s for all loops
>> +
> 
> Yes, so you need to watch for the uevent to happen, THEN it is safe to
> access the block device.  Doing it before then isn't a good idea :)
> 
> But, if you think this is an issue, do you have a patch that passes your
> testing to fix it?

I just raise it up for some ideas, and this change is
buried into the code refactor and honestly I need to
look into the codebase and related patchsets first.

Currently I have dozens of other development stuffs
on hand, if it's really a regression, I do hope
Christoph or other folks who are familiar with the code
could try to address this.

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h

