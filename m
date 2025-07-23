Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5311DF725
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 06:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253531; cv=none; b=r0gErp8vA6qA7gt6YjoT3ck8WAgj0/r5Uyf0sWXUR7KN4d06JiutbCPFZMUzXue+qCSZ/8e7LfGbL/rNPJhH4hKi+bL0s5X9TrFHKnuPsy+Zbb5VF8866n+qVMo9CwAcEzq7pbFGvc34RdBlLJ3CR9Cy4czc1TDiOT8wT3mn8N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253531; c=relaxed/simple;
	bh=TyI+JLJrKRUyuriPS/ho0UOqBm0HTVAVXgOY5oqeZpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WuF+MYcLgvJjGya+E10CAxESy97E6lNpktXdYMFKMoXQr7bllgHthQ8Pxr/kcdC7Quy5T9L693rTj5/N7TzfbmiJ4jTDyxwmclQhw3bZ0BR40F4+R3eksv0TWtbeAutLLFafyUTTwJEFYtbmzR5xX7rLU8/DozuwOJgBLMivWpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qNcUmgZU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qNcUmgZU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N5lJj6015973;
	Wed, 23 Jul 2025 06:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bAkpfc
	UKc/YNEr6AQIRXSZE/Vsv2cXHvgAjrVeFUh8E=; b=qNcUmgZU4uSBzBabb6HDRk
	iI3GOKqI6GAkQZdJqXAnq1Yxlv/fn7wrYG3unMihf1H7wwhZ1XZ6MGdC92v18Wwx
	HKHk10UKlvh+E7RflPK5XndL4wojbT9x7umBaHYOWm7rB5JvohWyHJZbmAZgk5AV
	HDFE2eZ95XUqUFXH3jZDNhbM7OdX5+TmuOcvEm2tpkaADw9jIHts2ky+MBmxl2n6
	PVcdGEUr/a1ku/k8/MrCZwhDVFqewP64o/k355LCxFmbu9sfOtOg8sVT6C0lkpH3
	bur/DBqDhUqVsvohFI7rXE/FUgt0+BmXz6SgjKaGJ7M8GkC3vx9hAVLzOrKy285g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff63286-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 06:51:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56N2j4Ql012404;
	Wed, 23 Jul 2025 06:51:45 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480p306syu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 06:51:45 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56N6pi3264815598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 06:51:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5A85580C8;
	Wed, 23 Jul 2025 06:51:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B656E580D2;
	Wed, 23 Jul 2025 06:51:40 +0000 (GMT)
Received: from [9.43.41.196] (unknown [9.43.41.196])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Jul 2025 06:51:40 +0000 (GMT)
Message-ID: <70edfc72-cd40-4d69-91cb-6a8b4742fe45@linux.ibm.com>
Date: Wed, 23 Jul 2025 12:21:38 +0530
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
 <3c33c551-b707-4fd2-bd52-418ff3bc547c@linux.ibm.com>
 <ffa76a0b-3067-129c-ead4-f1e5f0a65357@huaweicloud.com>
 <0687504a-ea0e-497c-b36e-a942520f7177@kernel.org>
 <8bb4fb9e-e79b-cc92-264f-ae2914093a64@huaweicloud.com>
 <3d591f18-b914-4df6-a46c-2644b6a2ce36@linux.ibm.com>
 <a1c888d6-e913-b225-0033-610e9794c297@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <a1c888d6-e913-b225-0033-610e9794c297@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA1NSBTYWx0ZWRfXziqds+ebUhh2
 dhosMD9SOfpceIy/4gmin8WSE8O3z/viwqJj+QxIT9Ntf9HUmllEVwG1qKY9iHmtCFK4TSRIpj/
 ssNEmSiBJPKUB30J3R37WSjTA97jXmiIGaWH+ppCZIxIadLCoxK0517GU7sDu2H0AvmJmIcwLLu
 /m6zXD5goNsReK2d0JMDEJde4818cb20Xbg1UlGQ729RBjRX1jRxn0dIn3MndhrFnxZ/kp12dwB
 uv37UmfJWvWN/f4tv6NhKqmY45P8lKCwxE7/z+RRl/A8C/zEDlnRlLkvaTh7QmF4fJyh4icYkxA
 D/bRhl3cyI8ek3pii03FBQ0aoAUcZQZn3JeTlsJkLf4zg0vj6C3c5LMe53rB0ZmQIUMyVEM182B
 fCx2mbb/U/LWb4uPUFW/o8+1g7Wz3xfosYo/YL2OGo/dptTWgTQfpZaSKsWGRKYRaM7E62Dx
