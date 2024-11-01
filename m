Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6884374D1;
	Fri,  1 Nov 2024 02:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730427443; cv=none; b=AYTDgb1SSwCrnbr8gdP9w2jbCsq++ABHdOdxLiJTkLgQOpw69A+3OHbi1UdWHxTB6f7ftEatAGpE8k+H9534Ks/mnXg6QSXoMCLE58KEL+r3TKV5I2ne74jNse1ePjQxZxeXPT6s9/weGpazpshHhzTw/hcJ1z3K+4mnR3Zfcyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730427443; c=relaxed/simple;
	bh=3IJ5z7vPmpvE6o56uYCMiKRwaOdrOWry1RofWajHgCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K6oAtc0RdoXw5k4XgTuTcs4Ewc+omTTvkf01HfCEhmtih/2g/VgEy31Zrno/MEJtjcehMza1W/pbevQNYtJuQMKgAmyXJ6AH6vOYysGOmnlrUIpqhPERSV5/Ip5P9vVZPUU2yOUG6HUz21fnrDHy8VKvmsQoP9uGOiKHyxcvn4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Xfkym5yXZz1yp1C;
	Fri,  1 Nov 2024 10:17:20 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id C6FCE140136;
	Fri,  1 Nov 2024 10:17:11 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Nov 2024 10:17:11 +0800
Message-ID: <b1a9c348-d3c6-1786-9c51-763cec1f2384@huawei.com>
Date: Fri, 1 Nov 2024 10:17:10 +0800
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
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
CC: Yu Kuai <yukuai1@huaweicloud.com>, <axboe@kernel.dk>, John Garry
	<john.g.garry@oracle.com>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>, "yukuai (C)"
	<yukuai3@huawei.com>, "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <eef1e927-c9b2-c61d-7f48-92e65d8b0418@huawei.com>
 <922e3d52-9567-4371-9a43-6d51f716a370@kernel.org>
 <129e1e4b-426f-3d5b-b95c-d386c90cfe06@huawei.com>
 <5b4a15be-1cb2-4477-8f17-b808612d10d5@kernel.org>
 <0e78cce0-3f4c-3ddf-4d5b-ee2b5c8d7e1a@huawei.com>
 <ZuAtLK5jIPEjhXmU@ryzen.lan>
 <7f179f49-a57b-45bf-92f0-f577aa0b8565@kernel.org>
 <04cf3f31-4bd8-3ce9-867a-41628e56e861@huaweicloud.com>
 <e1ff5ccc-8204-44d8-ba62-84c8bd204fa0@kernel.org> <ZyOQWyyai2JkKyzy@ryzen>
From: yangxingui <yangxingui@huawei.com>
In-Reply-To: <ZyOQWyyai2JkKyzy@ryzen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepemh200015.china.huawei.com (7.202.181.124) To
 kwepemg100017.china.huawei.com (7.202.181.58)



On 2024/10/31 22:12, Niklas Cassel wrote:
> On Thu, Sep 19, 2024 at 04:14:15PM +0200, Damien Le Moal wrote:
>> On 2024/09/19 14:26, Yu Kuai wrote:
>>>
>>> Does libata return a specific value in this case? If so, maybe we can
>>> stop other hctx untill this IO is handled.
>>>
>>> For now, I think libata should use single hctx, it just doesn't support
>>> multiple hctx yet.
>>
>> libata does not care/know about hctx. It only issues commands to ATA devices,
>> which always are single queue. And pure SATA adapters like AHCI are always
>> single queue.
>>
>> The issue at hand can happen only for libsas based SAS HBAs that have multiple
>> command submission queues (with a shared tag set). Commands for the same device
>> may end up being submitted through different queues, and when the submitted
>> commands include a mix of NCQ and non-NCQ commands, the problem happens without
>> libata being able to easily do anything about it, and not possible control
>> possible at the scsi layer either since the commands submitted are SCSI (not yet
>> translated to ATA commands) which do not have any NCQ/non-NCQ exclusion
>> knowledge at all. NCQ is an ATA concept unknown to the scsi and block layer.
>>
>> We (Niklas and I) are trying to find a solution, but that may not be within
>> libata itself. It may need changes to libsas as well. Not sure yet. Still exploring.
> 
> Hello Xingui,
> 
> I send a proposed solution to this problem here:
> https://lore.kernel.org/linux-ide/20241031140731.224589-4-cassel@kernel.org/
> 
> Please test and see if it addresses your problem.
> 
OK, thanks for following this issue and fixing it, we will verify it as 
soon as possible.

Thanks.
Xingui

