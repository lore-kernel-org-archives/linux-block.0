Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1EB13A3ED
	for <linux-block@vger.kernel.org>; Wed,  4 Jun 2025 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749050105; cv=none; b=kwf1/hRMWFH/XVP8FEx1v+idjUi9IuZEsydQ1j6X3LszzSxU1D0HUEAn3hskGOva7ipIW8qk2Xg2tnVSIoV0QXWgymULQeU+ZGdA4Ngu8CX36BwdNom28PV+ftB/XOth0B+3R4NXmiqw3e70oHTNiHqO91KqjxIY51yPBu8H8v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749050105; c=relaxed/simple;
	bh=fUl0Nh1xnJ3iMArjRODwLL+XvMqa5GZl+HVdaBu9PdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYTz06cYK5zvPrkww5+WXVySHqESWTmDTnfOuctkMIoa1AN9LmQthKlOCMg9AbAnbqfCULp3gegKwB3vsPbqJC210BkVNu3T21+qPvco+0+M4f3CVGxCXXYqKhFzs5keMsA7sarFnEvDritk0BegIf+fXCsjIAJ59+EPgogu1Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BB13PaOu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BB13PaOu"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554DGArr024765;
	Wed, 4 Jun 2025 15:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v4mNnS
	kwKfFFpFXT4Qg5jnMtcLh6NHOW14A+YR1xWvE=; b=BB13PaOuvmziRoEAi7ccQ8
	r40CZElCucWh/hpY3BGinEmxqS/gBKhOxnajgAcc8eccG3jbtexUkmwQyTCDdDTG
	1Zfg/GCch67t1syZJPiWWqoqGNGn+OrBjlwLcplV4KgvC35Ibk1Yvt5zNux+zpd6
	s0d/cTVbwYTmOWFgqMZc+hnn+Ee1frtedighBWXb+5fJ5OdP62XnWIKkLsWJJ0E5
	h9I7wflzVVZX05hG+9Aw0Hh7DXBTmnSFfsh2ubEJKWKqMYQ4My94nPXvuml+HjqE
	8XisQG3HWEHwfYEGTiRLnUR1Q4vo/pxfw5zaN03gF6zIdGLsoYok1zduAxQIIiqQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyug7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 15:09:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 554C1ajJ024914;
	Wed, 4 Jun 2025 15:09:54 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470dkmg7n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 15:09:54 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 554F9qAa53870942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Jun 2025 15:09:52 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBBFE58055;
	Wed,  4 Jun 2025 15:09:52 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA2EA5804B;
	Wed,  4 Jun 2025 15:09:49 +0000 (GMT)
Received: from [9.67.1.25] (unknown [9.67.1.25])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Jun 2025 15:09:49 +0000 (GMT)
Message-ID: <01e38aba-21ec-4507-8e5f-392838e8b937@linux.ibm.com>
Date: Wed, 4 Jun 2025 20:39:47 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix atomic write limits for stacked devices
To: John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, martin.petersen@oracle.com, axboe@kernel.dk,
        ojaswin@linux.ibm.com, gjoyce@ibm.com
References: <20250603112804.1917861-1-nilay@linux.ibm.com>
 <07cfb3a1-c410-4544-ae4d-5808114e02d7@oracle.com>
 <0747313c-a70d-482f-8ea6-ce2dff772c2c@linux.ibm.com>
 <2f2c8bf5-4341-4247-8a7b-f9ddd1d63422@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <2f2c8bf5-4341-4247-8a7b-f9ddd1d63422@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Pq2TbxM3 c=1 sm=1 tr=0 ts=684061c3 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=Bte2LCF9S3a1aycM5s4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDExMyBTYWx0ZWRfX8dYAN3+dxA9v Wo5zVArXlsIyf4tgk/zFa4N1OjPsD9S5x29TWEz2favpForgyczOa1fXkgM0e67ACFcy1lip7BE NZw2W4gjbISX0U8DIIhSkfGK88Qr3mdYEGevZVF1UvV69htds+ctWcHKvoJOG6cL1qyU0rcWIL+
 PJqX1w2NxA1mMbLX6Xjp3KP01nR6ChGEUV/HK5rM/86dmFroKlotDmGAg0Zq/7foTAMhtmDhXiS Sn5gPUdgcb2gQeWkzsA4o+94ivygCLRLKKJZZhOpMI/knLpnmlYOwkwVfUh732re/yoUemWIkfd 1Z05YNWdLOFtHyCImai+8/RbuBa3Ki1JJw23XJ3O5N2Lz4vTe0uqs8gWnS0q7l02mm4pXbon79V
 +U3XOdsl7RR+y+2dxZz01cF4pbRplz6XBymd7UmVbLABVFpGKk4GHHSc30ANl7exo1drE9/i
