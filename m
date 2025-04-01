Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F66020127A;
	Tue,  1 Apr 2025 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743510580; cv=none; b=l/qi0SM8HBbHf/R5ILdmwZrbz1I0dOA7JKDiu7ytptqr5bF5E3IaYTllIuf7nYCLY8RFvuuddPOTC4A+q9oRlGKKlBWpcrK/nuoVStdBLyjP80fj8nKz+3B8vXWGuMuQr1tTMyQWCqn+CICDy3+Ilk652LOAhR7njMXXP/W0ZXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743510580; c=relaxed/simple;
	bh=mwp6SfGSGRR8aH7f2Gy4yBvJ9Xx7Jizozw+CeQUhbwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPP0qhSO77cgLTC4J9dZ3+NQ/dHBOLvzA5S8DyFVtQMNBlDOm/gN6NZRE78OJPw1HbBzAaHibTZDuMDW5He16bp4pfJqwyYEIbEC93O2Aoqr982a+xSebB7zx5T2/3N5NoUDmsRbpt+gqMGG/ocxGsvc+KuDLhBmqnfxFBHe3gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j50s2DUd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j50s2DUd"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5318oVnj031090;
	Tue, 1 Apr 2025 12:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TxynqP
	Q6OuxZI4/kGp1OKERQSGA5OvWCZlG7IZYi9Dg=; b=j50s2DUdRKGJefiOUjdOOm
	YSoyKfwUC0OyEXHWdSfdRl18akgpR2w9/iRx+nr0YcQKPxzm1PRg8X+YYDrs75uR
	7vN8xJwPqmVVaxEsfphrho/HCg5bRp8YZMxI7b8mhREIHYOKPebUjauvo8VFKa0Q
	NaYkSJ4kVbA0nOY5+WUcbWd5Ddi2zLb9+RMAaSP9mozRMCJHf66oZYGHDjiboJRv
	MQKqvGheCZGdk85GRrurDA8zYAOTxtESkC/qFloY0T0z1S+fV+VxyID6j+kM2//i
	mm9fecwwIZ433ISZny0ryVoaaGdPlwOOMIra+ITO+JIqtlMr96sFc7vLh/P0qjfg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45r27q3j77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 12:29:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 531CFxjp004757;
	Tue, 1 Apr 2025 12:29:34 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pujytm4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 12:29:34 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 531CTXIh32899720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Apr 2025 12:29:34 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3EAA58068;
	Tue,  1 Apr 2025 12:29:33 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBB555804B;
	Tue,  1 Apr 2025 12:29:31 +0000 (GMT)
Received: from [9.109.198.185] (unknown [9.109.198.185])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Apr 2025 12:29:31 +0000 (GMT)
Message-ID: <e7db2242-483d-4225-b7f7-5ec6305b7263@linux.ibm.com>
Date: Tue, 1 Apr 2025 17:59:29 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] possible deadlock in elv_iosched_store
To: Ming Lei <ming.lei@redhat.com>
Cc: syzbot <syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <67e6b425.050a0220.2f068f.007b.GAE@google.com>
 <Z-dUCLvf06SfTOHy@fedora>
 <462d4e8a-dd95-48fe-b9fe-a558057f9595@linux.ibm.com>
 <Z-vZE2pyrg4_I2SV@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z-vZE2pyrg4_I2SV@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 90Fo8jASJrt-fVtnI_XukkAtGNr6F3-h
X-Proofpoint-GUID: 90Fo8jASJrt-fVtnI_XukkAtGNr6F3-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504010076



