Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4A8154C05
	for <linux-block@vger.kernel.org>; Fri,  7 Feb 2025 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926256; cv=none; b=XcmRURatjCtnNqOWQM2ROdkYn1vB5oyvml3P8GA82hnNv66z9WhpgEfXGOJi+xH5uH0Hh6knjhimWXZb4n2uXNr1/YGxdb4E7RA7Qo/63FcknSlzEol5ujrJoI+Q0bs9CKJ7EHMRAOlGBAWL3QmH9Z8I+aPmcHSqZbzBF9ajB4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926256; c=relaxed/simple;
	bh=+V6l5jS4ZefNfQAwEaUMALr1OtCxuwKffuw0R8/lksA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPVfboJEc3nUngt9+sk3iLecuwce7foZ6be0KTr7FXr4/TSQnsvUxH59BEVn5Wt0Zp7HU2uqpMXOGrC7WM737UO6Rye5tlnfL2uj4zv2WbjJWBeG0R11SSk3jdcnPRJLeQEyEKsC+XJrrycFJ4bbbqDV39z2MZNhfDz77lMu6WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kr4EAPuc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kr4EAPuc"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517189Ss021994;
	Fri, 7 Feb 2025 11:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FHFNVs
	qoE+aNzppMFbXq8g5F4O7oRu7A7YCVOVKyUJc=; b=kr4EAPucSbaxc561NS6O3m
	Q4Xag/CR/osSGb1pYZHnUMRybR/xdNE0UJbVSJS2AR2Do8vSrk3zKDqq57iXSiUx
	79HbDGdmNW5CFBv5NrXk9jAUjOY2fe8G4RB2ZgHDaJHRO8o0pMAtTRNUrh9OaFKC
	pWHh9/CjPS3gnrrSWFib+SpHcueanbvEKarf8vvKnxMrsQ1whV98cJzwjHcltVVp
	BeXSqdXlpreY+mkM6+NRzpELqOx4lgaFN8syD5SWf7k22IyYnh/wUYTClfSyoCtH
	eXHhe7Wt+KoF/C9+57eDapkV2t1j3lqPs35DHY+3m8OuHcqsCMXAbRj4yUMhfYmQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44n889ae7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 11:04:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 517709Gn007130;
	Fri, 7 Feb 2025 11:04:04 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxb039uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 11:04:04 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 517B43mI26215038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Feb 2025 11:04:03 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2BDA5812C;
	Fri,  7 Feb 2025 11:04:03 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9194258126;
	Fri,  7 Feb 2025 11:04:01 +0000 (GMT)
Received: from [9.171.24.9] (unknown [9.171.24.9])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Feb 2025 11:04:01 +0000 (GMT)
Message-ID: <f2e7b49e-6e40-4979-b69e-507ed5d7d363@linux.ibm.com>
Date: Fri, 7 Feb 2025 16:33:59 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: avoid acquiring q->sysfs_lock while accessing
 sysfs attributes
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20250205144506.663819-1-nilay@linux.ibm.com>
 <20250205144506.663819-3-nilay@linux.ibm.com> <20250205155330.GA14133@lst.de>
 <f933e87a-6014-434a-8258-d871c77ca14c@linux.ibm.com>
 <20250206140707.GA2141@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250206140707.GA2141@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XCnWozN38OaMHVSvCPYcOTC6IG5sfAdq
X-Proofpoint-ORIG-GUID: XCnWozN38OaMHVSvCPYcOTC6IG5sfAdq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_05,2025-02-07_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070084



On 2/6/25 7:37 PM, Christoph Hellwig wrote:
> On Thu, Feb 06, 2025 at 07:24:02PM +0530, Nilay Shroff wrote:
>> Yes that's possible and so I audited all sysfs attributes which are 
>> currently protected using q->sysfs_lock and I found some interesting
>> facts. Please find below:
>>
>> 1. io_poll:
>>    Write to this attribute is ignored. So, we don't need q->sysfs_lock.
>>
>> 2. io_poll_delay:
>>    Write to this attribute is NOP, so we don't need q->sysfs_lock.
> 
> Yes, those are easy.
> 
>> 3. io_timeout:
>>    Write to this attribute updates q->rq_timeout and read of this attribute
>>    returns the value stored in q->rq_timeout Moreover, the q->rq_timeout is
>>    set only once when we init the queue (under blk_mq_init_allocated_queue())
>>    even before disk is added. So that means that we may not need to protect
>>    it with q->sysfs_lock.
> 
> Are we sure blk_queue_rq_timeout is never called from anything but
> probe?  Either way given that this is a limit that isn't directly
> corelated with anything else simply using WRITE_ONCE/READ_ONCE might
> be enough.
I just again grep source code and confirmed that blk_queue_rq_timeout is 
mostly called from the driver probe method (barring nbd driver which may
set q->rq_timeout using ioctl). And yes, agreed, q->rq_timeout can be
accessed using WRITE_ONCE/READ_ONCE.

