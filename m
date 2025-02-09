Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182021DF737
	for <linux-block@vger.kernel.org>; Sun,  9 Feb 2025 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739108498; cv=none; b=eD429ogbT4yl0zPWKnKKvRfqu6/YAopoeZNqEaPO50RsD9RigdkJRNsM+75RrVHDXIXybwrfpD+pdLGN4dNojjjScRDPvMUpYzPqR7BHTh0Wrr0wR2MwOgXnDexn/Neqfy8vwJH2gdAzZ8+hiVxKFZg1G5/niuavS/SYxo1JByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739108498; c=relaxed/simple;
	bh=OCJ7zYy7z1QNlb6NS737jNb+3iVv8hFDyqADOym4pOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qN24S5OZellMk6KuKUXMS4gvwYArHoL9gnA6xZ7oVcY5VmQs3RDURine57AqQvlQ6VsdV48uWXieHwoC1ncevwe6Ggel+Vj9somto7oKoGOU6Xh1IW8WI+jJQX4nFc6nSNTqNQlweIbcB1FWre2AjC7vcfuZMsOOsw77HSXzUDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mDy75YRr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mDy75YRr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5199Oqfj003249;
	Sun, 9 Feb 2025 13:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MnObBl
	+2UlfKxQCd68PpUJqgyYQCdNWmBWzHLNQJtGg=; b=mDy75YRr7xU0xin+4WNl9d
	pyDtHXRNYXUzSgY+91K5WyMBlsGsJJhShQmSkaDAThG7jtznaf47WWlj+52IKGpC
	K3it401lGMXDTtnKkK8TTKCaeOGxr+TViQc3Y5bKsrdDNO3CHylOdj3E37cZo6KM
	TRrh9/MfMPFo21fmXpmrjl7SCAq85s4l1rTdls+xNvUdogvoiTsVvdppSdK/CBLU
	fqnyFMZhrztAQS8+p8z47sUKrC8B+a8nWTJ8rXwFtVRPeEgbkrYjw41djHvMo9/1
	o3X8L2pS0X1ZZR5kpDmrpc+J7FuKuw+bhAmM6L2pQVUE9nGmnK1P/2PBZ3+4d0TQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44pr2nrxev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Feb 2025 13:41:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5198GLdE011677;
	Sun, 9 Feb 2025 13:41:15 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44pktjhqxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Feb 2025 13:41:15 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 519DfFNV27918892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Feb 2025 13:41:15 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 750BD58056;
	Sun,  9 Feb 2025 13:41:15 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24FA558061;
	Sun,  9 Feb 2025 13:41:13 +0000 (GMT)
Received: from [9.171.51.217] (unknown [9.171.51.217])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  9 Feb 2025 13:41:12 +0000 (GMT)
Message-ID: <8a2b3944-8258-46bd-be12-737126cf6f69@linux.ibm.com>
Date: Sun, 9 Feb 2025 19:11:11 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: avoid acquiring q->sysfs_lock while accessing
 sysfs attributes
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        dlemoal@kernel.org, axboe@kernel.dk, gjoyce@ibm.com
References: <20250205144506.663819-1-nilay@linux.ibm.com>
 <20250205144506.663819-3-nilay@linux.ibm.com> <20250205155330.GA14133@lst.de>
 <f933e87a-6014-434a-8258-d871c77ca14c@linux.ibm.com>
 <Z6c0xvOFGYrGqxCd@fedora>
 <4d7bb88c-9e1d-48dd-8d67-4b8c4948c4a8@linux.ibm.com>
 <Z6iUcqtqwAiJpU7-@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z6iUcqtqwAiJpU7-@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B7k4_FNwUI6K6quKbgbiLhepZ283-CXD
X-Proofpoint-ORIG-GUID: B7k4_FNwUI6K6quKbgbiLhepZ283-CXD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-09_06,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502090120



