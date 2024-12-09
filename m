Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579EF233151
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766069; cv=none; b=PmSRH4YLpFtURBHs5uld4nSDgAMljxLNVzGl1jSQKSftKN60+5VfMiSfMjoqvrp33AgCAgoeokFvikZxBHBZ5dI6VF133PvtjcnHDDmksJhOipuTe+aDmwGMj/E1Dgcm5RiA7S+yoQPgogi+EODi1RdHqDYXW4Hj1CO42KCFxho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766069; c=relaxed/simple;
	bh=1Q4hZCNXy3GeAgOLsp3hkLLN0Ze/u3UMHQJ6ykzoPJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=poeEVu1t+gTEslV0xv46Vg5f7Iu/jV6zoltFd6IHV8m5F13/a2IcBGOtvRNYP5822Fh9+8QXy4otBRFeRt4KFF0qUMRs5QOLJqxZI9eH051nIAu1cHdoU37Mrv1iwhwgEnDZImTEXbS4OIG4IypIkGekrmK2Ufj9WNgKWx4cn+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NzTAq/5x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NzTAq/5x"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9DHK0c008130;
	Mon, 9 Dec 2024 17:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ng7Ea6
	2buaZk9T8dQuRoVMDpb4vecnZ8BThp47kRzA0=; b=NzTAq/5xqig33zM8Pg+zhN
	+TezWdcF6hulRIPO498gF3G+1DUSe7fi9WrHiIvFEIIgfGkV6fx9O6QFCs/YBGQu
	jFSZgRT3st+QLZL0rS0O0ZUlMpP3WyP9/4L/s6+GVuMXs6DSqZt717XbOsMYdOY+
	eMOQr8bj7PXtwE9g32OsimCchAxWmVbQD4jRI0VWzQI5MkSizu/93suwv8DYZlsH
	VMQU3X6EPDDZGuqnzIibDwRBjhPQasMKRBMFg/y9FBAlNm/fRKcTVJdZprGT7UN7
	HC7Kl7EwC9+KIOcAAlDDLwY72CaZtrWq21gfirAWzIdJYViq5PVrCKBl+NBclHtA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq244b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 17:41:01 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B9Hf0V0023569;
	Mon, 9 Dec 2024 17:41:00 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq244a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 17:41:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9EsLJm018636;
	Mon, 9 Dec 2024 17:41:00 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d26k7m81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 17:40:59 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9HewPC9306830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 17:40:59 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5EBD58054;
	Mon,  9 Dec 2024 17:40:58 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEF6C58045;
	Mon,  9 Dec 2024 17:40:55 +0000 (GMT)
Received: from [9.171.71.154] (unknown [9.171.71.154])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 17:40:55 +0000 (GMT)
Message-ID: <21c2b7af-917d-4152-92ba-cefdc06a6f8c@linux.ibm.com>
Date: Mon, 9 Dec 2024 23:10:54 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix potential deadlock in queue_attr_store()
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, kjain101@in.ibm.com, hch@lst.de,
        axboe@kernel.dk, ritesh.list@gmail.com, gjoyce@linux.ibm.com
References: <20241206164742.526149-1-nilay@linux.ibm.com>
 <CAFj5m9Ke8+EHKQBs_Nk6hqd=LGXtk4mUxZUN5==ZcCjnZSBwHw@mail.gmail.com>
 <42c6f7bd-c429-4879-9f9f-21a7b706d936@linux.ibm.com>
 <Z1a1bXT15IxJpUDH@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z1a1bXT15IxJpUDH@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JKhex8EEaJJDp92FEZPAAadtyb_oh4yt
X-Proofpoint-GUID: U5w3oDxqHG7DXvcLSjsxERLY_iQpaOUE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090136



