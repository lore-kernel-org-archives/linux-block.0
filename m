Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD122951CA
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719680; cv=none; b=Ge4jebkpdUnRbjqzFhCwhDIjeAxaMKkLh+FmaXMFgxpWFQZwDA13xoiXBFgR3tgG3XIdHfLQVoT3kHX3y98LEsX02gJpkKWNHdndhnF4gYdGejFXqN4LGF/H/y/ngA/W/ddQtYAx/Jmu4AovYg+4rTIuxp9rBhOwOg7B9CflleY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719680; c=relaxed/simple;
	bh=zEJngVggieNS2wwpkWk3BCnfVaMY+oiQBVv37YVxop8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7c3+oDl8dlyj4f97qwyJ8ptaXrTEWgaWuxWJ9HQaqU/LHFYp2RoL3qlhsaOvZhWprvtSt5oAxFhtQQdrC+IUI/YbjPjnldgLvnyeBXgRV6du+arrRscATHTovF7nAhtLQ+YcX66TXpZGGreXpDKttpmaC2oaX3DQydbeAUUgZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AyAFcDMR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AyAFcDMR"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F9QZIM029423;
	Tue, 15 Apr 2025 12:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1Gd/mm
	c6tyMQWatq5g7yLdYjYspsyI4vhmYPDocOVkE=; b=AyAFcDMRe544PyJe4WCXR8
	EhgWZtHpmILpm4VQQnrETuZ0oxAS/67HzNl8cufW3851QuDw6meHDZ40rHqf4gNB
	RL0zgWJ/Z7D3cnxZZNAi0/muszk1mgBDSx1ddOCdX6N8YDbLeTlZlFdSGfOGynGo
	StARXnThA0Jkaq0rlML1GPkGUBu8zNXuUkIscO1NV4Uodk9BVd/hQt2UhDZmuR17
	ccOdRowUGxU/hPPUd3j10qW/8levZKpvvp34YZWPqaUCto2PAWYl1jAEFIwvzqXZ
	b7oxMmAC664FQ+JXW3nedIprSaDOzNtSc+IhSv18tbhSuJ9Y0ld/ZUpP9ukEsFCw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461agt38s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 12:21:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53FApux7017195;
	Tue, 15 Apr 2025 12:21:11 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46040ktx1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 12:21:11 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53FCLAHA27066974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 12:21:10 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 731B758059;
	Tue, 15 Apr 2025 12:21:10 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7846D58053;
	Tue, 15 Apr 2025 12:21:08 +0000 (GMT)
Received: from [9.179.13.11] (unknown [9.179.13.11])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Apr 2025 12:21:08 +0000 (GMT)
Message-ID: <43325beb-6147-4f51-8e79-0c31db2ef742@linux.ibm.com>
Date: Tue, 15 Apr 2025 17:51:07 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] block: move debugfs/sysfs register out of freezing
 queue
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
 <20250410133029.2487054-13-ming.lei@redhat.com>
 <b28d98a6-b406-45b0-a5db-11bc600be75f@linux.ibm.com>
 <Z_xn-Zl5FDGdZ_Bk@fedora>
 <96d870d2-19f2-489e-951f-b92a56b59bf6@linux.ibm.com>
 <Z_4vwU7HMLCShZUO@fedora>
 <bf874ae8-d26c-4b00-92ac-acbd3e6f4c3c@linux.ibm.com>
 <Z_5I3oSmT9jRVu4Z@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z_5I3oSmT9jRVu4Z@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b7nn3_dqj6lTRowngPilgMrpWsDuoHGA
X-Proofpoint-GUID: b7nn3_dqj6lTRowngPilgMrpWsDuoHGA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=890 phishscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150085



