Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC4D21C178
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753174178; cv=none; b=iFIxrRxSDFFDLSvLORmsJhc4R1LC+E/FLFXv9orWw4SOjshXqnA1Nkf7DuBLLMUDdMbRsm6SYrh8ncZG7sIkDd+Rl5/y21yTaNJSA+g0C113jTC2QG8cWiHrl1SGZk8b0G2iKfTLI7kaQ8+4GYUj3zBywHQ7BX4X4rpMwG24zY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753174178; c=relaxed/simple;
	bh=deye/iHbaU7ETpieMdcx6vD4VwEGBwZ16KUonzpq69k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDhOEF2XGbvOJQ0T0kteKfYW5HN8TvPXkx12Ty6mdaNYghN0cPz0YH5pk8J5dUisuG9hSaicoAaJ2lt1Xa8ZEontBicVhAl/Bradp/9Gccv4IfdwuGJt/LXx7RsHBo8U5EoNFMEo7EdTPrCkcGlkJcNRWrdxPiFg1ka0xVh579Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iKTiQ7Cb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iKTiQ7Cb"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5PoxC008027;
	Tue, 22 Jul 2025 08:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6Ak7EJ
	01izZGMm+JgeG+0rfNb4WnkPnD+2fY0Tqdyrs=; b=iKTiQ7CbGpkLdhtnI6aZKE
	bx9gzisJCi1mA2g9TJp/qKtloivlePnjXGM8sbwuvxkoDp14sQuOD79urvrEdP98
	NJxmEDyWtrf7K6ryuyPlWIqFGYxjjkDmZokFegq+R35jEysZmJMZ9z5ih6Vo7aKU
	2R6LfhFGHX3mMa1HyJHHsXPSvPGZa3c5NiEztVMzKHM3UhKMoG0tTNC/G+askhcL
	lrt3UYVjyzHLr4IdGNbHMRhT6StuJeqv9YVonHzxhvnjsMeIBsjd863wMaV4uh+p
	Et7CiGrj/QPmiq6UfbTapiCV1/v0guNHVRndHBT8n8St03kyqtvewqqdbyuahP5g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805hfwac3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 08:49:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56M6cMPU014296;
	Tue, 22 Jul 2025 08:49:03 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480ppp22yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 08:49:03 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56M8n3Xl64422384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 08:49:03 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA7BA5805A;
	Tue, 22 Jul 2025 08:49:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE9FA58051;
	Tue, 22 Jul 2025 08:48:59 +0000 (GMT)
Received: from [9.109.203.242] (unknown [9.109.203.242])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Jul 2025 08:48:59 +0000 (GMT)
Message-ID: <8aabdf01-5df9-48d3-a7f9-ab8a78120541@linux.ibm.com>
Date: Tue, 22 Jul 2025 14:18:58 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/2] null_blk: fix set->driver_data while setting up
 tagset
To: Yu Kuai <yukuai1@huaweicloud.com>, Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Cc: hch@lst.de, hare@suse.de, ming.lei@redhat.com, axboe@kernel.dk,
        johannes.thumshirn@wdc.com, gjoyce@ibm.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20250721140450.1030511-1-nilay@linux.ibm.com>
 <20250721140450.1030511-3-nilay@linux.ibm.com>
 <1cadba31-8e73-4693-9ea5-b5fce8b69ba9@kernel.org>
 <5e926df5-0a6f-6ebb-8078-98f21dd10eef@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <5e926df5-0a6f-6ebb-8078-98f21dd10eef@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA3MSBTYWx0ZWRfXxkDHwasl78oP
 atIm9YSGmrTMLqh2k0rg8QWwBiw17T7q/1eN7fOW2rk0PYDlGZJvNL0UtqWom7VmDy/TRFHnPrt
 mhlhq1nsE3My1STzkE2viCZSbyoUhxGejnxB+L3RoXUSJmsJFOyM7D3go2muOQVtH7sWYPAA8Q0
 hhwKyp8kPTTbPX9unfl+g9VyyZuXNlWMxF+TjZETrE2zw+kAeT9Cjg0Xl2qNcvxgS1q/mDdQtZC
 +tz0+gCiPXTkIpf6hj4e2GhDiCiQ2q9hURlckIA9CdVXvmgTdnQy+apG59tsk4bhW2ytc7PDj++
 2SdvolCFW+4eWVPmfs6juRj+h7Pfz2T6QT1cPhT2OIdwYOTjCqfMwQOWn5D6Na2/aScrdLSoQLA
 U0NYowYj1qM/FpSR6jBtve93rXtEdsvqJtV+/Syrxv/ghmaUu/5pETjEhBfGxw52e9wAQCBn