On 12/9/24 14:46, Ming Lei wrote:
> On Sun, Dec 08, 2024 at 03:41:18PM +0530, Nilay Shroff wrote:
>>
>>
>> On 12/7/24 08:47, Ming Lei wrote:
>>> On Sat, Dec 7, 2024 at 12:48 AM Nilay Shroff <nilay@linux.ibm.com> wrote:
>>>>
>>>> For storing a value to a queue attribute, the queue_attr_store function
>>>> first freezes the queue (->q_usage_counter(io)) and then acquire
>>>> ->sysfs_lock. This seems not correct as the usual ordering should be to
>>>> acquire ->sysfs_lock before freezing the queue. This incorrect ordering
>>>> causes the following lockdep splat which we are able to reproduce always
>>>> simply by accessing /sys/kernel/debug file using ls command:
>>>>
>>>> [   57.597146] WARNING: possible circular locking dependency detected
>>>> [   57.597154] 6.12.0-10553-gb86545e02e8c #20 Tainted: G        W
>>>> [   57.597162] ------------------------------------------------------
>>>> [   57.597168] ls/4605 is trying to acquire lock:
>>>> [   57.597176] c00000003eb56710 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0x58/0xc0
>>>> [   57.597200]
>>>>                but task is already holding lock:
>>>> [   57.597207] c0000018e27c6810 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: iterate_dir+0x94/0x1d4
>>>> [   57.597226]
>>>>                which lock already depends on the new lock.
>>>>
>>>> [   57.597233]
>>>>                the existing dependency chain (in reverse order) is:
>>>> [   57.597241]
>>>>                -> #5 (&sb->s_type->i_mutex_key#3){++++}-{4:4}:
>>>> [   57.597255]        down_write+0x6c/0x18c
>>>> [   57.597264]        start_creating+0xb4/0x24c
>>>> [   57.597274]        debugfs_create_dir+0x2c/0x1e8
>>>> [   57.597283]        blk_register_queue+0xec/0x294
>>>> [   57.597292]        add_disk_fwnode+0x2e4/0x548
>>>> [   57.597302]        brd_alloc+0x2c8/0x338
>>>> [   57.597309]        brd_init+0x100/0x178
>>>> [   57.597317]        do_one_initcall+0x88/0x3e4
>>>> [   57.597326]        kernel_init_freeable+0x3cc/0x6e0
>>>> [   57.597334]        kernel_init+0x34/0x1cc
>>>> [   57.597342]        ret_from_kernel_user_thread+0x14/0x1c
>>>> [   57.597350]
>>>>                -> #4 (&q->debugfs_mutex){+.+.}-{4:4}:
>>>> [   57.597362]        __mutex_lock+0xfc/0x12a0
>>>> [   57.597370]        blk_register_queue+0xd4/0x294
>>>> [   57.597379]        add_disk_fwnode+0x2e4/0x548
>>>> [   57.597388]        brd_alloc+0x2c8/0x338
>>>> [   57.597395]        brd_init+0x100/0x178
>>>> [   57.597402]        do_one_initcall+0x88/0x3e4
>>>> [   57.597410]        kernel_init_freeable+0x3cc/0x6e0
>>>> [   57.597418]        kernel_init+0x34/0x1cc
>>>> [   57.597426]        ret_from_kernel_user_thread+0x14/0x1c
>>>> [   57.597434]
>>>>                -> #3 (&q->sysfs_lock){+.+.}-{4:4}:
>>>> [   57.597446]        __mutex_lock+0xfc/0x12a0
>>>> [   57.597454]        queue_attr_store+0x9c/0x110
>>>> [   57.597462]        sysfs_kf_write+0x70/0xb0
>>>> [   57.597471]        kernfs_fop_write_iter+0x1b0/0x2ac
>>>> [   57.597480]        vfs_write+0x3dc/0x6e8
>>>> [   57.597488]        ksys_write+0x84/0x140
>>>> [   57.597495]        system_call_exception+0x130/0x360
>>>> [   57.597504]        system_call_common+0x160/0x2c4
>>>> [   57.597516]
>>>>                -> #2 (&q->q_usage_counter(io)#21){++++}-{0:0}:
>>>> [   57.597530]        __submit_bio+0x5ec/0x828
>>>> [   57.597538]        submit_bio_noacct_nocheck+0x1e4/0x4f0
>>>> [   57.597547]        iomap_readahead+0x2a0/0x448
>>>> [   57.597556]        xfs_vm_readahead+0x28/0x3c
>>>> [   57.597564]        read_pages+0x88/0x41c
>>>> [   57.597571]        page_cache_ra_unbounded+0x1ac/0x2d8
>>>> [   57.597580]        filemap_get_pages+0x188/0x984
>>>> [   57.597588]        filemap_read+0x13c/0x4bc
>>>> [   57.597596]        xfs_file_buffered_read+0x88/0x17c
>>>> [   57.597605]        xfs_file_read_iter+0xac/0x158
>>>> [   57.597614]        vfs_read+0x2d4/0x3b4
>>>> [   57.597622]        ksys_read+0x84/0x144
>>>> [   57.597629]        system_call_exception+0x130/0x360
>>>> [   57.597637]        system_call_common+0x160/0x2c4
>>>> [   57.597647]
>>>>                -> #1 (mapping.invalidate_lock#2){++++}-{4:4}:
>>>> [   57.597661]        down_read+0x6c/0x220
>>>> [   57.597669]        filemap_fault+0x870/0x100c
>>>> [   57.597677]        xfs_filemap_fault+0xc4/0x18c
>>>> [   57.597684]        __do_fault+0x64/0x164
>>>> [   57.597693]        __handle_mm_fault+0x1274/0x1dac
>>>> [   57.597702]        handle_mm_fault+0x248/0x484
>>>> [   57.597711]        ___do_page_fault+0x428/0xc0c
>>>> [   57.597719]        hash__do_page_fault+0x30/0x68
>>>> [   57.597727]        do_hash_fault+0x90/0x35c
>>>> [   57.597736]        data_access_common_virt+0x210/0x220
>>>> [   57.597745]        _copy_from_user+0xf8/0x19c
>>>> [   57.597754]        sel_write_load+0x178/0xd54
>>>> [   57.597762]        vfs_write+0x108/0x6e8
>>>> [   57.597769]        ksys_write+0x84/0x140
>>>> [   57.597777]        system_call_exception+0x130/0x360
>>>> [   57.597785]        system_call_common+0x160/0x2c4
>>>> [   57.597794]
>>>>                -> #0 (&mm->mmap_lock){++++}-{4:4}:
>>>> [   57.597806]        __lock_acquire+0x17cc/0x2330
>>>> [   57.597814]        lock_acquire+0x138/0x400
>>>> [   57.597822]        __might_fault+0x7c/0xc0
>>>> [   57.597830]        filldir64+0xe8/0x390
>>>> [   57.597839]        dcache_readdir+0x80/0x2d4
>>>> [   57.597846]        iterate_dir+0xd8/0x1d4
>>>> [   57.597855]        sys_getdents64+0x88/0x2d4
>>>> [   57.597864]        system_call_exception+0x130/0x360
>>>> [   57.597872]        system_call_common+0x160/0x2c4
>>>> [   57.597881]
>>>>                other info that might help us debug this:
>>>>
>>>> [   57.597888] Chain exists of:
>>>>                  &mm->mmap_lock --> &q->debugfs_mutex --> &sb->s_type->i_mutex_key#3
>>>>
>>>> [   57.597905]  Possible unsafe locking scenario:
>>>>
>>>> [   57.597911]        CPU0                    CPU1
>>>> [   57.597917]        ----                    ----
>>>> [   57.597922]   rlock(&sb->s_type->i_mutex_key#3);
>>>> [   57.597932]                                lock(&q->debugfs_mutex);
>>>> [   57.597940]                                lock(&sb->s_type->i_mutex_key#3);
>>>> [   57.597950]   rlock(&mm->mmap_lock);
>>>> [   57.597958]
>>>>                 *** DEADLOCK ***
>>>>
>>>> [   57.597965] 2 locks held by ls/4605:
>>>> [   57.597971]  #0: c0000000137c12f8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0xcc/0x154
>>>> [   57.597989]  #1: c0000018e27c6810 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: iterate_dir+0x94/0x1d4
>>>>
>>>> Prevent the above lockdep warning by acquiring ->sysfs_lock before
>>>> freezing the queue while storing a queue attribute in queue_attr_store
>>>> function.
>>>>
>>>> Reported-by: kjain101@in.ibm.com
>>>> Fixes: af2814149883 ("block: freeze the queue in queue_attr_store")
>>>> Tested-by: kjain101@in.ibm.com
>>>> Cc: hch@lst.de
>>>> Cc: axboe@kernel.dk
>>>> Cc: ritesh.list@gmail.com
>>>> Cc: ming.lei@redhat.com
>>>> Cc: gjoyce@linux.ibm.com
>>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>>> ---
>>>>  block/blk-sysfs.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>>>> index 4241aea84161..f648b112782f 100644
>>>> --- a/block/blk-sysfs.c
>>>> +++ b/block/blk-sysfs.c
>>>> @@ -706,11 +706,11 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
>>>>         if (entry->load_module)
>>>>                 entry->load_module(disk, page, length);
>>>>
>>>> -       blk_mq_freeze_queue(q);
>>>>         mutex_lock(&q->sysfs_lock);
>>>> +       blk_mq_freeze_queue(q);
>>>>         res = entry->store(disk, page, length);
>>>> -       mutex_unlock(&q->sysfs_lock);
>>>>         blk_mq_unfreeze_queue(q);
>>>> +       mutex_unlock(&q->sysfs_lock);
>>>>         return res;
>>>
>>> We freeze queue first in __blk_mq_update_nr_hw_queues() in which
>>> q->sysfs_lock is acquired after the freezing.
>>>
>>> So this simple fix may trigger a new ABBA warning.
>>>
>> Oops! yes I agree. 
>>
>> How about (in addition to the current patch) updating __blk_mq_update_nr_hw_queues()
>> so that we acquire q->sysfs_lock before freezing the queue? In fact, I tried it (and
>> ensured that __blk_mq_update_nr_hw_queues() is triggered so that lockdep can track lock 
>> state and its dependencies) and that appears to be working good - no more lockdep 
>> warning. For reference attached the diff, in case, you want to have a look. Please let
>> me know. 
> 
> I think the idea is good since we grab ->syfs_lock before freezing queue
> for long time, and the lock order is changed just since af2814149883 ("block: freeze
> the queue in queue_attr_store"). And no one should try to acquire
> ->syfs_lock in io code path.
> 
> Also the patch improves the naughty updating_hw_queues code path too.
> 
Thanks for reviewing the patch! 
I'll submit a formal patch with those changes included.

Thanks,
--Nilay