X-Proofpoint-ORIG-GUID: J5JZqFpdOPVzuTuSuPD3jZidCBnKE8Uk
X-Proofpoint-GUID: J5JZqFpdOPVzuTuSuPD3jZidCBnKE8Uk
X-Authority-Analysis: v=2.4 cv=TtbmhCXh c=1 sm=1 tr=0 ts=68808682 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=jdM703KjvA6To6KMZTgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230055



On 7/23/25 6:11 AM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/07/22 18:19, Nilay Shroff 写道:
>>
>>
>> On 7/22/25 2:54 PM, Yu Kuai wrote:
>>>>>>> So why do we need this ? Isn't your patch 1/2 enough to fix the crash you got ?
>>>>>>>
>>>>>> I think you were right — the first patch alone is sufficient to prevent the
>>>>>> crash.
>>>>>> Initially, I thought the second patch might also be necessary, especially for
>>>>>> the
>>>>>> scenario where the user increases the number of submit_queues for a null_blk
>>>>>> device.
>>>>>> While the block layer does create a new hardware queue (hctx) in response to
>>>>>> such
>>>>>> an update, null_blk (null_map_queues()) does not map any software queue (ctx)
>>>>>> to it.
>>>>>> As a result, the newly added hctx remains unused for I/O.
>>>>>>
>>>>>> Given this behavior, I believe we should not allow users to update submit_queues
>>>>>> on a null_blk device if it is using a shared tagset. Currently, the code allows
>>>>>> this update, but it’s misleading since the change has no actual effect.
>>>>>>
>>>>>> Would it make sense to explicitly prevent updating submit_queues in this case?
>>>>>> That would align the interface with the actual behavior and avoid potential
>>>>>> confusion and also saves us allocating memory for hctx which remains unused.
>>>>>> Maybe we should have this check, in nullb_update_nr_hw_queues():
>>>>>>
>>>>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>>>>>> index fbae0427263d..aed2a6904db1 100644
>>>>>> --- a/drivers/block/null_blk/main.c
>>>>>> +++ b/drivers/block/null_blk/main.c
>>>>>> @@ -388,6 +388,12 @@ static int nullb_update_nr_hw_queues(struct nullb_device
>>>>>> *dev,
>>>>>>            if (!submit_queues)
>>>>>>                    return -EINVAL;
>>>>>>     +       /*
>>>>>> +        * Cannot update queues with shared tagset.
>>>>>> +        */
>>>>>> +       if (dev->shared_tags)
>>>>>> +               return -EINVAL;
>>>>>> +
>>>>>>            /*
>>>>>>             * Make sure that null_init_hctx() does not access nullb->queues[] past
>>>>>>             * the end of that array.
>>>>>>
>>>>>> If the above change looks good, maybe I can update second patch with
>>>>>> the above change.
>>>>>
>>>>> I'm good with this change, howerver, with a quick look it seems lots of
>>>>> configfs api are broken for shared_tags. For example:
>>>>>
>>>>> If we switch shared_tags from 0 to 1, and then read submit_queues,
>>>>> looks like it's the old dev->submit_queues instead of g_submit_queues;
>>>>
>>>> g_submit_queues is used as the initial value for dev->submit_queues. See
>>>> nullb_alloc_dev(). So if we prevent changing dev->submit_queues with configfs,
>>>> we'll get whatever g_submit_queues was set on modprobe for the shared tagset.
>>>
>>> I know that, I mean in the case shared_tags is 0 and set submit_queues
>>> different from g_submit_queues, and then *switch shared_tags from 0 to
>>> 1*, user will read wrong submit_queues :)
>>>
>> I think I got what you were referring here. So in addition to the above change
>> we also need to validate the nullb config before we power on nullb device. And
>> we can add that in null_validate_conf():
>>
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>> index aa163ae9b2aa..1762dc541a17 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -1893,6 +1893,10 @@ static int null_validate_conf(struct nullb_device *dev)
>>                  dev->submit_queues = 1;
>>          dev->prev_submit_queues = dev->submit_queues;
>>   +       if (dev->shared_tags)
>> +               if (dev->submit_queues > g_submit_queues)
>> +                       dev->submit_queues = g_submit_queues;
> 
> Perhaps:
> 
>     if (dev->shared_tags) {
>         dev->submit_queues = g_submit_queues;
>         dev->poll_queues = g_poll_queues;
>     } else if (dev->poll_queues > g_poll_queues) {
>         dev->poll_queues = g_poll_queues;
>     }
> 
Okay this makes sense. So for the shared tagset, we'd 
always reset the submit and poll queues value to the 
respective values set while loading the module. And for 
the non-shared tagset, we'd clamp poll_queues when its 
value exceeds the value initialized during module load
time. I will incorporate this in the next patch.

Thanks,
--Nilay
