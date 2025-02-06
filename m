Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555911EA7D9
	for <linux-block@vger.kernel.org>; Thu,  6 Feb 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738850064; cv=none; b=Evjl7No9+6RuHMJhXjWYJh/C3LfJXMfNUI8P5UP82nl9QmRQmEo1e2kWXz3c/7I7X4gWQifLzUn15mCB+WdjiZblnLsNpS4JIZaxUciVDYA3urUjQci3PQVqovnQeg6O4E5NdqjZTsPTjuyMw/+86WENUc6yNQTht0pvxbIsjyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738850064; c=relaxed/simple;
	bh=RCAzsfZWiMdB27iP0pJfhYtcIK46h72bKDVqW8ookfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gruhr200W9UJvPz22AM37vU5URFGPZPtbn0xTR99bBLqS0OI5YGGGlloZTPoZM0w0CfrZfhc0wwrTASIuXbuet6FEm/0pCYH1NRd5bu37k+7FJf5mlE8rSdpyu0GtyA6PICul0fISQyovXVUt7R6dk0mbxVrtsXKl7TkBRF1kX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NeqXQYM0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NeqXQYM0"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516DNK3Q024293;
	Thu, 6 Feb 2025 13:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Og7gVX
	Imx45X1iPG0cMkAt626gEB5b3754elsPKkdFQ=; b=NeqXQYM0X1WKv7wlHuMayA
	MuAzGqucc8ogKQk9Cq2OWFq3q546H2NLNLFyL31POJudbQ/NCDUWbBaVVukWI37K
	xxX0ZYsdAvksPdb82UuLRt74wARoH98hVNkldR4/HdgGduCFmeQXKV0PCFh2qTN/
	QcfjZMmrI2BcRbuoV5Qs/SUqjoumvrUYXJoj2ssxP5g9XsW6zkxV0nMZ665ACDXQ
	b3JE1qLksEjhhbR/W7asETllzd4qKTATEj6wHJpv4lxO8i5YbrmKl1Qtpts0+YiR
	Ct4ugmtZYZ/+soL1Tc0s2iW5dsUMQcQui3PDQfMj2OvtOQHtu61F6UA1thC2fNYg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44mattdt95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 13:54:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 516CoLh3021489;
	Thu, 6 Feb 2025 13:54:06 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j0n1p8j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Feb 2025 13:54:06 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 516Ds51D12714538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Feb 2025 13:54:06 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF18858052;
	Thu,  6 Feb 2025 13:54:05 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9736458056;
	Thu,  6 Feb 2025 13:54:03 +0000 (GMT)
Received: from [9.109.198.254] (unknown [9.109.198.254])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Feb 2025 13:54:03 +0000 (GMT)
Message-ID: <f933e87a-6014-434a-8258-d871c77ca14c@linux.ibm.com>
Date: Thu, 6 Feb 2025 19:24:02 +0530
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
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250205155330.GA14133@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a8dN80tKSvUdgJfRcXwQutpDphAsWhle
X-Proofpoint-ORIG-GUID: a8dN80tKSvUdgJfRcXwQutpDphAsWhle
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 adultscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=808 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060111



On 2/5/25 9:23 PM, Christoph Hellwig wrote:
> On Wed, Feb 05, 2025 at 08:14:48PM +0530, Nilay Shroff wrote:
>> The sysfs attributes are already protected with sysfs/kernfs internal
>> locking. So acquiring q->sysfs_lock is not needed while accessing sysfs
>> attribute files. So this change helps avoid holding q->sysfs_lock while
>> accessing sysfs attribute files.
> 
> the sysfs/kernfs locking only protects against other accesses using
> sysfs.  But that's not really the most interesting part here.  We
> also want to make sure nothing changes underneath in a way that
> could cause crashes (and maybe even torn information).
> 
> We'll really need to audit what is accessed in each method and figure
> out what protects it.  Chances are that sysfs_lock provides that
> protection in some case right now, and chances are also very high
> that a lot of this is pretty broken.
> 
Yes that's possible and so I audited all sysfs attributes which are 
currently protected using q->sysfs_lock and I found some interesting
facts. Please find below:

