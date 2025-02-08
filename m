Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BC2179BC
	for <linux-block@vger.kernel.org>; Sat,  8 Feb 2025 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739020749; cv=none; b=T0ey+nb21UoaSfKA/AmxSLPDaDEOvcTNFEFk4uFlXU7ZcK8zcTQ7b+mVEOVm/huch8xFOTEOgX5umh9uvuE3haZcWyezniYsl8K/ry9LmRNL75va225q7yug8FRGMZ+rdm5FOGqwfuiK+c+zDmesk19i8ybWZCdhlequXyHepTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739020749; c=relaxed/simple;
	bh=gJ+p+nL+2ZubnnChwgrFmQdUo2yD7zqpW7oMwnfw7oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pd0U3Ol1ZNqLLZhkex6bi4Uy2IArhk53CUdEA4behncLrGE5d82NuF8+fUVkYXUuczE/nVpE1k9ihFu4qO7st42E8omqIB8Bqs5/TYQd7vrQvKGOj79q9bEu9CTWq5SM1OxpSdFPakeI0Jz42/mky2jrJlpGuLcDkqgEI98EZ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s/4ckfbZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s/4ckfbZ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 518CDZJN028544;
	Sat, 8 Feb 2025 13:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wX8d9A
	P+7nCLejUc1EVhWXc3zPn9Y+Pk234meoyA62o=; b=s/4ckfbZsajCLQaXyslmj2
	SDhRsf+m5+ZUvQauYH6+LjhTH0Ckv2ww28VR/d1s2t4rqGt6eQvQLdlWdhghaJ0s
	tGel3PMp1WFuXcvxM+SdU7kbae6be49RxMpG32Qt1HGaaXHvwqAze/sSd41hVH/3
	XeT+PLDXWePjINrbfKAyIfNbSv9IHhOh1fYO2OPqDal8SYg/jT2b2QY5gpzVhe+7
	LzxZun/E0eY7pzCqZSEKpKtBoNsd/piAURqj9k9a6AP/Yh2h2uzvZv+FFP/1mNxs
	avM6S66xzBLudEyt9i40scs2TMIX1ptL3mgxT1YmD/aCnzYeSutziJXg0DKpLMgw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44p2ynrtea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Feb 2025 13:18:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5189njmP024540;
	Sat, 8 Feb 2025 13:18:54 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxxnr5w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Feb 2025 13:18:54 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 518DIrK129557424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Feb 2025 13:18:53 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE06858053;
	Sat,  8 Feb 2025 13:18:53 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E912B58043;
	Sat,  8 Feb 2025 13:18:50 +0000 (GMT)
Received: from [9.171.81.239] (unknown [9.171.81.239])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  8 Feb 2025 13:18:50 +0000 (GMT)
Message-ID: <93e9393b-f008-4ef2-bc04-67fdf7af320f@linux.ibm.com>
Date: Sat, 8 Feb 2025 18:48:48 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: fix lock ordering between the queue
 ->sysfs_lock and freeze-lock
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        dlemoal@kernel.org, axboe@kernel.dk, gjoyce@ibm.com
References: <20250205144506.663819-1-nilay@linux.ibm.com>
 <20250205144506.663819-2-nilay@linux.ibm.com> <20250205155952.GB14133@lst.de>
 <715ba1fd-2151-4c39-9169-2559176e30b5@linux.ibm.com>
 <Z6X1hbzI4euK_r-S@fedora>
 <fee9de06-e235-43c1-b756-b10e9fa2c68e@linux.ibm.com>
 <Z6cWE_scvYcE_mWN@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z6cWE_scvYcE_mWN@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MQYQwPdk6naSxfHW0pGx2riA0ODsk7Sp
X-Proofpoint-ORIG-GUID: MQYQwPdk6naSxfHW0pGx2riA0ODsk7Sp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-08_05,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502080108



