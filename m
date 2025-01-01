Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE53BA3F
	for <linux-block@vger.kernel.org>; Wed,  1 Jan 2025 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735730247; cv=none; b=HaB+TyeS6vkd4iLL5LOaQAX6xzs9ozDbJtk1Cs3mi2coNIkYycCJtHLLaIyF+2HrOfRxne/6KicEdrEr9Sj7vMmTKXTrX9yMP+ZxOrt20SFAn7OvOg0F1XhJAMPsjqGyNJXQjhvXjkBYMpxebCVTXIYfIxmQwup0ya+EHlLoyJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735730247; c=relaxed/simple;
	bh=n42ra/svvWRCc9zEicnIGnbizkyYsnZdaCx6eoau/H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZFb6CppBZDozL5f/T3p6ocFyxrz51qDJ2YU96XSs++hXwi4R2r5ehg21pQce+FJFLseKAm0RayyOFugmnv2fypCEm8R0j0Ajf4Gu37Ny1IVehrEOyjbTk4DSgV38+rkYRbjXySnE4gd/ZMjWimpUmKVcyK6mpovkVaPHO93kQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y7BHehnF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y7BHehnF"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5011wCaN014439;
	Wed, 1 Jan 2025 11:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Sy5RHE
	j3XZS6wDSBO3vV7Dof8DRcPrMrJYFhFDY70Yk=; b=Y7BHehnFXSxZQVmdVHUlnu
	OPCRJeWBldtmAgdoVygH68GNzyVnYflzw46CTzh12rDl5GJd98E7sdfwD9bR92oK
	4lJ8h6Xe3SchsO+eGl2R4B9j/NGyLTKMmEeYf7EmWns8pP4JDh1OYzcw0BwscgvP
	q1yn1ihBKgAwiJU0iS+erBEJtnUYlbuJqlqQ1/xEjbq03KCoglK7BmQKkxdQD6+x
	FLylVSJeO+2sZbjqkctUbi6vFieSxYf2X4wGe++2PxIP/6Ba1WNfXJhz+0L8/gF0
	5VFjGPtZj85+RA7rbPKL6ecbqT4hLiZT3gRHS+P+9Rw79LfWCsm9PCzaOjxFj0Dg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43vtea9h0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jan 2025 11:17:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5017SeJV016708;
	Wed, 1 Jan 2025 11:17:14 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43tw5kdvr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jan 2025 11:17:14 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 501BHDa739125496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jan 2025 11:17:13 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DC9A5805F;
	Wed,  1 Jan 2025 11:17:13 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87CD958050;
	Wed,  1 Jan 2025 11:17:11 +0000 (GMT)
Received: from [9.171.79.55] (unknown [9.171.79.55])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jan 2025 11:17:11 +0000 (GMT)
Message-ID: <23008fc2-6e83-4d83-8ea1-4a3f6c0e000c@linux.ibm.com>
Date: Wed, 1 Jan 2025 16:47:10 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: avoid to hold q->limits_lock across APIs for
 atomic update queue limits
To: Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
References: <20241217071928.GA19884@lst.de> <Z2Eog2mRqhDKjyC6@fedora>
 <a032a3a0-0784-4260-92fd-90feffe1fe20@kernel.org> <Z2Iu1CAAC-nE-5Av@fedora>
 <f34f179a-4eaf-4f73-93ff-efb1ff9fe482@linux.ibm.com>
 <Z2LQ0PYmt3DYBCi0@fedora>
 <0fdf7af6-9401-4853-8536-4295a614e6d2@linux.ibm.com>
 <9e2ad956-4d20-456f-9676-8ea88dfd116e@kernel.org>
 <20241219062026.GC19575@lst.de>
 <cf1e007b-dcb5-43cd-84e2-fd72d8836fb8@linux.ibm.com>
 <Z3Jhq5Z4gLupIrYm@fedora> <a5114533-8753-4137-b2eb-4c150d25d784@kernel.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <a5114533-8753-4137-b2eb-4c150d25d784@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2fbAAUNk_Gm3UgzyMeSzoyxYaahfJNjH
X-Proofpoint-GUID: 2fbAAUNk_Gm3UgzyMeSzoyxYaahfJNjH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501010095



On 12/31/24 04:59, Damien Le Moal wrote:
> On 2024/12/30 18:02, Ming Lei wrote:
>>> 1. Callers which need acquiring limits-lock while starting the update; and freezing 
>>>    queue only when committing the update:
>>>    - sd_revalidate_disk
>>
>> sd_revalidate_disk() should be the most strange one, in which
>> passthrough io command is required, so dependency on queue freeze lock
>> can't be added, such as, q->limits_lock
>>
>> Actually the current queue limits structure aren't well-organized, otherwise
>> limit lock isn't needed for reading queue limits from hardware, since
>> sd_revalidate_disk() just overwrites partial limits. Or it can be
>> done by refactoring sd_revalidate_disk(). However, the change might
>> be a little big, and I guess that is the reason why Damien don't like
>> it.
> 
> That was not the reason, but yes, modifying sd_revalidate_disk() is not without
> risks of introducing regressions. The reason I proposed to simply move the queue
> freeze around or inside queue_limits_commit_update() is that:
> 
> 1) It is the right thing to do as that is the only place where it is actually
> needed to avoid losing concurrent limits changes.
> 
> 2) It clarifies the locking order between queue freeze and the limits lock.
> 
> 3) The current issues should mostly all be solved with some refactoring of the
> ->store() calls in blk-sysfs.c, resolving the current ABBA deadlocks between
> queue freeze and limits lock.
> 
> With that, we should be able to fix the issue for all block drivers with changes
> to the block layer sysfs code only. But... I have not looked into the details of
> all limits commit calls in all block drivers. So there may be some bad apples in
> there that will also need some tweaking.
Yes, I think, we have places other than blk-sysfs, like nvme, where we need fixing.
> 
>>>    - nvme_init_identify
>>>    - loop_clear_limits
>>>    - few more...
>>>
>>> 2. Callers which need both freezing the queue and acquiring limits-lock while starting
>>>    the update:
>>>    - nvme_update_ns_info_block
>>>    - nvme_update_ns_info_generic
>>>    - few more... 
> 
> The queue freeze should not be necessary anywhere when starting the update. The
> queue freeze is only needed when applying the limits so that IOs that are in
> flight are not affected by the limits change while still being processed.
Hmm, but as mentioned for nvme limits update this is not always true. So this need to be tweaked.
>>>
>>> 3. Callers which neither need acquiring limits-lock nor require freezing queue as for 
>>>    these set of callers in the call stack limits-lock is already acquired and queue is 
>>>    already frozen:
>>>    - __blk_mq_update_nr_hw_queues
>>>    - queue_xxx_store and helpers
>>
>> I think it isn't correct.
>>
>> The queue limits are applied on fast IO path, in theory anywhere
>> updating q->limits need to drain IOs in submission path at least
>> after gendisk is added.
> 
> Yes !
> 
OK, I think it'd be tricky to fix __blk_mq_update_nr_hw_queues and queue_xxx_store
with the current proposal of acquiring limits lock followed by queue freeze 
while committing limit update. 

Thanks,
--Nilay
