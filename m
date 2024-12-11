Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8D8238E23
	for <linux-block@vger.kernel.org>; Wed, 11 Dec 2024 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920343; cv=none; b=VTW/6DcnPTZsjSRHFkUkErDiYwR67knzTVRIT1xHJXWzKjdRYoZAkqGprw8+0zu0d+jKwfdEUJjdN7NanThx9LzqCUpBzvcnnH6L+42eJO9iaw4aMcadNY2Z6Yw5iQu2SXTVhg47eLRn4eIQ/w2Vz6+LLeKQrw7t5tb+Ur1lChg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920343; c=relaxed/simple;
	bh=ptuiJM/STKL/vnkPz2h2GJA1Sktt0T07x8ldJqnnw6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dw+uuVdGglC3dNvQyPmxUwu7n7ojSO69s7xygbAAGx8YNIoSfhIxD6cGBpg1rbUgAO76MtlosKfmUGcbYbjKAGRJFZAFxV2362itcAUgmWH7L+pVkpXZqKXQgGzLHJ32oJFSC15T6me6WTXgFsVyNd9s033yFAmXn345YhzA95o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S5rEs5+K; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S5rEs5+K"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBAwIGv005949;
	Wed, 11 Dec 2024 12:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8MImcH
	mvD6gH5wGNCUMm3iiAnvsYHi+dDa1sRP5zHig=; b=S5rEs5+KvhbUpq8q39X1B8
	Duu+DPOLI6XoulbBWomjIeUVRx9iKWMIgoVbVdkT9WPY4IRSKQgw3kbV7NwqHr/V
	WyCiQtzgowK3tGGGlO/gVs1saHBLF7Iq4R/BBrpb7PhkM8ULK4n392nSgMevBXhS
	JU4ljJsyyhvDUkFcYO/k4q4r8sJVxXmD+bHqlT0R9/YNCXLsfiaCsQWlf0Fj5TKm
	ppfw/loHNkv95zhs3T8XtDlCyxPItpPGeH5gGLNN/emxj1KiW4qHXDwj2QituBK4
	dQegmUJliIAPOQlfFfaOvIw5/u6KEPDU8by9LbRjeaAz/d3nPiie49yRJuSIxpuA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1vw6s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 12:32:14 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BBCOYhE028775;
	Wed, 11 Dec 2024 12:32:13 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1vw6s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 12:32:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBAQRJU032491;
	Wed, 11 Dec 2024 12:32:12 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pn9cvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 12:32:12 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BBCWB7M15467098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Dec 2024 12:32:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 457D558056;
	Wed, 11 Dec 2024 12:32:11 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C0B75803F;
	Wed, 11 Dec 2024 12:32:08 +0000 (GMT)
Received: from [9.171.17.138] (unknown [9.171.17.138])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Dec 2024 12:32:08 +0000 (GMT)
Message-ID: <2a982e92-72f0-425e-be81-044701141d45@linux.ibm.com>
Date: Wed, 11 Dec 2024 18:02:07 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] block: Fix potential deadlock while freezing queue and
 acquiring sysfs_lock
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, kjain@linux.ibm.com, hch@lst.de,
        axboe@kernel.dk, ritesh.list@gmail.com, gjoyce@linux.ibm.com
References: <20241210144222.1066229-1-nilay@linux.ibm.com>
 <Z1l-6sBKSI9ubV9G@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z1l-6sBKSI9ubV9G@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6tk6o4CtTeZ86rWktirryDZwO8pSUp9_
X-Proofpoint-ORIG-GUID: OwdmHs5vb_KYzpCTt1cUDrQ6ASo2yuo9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412110091