On 4/15/25 5:24 PM, Ming Lei wrote:
>>>
>>> Why is updating nr_requests related with removing hctx attributes?
>>>
>>> Can you explain the side effect in details?
>> Thread 1:
>> writing-to-blk-mq-sysfs-attribute-nr_requests 
>>   -> queue_requests_store ==> freezes queue and acquires ->elevator_lock 
>>     -> blk_mq_update_nr_requests 
>>       -> blk_mq_tag_update_depth
>>         -> blk_mq_alloc_map_and_rqs
>>           -> blk_mq_alloc_rq_map
>>             -> blk_mq_init_tags ==> updates ->nr_tags and ->nr_reserved_tags 
>>
>> Thread2:
>> blk_mq_update_nr_hw_queues
>>   -> __blk_mq_update_nr_hw_queues
>>     -> blk_mq_realloc_tag_set_tags
>>       -> __blk_mq_alloc_map_and_rqs
>>         -> blk_mq_alloc_map_and_rqs
>>           -> blk_mq_alloc_rq_map
>>             -> blk_mq_init_tags ==> updates ->nr_tags and ->nr_reserved_tags 
>>
>> Thread 3:
>> reading-hctx-sysfs-attribute-nr_tags
>>   -> blk_mq_hw_sysfs_show ==> acquires ->elevaor_lock
>>     ->  blk_mq_hw_sysfs_nr_tags_show ==> access nr_tags 
>>
>> Thread 4:
>> reading-hctx-sysfs-attribute-nr_reserved_tags
>>   -> blk_mq_hw_sysfs_show ==> acquires ->elevaor_lock
>>     -> blk_mq_hw_sysfs_nr_reserved_tags_show ==> access nr_reserved_tags
> 
> `hctx->tags` is guaranteed to be live if above ->show() method, and the
> elevator lock is actually not needed, which isn't supposed to protect
> hctx->tags too.
> 
I think, the ->elavtor_lock would still be needed for protecting updates to 
hctx->tags from thread # 1 above and simultaneously reading the hctx->tags from 
thread #3 and #4 above.
  
>>
>> As we can see above, ->nr_tags and ->nr_reserved_tags are also exported 
>> to userspace using hctx sysfs attributes (nr_tags and nr_reserved_tags).
>>
>> So my point was,
>> #1 For alleviating race between nr_hw_queues and nr_requests update,
>>    we need protection (probably using srcu lock) so that ->nr_tags 
>>    and ->nr_reserved_tags are not updated simultaneously.
>>
>> #2 How could we protect race between thread 3 and thread 2 above or 
>>    race between thread 4 and thread 2 above?
> 
> blk_mq_update_nr_hw_queues() calls blk_mq_sysfs_unregister_hctxs() first,
> then user can not see the above attributes before calling blk_mq_sysfs_register_hctxs().
> 
> So there isn't the race.
> 

>>
>>>
>>>> Maybe we also want to protect blk_mq_update_nr_requests
>>>> with srcu read lock (set->update_nr_hwq_srcu) so that it couldn't run while  
>>>> blk_mq_update_nr_hw_queues is in progress?
>>>
>>> Yeah, agree, and it can be one new patch for covering race between
>>> blk_mq_update_nr_requests and blk_mq_update_nr_hw_queues, the point is just
>>> that nr_hw_queues is being changed, and not related with removing hctx
>>> attributes, IMO.
>>>
>> Please note that blk_mq_update_nr_requests also updates q->nr_requests,
> 
> blk_mq_update_nr_requests() uses nr_hw_queues, so there is race between
> blk_mq_update_nr_requests() and blk_mq_update_nr_hw_queues().
> 
Okay so I believe, this could be protected using srcu lock.

>> however looking at all code paths which updates this value is already
>> protected with ->elevator_lock. So the only thing which worries me
>> about updates of ->nr_tags and ->nr_reserved tags as shown above.
> 
> As I mentioned, there isn't such race.
Yes agreed, there's no race between thread 3 and thread 2 or 
thread 4 and thread 2.
 
Thanks,
--Nilay

