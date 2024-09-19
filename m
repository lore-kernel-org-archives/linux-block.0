Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916E719CCF4;
	Thu, 19 Sep 2024 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755260; cv=none; b=S2wZ7GOMVdctHAZTnZVju+mr8Yx9E8PAlectJY8LuSoxsyquRat7IBNoCvQhnzofuLPjxJI+F4IV7j8+RpCF4tB1wnFJNMe0QdISZukJje9JARyQ+NpThve/LVrCt6mNPKZPHiayPSfha7ovLoy3M2zvyojTk/glIXJbrrx5TwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755260; c=relaxed/simple;
	bh=OObN1ezUfyw7gZE5+/VFuKegN7OVO+qiLPLvdUWuUF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NolL8Tk4WWHYybFWHMZIv5w7QK5ypR15nB/TBla22dTABafMzZZXoQR5Mn3gOv9/71+Ns2KL4Rsc19lPbCLuehtOL6SHL6ntLUw1cL9bJY2a4dzB6Qd4jcjflpBEYabWGae6jHaWnDKVIJw/8MS1FFu8bwq0GomTaArNGhVgXr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojYAINq9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojYAINq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA55C4CEC4;
	Thu, 19 Sep 2024 14:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726755260;
	bh=OObN1ezUfyw7gZE5+/VFuKegN7OVO+qiLPLvdUWuUF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ojYAINq9iWvP5qV7U2jAMDk0x4Gs2YRSVZFvdqtYiZpG3YIbpSsCzC1G4GXRRpY2D
	 d21n7i45AGV1Krm7lblx+0o9uH5wWQk3rfHf2/Vl14oj+GbpaQep1q9ZZRJUpPrgw0
	 Eas7eVAXbtM8PzCIAQB9qoPRrpP2HFmfzP7covX2fzAAoShrLZLRtxDvUsPMOleoeH
	 IveKSmJo+RKajnA51afsqq8GFx6ftKwOHnzL4s0X/AYvv9/Tk9Lwq37I2oASQikabf
	 +0epZ0iAt0knNx7e1t0FB6qzw0PnFK551nBofcYv3uqMM7VEeS3bko/iwLXSOBu+a9
	 I19Dvw8N9RpVQ==
Message-ID: <e1ff5ccc-8204-44d8-ba62-84c8bd204fa0@kernel.org>
Date: Thu, 19 Sep 2024 16:14:15 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] block: Non-NCQ commands will never be executed while
 fio is continuously running
To: Yu Kuai <yukuai1@huaweicloud.com>, Niklas Cassel <cassel@kernel.org>,
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
 <04cf3f31-4bd8-3ce9-867a-41628e56e861@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <04cf3f31-4bd8-3ce9-867a-41628e56e861@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/09/19 14:26, Yu Kuai wrote:
> Hi,
> 
> 在 2024/09/11 6:38, Damien Le Moal 写道:
>> On 9/10/24 20:27, Niklas Cassel wrote:
>>> On Tue, Sep 10, 2024 at 02:34:06PM +0800, yangxingui wrote:
>>>>
>>>>
>>>> On 2024/9/10 12:45, Damien Le Moal wrote:
>>>>> On 9/10/24 10:09 AM, yangxingui wrote:
>>>>>>
>>>>>>
>>>>>> On 2024/9/9 21:21, Damien Le Moal wrote:
>>>>>>> On 9/9/24 22:10, yangxingui wrote:
>>>>>>>> Hello axboe & John,
>>>>>>>>
>>>>>>>> After the driver exposes all HW queues to the block layer, non-NCQ
>>>>>>>> commands will never be executed while fio is continuously running, such
>>>>>>>> as a smartctl command.
>>>>>>>>
>>>>>>>> The cause of the problem is that other hctx used by the NCQ command is
>>>>>>>> still active and can continue to issue NCQ commands to the sata disk.
>>>>>>>> And the pio command keeps retrying in its corresponding hctx because
>>>>>>>> qc_defer() always returns true.
>>>>>>>>
>>>>>>>> hctx0: ncq, pio, ncq
>>>>>>>> hctx1：ncq, ncq, ...
>>>>>>>> ...
>>>>>>>> hctxn: ncq, ncq, ...
>>>>>>>>
>>>>>>>> Is there any good solution for this?
>>>>>>>
>>>>>>> SATA devices are single queue so how can you have multiple queues ?
>>>>>>> What adapter are you using ?
>>>>>>
>>>>>> In the following patch, we expose the host's 16 hardware queues to the block
>>>>>> layer. And when connecting to a sata disk, 16 hctx are used.
>>>>>>
>>>>>> 8d98416a55eb ("scsi: hisi_sas: Switch v3 hw to MQ")
>>>>>
>>>>> OK, so the HBA is a hisi one, using libsas...
>>>>> What is the device ? An SSD ? and HDD ?
>>>> Both SATA SSD and SATA HDD have this problem.
>>>>
>>>>>
>>>>> Do you set a block I/O scheduler for the drive, e.g. mq-deadline. If not, does
>>>>> setting a scheduler resolve the issue ?
>>>> Currently, the default configuration mq-deadline is used, and the same
>>>> phenomenon occurs when I try setting it to none. It seems to have nothing to
>>>> do with the scheduling strategy.
>>>>
>>>>>
>>>>> I do not have any hisi HBA. I use a lot of mpt3sas and mpi3mr HBAs which also
>>>>> have multiple queues with a shared tagset. Never seen the issue you are
>>>>> reporting though using HDDs with mq-deadline or bfq as the scheduler.
>>>> Unlike libsas, as these hosts don't use qc_defer()?
>>>
>>> mpt3sas and mpi3mr do not use any libata code at all, the SCSI to ATA
>>> Translation (SAT) is done completely by the HBA, so from a Linux
>>> perspective, we are issuing SCSI commands to the HBA.
>>
>> Yes, but we still can get requeue happening. Though for a SATA drive, that is
>> unlikely since the max queue depth is clearly defined, unlike for SAS drives
>>
>>> We can see that libsas uses ata_std_qc_defer() as its .qc_defer callback:
>>> https://github.com/torvalds/linux/blob/v6.11-rc7/drivers/scsi/libsas/sas_ata.c#L566
>>
>> And that may be the issue. More on this below.
>>
>>> Without considering if it is a good idea or not, it should be possible to
>>> translate some commands to instead use the "NCQ encapsulated" variant of
>>> the ATA command that was used in the "ATA-16 passthrough" SCSI command.
>>
>> That would be way too much work on the user side, and likely open up a can of
>> device bugs unseen until now.
>>
>>> To be able to send a non-queued command, there has to be no NCQ commands queued
>>> on the device. I guess you could implement a scheduler that would be quiescing
>>> the queue, processes the non-queued command, and then thaw the queue, but that
>>> would essentially make non-queued commands high priority commands, and could
>>> thus be used to seriously limit throughput by just sending some non-queued
>>> commands every now and then :)
>>
>> Passthrough commands do not go through the scheduler and are submitted directly
>> to the dispatch queue, generally at the head of it (see blk_mq_insert_request()).
>>
>> So for a single queue device, even if ata_qc_defer causes a requeue, the
>> passthrough command ends up back at the top of the dispatch queue. After
>> repeating this a few times, all in-flight NCQ commands complete and the
>> passthrough command goes through.
>>
>> But I feel this is very fragile given that the block layer requeue is done
>> through a work item, so in parallel to an application submitting IOs. So in
>> theory, I think that the requeue for the passthrough command could happen forever...
>>
>> And for a multi-queue setup like with the hisi adapter, that is what is happening.
>>
>> I do not have any good idea how to fix that yet. We need to find something.
>> scsi_queue_rq() and the budget/host or device blocked state management may help
>> with that, or we have a bug there... In any case, I do not think it is a block
>> layer issue as the block layer knows nothing about NCQ vs non-NCQ.
> 
> Does libata return a specific value in this case? If so, maybe we can
> stop other hctx untill this IO is handled.
> 
> For now, I think libata should use single hctx, it just doesn't support
> multiple hctx yet.

libata does not care/know about hctx. It only issues commands to ATA devices,
which always are single queue. And pure SATA adapters like AHCI are always
single queue.

The issue at hand can happen only for libsas based SAS HBAs that have multiple
command submission queues (with a shared tag set). Commands for the same device
may end up being submitted through different queues, and when the submitted
commands include a mix of NCQ and non-NCQ commands, the problem happens without
libata being able to easily do anything about it, and not possible control
possible at the scsi layer either since the commands submitted are SCSI (not yet
translated to ATA commands) which do not have any NCQ/non-NCQ exclusion
knowledge at all. NCQ is an ATA concept unknown to the scsi and block layer.

We (Niklas and I) are trying to find a solution, but that may not be within
libata itself. It may need changes to libsas as well. Not sure yet. Still exploring.

> 
> Thanks,
> Kuai
> 
>>
> 

-- 
Damien Le Moal
Western Digital Research

