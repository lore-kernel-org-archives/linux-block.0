Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187D1A38EB;
	Tue, 10 Sep 2024 22:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726007888; cv=none; b=Dg+H2xu4aiswuNKzrxbTXAk/uPjW56nu7Ak2RCLcsz3wj5WhG8DOLSoElULHZoSNJxkhuD49LebWcPmVnVd0remngHpG5cweaEUc5a9s7HV0qCgMLtqCVAMmkU96oc2Zfzfj/AEmDTgXopSZvVnmZLMH8ObhZBzqejDNDf81F24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726007888; c=relaxed/simple;
	bh=Ff7PpZdGO9Fv+QWUyn4xNEoHuiQVRYRHAUpvn/dpU5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKIk0gvgL3K67q1wZquHWHk2h9DrR0J9zb+T/kQF8m5Pe++WgiRkzcM7KnsasvVt/ckb3ecCSupzA9KaTnjmRsffMfyvRz1iZERxZqphG7N3szTlPdLM42DR0xLaVrGgchbWoCVx5jNG3tX9oq5LdHEwOq+thGiIK5KrOuw5SfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ja5l4yJ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja5l4yJ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5967C4CEC3;
	Tue, 10 Sep 2024 22:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726007888;
	bh=Ff7PpZdGO9Fv+QWUyn4xNEoHuiQVRYRHAUpvn/dpU5s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ja5l4yJ3WiAvPQUH5fmCvNjvtQ0gBjgEnpLTiS294idkY66rb2unLRnYaTgCkwmcG
	 xDsSZg+dBBdg9ejpU5w5yymx4I/eHdP5Fq9+YcuEOEn2PuheEqzyvp81PR1qT+cYXY
	 JYnhgFHGyFAWmFGoalnhS+tlij7/yi7AIhZCb5ymqcJ3hR3LbTVcSKhIdu+2NkQoVh
	 fLFx8GeuYfPIvKtKDlp+Fsa3+Ycg/oeHv5wpBVU3zXC/e/ESRVZ2iL1kTwQzYX5NR7
	 hm7CSP2vnQBrE7e1hWL/MEs48/0M27Ec/PdGw5qYxbsNkz2If6q4MmeDTv4oOgVRjO
	 XbUuBeDT9scUw==
Message-ID: <7f179f49-a57b-45bf-92f0-f577aa0b8565@kernel.org>
Date: Wed, 11 Sep 2024 07:38:05 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] block: Non-NCQ commands will never be executed while
 fio is continuously running
To: Niklas Cassel <cassel@kernel.org>, yangxingui <yangxingui@huawei.com>
Cc: axboe@kernel.dk, John Garry <john.g.garry@oracle.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 James.Bottomley@hansenpartnership.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <eef1e927-c9b2-c61d-7f48-92e65d8b0418@huawei.com>
 <922e3d52-9567-4371-9a43-6d51f716a370@kernel.org>
 <129e1e4b-426f-3d5b-b95c-d386c90cfe06@huawei.com>
 <5b4a15be-1cb2-4477-8f17-b808612d10d5@kernel.org>
 <0e78cce0-3f4c-3ddf-4d5b-ee2b5c8d7e1a@huawei.com>
 <ZuAtLK5jIPEjhXmU@ryzen.lan>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZuAtLK5jIPEjhXmU@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/10/24 20:27, Niklas Cassel wrote:
> On Tue, Sep 10, 2024 at 02:34:06PM +0800, yangxingui wrote:
>>
>>
>> On 2024/9/10 12:45, Damien Le Moal wrote:
>>> On 9/10/24 10:09 AM, yangxingui wrote:
>>>>
>>>>
>>>> On 2024/9/9 21:21, Damien Le Moal wrote:
>>>>> On 9/9/24 22:10, yangxingui wrote:
>>>>>> Hello axboe & John,
>>>>>>
>>>>>> After the driver exposes all HW queues to the block layer, non-NCQ
>>>>>> commands will never be executed while fio is continuously running, such
>>>>>> as a smartctl command.
>>>>>>
>>>>>> The cause of the problem is that other hctx used by the NCQ command is
>>>>>> still active and can continue to issue NCQ commands to the sata disk.
>>>>>> And the pio command keeps retrying in its corresponding hctx because
>>>>>> qc_defer() always returns true.
>>>>>>
>>>>>> hctx0: ncq, pio, ncq
>>>>>> hctx1：ncq, ncq, ...
>>>>>> ...
>>>>>> hctxn: ncq, ncq, ...
>>>>>>
>>>>>> Is there any good solution for this?
>>>>>
>>>>> SATA devices are single queue so how can you have multiple queues ?
>>>>> What adapter are you using ?
>>>>
>>>> In the following patch, we expose the host's 16 hardware queues to the block
>>>> layer. And when connecting to a sata disk, 16 hctx are used.
>>>>
>>>> 8d98416a55eb ("scsi: hisi_sas: Switch v3 hw to MQ")
>>>
>>> OK, so the HBA is a hisi one, using libsas...
>>> What is the device ? An SSD ? and HDD ?
>> Both SATA SSD and SATA HDD have this problem.
>>
>>>
>>> Do you set a block I/O scheduler for the drive, e.g. mq-deadline. If not, does
>>> setting a scheduler resolve the issue ?
>> Currently, the default configuration mq-deadline is used, and the same
>> phenomenon occurs when I try setting it to none. It seems to have nothing to
>> do with the scheduling strategy.
>>
>>>
>>> I do not have any hisi HBA. I use a lot of mpt3sas and mpi3mr HBAs which also
>>> have multiple queues with a shared tagset. Never seen the issue you are
>>> reporting though using HDDs with mq-deadline or bfq as the scheduler.
>> Unlike libsas, as these hosts don't use qc_defer()?
> 
> mpt3sas and mpi3mr do not use any libata code at all, the SCSI to ATA
> Translation (SAT) is done completely by the HBA, so from a Linux
> perspective, we are issuing SCSI commands to the HBA.

Yes, but we still can get requeue happening. Though for a SATA drive, that is
unlikely since the max queue depth is clearly defined, unlike for SAS drives

> We can see that libsas uses ata_std_qc_defer() as its .qc_defer callback:
> https://github.com/torvalds/linux/blob/v6.11-rc7/drivers/scsi/libsas/sas_ata.c#L566

And that may be the issue. More on this below.

> Without considering if it is a good idea or not, it should be possible to
> translate some commands to instead use the "NCQ encapsulated" variant of
> the ATA command that was used in the "ATA-16 passthrough" SCSI command.

That would be way too much work on the user side, and likely open up a can of
device bugs unseen until now.

> To be able to send a non-queued command, there has to be no NCQ commands queued
> on the device. I guess you could implement a scheduler that would be quiescing
> the queue, processes the non-queued command, and then thaw the queue, but that
> would essentially make non-queued commands high priority commands, and could
> thus be used to seriously limit throughput by just sending some non-queued
> commands every now and then :)

Passthrough commands do not go through the scheduler and are submitted directly
to the dispatch queue, generally at the head of it (see blk_mq_insert_request()).

So for a single queue device, even if ata_qc_defer causes a requeue, the
passthrough command ends up back at the top of the dispatch queue. After
repeating this a few times, all in-flight NCQ commands complete and the
passthrough command goes through.

But I feel this is very fragile given that the block layer requeue is done
through a work item, so in parallel to an application submitting IOs. So in
theory, I think that the requeue for the passthrough command could happen forever...

And for a multi-queue setup like with the hisi adapter, that is what is happening.

I do not have any good idea how to fix that yet. We need to find something.
scsi_queue_rq() and the budget/host or device blocked state management may help
with that, or we have a bug there... In any case, I do not think it is a block
layer issue as the block layer knows nothing about NCQ vs non-NCQ.

-- 
Damien Le Moal
Western Digital Research