On 2/9/25 5:11 PM, Ming Lei wrote:
> On Sat, Feb 08, 2025 at 06:26:38PM +0530, Nilay Shroff wrote:
>>
>>
>> On 2/8/25 4:11 PM, Ming Lei wrote:
>>> On Thu, Feb 06, 2025 at 07:24:02PM +0530, Nilay Shroff wrote:
>>>>
>>>>
>>>> On 2/5/25 9:23 PM, Christoph Hellwig wrote:
>>>>> On Wed, Feb 05, 2025 at 08:14:48PM +0530, Nilay Shroff wrote:
>>>>>> The sysfs attributes are already protected with sysfs/kernfs internal
>>>>>> locking. So acquiring q->sysfs_lock is not needed while accessing sysfs
>>>>>> attribute files. So this change helps avoid holding q->sysfs_lock while
>>>>>> accessing sysfs attribute files.
>>>>>
>>>>> the sysfs/kernfs locking only protects against other accesses using
>>>>> sysfs.  But that's not really the most interesting part here.  We
>>>>> also want to make sure nothing changes underneath in a way that
>>>>> could cause crashes (and maybe even torn information).
>>>>>
>>>>> We'll really need to audit what is accessed in each method and figure
>>>>> out what protects it.  Chances are that sysfs_lock provides that
>>>>> protection in some case right now, and chances are also very high
>>>>> that a lot of this is pretty broken.
>>>>>
>>>> Yes that's possible and so I audited all sysfs attributes which are 
>>>> currently protected using q->sysfs_lock and I found some interesting
>>>> facts. Please find below:
>>>>
>>>> 1. io_poll:
>>>>    Write to this attribute is ignored. So, we don't need q->sysfs_lock.
>>>>
>>>> 2. io_poll_delay:
>>>>    Write to this attribute is NOP, so we don't need q->sysfs_lock.
>>>>
>>>> 3. io_timeout:
>>>>    Write to this attribute updates q->rq_timeout and read of this attribute
>>>>    returns the value stored in q->rq_timeout Moreover, the q->rq_timeout is
>>>>    set only once when we init the queue (under blk_mq_init_allocated_queue())
>>>>    even before disk is added. So that means that we may not need to protect
>>>>    it with q->sysfs_lock.
>>>>
>>>> 4. nomerges:
>>>>    Write to this attribute file updates two q->flags : QUEUE_FLAG_NOMERGES 
>>>>    and QUEUE_FLAG_NOXMERGES. These flags are accessed during bio-merge which
>>>>    anyways doesn't run with q->sysfs_lock held. Moreover, the q->flags are 
>>>>    updated/accessed with bitops which are atomic. So, I believe, protecting
>>>>    it with q->sysfs_lock is not necessary.
>>>>
>>>> 5. nr_requests:
>>>>    Write to this attribute updates the tag sets and this could potentially
>>>>    race with __blk_mq_update_nr_hw_queues(). So I think we should really 
>>>>    protect it with q->tag_set->tag_list_lock instead of q->sysfs_lock.
>>>>
>>>> 6. read_ahead_kb:
>>>>    Write to this attribute file updates disk->bdi->ra_pages. The disk->bdi->
>>>>    ra_pages is also updated under queue_limits_commit_update() which runs 
>>>>    holding q->limits_lock; so I think this attribute file should be protected
>>>>    with q->limits_lock and protecting it with q->sysfs_lock is not necessary. 
>>>>    Maybe we should move it under the same sets of attribute files which today
>>>>    runs with q->limits_lock held.
>>>>
>>>> 7. rq_affinity:
>>>>    Write to this attribute file makes atomic updates to q->flags: QUEUE_FLAG_SAME_COMP
>>>>    and QUEUE_FLAG_SAME_FORCE. These flags are also accessed from blk_mq_complete_need_ipi()
>>>>    using test_bit macro. As read/write to q->flags uses bitops which are atomic, 
>>>>    protecting it with q->stsys_lock is not necessary.
>>>>
>>>> 8. scheduler:
>>>>    Write to this attribute actually updates q->elevator and the elevator change/switch 
>>>>    code expects that the q->sysfs_lock is held while we update the iosched to protect 
>>>>    against the simultaneous __blk_mq_update_nr_hw_queues update. So yes, this field needs 
>>>>    q->sysfs_lock protection.
>>>>
>>>>    However if we're thinking of protecting sched change/update using q->tag_sets->
>>>>    tag_list_lock (as discussed in another thread), then we may use q->tag_set->
>>>>    tag_list_lock instead of q->sysfs_lock here while reading/writing to this attribute
>>>>    file.
>>>
>>> This is one misuse of tag_list_lock, which is supposed to cover host
>>> wide change, and shouldn't be used for request queue level protection,
>>> which is exactly provided by q->sysfs_lock.
>>>
>> Yes I think Christoph was also pointed about the same but then assuming 
>> schedule/elevator update would be a rare operation it may not cause
>> a lot of contention. Having said that, I'm also fine creating another 
>> lock just to protect elevator changes and removing ->sysfs_lock from 
>> elevator code.
> 
> Then please use new lock.
Okay, I will replace q->sysfs_lock with another dedicated lock for synchronizing
elevator switch and nr_hw_queue update and that would help eliminate dependency 
between the q->q_usage_counter(io) (or freeze-lock) and the q->sysfs_lock. 
> 
>>
>>> Not mention it will cause ABBA deadlock over freeze lock, please see
>>> blk_mq_update_nr_hw_queues(). And it can't be used for protecting
>>> 'nr_requests' too.
>> I don't know how this might cause ABBA deadlock. The proposal here's to 
>> use ->tag_list_lock (instead of ->sysfs_lock) while updating scheduler 
>> attribute from sysfs as well as while we update the elevator through 
>> __blk_mq_update_nr_hw_queues().
>>
>> In each code path (either from sysfs attribute update or from nr_hw_queues 
>> update), we first acquire ->tag_list_lock and then freeze-lock.
>>
>> Do you see any code path where the above order might not be followed?  	
> 
> You patch 14ef49657ff3 ("block: fix nr_hw_queue update racing with disk addition/removal")
> has added one such warning:  blk_mq_sysfs_unregister() is called after
> queue freeze lock is grabbed from del_gendisk()
> 
> Also there are many such use cases in nvme: blk_mq_quiesce_tagset()/blk_mq_unquiesce_tagset()
> called after tagset is frozen.
> 
> More serious, driver may grab ->tag_list_lock in error recovery code for
> providing forward progress, you have to be careful wrt. using ->tag_list_lock,
> for example:
> 
> 	mutex_lock(->tag_list_lock)
> 	blk_mq_freeze_queue()		// If IO timeout happens, the driver timeout
> 								// handler stuck on mutex_lock(->tag_list_lock)

Ok got it! But lets wait for a bit if Christoph or others have any further comment before
I start making this change.

Thanks,
--Nilay 

