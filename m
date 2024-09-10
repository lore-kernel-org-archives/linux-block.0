Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045062AEF1;
	Tue, 10 Sep 2024 01:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725930564; cv=none; b=Uk7BBovweC8YNeQ5Ur9AikIxYDhuc8q6FLCCIuNnFRBC/0rMofEZow7KoIIZ1tCZwkf934I4kyj4c9NBy7vbD4Uf8jhCQD9sOL+3AO+aHvFBYvU9aNUzIPhIZuaV2fNDZwWalddDq6Wif0Fks8xqxK8gQchgaSgPnk4mcKOa4HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725930564; c=relaxed/simple;
	bh=CRVH9LF38aXpxzDBabvtFuZ02DaiE90+UuEHz/xd8XM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MfJlS6qsXXif0Y6XQE0phcGkv7b/FZi9LOFLS+sGXbwoC0nXVbRK2yydiph/YtgMxBli+F+j16aHvgqDjb3sPm24dZWcnnVlM5E4ZET57w3KY12TsG//ts2Leflacs1PTdWu4HfvR4/cTV1kPR5kSJSUesVm3a/WAQeFviGybGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X2lv06crhzyRMs;
	Tue, 10 Sep 2024 09:08:12 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id EE95018010F;
	Tue, 10 Sep 2024 09:09:17 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Sep 2024 09:09:17 +0800
Message-ID: <129e1e4b-426f-3d5b-b95c-d386c90cfe06@huawei.com>
Date: Tue, 10 Sep 2024 09:09:16 +0800
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
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <922e3d52-9567-4371-9a43-6d51f716a370@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepemh100005.china.huawei.com (7.202.181.88) To
 kwepemg100017.china.huawei.com (7.202.181.58)



On 2024/9/9 21:21, Damien Le Moal wrote:
> On 9/9/24 22:10, yangxingui wrote:
>> Hello axboe & John,
>>
>> After the driver exposes all HW queues to the block layer, non-NCQ
>> commands will never be executed while fio is continuously running, such
>> as a smartctl command.
>>
>> The cause of the problem is that other hctx used by the NCQ command is
>> still active and can continue to issue NCQ commands to the sata disk.
>> And the pio command keeps retrying in its corresponding hctx because
>> qc_defer() always returns true.
>>
>> hctx0: ncq, pio, ncq
>> hctx1：ncq, ncq, ...
>> ...
>> hctxn: ncq, ncq, ...
>>
>> Is there any good solution for this?
> 
> SATA devices are single queue so how can you have multiple queues ?
> What adapter are you using ?

In the following patch, we expose the host's 16 hardware queues to the 
block layer. And when connecting to a sata disk, 16 hctx are used.

8d98416a55eb ("scsi: hisi_sas: Switch v3 hw to MQ")

Thanks,
Xingui
.