>>
>> 4. nomerges:
>>    Write to this attribute file updates two q->flags : QUEUE_FLAG_NOMERGES 
>>    and QUEUE_FLAG_NOXMERGES. These flags are accessed during bio-merge which
>>    anyways doesn't run with q->sysfs_lock held. Moreover, the q->flags are 
>>    updated/accessed with bitops which are atomic. So, I believe, protecting
>>    it with q->sysfs_lock is not necessary.
> 
> Yes.
> 
>> 5. nr_requests:
>>    Write to this attribute updates the tag sets and this could potentially
>>    race with __blk_mq_update_nr_hw_queues(). So I think we should really 
>>    protect it with q->tag_set->tag_list_lock instead of q->sysfs_lock.
> 
> Yeah.
> 
>> 6. read_ahead_kb:
>>    Write to this attribute file updates disk->bdi->ra_pages. The disk->bdi->
>>    ra_pages is also updated under queue_limits_commit_update() which runs 
>>    holding q->limits_lock; so I think this attribute file should be protected
>>    with q->limits_lock and protecting it with q->sysfs_lock is not necessary. 
>>    Maybe we should move it under the same sets of attribute files which today
>>    runs with q->limits_lock held.
> 
> Yes, limits_lock sounds sensible here.
> 
>> 7. rq_affinity:
>>    Write to this attribute file makes atomic updates to q->flags: QUEUE_FLAG_SAME_COMP
>>    and QUEUE_FLAG_SAME_FORCE. These flags are also accessed from blk_mq_complete_need_ipi()
>>    using test_bit macro. As read/write to q->flags uses bitops which are atomic, 
>>    protecting it with q->stsys_lock is not necessary.
> 
> Agreed.  Although updating both flags isn't atomic that should be
> harmless in this case (but could use a comment about that).
Sure will add comment about this.
> 
>> 8. scheduler:
>>    Write to this attribute actually updates q->elevator and the elevator change/switch 
>>    code expects that the q->sysfs_lock is held while we update the iosched to protect 
>>    against the simultaneous __blk_mq_update_nr_hw_queues update. So yes, this field needs 
>>    q->sysfs_lock protection.
>>
>>    However if we're thinking of protecting sched change/update using q->tag_sets->
>>    tag_list_lock (as discussed in another thread), then we may use q->tag_set->
>>    tag_list_lock instead of q->sysfs_lock here while reading/writing to this attribute
>>    file.
> 
> Yes.
> 
>> 9. wbt_lat_usec:
>>    Write to this attribute file updates the various wbt limits and state. This may race 
>>    with blk_mq_exit_sched() or blk_register_queue(). The wbt updates through the 
>>    blk_mq_exit_sched() and blk_register_queue() is currently protected with q->sysfs_lock
>>    and so yes, we need to protect this attribute with q->sysfs_lock.
>>
>>    However, as mentioned above, if we're thinking of protecting elevator change/update
>>    using q->sets->tag_list_lock then we may use q->tag_set->tag_list_lock intstead of
>>    q->sysfs_lock while reading/writing to this attribute file.
> 
> Yes.
> 
>> The rest of attributes seems don't require protection from q->sysfs_lock or any other lock and 
>> those could be well protected with the sysfs/kernfs internal lock.
> 
> So I think the first step here is to remove the locking from
> queue_attr_store/queue_attr_show and move it into the attributes that
> still need it in some form, followed by replacing it with the more
> suitable locks as defined above.  And maybe with a little bit more
> work we can remove sysfs_lock entirely eventually.
Yes this sounds like a good plan! 

Thank you Christoph for your review! And as you suggested, in another thread, 
I'd wait some more time for Jens and Ming, if in case they have any further 
comments about this change.

Thanks,
--Nilay

