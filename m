Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7E022DF86
	for <linux-block@vger.kernel.org>; Wed, 23 Jul 2025 11:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268764; cv=none; b=OjbHlm0FL1Hxz+JL1FBQNa7Xxpps/DZm0sM+nljVFtmhQmBmLGi3IwQNiXFLz3cSx6Hf+Lh7YoqSM0aVqjvgoVFZVW/u4zVmOqT+iOR6CKTzWVI9dGq3a5H3hLILOZUFoW4srPSRJJ4pV4jOqoqbZYERZ8ECTfc8KkaVNotmA3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268764; c=relaxed/simple;
	bh=bCcwCKd1rc8KetZU7TL6kiDUls0H0gZS6lDy+JyYwHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2DyPK6E2VQFVCF1teL2AHEbFUNM+cUJHixQl/bvdgsS9kKMZ43ww+aOgi6EtNz/WeYOt+tok4sP/ct/O4jzaPM59+EsAbVtZ4ZD1qIYjRGA8lzhWmtFFpEBeQV5Vp2I30udaCONm6LLM35n6nFriPBIConOiWpnQIydzJLVch4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Edg1SL2n; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Edg1SL2n"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N50vIg005394;
	Wed, 23 Jul 2025 11:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GKsRQU
	Jcra76SvEAl/rv3kkVqDulESFt0P37dc1I5l4=; b=Edg1SL2np1lOYOXqpUtGEq
	x5EBmCcQUGB4OW6zimuZL/s6xXzSlSBlYDLGvM4R838J79rwEUVVORjitmD6Czgn
	Zu+O7XjqaKR2KNu4N1XQ4zM4/vApz0z8ognkHpDR+Ge1yWTdPuQd4eC1KDaIySc9
	b5Dm+8Ox02OPdwfyd0gf8JWvR3U9cYpLE9RFBrExx12bz9c3XQPp1AX5VIrUetk0
	QepzSDSoUW8EbsT/0WjiJaLFWUbxM4fxU7SqogZXtrlG3dDkUn06UUc9SIkoOq8b
	p2pb1RGaF7NVonL9O6Pbblqkh6j158cpS8k8IfcGYfCtk1tgVmzKs4nkew5rpb8A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff4v94e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 11:05:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56N8Bdra014330;
	Wed, 23 Jul 2025 11:05:40 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480ppp7ghr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 11:05:40 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56NB5X9M27918850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 11:05:33 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97DBB58162;
	Wed, 23 Jul 2025 11:05:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8BCB58160;
	Wed, 23 Jul 2025 11:05:35 +0000 (GMT)
Received: from [9.43.41.196] (unknown [9.43.41.196])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Jul 2025 11:05:35 +0000 (GMT)
Message-ID: <19972ca9-804e-407b-a784-ba2566bc907a@linux.ibm.com>
Date: Wed, 23 Jul 2025 16:35:33 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] block: restore two stage elevator switch while running
 nr_hw_queue update
To: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org
Cc: yi.zhang@redhat.com, ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk,
        shinichiro.kawasaki@wdc.com, gjoyce@ibm.com,
        "yukuai (C)"
 <yukuai3@huawei.com>
References: <20250718133232.626418-1-nilay@linux.ibm.com>
 <b7cc0c1c-6027-4f1a-8ca1-e7ac4ae9e5ec@huaweicloud.com>
 <43099391-2279-473d-8c13-70486b96f50f@linux.ibm.com>
 <c339715d-4a4b-0a4a-4d53-86eabe7b5d97@huaweicloud.com>
 <50fc4df5-991d-4076-ab72-eea33b9e5e07@linux.ibm.com>
 <a707901a-1d21-313f-0456-01f419181f2c@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <a707901a-1d21-313f-0456-01f419181f2c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PNpnyt2WPlrfxArCJHvaTCByA9lfuxVJ
X-Proofpoint-ORIG-GUID: PNpnyt2WPlrfxArCJHvaTCByA9lfuxVJ
X-Authority-Analysis: v=2.4 cv=Ae2xH2XG c=1 sm=1 tr=0 ts=6880c204 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=oI82WSWj1OA9ISeKEK8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5MCBTYWx0ZWRfX64G3/mlyGz1h
 Qv9l0zByNm6n27AVnqK5SV/cD0LMw2DBj+A97Dt83fF5+IQoElXEIk7TSgZiCt1/Nb6lDArpFBy
 8J9E5EZS3BvouxWg8ZlmdnrqN/p3j/KUtQ8H0hyGyY81ZVobUfrMDBsbcBGo5q64IePHZm5m8n6
 dT1d2Wpy3ztOwR5I86I6leXBoEn/IigHlzjxSz+zuTSCYUiscxOBLBThRZyyZr9FXxI8ro1s3ip
 2+6wpveWLSAGPu900DMNzocdf70uoeoCzyjb2UnHcx9qwlsFJ5zozkVfX6fkSD/e+OFJ98kDBql
 k9gNHV9j34hgTq7YmfouHOSCPuMTYgXrOPiREt1OzX7OcWEysUaXm2zKGUNhXTYvpzkSp/+XfE1
 WY/VColK5OVUKH/Q2A5K5uiAZAHm3gfnGRZ4Xy3AGy1geRHmBS15TeToXK3I/vbLkiSg3EJk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230090



On 7/23/25 12:28 PM, Yu Kuai wrote:
>>>>> BTW, this is not related to this patch. Should we handle fall_back
>>>>> failure like blk_mq_sysfs_register_hctxs()?
>>>>>
>>>> OKay I guess you meant here handle failure case by unwinding the
>>>> queue instead of looping through it from start to end. If yes, then
>>>> it could be done but again we may not want to do it the bug fix patch.
>>>>
>>>
>>> Not like that, actually I don't have any ideas for now, the hctxs is
>>> unregistered first, and if register failed, for example, due to -ENOMEM,
>>> I can't find a way to fallback :(
>>>
>> If registering new hctxs fails, we fall back to the previous value of
>> nr_hw_queues (prev_nr_hw_queues). When prev_nr_hw_queues is less than
>> the new nr_hw_queues, we do not reallocate memory for the existing hctxs—
>> instead, we reuse the memory that was already allocated.
>>
>> Memory allocation is only attempted for the additional hctxs beyond
>> prev_nr_hw_queues. Therefore, if memory allocation for these new hctxs
>> fails, we can safely fall back to prev_nr_hw_queues because the memory
>> of the previously allocated hctxs remains intact.
> 
> No, like I said before, blk_mq_sysfs_unregister_hctxs() will free memory
> by kobject_del() for hctx->kobj and ctx->kobj, and
> __blk_mq_update_nr_hw_queues() call that helper in the beginning.
> And later in the fall back code, blk_mq_sysfs_register_hctxs() can fail
> by memory allocation in kobject_add(), however, the return value is not
> checked.
> 
This can be done checking the kobject state in sysfs: kobj->state_in_sysfs.
If kobj->state_in_sysfs is 1 then it implies that kobject_add() for this
kobj was successful and we can safely call kobject_del() on it otherwise
we can skip it. We already have few places in the kernel using this trick.
For instance, check sysfs_slab_unlink(). So, IMO, similar technique could be
used for hctx->kobj and ctx->kobj as well while we attempt to delete these 
kobjects from unregistering queue and nr_hw_queue update.

Thanks,
--Nilay
