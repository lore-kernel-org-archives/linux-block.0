Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953D423F276
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877300; cv=none; b=KWEaOfw45XmtCXztbdRIVQdMkWYXsB1LpYgRMuAOsBOnBLNnBFkqmDZT51nth/EoKwek1wjEfI3rh9XRn6JFQ3OsVTfzI+ArfEqqWrWcx/sltW+9pUu1EkHXl9dk6sQ4/fmTBkC9bO9vevcFZupbr8eRVVffnWR49XFdCgN44oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877300; c=relaxed/simple;
	bh=LAm0a+piwwvujLBXANpJSTGdsQtHiWmfsC3+BBCnzTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YoKYfhXxS3BxKTJhJ78J4sgoOyXERcsEb3i++Crf+9sD/AfXLfBPEXVDNIpWEEJhrLHsNv0zwqiHvfB/eij46eAX2bEHX5aQ/mO0e/6QPdHUoLYhlIe+NX246LBYpbsdaEdoCnIN/YxtGLQvwRlhuVw4iPV1t2vlrs78MZOwUZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LTWvLtVQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LTWvLtVQ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51I5NtgH009756;
	Tue, 18 Feb 2025 11:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=twV6iP
	LxfVAqJWF2Zw5u+RGhxA8myjSbjznES6CgLZI=; b=LTWvLtVQ8VlqBV8ofDUErU
	81SYO2MMNsHmTn3So9mpopaHZPyvYzwIpLHV0i4mXWJ84xKao9KN9vB5uuKO7odg
	M5fyS6pw/+a3J7OI9lenxW2kp6YRX4l9xAq67GfBiLm9hATXc0OPUyqBdzUcWQex
	WwKSIEu+jzQ8+OspjlDex8ARqoryq5fNB2e+uYpbYZx/ffkfYEQqAavL+we2impx
	62Q5VgvBInSqPt81nhhBawrbwFv5VjJR4Ms9OHcYE0Q7Gz8z1S4UDhFY3jPng4ib
	kzGPFrN4A0Ti6+wZ7d43k6YDfKzAmIWIBQZJ+s+2fhi08gcGoRM2NV8cfhGPuhXA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vm18sgv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 11:14:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51I9lAZF008133;
	Tue, 18 Feb 2025 11:14:49 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44u58tjxuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 11:14:49 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51IBEm7C3932758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 11:14:48 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DF4E5805B;
	Tue, 18 Feb 2025 11:14:48 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3640B58055;
	Tue, 18 Feb 2025 11:14:46 +0000 (GMT)
Received: from [9.109.198.198] (unknown [9.109.198.198])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Feb 2025 11:14:45 +0000 (GMT)
Message-ID: <e54fc76f-2bb8-4d22-b297-7cd1c94b7e88@linux.ibm.com>
Date: Tue, 18 Feb 2025 16:44:44 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 3/6] block: Introduce a dedicated lock for protecting
 queue elevator updates
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20250218082908.265283-1-nilay@linux.ibm.com>
 <20250218082908.265283-4-nilay@linux.ibm.com> <20250218090516.GA12269@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250218090516.GA12269@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Piwycs4H6EXPDfCAYsoiTK3DuWWpu8tw
X-Proofpoint-ORIG-GUID: Piwycs4H6EXPDfCAYsoiTK3DuWWpu8tw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_04,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180086



On 2/18/25 2:35 PM, Christoph Hellwig wrote:
> On Tue, Feb 18, 2025 at 01:58:56PM +0530, Nilay Shroff wrote:
>> As the scope of q->sysfs_lock is not well-defined, its misuse has
>> resulted in numerous lockdep warnings. To resolve this, replace q->
>> sysfs_lock with a new dedicated q->elevator_lock, which will be
>> exclusively used to protect elevator switching and updates.
> 
> Well, it's not replacing q->sysfs_lock as that is still around.
> It changes some data to now be protected by elevator_lock instead,
> and you should spell out which, preferably in a comment next to the
> elevator_lock definition (I should have done the same for limits_lock
> despite the trivial applicability to the limits field).
> 
>>  	/* q->elevator needs protection from ->sysfs_lock */
>> -	mutex_lock(&q->sysfs_lock);
>> +	mutex_lock(&q->elevator_lock);
> 
> Well, the above comment is no trivially wrong.
Yes I will update comment, I don't know how I missed updating it :(
> 
>>  
>>  	/* the check has to be done with holding sysfs_lock */
> 
> Same for this one.

> They could probably go away with the proper comments near elevator_lock
> itself.
yes I will add proper comment.

> 
>>  static ssize_t queue_requests_show(struct gendisk *disk, char *page)
>>  {
>> -	return queue_var_show(disk->queue->nr_requests, page);
>> +	int ret;
>> +
>> +	mutex_lock(&disk->queue->sysfs_lock);
>> +	ret = queue_var_show(disk->queue->nr_requests, page);
>> +	mutex_unlock(&disk->queue->sysfs_lock);
> 
> This also shifts taking sysfs_lock into the the ->show and ->store
> methods.  Which feels like a good thing, but isn't mentioned in the
> commit log or directly releate to elevator_lock.  Can you please move
> taking the locking into the methods into a preparation patch with a
> proper commit log?
Yes I would do add proper commit log as suggested

> Also it's pretty strange the ->store_nolock is
> now called with the queue frozen but ->store is not and both are
> called without any locks.  So I think part of that prep patch should
> also be moving the queue freezing into ->store and do away with
> the separate ->store_nolock, and just keep the special ->store_limit.
You are absolutely correct and that was my original plan to do away with
->store_nolock and ->show_nolock methods in the end however problem arised
due to "read_ahead_kb" attribute. As you know, "read_ahead_kb" requires
update outside of atomic limit APIs (for the reason mentioned in last 
patch comment as well as in the cover letter).  So we can't move 
"read_ahead_kb" into ->store_limit. For updating "read_ahead_kb", 
we follow the below sequence:

lock ->limits_lock
  lock ->freeze_lock
    update bdi->ra_pages
  unlock ->freeze_lock
unlock ->limits_lock

As you could see above, we have to take ->limits_lock before ->freeze_lock 
while updating ra_pages (doing the opposite would surely trigger lockdep 
splat). However for attributes which are grouped under ->store_nolock the
update sequence is:

lock ->freeze_lock 
  invoke attribute specific store method
unlock ->freeze_lock.

So now if you suggest keeping only ->store and do away with ->store_nolock
method then we have to move feeze-lock inside each attributes' corresponding 
store method as we can't keep freeze-lock under ->store in queue_attr_store().

> There's also no more need for ->lock_module when the elevator store
> method is called unfrozen and without a lock.
>
yes agreed, I would remove ->load_module and we can now load module 
from elevator ->store method directly before we freeze the queue.

> ->show and ->show_nolock also are identical now and can be done
> away with.
> 
Yes this is possible and I just kept it for pairing show_nolock with
store_nolock. But I would remove it.

> So maybe shifting the freezing and locking into the methods should go
> very first, before dropping the lock for the attributes that don't it?
> 
Yes this can be done. I will add it when I spin next patchset.
 
Thanks,
--Nilay