On 2/8/25 2:00 PM, Ming Lei wrote:
> On Fri, Feb 07, 2025 at 11:32:37PM +0530, Nilay Shroff wrote:
>>
>>
>> On 2/7/25 5:29 PM, Ming Lei wrote:
>>> On Thu, Feb 06, 2025 at 06:52:36PM +0530, Nilay Shroff wrote:
>>>>
>>>>
>>>> On 2/5/25 9:29 PM, Christoph Hellwig wrote:
>>>>> On Wed, Feb 05, 2025 at 08:14:47PM +0530, Nilay Shroff wrote:
>>>>>>  
>>>>>>  static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>>>>> @@ -5006,8 +5008,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>>>>>  		return;
>>>>>>  
>>>>>>  	memflags = memalloc_noio_save();
>>>>>> -	list_for_each_entry(q, &set->tag_list, tag_set_list)
>>>>>> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>>>>> +		mutex_lock(&q->sysfs_lock);
>>>>>
>>>>> This now means we hold up to number of request queues sysfs_lock
>>>>> at the same time.  I doubt lockdep will be happy about this.
>>>>> Did you test this patch with a multi-namespace nvme device or
>>>>> a multi-LU per host SCSI setup?
>>>>>
>>>> Yeah I tested with a multi namespace NVMe disk and lockdep didn't 
>>>> complain. Agreed we need to hold up q->sysfs_lock for multiple 
>>>> request queues at the same time and that may not be elegant, but 
>>>> looking at the mess in __blk_mq_update_nr_hw_queues we may not
>>>> have other choice which could help correct the lock order.
>>>
>>> All q->sysfs_lock instance actually shares same lock class, so this way
>>> should have triggered double lock warning, please see mutex_init().
>>>
>> Well, my understanding about lockdep is that even though all q->sysfs_lock
>> instances share the same lock class key, lockdep differentiates locks 
>> based on their memory address. Since each instance of &q->sysfs_lock has 
>> got different memory address, lockdep treat each of them as distinct locks 
>> and IMO, that avoids triggering double lock warning.
> 
> That isn't correct, think about how lockdep can deal with millions of
> lock instances.
> 
> Please take a look at the beginning of Documentation/locking/lockdep-design.rst
> 
> ```
> The validator tracks the 'usage state' of lock-classes, and it tracks
> the dependencies between different lock-classes.
> ```
> 
> Please verify it by the following code:
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4e76651e786d..a4ffc6198e7b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -5150,10 +5150,37 @@ void blk_mq_cancel_work_sync(struct request_queue *q)
>  		cancel_delayed_work_sync(&hctx->run_work);
>  }
> 
> +struct lock_test {
> +	struct mutex	lock;
> +};
> +
> +void init_lock_test(struct lock_test *lt)
> +{
> +	mutex_init(&lt->lock);
> +	printk("init lock: %p\n", lt);
> +}
> +
> +static void test_lockdep(void)
> +{
> +	struct lock_test A, B;
> +
> +	init_lock_test(&A);
> +	init_lock_test(&B);
> +
> +	printk("start lock test\n");
> +	mutex_lock(&A.lock);
> +	mutex_lock(&B.lock);
> +	mutex_unlock(&B.lock);
> +	mutex_unlock(&A.lock);
> +	printk("end lock test\n");
> +}
> +
>  static int __init blk_mq_init(void)
>  {
>  	int i;
> 
> +	test_lockdep();
> +
>  	for_each_possible_cpu(i)
>  		init_llist_head(&per_cpu(blk_cpu_done, i));
>  	for_each_possible_cpu(i)
> 
> 
> 
Thank you Ming for providing the patch for testing lockdep!
You and Christoph were correct. The lockdep should complain about possible 
recursive locking for q->sysfs_lock and after a bit of debugging I think I found
the cause about why on my system lockdep was unable to complain about recursive locking. 
The reason is on my test system, I enabled KASAN and KASAN reported a potential 
use-after-free bug that tainted the kernel and disabled the further lock debugging. 
Hence any subsequent locking issues were not detected by lockdep. 

Thanks,
--Nilay

