Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B67B45C18;
	Wed, 11 Sep 2024 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047696; cv=none; b=Ue89ftKa3/EDXYBPAJRkwpHbTzGrHAy3ufWnx5h1Ib6i3djTymRKjG2DQt+bomhubOvE999alNCVhEZfSWafPu4SNvs9kFKXoOY/cho4vaDe5WIpBcE/PMjc61NMah4bOBO2UXlTS7HdmZThg7kjA04j8rc49dNrZOG+6uuvqxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047696; c=relaxed/simple;
	bh=8m3dhEe0+qY5PdgSKzgOiislm4f1BflviWFlGZGg7Us=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XmxN7s2swCq/8GIp3Zl188MInx4h5GLJNlH1476H1vwDITCP4LASBfevP3IBB3hedhj1gme9DE1DY9Og6HageYl34fQZdQcWyOchS9FRhbd55RWDSA42zufuLJ86dlyw0N1GvorhDB7Tf/wazEyR7CPQWtRiHt1Kx6s77FT+vP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4X3bCY0Xxdz1P9Wy;
	Wed, 11 Sep 2024 17:40:25 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id 9267E1800D1;
	Wed, 11 Sep 2024 17:41:31 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Sep 2024 17:41:31 +0800
Message-ID: <efab5585-655b-1e17-8714-803364ead5af@huawei.com>
Date: Wed, 11 Sep 2024 17:41:30 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [bug report] block: Non-NCQ commands will never be executed while
 fio is continuously running
Content-Language: en-CA
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
CC: <axboe@kernel.dk>, John Garry <john.g.garry@oracle.com>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>
References: <eef1e927-c9b2-c61d-7f48-92e65d8b0418@huawei.com>
 <922e3d52-9567-4371-9a43-6d51f716a370@kernel.org>
 <129e1e4b-426f-3d5b-b95c-d386c90cfe06@huawei.com>
 <5b4a15be-1cb2-4477-8f17-b808612d10d5@kernel.org>
 <0e78cce0-3f4c-3ddf-4d5b-ee2b5c8d7e1a@huawei.com>
 <ZuAtLK5jIPEjhXmU@ryzen.lan>
 <7f179f49-a57b-45bf-92f0-f577aa0b8565@kernel.org>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <7f179f49-a57b-45bf-92f0-f577aa0b8565@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepemh500014.china.huawei.com (7.202.181.147) To
 kwepemg100017.china.huawei.com (7.202.181.58)



On 2024/9/11 6:38, Damien Le Moal wrote:
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
> 
Thanks for your reply, can we provide a module parameter to confirm 
whether to expose multiple queues to the upper layer? And let users choose.

Thanks,
Xingui
.
