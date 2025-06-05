Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E982C3242
	for <linux-block@vger.kernel.org>; Thu,  5 Jun 2025 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749117114; cv=none; b=qm/iWYsaLKi0nMPBJo+puwuouHZu1cyb8Eqy/VIhlUhGbtIvItkQKhFjL7i280xJRZsX0uDf4IQofnKJxLHfQwKGXnqZ6Vn0ogf8XEvyT/fa/9hPagRBjsVWVkElYXlgoiAWNtA1AeV2qQf2KNuOr21SGpYtrZO+xFw0Ym74nIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749117114; c=relaxed/simple;
	bh=Fm3+TqqAQFNQpF6jEg4UtIp98qBNMpkOKYyEBaaZ/MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8LiDQGwpq0y8FDOW1r34WlMuuitDtPN1iFdu/3lzUONazPfFH7gWJDQ/nSsCVZ06Wgb+UPbl9MpGirisknZTHjdToSancZZsaYqBTJr7lp+ojXILcXjKWxz++ziovyTHRTx5/OPn7bU+EOuJCPEMdYui3vbf607krucvCOQn6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QtAB+oV5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QtAB+oV5"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554NMo3Y022809;
	Thu, 5 Jun 2025 09:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R+xTMJ
	g3/qVzhcsDLj0EzSR1UTDi3uKLsIHDwiMZzTQ=; b=QtAB+oV5uUQxk9HkFAvG4I
	3FGpBmyQULyEPkaNNEthr/R+/J2oO5inOzmVkuEduGn9FMqCE29yHgFTtNyHA2O2
	+FW2FqiEJK/Q1qRaDg37NMDaSbUefWsNG8/45V+NExwvH2CpWAVlNO6A5wApZ+nw
	aCangVgXbUhtSSJ7V0iW5F7r7Flp2RVQEHnRX2MOWF+1On+JiOLKSCjyqlsVep0y
	hNIGzAYW8T1e1YY9xkPmexgR++hgphQfEBNTHi42R7+VrcK+4De/ZPajiiYDSU3+
	XM9ElBpSarmRfBIpzt+nZUwNFPf6LdG0xoSXzKlGwyz6L3ucG820Bg2GN5UFdmGg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyyymp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 09:51:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5558QvU5031750;
	Thu, 5 Jun 2025 09:51:44 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470cg049eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 09:51:44 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5559pgNj20972144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Jun 2025 09:51:42 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FF5D5805D;
	Thu,  5 Jun 2025 09:51:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4685F58043;
	Thu,  5 Jun 2025 09:51:14 +0000 (GMT)
Received: from [9.109.198.212] (unknown [9.109.198.212])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Jun 2025 09:51:03 +0000 (GMT)
Message-ID: <888f3b1d-7817-4007-b3b3-1a2ea04df771@linux.ibm.com>
Date: Thu, 5 Jun 2025 15:20:36 +0530
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
 <01e38aba-21ec-4507-8e5f-392838e8b937@linux.ibm.com>
 <4ab6d5a2-1780-4e81-8ea1-e5d93d651dc5@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <4ab6d5a2-1780-4e81-8ea1-e5d93d651dc5@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Pq2TbxM3 c=1 sm=1 tr=0 ts=684168b1 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=_jLFwQdRFzRFQxlFB-MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA4MyBTYWx0ZWRfX8OpfxpxBRrTl AWdcrAIGh9R62yLbCJ1Uxk6YrlKBvbZrSAEtIUcyoY6id08GurOt6mpr28rJMCWXHTcHsPG+lKM dc3DIViCwvSxEHX20DjfHc6+nP1XEC7uAflIi7zpdw3sCeNQ7o9djFMb3tNxr0LdX3yZ4HnEKDZ
 2UgI/Gi5/TczZg9o4HyZpF8gPrgq9KGeZECPG6OLkaHwVvR4ri6O9As7Rv3EI74xqtx7Jz+lD1j 4AKlrQGH/o281vfOudXDDuliAM2CG1POuDXTEU7O+qauhMk1LdNpRsi3JRTPRVCVPiA6UFklECF TjgKru2ZDddTJ9foe3V1/e5vbSE1AkAPrJPEvQj4SioLRUz5rRoERL3pJlExMTqrCcGd+LLxS0y
 Gs6D8HOeKuM63/PMCEnR4nYAWBe0VU8GHxcZGs4ePf2zXnim4eDaVHOXdMXans2KwL2RkEbK
X-Proofpoint-GUID: WS1rTk_-U7bL6PfOA11QuAQh5qOYR1SV
X-Proofpoint-ORIG-GUID: WS1rTk_-U7bL6PfOA11QuAQh5qOYR1SV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050083



On 6/5/25 2:31 PM, John Garry wrote:
> On 04/06/2025 16:09, Nilay Shroff wrote:
>>> I need to test further, but maybe we can change the check to this:
>>>
>>> if (t->io_min <= SECTOR_SIZE || t->io_min == t->physical_block_size) {
>>>          /* No chunk sectors, so use bottom device values directly */
>>>          t->atomic_write_hw_unit_max = b->atomic_write_hw_unit_max;
>>>          t->atomic_write_hw_unit_min = b->atomic_write_hw_unit_min;
>>>          t->atomic_write_hw_max = b->atomic_write_hw_max;
>>>          return true;
>>> }
>> How about instead adding a new BLK_FEAT_STRIPED flag and then use it here while
>> setting atomic limits as shown below:
>>
>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>> index a000daafbfb4..bf5d35282d42 100644
>> --- a/block/blk-settings.c
>> +++ b/block/blk-settings.c
>> @@ -598,8 +598,14 @@ static bool blk_stack_atomic_writes_head(struct queue_limits *t,
>>              !blk_stack_atomic_writes_boundary_head(t, b))
>>                  return false;
>>   -       if (t->io_min <= SECTOR_SIZE) {
>> -               /* No chunk sectors, so use bottom device values directly */
>> +       if (t->io_min <= SECTOR_SIZE || !(t->features & BLK_FEAT_STRIPED)) {
>> +               /*
>> +                * If there are no chunk sectors, or if the top device does not
>> +                * advertise the STRIPED feature (i.e., it's not a striped
>> +                * device like md-raid0 or dm-stripe), then we directly inherit
>> +                * the atomic write capabilities from the underlying (bottom)
>> +                * device.
>> +                */
>>                  t->atomic_write_hw_unit_max = b->atomic_write_hw_unit_max;
>>                  t->atomic_write_hw_unit_min = b->atomic_write_hw_unit_min;
>>                  t->atomic_write_hw_max = b->atomic_write_hw_max;
>>
>> I tested the above change with md-raid0 and dm-strip setup and seems to
>> be working well. What do you think?
> 
> I would hope that we don't require this complexity.
> 
> I think that this check should be fine:
> 
> if (t->io_min <= t->physical_block_size) {
> 
> }
> 
> But I have found a method to break atomic writes for raid10 on mainline with that - that is if I have physical_block_size > chunk size. This ends up that atomic write unit max comes directly from the bottom device atomic write unit max, and it should be limited by chunk size.
> 
> Let me send a patch for that, and we can go from there - ok?

Yeah sure, we need to fix this. Please send your changes and I'd be glad to
help review and test your changes on my setup. 

Thanks,
--Nilay