On 4/1/25 5:46 PM, Ming Lei wrote:
> On Tue, Apr 01, 2025 at 05:23:56PM +0530, Nilay Shroff wrote:
>>
>>
>> On 3/29/25 7:29 AM, Ming Lei wrote:
>>> On Fri, Mar 28, 2025 at 07:37:25AM -0700, syzbot wrote:
>>>> Hello,
>>>>
>>>> syzbot found the following issue on:
>>>>
>>>> HEAD commit:    1a9239bb4253 Merge tag 'net-next-6.15' of git://git.kernel..
>>>> git tree:       upstream
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1384b43f980000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c7163a109ac459a8
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=4c7e0f9b94ad65811efb
>>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178cfa4c580000
>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a8ca4c580000
>>>>
>>>> Downloadable assets:
>>>> disk image: https://storage.googleapis.com/syzbot-assets/fc7dc9f0d9a7/disk-1a9239bb.raw.xz
>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/f555a3ae03d3/vmlinux-1a9239bb.xz
>>>> kernel image: https://storage.googleapis.com/syzbot-assets/55f6ea74eaf2/bzImage-1a9239bb.xz
>>>>
>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>> Reported-by: syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
>>>>
>>>
>>> ...
>>>
>>>>
>>>> If you want syzbot to run the reproducer, reply with:
>>>> #syz test: git://repo/address.git branch-or-commit-hash
>>>> If you attach or paste a git patch, syzbot will apply it before testing.
>>>
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index ae8494d88897..d7a103dc258b 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -4465,14 +4465,12 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
>>>  	return NULL;
>>>  }
>>>  
>>> -static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>>> -						struct request_queue *q)
>>> +static void __blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>>> +				     struct request_queue *q)
>>>  {
>>>  	struct blk_mq_hw_ctx *hctx;
>>>  	unsigned long i, j;
>>>  
>>> -	/* protect against switching io scheduler  */
>>> -	mutex_lock(&q->elevator_lock);
>>>  	for (i = 0; i < set->nr_hw_queues; i++) {
>>>  		int old_node;
>>>  		int node = blk_mq_get_hctx_node(set, i);
>>> @@ -4505,7 +4503,19 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>>>  
>>>  	xa_for_each_start(&q->hctx_table, j, hctx, j)
>>>  		blk_mq_exit_hctx(q, set, hctx, j);
>>> -	mutex_unlock(&q->elevator_lock);
>>> +}
>>> +
>>> +static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>>> +				   struct request_queue *q, bool lock)
>>> +{
>>> +	if (lock) {
>>> +		/* protect against switching io scheduler  */
>>> +		mutex_lock(&q->elevator_lock);
>>> +		__blk_mq_realloc_hw_ctxs(set, q);
>>> +		mutex_unlock(&q->elevator_lock);
>>> +	} else {
>>> +		__blk_mq_realloc_hw_ctxs(set, q);
>>> +	}
>>>  
>>>  	/* unregister cpuhp callbacks for exited hctxs */
>>>  	blk_mq_remove_hw_queues_cpuhp(q);
>>> @@ -4537,7 +4547,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>>>  
>>>  	xa_init(&q->hctx_table);
>>>  
>>> -	blk_mq_realloc_hw_ctxs(set, q);
>>> +	blk_mq_realloc_hw_ctxs(set, q, false);
>>>  	if (!q->nr_hw_queues)
>>>  		goto err_hctxs;
>>>  
>>> @@ -5033,7 +5043,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>>  fallback:
>>>  	blk_mq_update_queue_map(set);
>>>  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>> -		blk_mq_realloc_hw_ctxs(set, q);
>>> +		blk_mq_realloc_hw_ctxs(set, q, true);
>>>  
>>>  		if (q->nr_hw_queues != set->nr_hw_queues) {
>>>  			int i = prev_nr_hw_queues;
>>>
>>
>> This patch looks good to me, however after we fix this one, I found another splat. 
>> I see that these new splats are side effect of commit ffa1e7ada456 ("block: Make 
>> request_queue lockdep splats show up earlier").
>>
>> IMO in the block layer code (unless it's in an IO submission path or a path where we 
>> have already frozen queue) we may still want to allow memory allocation with GFP_KERNEL. 
>> So in that sense, for example, we may acquire ->elevator_lock followed by fs_reclaim. 
> 
> If any memory GFP_KERNEL allocation grabs ->elevator_lock, it is one real
> deadlock risk.
> 
>> Or in another words, shouldn't it be legitimate to acquire blk layer specific lock and 
>> then allocate memory using GFP_KERNEL assuming we haven't freezed queue or we're not in 
>> IO submission path. But this commit ffa1e7ada456 ("block: Make request_queue lockdep
>> splats show up earlier") now showing up some false-positive splat as well, please see
>> below:
> 
> It depends if we may run GFP_KERNEL allocation with ->elevator_lock.
> 
Okay, so do you think we shall use GFP_NOIO for memory allocation if it's done after we
acquire ->elevator_lock?

Thanks,
--Nilay