X-Proofpoint-GUID: B7v-tEemcZrSDW27kTYox-DJ4mQTY0wE
X-Proofpoint-ORIG-GUID: B7v-tEemcZrSDW27kTYox-DJ4mQTY0wE
X-Authority-Analysis: v=2.4 cv=X9RSKHTe c=1 sm=1 tr=0 ts=687f5080 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=6hz1Lxi9_UaovGwRkSsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220071



On 7/22/25 8:08 AM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/07/22 9:07, Damien Le Moal 写道:
>> On 7/21/25 11:04 PM, Nilay Shroff wrote:
>>> When setting up a null block device, we initialize a tagset that
>>> includes a driver_data field—typically used by block drivers to
>>> store a pointer to driver-specific data. In the case of null_blk,
>>> this should point to the struct nullb instance.
>>>
>>> However, due to recent tagset refactoring in the null_blk driver, we
>>> missed initializing driver_data when creating a shared tagset. As a
>>> result, software queues (ctx) fail to map correctly to new hardware
>>> queues (hctx). For example, increasing the number of submit queues
>>> triggers an nr_hw_queues update, which invokes null_map_queues() to
>>> remap queues. Since set->driver_data is unset, null_map_queues()
>>> fails to map any ctx to the new hctxs, leading to hctx->nr_ctx == 0,
>>> effectively making the hardware queues unusable for I/O.
> 
> I don't get it, for the case shared tagset, g_submit_queues and
> g_poll_queues should be used, how can you increasing submit_queues?
>>>
>>> This patch fixes the issue by ensuring that set->driver_data is properly
>>> initialized to point to the struct nullb during tagset setup.
>>>
>>> Fixes: 72ca28765fc4 ("null_blk: refactor tag_set setup")
>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>> ---
>>>   drivers/block/null_blk/main.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>>> index aa163ae9b2aa..fbae0427263d 100644
>>> --- a/drivers/block/null_blk/main.c
>>> +++ b/drivers/block/null_blk/main.c
>>> @@ -1856,6 +1856,7 @@ static int null_setup_tagset(struct nullb *nullb)
>>>   {
>>>       if (nullb->dev->shared_tags) {
>>>           nullb->tag_set = &tag_set;
>>> +        nullb->tag_set->driver_data = nullb;
>>
>> This looks better, but in the end, why is this even needed ? Since this is a
>> shared tagset, multiple nullb devices can use that same tagset, so setting the
>> driver_data pointer to this device only seems incorrect.
> 
> Yes this looks incorrect, if there are multiple null_dev shared one
> tag_set and blk_mq_update_nr_hw_queues() is triggered, all null_dev will
> end up accesing the same null_dev in the map_queues callback.
>>
>> Checking the code, the only function that makes use of this pointer is
>> null_map_queues(), which correctly test for private_data being NULL.
>>
>> So why do we need this ? Isn't your patch 1/2 enough to fix the crash you got ?
> 
> Same question :)

I have responded to Damien in another thread. Sorry I missed to add you in that thread... 
You may refer the thread here: https://lore.kernel.org/all/3c33c551-b707-4fd2-bd52-418ff3bc547c@linux.ibm.com/

Thanks,
--Nilay
