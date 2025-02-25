Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2281267AFA
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477955; cv=none; b=Cb+WmcUSslF7HmYXZVSNkG1pAArV0FMK3k/Vpmy3uh/oqyiYIyYpuuj2SJXrA3k/A+0y2gny2ThLw6NQzDTv88QQr9lV5oGATQFFvyndDwJjGPLRk5i7iWyKYFfZYd8t9IHTMSnAcyEDpRYwf8aSPi4Zkiq0AdNETCi6sWi0J3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477955; c=relaxed/simple;
	bh=8SWrmdBtKuBxXIOaR95Cj95nANhaAb49TeSjLvh/Naw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1ciL3WxEzNpUHM5cRPgprVzlKhEjDet4j0t0OR6jPcVmLSqYeeYgIoL/NORFGpqTBdcuuLekhiYza1yGuyZxRFrciIl4Jx1EoeqDpKh7oampRaZb8ZsvZFFMTIPbUQnj6jWrL/CIaILoSXzmhFQrJ4zt2bfaHKuZAi3XnfaQF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NmL+pc9l; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NmL+pc9l"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P20mYK003397;
	Tue, 25 Feb 2025 10:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QdNiHo
	E1DzpV4+mim8/03voCrqkEFTjVWd34kdCzX3I=; b=NmL+pc9lQkQBi2TjZedJkk
	0KCDcc/KJGIpbVmPuI/L3v34cQhBQsQ6K3N5VIqCIvErsR3wJfm8xUPq9q1VZlmG
	DAd3VvBc8BdU2i3QSt81pWvmrQ/OAUF3p/86lflbyzSwhSYPDqj4BiQS0Zx6dDeX
	i/UrpKn0z73seJZgc5yXJsqEurE2WnK7jw0CUB+xtcjmt1p8nNVc5XrXfiSLVkju
	ctrI8v8dd6pYqLocspyGFJKp+rTkME6guvex5WFUClAMJQhyIK48yeXSxn1HNkHZ
	dt5vMOTnuSgVlmB6ThVfUfkZgmB36pE/xI3vxU6qebwaT3I6J6VAQ0Y9QNxtWkPg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4514q09sv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 10:05:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8ItHu002551;
	Tue, 25 Feb 2025 10:05:43 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4jkvhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 10:05:43 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51PA5gaS55116136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 10:05:42 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 073745805A;
	Tue, 25 Feb 2025 10:05:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA1315805E;
	Tue, 25 Feb 2025 10:05:39 +0000 (GMT)
Received: from [9.61.156.112] (unknown [9.61.156.112])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2025 10:05:39 +0000 (GMT)
Message-ID: <510f2a3e-39dd-4a82-ad86-7b6d7e9b4525@linux.ibm.com>
Date: Tue, 25 Feb 2025 15:35:38 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 6/7] block: protect wbt_lat_usec using q->elevator_lock
To: Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
References: <20250224133102.1240146-1-nilay@linux.ibm.com>
 <20250224133102.1240146-7-nilay@linux.ibm.com>
 <b70d5872-99e1-458f-aea9-282d2d9dda78@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <b70d5872-99e1-458f-aea9-282d2d9dda78@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xWwh1PGw7udum4Jl0gH6r8ilDMdqadHZ
X-Proofpoint-GUID: xWwh1PGw7udum4Jl0gH6r8ilDMdqadHZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502250069



On 2/25/25 1:23 PM, Hannes Reinecke wrote:
> On 2/24/25 14:30, Nilay Shroff wrote:
>> The wbt latency and state could be updated while initializing the
>> elevator or exiting the elevator. It could be also updates while
>> configuring IO latency QoS parameters using cgroup. The elevator
>> code path is now protected with q->elevator_lock. So we should
>> protect the access to sysfs attribute wbt_lat_usec using q->elevator
>> _lock instead of q->sysfs_lock. White we're at it, also protect
>> ioc_qos_write(), which configures wbt parameters via cgroup, using
>> q->elevator_lock.
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   block/blk-iocost.c |  2 ++
>>   block/blk-sysfs.c  | 20 ++++++++------------
>>   2 files changed, 10 insertions(+), 12 deletions(-)
>>
>> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
>> index 65a1d4427ccf..c68373361301 100644
>> --- a/block/blk-iocost.c
>> +++ b/block/blk-iocost.c
>> @@ -3249,6 +3249,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
>>       }
>>         memflags = blk_mq_freeze_queue(disk->queue);
>> +    mutex_lock(&disk->queue->elevator_lock);
>>       blk_mq_quiesce_queue(disk->queue);
>>   
> Ordering?
> 
> Do we have a defined order between 'freeze', 'quiesce' and taking the respective lock?
> 
> Or, to put it the other way round: why do we tak the lock after the 'freeze', but before the 'quiesce'?

This is the order followed currently in __blk_mq_update_nr_hw_queues()
where we first freeze queue and then acquire the other locks. Yes this may
look a bit unusual but that's how it is. If we need to change that
ordering then we may require breaking the __blk_mq_update_nr_hw_queues()
function. So the current locking sequence wrt ->elevator_lock is:
freeze queue followed by acquiring ->elevator_lock.

So we try follow the same locking order at all call sites where we
need to freeze-queue and use ->elevator_lock.

> 
> Isn't that worth a comment somewhere?
Alright, I'd add comment about this ordering probably near the 
declaration of this lock in request_queue.

Thanks,
--Nilay