X-Proofpoint-GUID: 08sHXlnXEy6-1YAIUztJD0wOUnGHfkSx
X-Proofpoint-ORIG-GUID: 08sHXlnXEy6-1YAIUztJD0wOUnGHfkSx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040113



On 6/4/25 12:59 PM, John Garry wrote:
> On 03/06/2025 16:16, Nilay Shroff wrote:
>>>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>>>> index a000daafbfb4..35c1354dd5ae 100644
>>>> --- a/block/blk-settings.c
>>>> +++ b/block/blk-settings.c
>>>> @@ -598,8 +598,14 @@ static bool blk_stack_atomic_writes_head(struct queue_limits *t,
>>>>            !blk_stack_atomic_writes_boundary_head(t, b))
>>>>            return false;
>>>>    -    if (t->io_min <= SECTOR_SIZE) {
>>>> -        /* No chunk sectors, so use bottom device values directly */
>>>> +    if (t->io_min <= SECTOR_SIZE ||
>>>> +        (!(t->atomic_write_hw_unit_max % t->io_min) &&
>>>> +         !(t->atomic_write_hw_unit_min % t->io_min))) {
>>> So will this now break md raid0/10 or dm stripe when t->io_min is set (> SECTOR_SIZE)? I mean, for md raid0/10 or dm-stripe, we should be taking the chunk size into account there and we now don't seem to be doing so now.
>>>
>> Shouldn't it be work good if we ensure that a bottom device atomic write unit min/max are
>> aligned with the top device chunk sectors then top device could simply copy and use the
>> bottom device atomic write limits directly? 
> 
> You need to be more specific when you say "aligned".
> 
I meant to say bottom device atomic write unit min/max are multiples of top device chunk sectors .

> Consider chunk sectors for md raid0 is 16KB and b->atomic_write_hw_unit_max is 32KB. Then we must reduce t->atomic_write_hw_unit_max to 16KB (so cannot use the value in b->atomic_write_hw_unit_max directly).
Okay, I think I understood your concerns here.

> 
>> Or do we have a special case for raid0/10 and
>> dm-strip which can't handle atomic write if chunk size for stacked device is greater than
>> SECTOR_SIZE?
>>
>> BTW there's a typo in the above change, we should have the above if check written as below
>> (my bad):
>>      if (t->io_min <= SECTOR_SIZE ||
>>          (!(b->atomic_write_hw_unit_max % t->io_min) &&
>>           !(b->atomic_write_hw_unit_min % t->io_min))) {
>>      ...
>>      ...
>>
>>> What is the value of top device io_min and physical_block_size in your example?
>> The NVme disk which I am using has both t->io_min and t->physical_block_size set
>> to 4096.
> 
> I need to test further, but maybe we can change the check to this:
> 
> if (t->io_min <= SECTOR_SIZE || t->io_min == t->physical_block_size) {
>         /* No chunk sectors, so use bottom device values directly */
>         t->atomic_write_hw_unit_max = b->atomic_write_hw_unit_max;
>         t->atomic_write_hw_unit_min = b->atomic_write_hw_unit_min;
>         t->atomic_write_hw_max = b->atomic_write_hw_max;
>         return true;
> }

How about instead adding a new BLK_FEAT_STRIPED flag and then use it here while 
setting atomic limits as shown below:

diff --git a/block/blk-settings.c b/block/blk-settings.c
index a000daafbfb4..bf5d35282d42 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -598,8 +598,14 @@ static bool blk_stack_atomic_writes_head(struct queue_limits *t,
            !blk_stack_atomic_writes_boundary_head(t, b))
                return false;
 
-       if (t->io_min <= SECTOR_SIZE) {
-               /* No chunk sectors, so use bottom device values directly */
+       if (t->io_min <= SECTOR_SIZE || !(t->features & BLK_FEAT_STRIPED)) {
+               /*
+                * If there are no chunk sectors, or if the top device does not
+                * advertise the STRIPED feature (i.e., it's not a striped
+                * device like md-raid0 or dm-stripe), then we directly inherit
+                * the atomic write capabilities from the underlying (bottom)
+                * device.
+                */
                t->atomic_write_hw_unit_max = b->atomic_write_hw_unit_max;
                t->atomic_write_hw_unit_min = b->atomic_write_hw_unit_min;
                t->atomic_write_hw_max = b->atomic_write_hw_max;

I tested the above change with md-raid0 and dm-strip setup and seems to 
be working well. What do you think?

Thanks,
--Nilay


