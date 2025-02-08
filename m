Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB3819F101
	for <linux-block@vger.kernel.org>; Sat,  8 Feb 2025 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739019416; cv=none; b=ZIl7LBgctalbUAHmCdSiNg3K57/S4ICYWEUA6EAiutmyExvVgy1ToUljAMhwPPhvdCrKNNh5vgqtVaxdxoglL/ytetbC79cPHDs+zhXMxVj6VOr5CJq4g0gJ2YuThBE2TA+wkrJyg9KUo4/SHNOB19HHf6LZbloZPhq4O0QuTAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739019416; c=relaxed/simple;
	bh=5RSQPJx0Bv12HU0SzbazXpfDXhE+kxrbjoA8bj6cpMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQimoebY0QTWm39y4dLw63m12Jxssun4oGz9P5rvVm9lCaKpLGVL+f8dRZ4LJ/bhZPaXz9pF1H0IWnvUpolT+9R1pEM75Zb0EqOota8HnbThutMnlUPa+7D6TkQpLVd3d6aG94VeszkwwGQlj2kZDm2YQPSxUovY4Iy8MgbZHOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VOArdwgb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VOArdwgb"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 518B02A0014974;
	Sat, 8 Feb 2025 12:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RAY9Xz
	bDKeJBZexDd11LzL6C5ha0MMbj2N+v3+OXTUQ=; b=VOArdwgb0urGDn/nl757/i
	2LNmm3UFr2JwHa/ZTtkul0/Pp5e7BBEbhs/1VjcrRnqSYifNnc8CNjBfRYv3AM7d
	z6/Yu4V0MnTR56HpS80veTVrpJz3t3uRFUVpLK0HloaZH6eTBe4swFqKAdw5dSQl
	bsN1BpSc1EoeSJPjVbLZY4hr+9ilm8VkjhuPekka2mRTR0K63J2TnYVI5nUgzjmP
	mNPTWijl6JosJiYeOcqP9ylrZnkGcsJ4eFEglBmleZViXFOSCE+WiYzQMV5ztd3t
	5JyP053kxFRG/n302LTt5SvKDEIdIfl8Vy35hcktm1fq8l/+UPJafWCGG9GT0oKA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44p0x316fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Feb 2025 12:56:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5189njhm024540;
	Sat, 8 Feb 2025 12:56:44 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxxnr3s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Feb 2025 12:56:44 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 518CuhAP19530400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Feb 2025 12:56:43 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1589558043;
	Sat,  8 Feb 2025 12:56:43 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F4425805D;
	Sat,  8 Feb 2025 12:56:40 +0000 (GMT)
Received: from [9.171.81.239] (unknown [9.171.81.239])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  8 Feb 2025 12:56:40 +0000 (GMT)
Message-ID: <4d7bb88c-9e1d-48dd-8d67-4b8c4948c4a8@linux.ibm.com>
Date: Sat, 8 Feb 2025 18:26:38 +0530
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
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z6c0xvOFGYrGqxCd@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fbeRd7jR-h0i2GkDKNNq_PnFbVp0Eufq
X-Proofpoint-ORIG-GUID: fbeRd7jR-h0i2GkDKNNq_PnFbVp0Eufq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-08_05,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502080099



