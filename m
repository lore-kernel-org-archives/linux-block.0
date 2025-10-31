Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F0834C829;
	Fri, 31 Oct 2025 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921665; cv=none; b=kUj92iK4gvq00K1bBNasy5rAP3WSGvYrrHIC3ww7dXVr4Ep9JPQnVfBGukJlz+eN4k1v48guL3cgmFShfIL5Of1iv0WUhHxOoujfkYReJ2rsauYSbGrStRg9O5bdLJ1dOgVirm7GMGbzaIK2wV32/iDLvxS+//kl3Sv/RI0J/zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921665; c=relaxed/simple;
	bh=ViiHpZJMZyDxLPatqQLOhRIrDkTpsGqBdd/rhfNNR9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWOL2Ro22LdCNQMscj+pkyawr9aBC/wqVWoMhOqCvdomfgb2sTCzNjLCk+y19c4UbXtJRUvdVa8P9bkhv6xPYDRUuwqTh/P++m07XFUV2i+6q5rguXRzuIo+Da/s9Wg1kZl6OnWtREABiPDNPtM09WLgUfgmiGfayejXGzIFY1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oM1YfZPE; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oM1YfZPE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761921648; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rRP5U1puhOFNZW6X5aXL2VEcfc6ahJc/GiVy3zRzEXE=;
	b=oM1YfZPESF+GNZ02YR+KiXNB6FL93+FQb/DCxayP9cJqJttwu8UgEiTXxqdaOiRvszSV/T+A/P3jy3qAecMRffIxpJDxX4be5yyVaA6yzqjFbZ1RN6e1CQtaiEXthRri7vRkFknigF6mhyTR8FrjkDPbf4SQJjYcDwUbT752dcY=
Received: from 30.180.79.37(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WrPDjyg_1761921646 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Oct 2025 22:40:47 +0800
Message-ID: <7f3ee1f2-b399-4d31-839e-1c35004ffa4e@linux.alibaba.com>
Date: Fri, 31 Oct 2025 22:40:45 +0800
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
 <2025103145-obedient-paramedic-465d@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2025103145-obedient-paramedic-465d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/10/31 22:31, Greg Kroah-Hartman wrote:
> On Fri, Oct 31, 2025 at 06:12:05PM +0800, Gao Xiang wrote:
>> Hi Greg,
>>
>> On 2025/10/31 17:58, Greg Kroah-Hartman wrote:
>>> On Fri, Oct 31, 2025 at 05:54:10PM +0800, Gao Xiang wrote:
>>>>
>>>>
>>>> On 2025/10/31 17:45, Christoph Hellwig wrote:
>>>>> On Fri, Oct 31, 2025 at 05:36:45PM +0800, Gao Xiang wrote:
>>>>>> Right, sorry yes, disk_uevent(KOBJ_ADD) is in the end.
>>>>>>
>>>>>>>     Do you see that earlier, or do you have
>>>>>>> code busy polling for a node?
>>>>>>
>>>>>> Personally I think it will break many userspace programs
>>>>>> (although I also don't think it's a correct expectation.)
>>>>>
>>>>> We've had this behavior for a few years, and this is the first report
>>>>> I've seen.
>>>>>
>>>>>> After recheck internally, the userspace program logic is:
>>>>>>      - stat /dev/vdX;
>>>>>>      - if exists, mount directly;
>>>>>>      - if non-exists, listen uevent disk_add instead.
>>>>>>
>>>>>> Previously, for devtmpfs blkdev files, such stat/mount
>>>>>> assumption is always valid.
>>>>>
>>>>> That assumption doesn't seem wrong.
>>>>
>>>> ;-) I was thought UNIX mknod doesn't imply the device is
>>>> ready or valid in any case (but dev files in devtmpfs
>>>> might be an exception but I didn't find some formal words)...
>>>> so uevent is clearly a right way, but..
>>>
>>> Yes, anyone can do a mknod and attempt to open a device that isn't
>>> present.
>>>
>>> when devtmpfs creates the device node, it should be there.  Unless it
>>> gets removed, and then added back, so you could race with userspace, but
>>> that's not normal.
>>>
>>>>> But why does the device node
>>>>> get created earlier?  My assumption was that it would only be
>>>>> created by the KOBJ_ADD uevent.  Adding the device model maintainers
>>>>> as my little dig through the core drivers/base/ code doesn't find
>>>>> anything to the contrary, but maybe I don't fully understand it.
>>>>
>>>> AFAIK, device_add() is used to trigger devtmpfs file
>>>> creation, and it can be observed if frequently
>>>> hotpluging device in the VM and mount.  Currently
>>>> I don't have time slot to build an easy reproducer,
>>>> but I think it's a real issue anyway.
>>>
>>> As I say above, that's not normal, and you have to be root to do this,
>>
>> Just thinking out if I am a random reporter, I could
>> report the original symptom now because we face it,
>> but everyone has his own internal business or even
>> with limited kernel ability for example, in any
>> case, there is no such expectation to rush someone
>> into build a clean reproducer.
>>
>> Nevertheless, I will take time on the reproducer, and
>> I think it could just add some artificial delay just
>> after device_add(). I could try anyway, but no rush.
>>
>>> so I don't understand what you are trying to prevent happening?  What is
>>
>> The original report was
>> https://lore.kernel.org/r/43375218-2a80-4a7a-b8bb-465f6419b595@linux.alibaba.com/
> 
> So you see cases where the device node is present, you try to open it,
> but yet there is no real block device behind it at all?

Roughly yes, block devices have a pseudo filesystem, briefly
it registered the block device with device_add() so the
devtmpfs file is visible then but bdev_add() is not called yet
so for example, mounting like bdev_file_open_by_dev() cannot
find this and return ENXIO.

> 
>>> the bug and why is it just showing up now (i.e. what changed to cause
>>> it?)
>>
>> I don't know, I think just because 6.6 is a relatively
>> newer kernel, and most userspace logic has retry logic
>> to cover this up.
> 
> 6.6 has been out for 2 years now, this is a long time in kernel
> development cycles for things to just start showing up now.

I think for most cases devices are added during boot so
it's hard to find, but in the stress hotplug cases, it
can be observed easily honestly.

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h