On 12/11/24 17:30, Ming Lei wrote:
> On Tue, Dec 10, 2024 at 08:11:43PM +0530, Nilay Shroff wrote:
>> For storing a value to a queue attribute, the queue_attr_store function
>> first freezes the queue (->q_usage_counter(io)) and then acquire
>> ->sysfs_lock. This seems not correct as the usual ordering should be to
>> acquire ->sysfs_lock before freezing the queue. This incorrect ordering
>> causes the following lockdep splat which we are able to reproduce always
>> simply by accessing /sys/kernel/debug file using ls command:
>>
>> [   57.597146] WARNING: possible circular locking dependency detected
>> [   57.597154] 6.12.0-10553-gb86545e02e8c #20 Tainted: G        W
>> [   57.597162] ------------------------------------------------------
>> [   57.597168] ls/4605 is trying to acquire lock:
>> [   57.597176] c00000003eb56710 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0x58/0xc0
>> [   57.597200]
>>                but task is already holding lock:
>> [   57.597207] c0000018e27c6810 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: iterate_dir+0x94/0x1d4
>> [   57.597226]
>>                which lock already depends on the new lock.
>>
>> [   57.597233]
>>                the existing dependency chain (in reverse order) is:
>> [   57.597241]
>>                -> #5 (&sb->s_type->i_mutex_key#3){++++}-{4:4}:
>> [   57.597255]        down_write+0x6c/0x18c
>> [   57.597264]        start_creating+0xb4/0x24c
>> [   57.597274]        debugfs_create_dir+0x2c/0x1e8
>> [   57.597283]        blk_register_queue+0xec/0x294
>> [   57.597292]        add_disk_fwnode+0x2e4/0x548
>> [   57.597302]        brd_alloc+0x2c8/0x338
>> [   57.597309]        brd_init+0x100/0x178
>> [   57.597317]        do_one_initcall+0x88/0x3e4
>> [   57.597326]        kernel_init_freeable+0x3cc/0x6e0
>> [   57.597334]        kernel_init+0x34/0x1cc
>> [   57.597342]        ret_from_kernel_user_thread+0x14/0x1c
>> [   57.597350]
>>                -> #4 (&q->debugfs_mutex){+.+.}-{4:4}:
>> [   57.597362]        __mutex_lock+0xfc/0x12a0
>> [   57.597370]        blk_register_queue+0xd4/0x294
>> [   57.597379]        add_disk_fwnode+0x2e4/0x548
>> [   57.597388]        brd_alloc+0x2c8/0x338
>> [   57.597395]        brd_init+0x100/0x178
>> [   57.597402]        do_one_initcall+0x88/0x3e4
>> [   57.597410]        kernel_init_freeable+0x3cc/0x6e0
>> [   57.597418]        kernel_init+0x34/0x1cc
>> [   57.597426]        ret_from_kernel_user_thread+0x14/0x1c
>> [   57.597434]
>>                -> #3 (&q->sysfs_lock){+.+.}-{4:4}:
>> [   57.597446]        __mutex_lock+0xfc/0x12a0
>> [   57.597454]        queue_attr_store+0x9c/0x110
>> [   57.597462]        sysfs_kf_write+0x70/0xb0
>> [   57.597471]        kernfs_fop_write_iter+0x1b0/0x2ac
>> [   57.597480]        vfs_write+0x3dc/0x6e8
>> [   57.597488]        ksys_write+0x84/0x140
>> [   57.597495]        system_call_exception+0x130/0x360
>> [   57.597504]        system_call_common+0x160/0x2c4
>> [   57.597516]
>>                -> #2 (&q->q_usage_counter(io)#21){++++}-{0:0}:
>> [   57.597530]        __submit_bio+0x5ec/0x828
>> [   57.597538]        submit_bio_noacct_nocheck+0x1e4/0x4f0
>> [   57.597547]        iomap_readahead+0x2a0/0x448
>> [   57.597556]        xfs_vm_readahead+0x28/0x3c
>> [   57.597564]        read_pages+0x88/0x41c
>> [   57.597571]        page_cache_ra_unbounded+0x1ac/0x2d8
>> [   57.597580]        filemap_get_pages+0x188/0x984
>> [   57.597588]        filemap_read+0x13c/0x4bc
>> [   57.597596]        xfs_file_buffered_read+0x88/0x17c
>> [   57.597605]        xfs_file_read_iter+0xac/0x158
>> [   57.597614]        vfs_read+0x2d4/0x3b4
>> [   57.597622]        ksys_read+0x84/0x144
>> [   57.597629]        system_call_exception+0x130/0x360
>> [   57.597637]        system_call_common+0x160/0x2c4
>> [   57.597647]
>>                -> #1 (mapping.invalidate_lock#2){++++}-{4:4}:
>> [   57.597661]        down_read+0x6c/0x220
>> [   57.597669]        filemap_fault+0x870/0x100c
>> [   57.597677]        xfs_filemap_fault+0xc4/0x18c
>> [   57.597684]        __do_fault+0x64/0x164
>> [   57.597693]        __handle_mm_fault+0x1274/0x1dac
>> [   57.597702]        handle_mm_fault+0x248/0x484
>> [   57.597711]        ___do_page_fault+0x428/0xc0c
>> [   57.597719]        hash__do_page_fault+0x30/0x68
>> [   57.597727]        do_hash_fault+0x90/0x35c
>> [   57.597736]        data_access_common_virt+0x210/0x220
>> [   57.597745]        _copy_from_user+0xf8/0x19c
>> [   57.597754]        sel_write_load+0x178/0xd54
>> [   57.597762]        vfs_write+0x108/0x6e8
>> [   57.597769]        ksys_write+0x84/0x140
>> [   57.597777]        system_call_exception+0x130/0x360
>> [   57.597785]        system_call_common+0x160/0x2c4
>> [   57.597794]
>>                -> #0 (&mm->mmap_lock){++++}-{4:4}:
>> [   57.597806]        __lock_acquire+0x17cc/0x2330
>> [   57.597814]        lock_acquire+0x138/0x400
>> [   57.597822]        __might_fault+0x7c/0xc0
>> [   57.597830]        filldir64+0xe8/0x390
>> [   57.597839]        dcache_readdir+0x80/0x2d4
>> [   57.597846]        iterate_dir+0xd8/0x1d4
>> [   57.597855]        sys_getdents64+0x88/0x2d4
>> [   57.597864]        system_call_exception+0x130/0x360
>> [   57.597872]        system_call_common+0x160/0x2c4
>> [   57.597881]
>>                other info that might help us debug this:
>>
>> [   57.597888] Chain exists of:
>>                  &mm->mmap_lock --> &q->debugfs_mutex --> &sb->s_type->i_mutex_key#3
>>
>> [   57.597905]  Possible unsafe locking scenario:
>>
>> [   57.597911]        CPU0                    CPU1
>> [   57.597917]        ----                    ----
>> [   57.597922]   rlock(&sb->s_type->i_mutex_key#3);
>> [   57.597932]                                lock(&q->debugfs_mutex);
>> [   57.597940]                                lock(&sb->s_type->i_mutex_key#3);
>> [   57.597950]   rlock(&mm->mmap_lock);
>> [   57.597958]
>>                 *** DEADLOCK ***
>>
>> [   57.597965] 2 locks held by ls/4605:
>> [   57.597971]  #0: c0000000137c12f8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0xcc/0x154
>> [   57.597989]  #1: c0000018e27c6810 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: iterate_dir+0x94/0x1d4
>>
>> Prevent the above lockdep warning by acquiring ->sysfs_lock before
>> freezing the queue while storing a queue attribute in queue_attr_store
>> function. Later, we also found[1] another function __blk_mq_update_nr_
>> hw_queues where we first freeze queue and then acquire the ->sysfs_lock.
>> So we've also updated lock ordering in __blk_mq_update_nr_hw_queues
>> function and ensured that in all code paths we follow the correct lock
>> ordering i.e. acquire ->sysfs_lock before freezing the queue.
>>
>> [1] https://lore.kernel.org/all/CAFj5m9Ke8+EHKQBs_Nk6hqd=LGXtk4mUxZUN5==ZcCjnZSBwHw@mail.gmail.com/
>>
>> Reported-by: kjain@linux.ibm.com
>> Fixes: af2814149883 ("block: freeze the queue in queue_attr_store")
>> Tested-by: kjain@linux.ibm.com
>> Cc: hch@lst.de
>> Cc: axboe@kernel.dk
>> Cc: ritesh.list@gmail.com
>> Cc: ming.lei@redhat.com
>> Cc: gjoyce@linux.ibm.com
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>     Changes from v1:
>> 	- Fix lock ordering in __blk_mq_update_nr_hw_queues (Ming Lei)
>> ---
>>  block/blk-mq-sysfs.c | 16 ++++++----------
>>  block/blk-mq.c       | 29 ++++++++++++++++++-----------
>>  block/blk-sysfs.c    |  4 ++--
>>  3 files changed, 26 insertions(+), 23 deletions(-)
>>
>> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
>> index 156e9bb07abf..cd5ea6eaa76b 100644
>> --- a/block/blk-mq-sysfs.c
>> +++ b/block/blk-mq-sysfs.c
>> @@ -275,15 +275,13 @@ void blk_mq_sysfs_unregister_hctxs(struct request_queue *q)
>>  	struct blk_mq_hw_ctx *hctx;
>>  	unsigned long i;
>>  
>> -	mutex_lock(&q->sysfs_dir_lock);
>> +	lockdep_assert_held(&q->sysfs_dir_lock);
>> +
>>  	if (!q->mq_sysfs_init_done)
>> -		goto unlock;
>> +		return;
>>  
>>  	queue_for_each_hw_ctx(q, hctx, i)
>>  		blk_mq_unregister_hctx(hctx);
>> -
>> -unlock:
>> -	mutex_unlock(&q->sysfs_dir_lock);
>>  }
>>  
>>  int blk_mq_sysfs_register_hctxs(struct request_queue *q)
>> @@ -292,9 +290,10 @@ int blk_mq_sysfs_register_hctxs(struct request_queue *q)
>>  	unsigned long i;
>>  	int ret = 0;
>>  
>> -	mutex_lock(&q->sysfs_dir_lock);
>> +	lockdep_assert_held(&q->sysfs_dir_lock);
>> +
>>  	if (!q->mq_sysfs_init_done)
>> -		goto unlock;
>> +		return ret;
>>  
>>  	queue_for_each_hw_ctx(q, hctx, i) {
>>  		ret = blk_mq_register_hctx(hctx);
>> @@ -302,8 +301,5 @@ int blk_mq_sysfs_register_hctxs(struct request_queue *q)
>>  			break;
>>  	}
>>  
>> -unlock:
>> -	mutex_unlock(&q->sysfs_dir_lock);
>> -
>>  	return ret;
>>  }
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index aa340b097b6e..cccfc6dada7e 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -4455,7 +4455,8 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>>  	unsigned long i, j;
>>  
>>  	/* protect against switching io scheduler  */
>> -	mutex_lock(&q->sysfs_lock);
>> +	lockdep_assert_held(&q->sysfs_lock);
>> +
>>  	for (i = 0; i < set->nr_hw_queues; i++) {
>>  		int old_node;
>>  		int node = blk_mq_get_hctx_node(set, i);
>> @@ -4488,7 +4489,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>>  
>>  	xa_for_each_start(&q->hctx_table, j, hctx, j)
>>  		blk_mq_exit_hctx(q, set, hctx, j);
>> -	mutex_unlock(&q->sysfs_lock);
>>  
>>  	/* unregister cpuhp callbacks for exited hctxs */
>>  	blk_mq_remove_hw_queues_cpuhp(q);
>> @@ -4520,10 +4520,14 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>>  
>>  	xa_init(&q->hctx_table);
>>  
>> +	mutex_lock(&q->sysfs_lock);
>> +
>>  	blk_mq_realloc_hw_ctxs(set, q);
>>  	if (!q->nr_hw_queues)
>>  		goto err_hctxs;
>>  
>> +	mutex_unlock(&q->sysfs_lock);
>> +
>>  	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
>>  	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
>>  
>> @@ -4542,6 +4546,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>>  	return 0;
>>  
>>  err_hctxs:
>> +	mutex_unlock(&q->sysfs_lock);
> 
> The change in blk_mq_init_allocated_queue() isn't necessary, since queue
> kobj isn't exposed yet, otherwise, feel free to add:
Yeah agreed but the reason I added the ->sysfs_lock is because now 
blk_mq_realloc_hw_ctxs() expects the ->sysfs_lock is held before 
it's invoked. The reason being when blk_mq_realloc_hw_ctxs() is 
invoked from __blk_mq_update_nr_hw_queues(), the ->sysfs_lock must be
held.

> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 
> 
Thanks,
--Nilay