On 2/8/25 4:11 PM, Ming Lei wrote:
> On Thu, Feb 06, 2025 at 07:24:02PM +0530, Nilay Shroff wrote:
>>
>>
>> On 2/5/25 9:23 PM, Christoph Hellwig wrote:
>>> On Wed, Feb 05, 2025 at 08:14:48PM +0530, Nilay Shroff wrote:
>>>> The sysfs attributes are already protected with sysfs/kernfs internal
>>>> locking. So acquiring q->sysfs_lock is not needed while accessing sysfs
>>>> attribute files. So this change helps avoid holding q->sysfs_lock while
>>>> accessing sysfs attribute files.
>>>
>>> the sysfs/kernfs locking only protects against other accesses using
>>> sysfs.  But that's not really the most interesting part here.  We
>>> also want to make sure nothing changes underneath in a way that
>>> could cause crashes (and maybe even torn information).
>>>
>>> We'll really need to audit what is accessed in each method and figure
>>> out what protects it.  Chances are that sysfs_lock provides that
>>> protection in some case right now, and chances are also very high
>>> that a lot of this is pretty broken.
>>>
>> Yes that's possible and so I audited all sysfs attributes which are 
>> currently protected using q->sysfs_lock and I found some interesting
>> facts. Please find below:
>>
>> 1. io_poll:
>>    Write to this attribute is ignored. So, we don't need q->sysfs_lock.
>>
>> 2. io_poll_delay:
>>    Write to this attribute is NOP, so we don't need q->sysfs_lock.
>>
>> 3. io_timeout:
>>    Write to this attribute updates q->rq_timeout and read of this attribute
>>    returns the value stored in q->rq_timeout Moreover, the q->rq_timeout is
>>    set only once when we init the queue (under blk_mq_init_allocated_queue())
>>    even before disk is added. So that means that we may not need to protect
>>    it with q->sysfs_lock.
>>
>> 4. nomerges:
>>    Write to this attribute file updates two q->flags : QUEUE_FLAG_NOMERGES 
>>    and QUEUE_FLAG_NOXMERGES. These flags are accessed during bio-merge which
>>    anyways doesn't run with q->sysfs_lock held. Moreover, the q->flags are 
>>    updated/accessed with bitops which are atomic. So, I believe, protecting
>>    it with q->sysfs_lock is not necessary.
>>
>> 5. nr_requests:
>>    Write to this attribute updates the tag sets and this could potentially
>>    race with __blk_mq_update_nr_hw_queues(). So I think we should really 
>>    protect it with q->tag_set->tag_list_lock instead of q->sysfs_lock.
>>
>> 6. read_ahead_kb:
>>    Write to this attribute file updates disk->bdi->ra_pages. The disk->bdi->
>>    ra_pages is also updated under queue_limits_commit_update() which runs 
>>    holding q->limits_lock; so I think this attribute file should be protected
>>    with q->limits_lock and protecting it with q->sysfs_lock is not necessary. 
>>    Maybe we should move it under the same sets of attribute files which today
>>    runs with q->limits_lock held.
>>
>> 7. rq_affinity:
>>    Write to this attribute file makes atomic updates to q->flags: QUEUE_FLAG_SAME_COMP
>>    and QUEUE_FLAG_SAME_FORCE. These flags are also accessed from blk_mq_complete_need_ipi()
>>    using test_bit macro. As read/write to q->flags uses bitops which are atomic, 
>>    protecting it with q->stsys_lock is not necessary.
>>
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
> This is one misuse of tag_list_lock, which is supposed to cover host
> wide change, and shouldn't be used for request queue level protection,
> which is exactly provided by q->sysfs_lock.
> 
Yes I think Christoph was also pointed about the same but then assuming 
schedule/elevator update would be a rare operation it may not cause
a lot of contention. Having said that, I'm also fine creating another 
lock just to protect elevator changes and removing ->sysfs_lock from 
elevator code.

> Not mention it will cause ABBA deadlock over freeze lock, please see
> blk_mq_update_nr_hw_queues(). And it can't be used for protecting
> 'nr_requests' too.
I don't know how this might cause ABBA deadlock. The proposal here's to 
use ->tag_list_lock (instead of ->sysfs_lock) while updating scheduler 
attribute from sysfs as well as while we update the elevator through 
__blk_mq_update_nr_hw_queues().

In each code path (either from sysfs attribute update or from nr_hw_queues 
update), we first acquire ->tag_list_lock and then freeze-lock.

Do you see any code path where the above order might not be followed?  	

Thanks,
--Nilay
