Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CBA136358;
	Tue, 10 Sep 2024 06:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725950060; cv=none; b=MGLJkGEeIWVXEkFRUsgRDqrknIVwS+rnwCHozNUJemZFBTQSipRHXQbIGtvznfFzoXhzQEx2Qdu4XLLa/AhERD+ePdW1yePZtM+z3JC9fyJWyQcmRJ9WslRNg6D7G5ZlujE+OW7th67ilcHgIrXs4zTSPk+aLsRjrKUWbV3JWOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725950060; c=relaxed/simple;
	bh=5Jxbv6JeXuC4PjVEMTYtdG6lZie32lIr5sye8UIQULA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PtbF/gFKZqw6bHToY5ggdlEWOQEEBfjtdtwdsBTIQVotm2/r7bJWwgy1hc0HAVV2xK4j+mGRKF93hJzbh6yCUQhqF+7yHoK+4FvAKAI/2r4nf/F5Vw000B5sWA87AjtGxIbu12RfxkvKkYF4gtuA36ObDESScxdM98Q2xnbrJCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X2v6z05xzz20ndx;
	Tue, 10 Sep 2024 14:34:03 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id AAF281401F4;
	Tue, 10 Sep 2024 14:34:07 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Sep 2024 14:34:07 +0800
Message-ID: <0e78cce0-3f4c-3ddf-4d5b-ee2b5c8d7e1a@huawei.com>
Date: Tue, 10 Sep 2024 14:34:06 +0800
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
To: Damien Le Moal <dlemoal@kernel.org>, <axboe@kernel.dk>, John Garry
	<john.g.garry@oracle.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>
References: <eef1e927-c9b2-c61d-7f48-92e65d8b0418@huawei.com>
 <922e3d52-9567-4371-9a43-6d51f716a370@kernel.org>
 <129e1e4b-426f-3d5b-b95c-d386c90cfe06@huawei.com>
 <5b4a15be-1cb2-4477-8f17-b808612d10d5@kernel.org>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <5b4a15be-1cb2-4477-8f17-b808612d10d5@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepemh200001.china.huawei.com (7.202.181.106) To
 kwepemg100017.china.huawei.com (7.202.181.58)



On 2024/9/10 12:45, Damien Le Moal wrote:
> On 9/10/24 10:09 AM, yangxingui wrote:
>>
>>
>> On 2024/9/9 21:21, Damien Le Moal wrote:
>>> On 9/9/24 22:10, yangxingui wrote:
>>>> Hello axboe & John,
>>>>
>>>> After the driver exposes all HW queues to the block layer, non-NCQ
>>>> commands will never be executed while fio is continuously running, such
>>>> as a smartctl command.
>>>>
>>>> The cause of the problem is that other hctx used by the NCQ command is
>>>> still active and can continue to issue NCQ commands to the sata disk.
>>>> And the pio command keeps retrying in its corresponding hctx because
>>>> qc_defer() always returns true.
>>>>
>>>> hctx0: ncq, pio, ncq
>>>> hctx1：ncq, ncq, ...
>>>> ...
>>>> hctxn: ncq, ncq, ...
>>>>
>>>> Is there any good solution for this?
>>>
>>> SATA devices are single queue so how can you have multiple queues ?
>>> What adapter are you using ?
>>
>> In the following patch, we expose the host's 16 hardware queues to the block
>> layer. And when connecting to a sata disk, 16 hctx are used.
>>
>> 8d98416a55eb ("scsi: hisi_sas: Switch v3 hw to MQ")
> 
> OK, so the HBA is a hisi one, using libsas...
> What is the device ? An SSD ? and HDD ?
Both SATA SSD and SATA HDD have this problem.

> 
> Do you set a block I/O scheduler for the drive, e.g. mq-deadline. If not, does
> setting a scheduler resolve the issue ?
Currently, the default configuration mq-deadline is used, and the same 
phenomenon occurs when I try setting it to none. It seems to have 
nothing to do with the scheduling strategy.

> 
> I do not have any hisi HBA. I use a lot of mpt3sas and mpi3mr HBAs which also
> have multiple queues with a shared tagset. Never seen the issue you are
> reporting though using HDDs with mq-deadline or bfq as the scheduler.
Unlike libsas, as these hosts don't use qc_defer()?

Thanks,
Xingui
.

