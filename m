Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33281B7E9
	for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 03:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709003617; cv=none; b=aqMtJlQa8dmyR5M445yWt6Bm/uVy7EGWym5lvZKeHx/no0br+Mj1ivqd7yfxZ0el2b87j/1nDKCSmYtXMZGa+AfR23JMMP9S1leSuxXXcNR2tpok1+AgqmUHsncRcMF6KHdvEcYe22oaDVAyGjESi/EptlQ/iPfHi6knjwSGap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709003617; c=relaxed/simple;
	bh=ObB1NeaW1Jr7Xs8rF4PgSm6N8niNOE3jFxh68NYUs0M=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Fj4Cs/Q6qKJEjTQq6hI6j7nJHuLcBi002PkURekzEJvlClcNf9bPXN5uJ8UNwgKKux+i9oT6HvbfU1FS7TzcWDRf5h2WNj80DtiTEFr2oSWUclgjS2n+xP1yx9g15eZRax+ZhdATQaMM0REI/W4kNRWrmDcm8zYR44S1UfApMmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TkMxx5lvnz4f3l7B
	for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 11:13:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 056CE1A016E
	for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 11:13:31 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBFYU91lzf8aFQ--.29896S3;
	Tue, 27 Feb 2024 11:13:30 +0800 (CST)
Subject: Re: regression on BLKRRPART ioctl for EIO
To: Saranya Muruganandam <saranyamohan@google.com>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 sashal@kernel.org, Ming Lei <ming.lei@redhat.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <CAP9s-SrvNZROseNkpSL-p-qsO0RT6H+81xX4gg-TV71gQ_UbYA@mail.gmail.com>
 <20240212154411.GA28927@lst.de>
 <CAP9s-Sr3_GVYBv-XObPRC9L27jJoQqX40d8g3gysEmy6VdQS1Q@mail.gmail.com>
 <CAP9s-So3NkfexGOQ2ogt5duaCevbWXb3wJf_zyB2F+eotBmg6w@mail.gmail.com>
 <CAP9s-Sp+H8rBUyAURpKOu9ZuiU_GRTmqc+ksoiJx_xHdfFHqig@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <27bff287-049d-5bbb-2392-fd5f099bed3c@huaweicloud.com>
Date: Tue, 27 Feb 2024 11:13:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAP9s-Sp+H8rBUyAURpKOu9ZuiU_GRTmqc+ksoiJx_xHdfFHqig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBFYU91lzf8aFQ--.29896S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4DuFy8GrW8ZF1rXw1kZrb_yoW5AF4kpF
	WxJ3Z8tw4vy3Z0ya4Dtan7W3WjyasxArWSq3s0qrsI93s0yw1S9r43tFyUua4jvrs7tw1U
	KFWUX3sIqrn5Za7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/02/27 10:38, Saranya Muruganandam 写道:
> Hi,
> Is there advice on how to fix this `blockdev --rereadpt` regression in
> the kernel?
> Would appreciate some advice.
> 
> Thanks,
> Saranya
> 
> 
> On Mon, Feb 12, 2024 at 8:01 PM Saranya Muruganandam
> <saranyamohan@google.com> wrote:
>>
>> When we fail to read from the disk, BLKRRPART used to be able to
>> capture and bubble this up to the caller.
>> It no longer does since we no longer capture the error from bdev_disk_changed.
>>
>> Here is an example with fault-injection:
>>
>> # echo 0 > /sys/kernel/debug/fail_make_request/interval
>> # echo 100 > /sys/kernel/debug/fail_make_request/probability
>> # echo -1 > /sys/kernel/debug/fail_make_request/times
>> # echo 1 > /sys/block/sdc/make-it-fail
>> # blockdev --rereadpt /dev/sdc # no error
>> # echo $?
>> 0 # incorrectly reports success.

I take a look at this, and it's right the root cause is commit
4601b4b130de ("block: reopen the device in blkdev_reread_part") ignore
errors from bdev_disk_changed() now.

I think we can fix this by returning error from bdev_get_whole() if
bdev_disk_changed() failed, this will cause that open disk to fail now,
however, I think this can be acceptable.

Christoph, do you think so? Or we should distinguish ioctl and open
device and only let ioctl to fail.

Thanks,
Kuai


>>
>> Whereas fdisk and sfdisk correctly report the issue :
>>
>> # sfdisk /dev/sdc
>> sfdisk: cannot open /dev/sdc: Input/output error
>> # fdisk /dev/sdc
>>
>> Welcome to fdisk (util-linux 2.28.2).
>> Changes will remain in memory only, until you decide to write them.
>> Be careful before using the write command.
>>
>> fdisk: cannot open /dev/sdc: Input/output error
>>
>> Best,
>> Saranya
>>
>>
>>
>> On Mon, Feb 12, 2024 at 8:00 PM Saranya Muruganandam
>> <saranyamohan@google.com> wrote:
>>>
>>> When we fail to read from the disk, BLKRRPART used to be able to capture and bubble this up to the caller.
>>> It no longer does since we no longer capture the error from bdev_disk_changed.
>>>
>>> Here is an example with fault-injection:
>>>
>>> # echo 0 > /sys/kernel/debug/fail_make_request/interval
>>> # echo 100 > /sys/kernel/debug/fail_make_request/probability
>>> # echo -1 > /sys/kernel/debug/fail_make_request/times
>>> # echo 1 > /sys/block/sdc/make-it-fail
>>> # blockdev --rereadpt /dev/sdc # no error
>>> # echo $?
>>> 0 # incorrectly reports success.
>>>
>>> Whereas fdisk and sfdisk correctly report the issue :
>>>
>>> # sfdisk /dev/sdc
>>> sfdisk: cannot open /dev/sdc: Input/output error
>>> # fdisk /dev/sdc
>>>
>>> Welcome to fdisk (util-linux 2.28.2).
>>> Changes will remain in memory only, until you decide to write them.
>>> Be careful before using the write command.
>>>
>>> fdisk: cannot open /dev/sdc: Input/output error
>>>
>>> Best,
>>> Saranya
>>>
>>> On Mon, Feb 12, 2024 at 7:44 AM Christoph Hellwig <hch@lst.de> wrote:
>>>>
>>>> What scenario are you looking at?
> 
> .
> 