1. io_poll:
   Write to this attribute is ignored. So, we don't need q->sysfs_lock.

2. io_poll_delay:
   Write to this attribute is NOP, so we don't need q->sysfs_lock.

3. io_timeout:
   Write to this attribute updates q->rq_timeout and read of this attribute
   returns the value stored in q->rq_timeout Moreover, the q->rq_timeout is
   set only once when we init the queue (under blk_mq_init_allocated_queue())
   even before disk is added. So that means that we may not need to protect
   it with q->sysfs_lock.

4. nomerges:
   Write to this attribute file updates two q->flags : QUEUE_FLAG_NOMERGES 
   and QUEUE_FLAG_NOXMERGES. These flags are accessed during bio-merge which
   anyways doesn't run with q->sysfs_lock held. Moreover, the q->flags are 
   updated/accessed with bitops which are atomic. So, I believe, protecting
   it with q->sysfs_lock is not necessary.

5. nr_requests:
   Write to this attribute updates the tag sets and this could potentially
   race with __blk_mq_update_nr_hw_queues(). So I think we should really 
   protect it with q->tag_set->tag_list_lock instead of q->sysfs_lock.

6. read_ahead_kb:
   Write to this attribute file updates disk->bdi->ra_pages. The disk->bdi->
   ra_pages is also updated under queue_limits_commit_update() which runs 
   holding q->limits_lock; so I think this attribute file should be protected
   with q->limits_lock and protecting it with q->sysfs_lock is not necessary. 
   Maybe we should move it under the same sets of attribute files which today
   runs with q->limits_lock held.

7. rq_affinity:
   Write to this attribute file makes atomic updates to q->flags: QUEUE_FLAG_SAME_COMP
   and QUEUE_FLAG_SAME_FORCE. These flags are also accessed from blk_mq_complete_need_ipi()
   using test_bit macro. As read/write to q->flags uses bitops which are atomic, 
   protecting it with q->stsys_lock is not necessary.

8. scheduler:
   Write to this attribute actually updates q->elevator and the elevator change/switch 
   code expects that the q->sysfs_lock is held while we update the iosched to protect 
   against the simultaneous __blk_mq_update_nr_hw_queues update. So yes, this field needs 
   q->sysfs_lock protection.

   However if we're thinking of protecting sched change/update using q->tag_sets->
   tag_list_lock (as discussed in another thread), then we may use q->tag_set->
   tag_list_lock instead of q->sysfs_lock here while reading/writing to this attribute
   file.

9. wbt_lat_usec:
   Write to this attribute file updates the various wbt limits and state. This may race 
   with blk_mq_exit_sched() or blk_register_queue(). The wbt updates through the 
   blk_mq_exit_sched() and blk_register_queue() is currently protected with q->sysfs_lock
   and so yes, we need to protect this attribute with q->sysfs_lock.

   However, as mentioned above, if we're thinking of protecting elevator change/update
   using q->sets->tag_list_lock then we may use q->tag_set->tag_list_lock intstead of
   q->sysfs_lock while reading/writing to this attribute file.

So yes, you've rightly guessed few of the above attributes are not well protected and few
still may require sysfs_lock protection. 

From the above list, I see that the "read_ahead_kb" should be protected with q->limits_lock.

The "nr_requests" should be protected with q->tag_set->tag_list_lock instead of q->sysfs_lock.

The "scheduler" and "wbt_lat_usec" require protection using either q->sysfs_lock or 
q->tag_set->tag_list_lock. 

The rest of attributes seems don't require protection from q->sysfs_lock or any other lock and 
those could be well protected with the sysfs/kernfs internal lock.

Thanks,
--Nilay

