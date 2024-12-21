Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B825B1FB
	for <linux-block@vger.kernel.org>; Sat, 21 Dec 2024 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734784290; cv=none; b=J6q/1a8jfLnI02qOWieErbyHmuyl/ip8a8v8UdLDdVw3EXr82e8svZuztbtmR3Nm+VkXv/HJn5djbkEYAvLwCrf810coEUtuJ1+WfShdiVEIZ6IDRlaicyUp3/fFL57eqvHflwkXg1ZJS3jDKRHIvAaC/DVKsai+EUaiLCJ1dDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734784290; c=relaxed/simple;
	bh=Dt5H/Pbsxl+gEca5TEtCtYKHwbyTv5iDQOjJJJIL8Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aIrxqjwq/mHg2MfxQJfcK/PF8cW1+bZubYhHr8wnVa1Fq3svKIXM+Gn5Qf+xgl04BQUVzWnjEPMt/Hw/sCjPiOHx+apvkIj0CSgPUJ+N2k96esZu0dwUG77HplOTdLOYlx5nsFRjtHdOZLIqG6F+hzWK1frC6Yz7ADsMOEfkxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q0b0a3o7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q0b0a3o7"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BL5FeIh007583;
	Sat, 21 Dec 2024 12:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=o8QyF6
	PhuPD5w6oreKzKNYY0+KSEx9E8BdD19rKD20o=; b=q0b0a3o79QW4n+VC1x+q8l
	HB06u9ZFi8J4NT+CuYSjhbGRERedXy2wUcvCRgDuvpKtfcfV4GxWv+bZBAoExB2p
	4XiwmEEYuJTgo1I6e8R6kFHnfrwaZLNMvu8+NDly7cNE8UC7nX59V84WqMn9eouD
	H0e7rJ/7tPOxKNYU9x4BO0dbTxCZfrVyPLIiCqLJDCq7kl8WjznqKWo8gSAVK894
	N6UidgOEyM89SwcWHXZcclXfHIx0oCiEmmOAF4jBn04h2noubUDfEqPapsi8GPbg
	FSRbYm0e1yk6wI83e6IG6V/fWUjZglYFldEOqbVcOMf7CrXA3PnptfCXcy+Ix9AQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43nqc5h0wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 12:31:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BLA4D9o014451;
	Sat, 21 Dec 2024 12:31:24 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hq2266yx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Dec 2024 12:31:24 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BLCVN8r24642290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Dec 2024 12:31:23 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E41D58058;
	Sat, 21 Dec 2024 12:31:23 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12FED58057;
	Sat, 21 Dec 2024 12:31:22 +0000 (GMT)
Received: from [9.179.8.248] (unknown [9.179.8.248])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Dec 2024 12:31:21 +0000 (GMT)
Message-ID: <cfbcca3c-080a-4f71-9b26-c04a0eaf1bf5@linux.ibm.com>
Date: Sat, 21 Dec 2024 18:01:20 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Revert "block: Fix potential deadlock while
 freezing queue and acquiring sysfs_lock"
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20241218101617.3275704-1-ming.lei@redhat.com>
 <20241218101617.3275704-2-ming.lei@redhat.com>
 <23c3e917-9dd3-4a0f-8bf4-0a6f421aae0e@linux.ibm.com>
 <d48795a6-cb9f-4649-8c43-e36639a39721@kernel.dk>
 <CAFj5m9JKrNm75DzJGFaDDZp4Owq79EBnH5cXFETiz5pRKoGxBg@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAFj5m9JKrNm75DzJGFaDDZp4Owq79EBnH5cXFETiz5pRKoGxBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5tbQW9p5x36DmPVScVAKskAIEBP1qAU_
X-Proofpoint-ORIG-GUID: 5tbQW9p5x36DmPVScVAKskAIEBP1qAU_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412210110



On 12/20/24 20:54, Ming Lei wrote:
> On Fri, Dec 20, 2024 at 11:10 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 12/20/24 3:23 AM, Nilay Shroff wrote:
>>> On 12/18/24 15:46, Ming Lei wrote:
>>>> This reverts commit be26ba96421ab0a8fa2055ccf7db7832a13c44d2.
>>>>
>>>> Commit be26ba96421a ("block: Fix potential deadlock while freezing queue and
>>>> acquiring sysfs_loc") actually reverts commit 22465bbac53c ("blk-mq: move cpuhp
>>>> callback registering out of q->sysfs_lock"), and causes the original resctrl
>>>> lockdep warning.
>>>>
>>>> So revert it and we need to fix the issue in another way.
>>>>
>>> Hi Ming,
>>>
>>> Can we wait here for some more time before we revert this as this is
>>> currently being discussed[1] and we don't know yet how we may fix it?
>>>
>>> [1]https://lore.kernel.org/all/20241219061514.GA19575@lst.de/
>>
>> It's already queued up and will go out today. Doesn't exclude people
>> working on solving this for real.
> 
> IMO, it is correct to cut the dependency between q->sysfs_lock and
> global cpu hotplug lock, otherwise more subsystems can be involved,
> so let's revert it first.
> 
Yeah agreed, we may want to in that case just remove lockdep aseert of 
q->sysfs_lock from blk_mq_realloc_hw_ctxs() and also remove q->sysfs_lock 
from blk_mq_init_allocated_queue(). But that's ok. Lets see how we'd pursue 
further and solve other limits-lock and queue-freeze issue. 

> Christoph is also working on q->sysfs_lock warning, and we can try to
> figure out other solutions given the involved(or most of) locks should be
> from block layer internal.
> 
> https://lore.kernel.org/linux-block/20241219061514.GA19575@lst.de/
> 
 
Thanks,
--Nilay
