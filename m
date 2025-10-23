Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ECE2F83AC
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208110; cv=none; b=TbrgC2d6nXz1I4Fb5/Xf8NXP3o0yol3m18IsUFBVolrj31iGSGRxcNQCwld5kO8wnD9mpiRITRzhK8vUWJ4T0+ybtAit1Xj6z8LTabwvMMam0C1ZeC6/bjIzqQbYBUkISIG8Z50vwkdr7Ftnd4aBaWVI5JSikEC9ijyYFfwezA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208110; c=relaxed/simple;
	bh=ufeh8eXqlHTcGgkz/Bj0ELams+yTjVHVEZXGzjWhB5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HF62qhtyNoGFT78pBlBpg0SQwbzxQNps14uHm+FGoMEzw1f8/SwblGCg36Szc/RxkLzIkgADqdaAjJvwrjc8ae2sxqk1rgn64awXfB4FbyGGnGFums8ESran6EszPXso4ySDqSp+MWSykACenoTfFw9mprtuTBWrvyLOi4b1bos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ecKYvSKt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ecKYvSKt"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MJcV5F003940;
	Thu, 23 Oct 2025 08:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BmWPXf
	9o4W1EXNfX+pGF9jJedGOtSCOfcVQ1KnCz0rk=; b=ecKYvSKtvKBS9kp/W41TIp
	le5uerXgVhUPWF/I/3aQQRaHWV8kuM2OXWqapSQGPszR1dgn4+bIe62imXASUVQP
	CcGttefBAZQdU/kEo6dSmJ0zwkKCZu7K/JV8rNwAaLiFWVE+KwfelzAmmPAhtEWn
	isY9+aaHspD/Jo89ba9ofTuMCTCC7AD8bk3Yy8TDJfDyJy2wHSnPOdb24RiNuHIl
	4aM/KXVvzvZLpBdNIJrZ9WDCIQPwFHB9GfxiBwXqZaqkjsQqY69xb5ntB71LB+mp
	ERGJ0icE8l21S+2ZXxGfroxBSU/rO+TuUuTBL+fYepzS1Cx91xTecyb/VMQqqLMQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hqm89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 08:28:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N62aJQ032166;
	Thu, 23 Oct 2025 08:28:13 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7n4qw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 08:28:13 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59N8S0Sk26542838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 08:28:00 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3550558059;
	Thu, 23 Oct 2025 08:28:13 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 414C358043;
	Thu, 23 Oct 2025 08:28:10 +0000 (GMT)
Received: from [9.109.198.148] (unknown [9.109.198.148])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Oct 2025 08:28:09 +0000 (GMT)
Message-ID: <17e70cb9-95d9-435b-a497-3924896e9c32@linux.ibm.com>
Date: Thu, 23 Oct 2025 13:58:08 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: introduce alloc_sched_data and free_sched_data
 elevator methods
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, yukuai1@huaweicloud.com,
        axboe@kernel.dk, yi.zhang@redhat.com, czhong@redhat.com,
        gjoyce@ibm.com
References: <20251016053057.3457663-1-nilay@linux.ibm.com>
 <20251016053057.3457663-3-nilay@linux.ibm.com> <aPhgAMxgG2q0DKcv@fedora>
 <59cf7e0f-1069-4766-9234-cc91985470e4@linux.ibm.com>
 <aPnd2WMKE5gjkM0s@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aPnd2WMKE5gjkM0s@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXwV1J4iFU1beb
 BN2uKza/zWNlL62W3TU1Oj8qqOoRWVDItU5+rT4c8IPaGGSTBvbSx5snAsiEMsCvBL5OspXcy6y
 VTwVPv5CwoDwfSLaMu74BoVitObWduWAnh6rTDPZafaNj/APjLlKCLzmtoQ40S9q54d6DcVxTn9
 UHJUWspr2Y1jrD+E2RHsbQIZPQgKQ32YD93sZxicm/jWiY5kBsj2OyA5nGNF3/lZBq7cawGCcQv
 qcpX6HiMTkAuM5cemRSGTX4+HRL0QB/6t3lY6GJGoonaw8UQrsMua5FRXNEUTv3NeLCWxrHMWWo
 4de/LCbbzk+26FXyC4Cgs/YqsVDAHMpWAHzGPPNs06o2CRX3x6AhcTdHMB23kWTCsslUs6ZJjWw
 JMNTgqViipq+PiVBCb1+JVAqFQWaew==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68f9e71e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xLKKOo7hbmr0dyL8mpYA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: anq7KY0Nrw0jR14H5XJ837-H_avEWumV
X-Proofpoint-ORIG-GUID: anq7KY0Nrw0jR14H5XJ837-H_avEWumV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022



On 10/23/25 1:18 PM, Ming Lei wrote:
> On Thu, Oct 23, 2025 at 11:27:26AM +0530, Nilay Shroff wrote:
>>
>>
>> On 10/22/25 10:09 AM, Ming Lei wrote:
>>> On Thu, Oct 16, 2025 at 11:00:48AM +0530, Nilay Shroff wrote:
>>>> The recent lockdep splat [1] highlights a potential deadlock risk
>>>> involving ->elevator_lock and ->freeze_lock dependencies on -pcpu_alloc_
>>>> mutex. The trace shows that the issue occurs when the Kyber scheduler
>>>> allocates dynamic memory for its elevator data during initialization.
>>>>
>>>> To address this, introduce two new elevator operation callbacks:
>>>> ->alloc_sched_data and ->free_sched_data.
>>>
>>> This way looks good.
>>>
>>>>
>>>> When an elevator implements these methods, they are invoked during
>>>> scheduler switch before acquiring ->freeze_lock and ->elevator_lock.
>>>> This allows safe allocation and deallocation of per-elevator data
>>>
>>> This per-elevator data should be very similar with `struct elevator_tags`
>>> from block layer viewpoint: both have same lifetime, and follow same
>>> allocation constraint(per-cpu lock).
>>>
>>> Can we abstract elevator data structure to cover both? Then I guess the
>>> code should be more readable & maintainable, what do you think of this way?
>>>
>>> One easiest way could be to add 'void *data' into `struct elevator_tags`,
>>> just the naming of `elevator_tags` is not generic enough, but might not
>>> a big deal.
>>>
>> Hmm, good point! I'd rather suggest if we could instead rename 
>> struct elevator_tags to struct elevator_resources and then
>> add void *data field to it. Something like this:
>>
>> struct elevator_tags {
>> 	unsigned int nr_hw_queues;
>> 	unsigned int nr_requests;
>> 	struct blk_mq_tags *tags[];
>>         void *data;
> 
> 'data' can't follow `tags[]`.

yeah it was impromptu :)
> 
>> };
>>
>> What do you think?
> 
> It is good. The patch may be split into two:
> 
> - add data to `struct elevator_tags` for covering the lockdep issue
> 
> - renaming
> 
> Then it will become easier for review.
> 
Alright, I'll implement it in the next patchset.

Thanks,
--Nilay

