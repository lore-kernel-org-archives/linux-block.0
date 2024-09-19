Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A86219DF83;
	Thu, 19 Sep 2024 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726748821; cv=none; b=UV1Lctq7I9y8lOiO3qRSrWohx785DRic3Gzju1dwTq7frFMqb9diuNdANPeneYCoBWQ/dN4Fb9bklvK4ba+7mLh2erySKzSGQAqZG0nmy0OM0cKBu4TN6FT+tv3Oo8+tzRcxgYgBDdjfKfFE6tHFJofWERrD1Cn3M5cQ9JthdcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726748821; c=relaxed/simple;
	bh=80x4nsv2zhGPIBVG5Z54211v7pd2E6x1EBsjZw2zxEs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VEKvN2N1e4s0lzDpi4d4c6FZlEWYpgRwftj/hI1iZYW+rGBErSjSXf+kPp/MzBiFowNYNU3zDHz8ZSRiVgTquIyuFM28H8xCEbKealVpBapz+9gbn2kyHL9OXyM+hcv0Q6yzWaLoZHkgV2qUs/n/iFsuKYwf5rTsWJ/tK5T5zZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X8ZWd542cz4f3lCm;
	Thu, 19 Sep 2024 20:26:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5875E1A018D;
	Thu, 19 Sep 2024 20:26:54 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgD3KseMGOxm7lQMBw--.51560S3;
	Thu, 19 Sep 2024 20:26:54 +0800 (CST)
Subject: Re: [bug report] block: Non-NCQ commands will never be executed while
 fio is continuously running
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 yangxingui <yangxingui@huawei.com>
Cc: axboe@kernel.dk, John Garry <john.g.garry@oracle.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 James.Bottomley@hansenpartnership.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "yukuai (C)" <yukuai3@huawei.com>,
 "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <eef1e927-c9b2-c61d-7f48-92e65d8b0418@huawei.com>
 <922e3d52-9567-4371-9a43-6d51f716a370@kernel.org>
 <129e1e4b-426f-3d5b-b95c-d386c90cfe06@huawei.com>
 <5b4a15be-1cb2-4477-8f17-b808612d10d5@kernel.org>
 <0e78cce0-3f4c-3ddf-4d5b-ee2b5c8d7e1a@huawei.com>
 <ZuAtLK5jIPEjhXmU@ryzen.lan>
 <7f179f49-a57b-45bf-92f0-f577aa0b8565@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <04cf3f31-4bd8-3ce9-867a-41628e56e861@huaweicloud.com>
Date: Thu, 19 Sep 2024 20:26:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7f179f49-a57b-45bf-92f0-f577aa0b8565@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3KseMGOxm7lQMBw--.51560S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWF13XF1DKF15Jw15Ww48JFb_yoWrKryfpr
	WrGF4jkw4kAr4Fywn29w18XFyIqwnxAayqqr15Jr9rXrZ0yFySvr48tr4Y9F97Xrn7CF1j
	q3yjq39xX3WUA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/09/11 6:38, Damien Le Moal 写道:
> On 9/10/24 20:27, Niklas Cassel wrote:
>> On Tue, Sep 10, 2024 at 02:34:06PM +0800, yangxingui wrote:
>>>
>>>
>>> On 2024/9/10 12:45, Damien Le Moal wrote:
>>>> On 9/10/24 10:09 AM, yangxingui wrote:
>>>>>
>>>>>
>>>>> On 2024/9/9 21:21, Damien Le Moal wrote:
>>>>>> On 9/9/24 22:10, yangxingui wrote:
>>>>>>> Hello axboe & John,
>>>>>>>
>>>>>>> After the driver exposes all HW queues to the block layer, non-NCQ
>>>>>>> commands will never be executed while fio is continuously running, such
>>>>>>> as a smartctl command.
>>>>>>>
>>>>>>> The cause of the problem is that other hctx used by the NCQ command is
>>>>>>> still active and can continue to issue NCQ commands to the sata disk.
>>>>>>> And the pio command keeps retrying in its corresponding hctx because
>>>>>>> qc_defer() always returns true.
>>>>>>>
>>>>>>> hctx0: ncq, pio, ncq
>>>>>>> hctx1：ncq, ncq, ...
>>>>>>> ...
>>>>>>> hctxn: ncq, ncq, ...
>>>>>>>
>>>>>>> Is there any good solution for this?
>>>>>>
>>>>>> SATA devices are single queue so how can you have multiple queues ?
>>>>>> What adapter are you using ?
>>>>>
>>>>> In the following patch, we expose the host's 16 hardware queues to the block
>>>>> layer. And when connecting to a sata disk, 16 hctx are used.
>>>>>
>>>>> 8d98416a55eb ("scsi: hisi_sas: Switch v3 hw to MQ")
>>>>
>>>> OK, so the HBA is a hisi one, using libsas...
>>>> What is the device ? An SSD ? and HDD ?
>>> Both SATA SSD and SATA HDD have this problem.
>>>
>>>>
>>>> Do you set a block I/O scheduler for the drive, e.g. mq-deadline. If not, does
>>>> setting a scheduler resolve the issue ?
>>> Currently, the default configuration mq-deadline is used, and the same
>>> phenomenon occurs when I try setting it to none. It seems to have nothing to
>>> do with the scheduling strategy.
>>>
>>>>
>>>> I do not have any hisi HBA. I use a lot of mpt3sas and mpi3mr HBAs which also
>>>> have multiple queues with a shared tagset. Never seen the issue you are
>>>> reporting though using HDDs with mq-deadline or bfq as the scheduler.
>>> Unlike libsas, as these hosts don't use qc_defer()?
>>
>> mpt3sas and mpi3mr do not use any libata code at all, the SCSI to ATA
>> Translation (SAT) is done completely by the HBA, so from a Linux
>> perspective, we are issuing SCSI commands to the HBA.
> 
> Yes, but we still can get requeue happening. Though for a SATA drive, that is
> unlikely since the max queue depth is clearly defined, unlike for SAS drives
> 
>> We can see that libsas uses ata_std_qc_defer() as its .qc_defer callback:
>> https://github.com/torvalds/linux/blob/v6.11-rc7/drivers/scsi/libsas/sas_ata.c#L566
> 
> And that may be the issue. More on this below.
> 
>> Without considering if it is a good idea or not, it should be possible to
>> translate some commands to instead use the "NCQ encapsulated" variant of
>> the ATA command that was used in the "ATA-16 passthrough" SCSI command.
> 
> That would be way too much work on the user side, and likely open up a can of
> device bugs unseen until now.
> 
>> To be able to send a non-queued command, there has to be no NCQ commands queued
>> on the device. I guess you could implement a scheduler that would be quiescing
>> the queue, processes the non-queued command, and then thaw the queue, but that
>> would essentially make non-queued commands high priority commands, and could
>> thus be used to seriously limit throughput by just sending some non-queued
>> commands every now and then :)
> 
> Passthrough commands do not go through the scheduler and are submitted directly
> to the dispatch queue, generally at the head of it (see blk_mq_insert_request()).
> 
> So for a single queue device, even if ata_qc_defer causes a requeue, the
> passthrough command ends up back at the top of the dispatch queue. After
> repeating this a few times, all in-flight NCQ commands complete and the
> passthrough command goes through.
> 
> But I feel this is very fragile given that the block layer requeue is done
> through a work item, so in parallel to an application submitting IOs. So in
> theory, I think that the requeue for the passthrough command could happen forever...
> 
> And for a multi-queue setup like with the hisi adapter, that is what is happening.
> 
> I do not have any good idea how to fix that yet. We need to find something.
> scsi_queue_rq() and the budget/host or device blocked state management may help
> with that, or we have a bug there... In any case, I do not think it is a block
> layer issue as the block layer knows nothing about NCQ vs non-NCQ.

Does libata return a specific value in this case? If so, maybe we can
stop other hctx untill this IO is handled.

For now, I think libata should use single hctx, it just doesn't support
multiple hctx yet.

Thanks,
Kuai

> 

