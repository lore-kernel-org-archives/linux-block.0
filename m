Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA124E01D;
	Fri,  8 Aug 2025 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754646191; cv=none; b=FxQfi/NL0xV8V2BqSBFSVJGepQ4QCJ3A0ivGkJw2vcTOh7NLDJqwklGESQGf/au0wGvx7QFr6R6h74AJ1159TMgSq4lMgLFGF4jdcldkPITWlZzB6xYvI1MRwmVlD9y9jipb2FreBnMYMBq0JTfgtuYb29E/JyhLKMA2XcGufzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754646191; c=relaxed/simple;
	bh=OFBtYGA9jyyP616MEUWygGbW99rkDql9vzmXRe4ELgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WhA4uKcobpfx0vrjNW4cKAqulb4Bu37nz1fdmaaOBwlAUyIolXLiX4BCiKFJDOYgbGHOmd8Hens+bRKSr+n/uGI+/O3yUQzeM+JFDxhORx3HTxxmDH1V1m/7qmrmYtjQmkjzQt+hVVEfYxt0eymHGHT1L0URKicG0oWNJve3Slg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fe1MZysO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fe1MZysO"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5781S5r9018048;
	Fri, 8 Aug 2025 09:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3iCm68
	gvqk7eweb+HXavWWEyuogYOBFRA9qFLjnlkNM=; b=fe1MZysOOc1LOYr4zuTNP2
	S3NAF4uirorxb+uh1BZiKDpxHlNFT3fHaCp3MC5Jpm5RWVbjXnfqygoRMVuwDjWC
	ACbfxrzoSFCRMJB6szAFbbmj551SzQkw0rCQkK5LPLTvzy3pQTvUaPAQiJ6v5WK9
	07FwgNAkzdsXuLUADfJULzi3HY+2peL6xn3PpbA5goIDKe3uq+XuLGYxKPPveKT7
	1+FhaXKPcHjEfgXGhC1FbUDGD6vmWTtUOaPLXdHegzb2AiqeSBjPedRPB3gVz5aM
	RkiNYB/KVfncxQ/69WgKWpp/aGvwyAOld9stnxvRm4QXr1RJhkolRG1kMya3r7Lw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63fakd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 09:42:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5785j3E1025897;
	Fri, 8 Aug 2025 09:42:48 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwnd2q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 09:42:48 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5789gljf11862654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 09:42:48 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD3E658059;
	Fri,  8 Aug 2025 09:42:47 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3679E5804B;
	Fri,  8 Aug 2025 09:42:44 +0000 (GMT)
Received: from [9.61.149.61] (unknown [9.61.149.61])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Aug 2025 09:42:43 +0000 (GMT)
Message-ID: <da463a76-8cb2-4cf9-bcfc-bc7a14127f2b@linux.ibm.com>
Date: Fri, 8 Aug 2025 15:12:42 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix kobject double initialization in add_disk
To: Yu Kuai <yukuai1@huaweicloud.com>,
        Zheng Qixing <zhengqixing@huaweicloud.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
        zhengqixing@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250807072056.2627592-1-zhengqixing@huaweicloud.com>
 <470ab442-e5eb-4fa8-bde7-d6d2d1115a5a@linux.ibm.com>
 <1aa629f8-88d3-4e1b-9e96-003959809fa1@huaweicloud.com>
 <c5036a51-ffd5-4eab-f1a5-369adff3a291@huaweicloud.com>
 <bc3b132d-f017-4bcd-a3f4-3ea344d67a04@linux.ibm.com>
 <712dba37-31a6-f53d-741d-a98f69f2d756@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <712dba37-31a6-f53d-741d-a98f69f2d756@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA3NiBTYWx0ZWRfXwtkOjywYfg8F
 JaxZzRNOM2SOetGTzqFz6sLXvTkD/Czhtcli9psyYHTnYvsrBRM96zcqkPE9zN0pQC+drLzbNAw
 kKLZsgNW6J7wmuRSCOexkkt5VuYpAuJiVPhcBolKDi59qJ1ITt8q8lO1zMgBR1JpJPjCV4bwowZ
 /dZtpsTSJ72K+1xib/83CARCGM4MGtZcDxkEVdFYh9gVtyu29V22rFgIq3g/I1umnd/X6lmPYFU
 UQsFjPBuIn2SxwCT0vRg4TP8uOY1EQRw2R0qWkctTsQ3Qwut5F/9KHsRQ2EsBbLyeWVUxj23E8A
 HPcioUGB22oUF5HKHRnQkYTvJtpBDzXoPhQyf3R3+n7IS8E3Xwqjo8IMdzLrDfksT2akcN2orjb
 YgalzzEURulwORNSrRKDKVCqFzkt+oY75pcER6u5NJ0LBHcVuGcoamiOuTpRqMnH+L5vPrr/
X-Proofpoint-GUID: G2NtUceRmJuLuf0nDlpL8Ik57AtafTxo
X-Authority-Analysis: v=2.4 cv=PoCTbxM3 c=1 sm=1 tr=0 ts=6895c699 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8
 a=isF1HUrzlCBTO032eRcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: G2NtUceRmJuLuf0nDlpL8Ik57AtafTxo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508080076



On 8/8/25 2:04 PM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/08 16:09, Nilay Shroff 写道:
>>
>>
>> On 8/8/25 6:18 AM, Yu Kuai wrote:
>>> Hi,
>>>
>>> 在 2025/08/07 21:44, Zheng Qixing 写道:
>>>> Hi,
>>>>
>>>>
>>>> 在 2025/8/7 19:47, Nilay Shroff 写道:
>>>>>
>>>>> On 8/7/25 12:50 PM, Zheng Qixing wrote:
>>>>>> From: Zheng Qixing <zhengqixing@huawei.com>
>>>>>>
>>>>>> Device-mapper can call add_disk() multiple times for the same gendisk
>>>>>> due to its two-phase creation process (dm create + dm load). This leads
>>>>>> to kobject double initialization errors when the underlying iSCSI devices
>>>>>> become temporarily unavailable and then reappear.
>>>>>>
>>>>>> However, if the first add_disk() call fails and is retried, the queue_kobj
>>>>>> gets initialized twice, causing:
>>>>>>
>>>>>> kobject: kobject (ffff88810c27bb90): tried to init an initialized object,
>>>>>> something is seriously wrong.
>>>>>>    Call Trace:
>>>>>>     <TASK>
>>>>>>     dump_stack_lvl+0x5b/0x80
>>>>>>     kobject_init.cold+0x43/0x51
>>>>>>     blk_register_queue+0x46/0x280
>>>>>>     add_disk_fwnode+0xb5/0x280
>>>>>>     dm_setup_md_queue+0x194/0x1c0
>>>>>>     table_load+0x297/0x2d0
>>>>>>     ctl_ioctl+0x2a2/0x480
>>>>>>     dm_ctl_ioctl+0xe/0x20
>>>>>>     __x64_sys_ioctl+0xc7/0x110
>>>>>>     do_syscall_64+0x72/0x390
>>>>>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>>>
>>>>>> Fix this by separating kobject initialization from sysfs registration:
>>>>>>    - Initialize queue_kobj early during gendisk allocation
>>>>>>    - add_disk() only adds the already-initialized kobject to sysfs
>>>>>>    - del_gendisk() removes from sysfs but doesn't destroy the kobject
>>>>>>    - Final cleanup happens when the disk is released
>>>>>>
>>>>>> Fixes: 2bd85221a625 ("block: untangle request_queue refcounting from sysfs")
>>>>>> Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
>>>>>> Closes: https://lore.kernel.org/all/83591d0b-2467-433c-bce0-5581298eb161@huawei.com/
>>>>>> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
>>>>>> ---
>>>>>>    block/blk-sysfs.c | 4 +---
>>>>>>    block/blk.h       | 1 +
>>>>>>    block/genhd.c     | 2 ++
>>>>>>    3 files changed, 4 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>>>>>> index 396cded255ea..37d8654faff9 100644
>>>>>> --- a/block/blk-sysfs.c
>>>>>> +++ b/block/blk-sysfs.c
>>>>>> @@ -847,7 +847,7 @@ static void blk_queue_release(struct kobject *kobj)
>>>>>>        /* nothing to do here, all data is associated with the parent gendisk */
>>>>>>    }
>>>>>> -static const struct kobj_type blk_queue_ktype = {
>>>>>> +const struct kobj_type blk_queue_ktype = {
>>>>>>        .default_groups = blk_queue_attr_groups,
>>>>>>        .sysfs_ops    = &queue_sysfs_ops,
>>>>>>        .release    = blk_queue_release,
>>>>>> @@ -875,7 +875,6 @@ int blk_register_queue(struct gendisk *disk)
>>>>>>        struct request_queue *q = disk->queue;
>>>>>>        int ret;
>>>>>> -    kobject_init(&disk->queue_kobj, &blk_queue_ktype);
>>>>>>        ret = kobject_add(&disk->queue_kobj, &disk_to_dev(disk)->kobj, "queue");
>>>>>>        if (ret < 0)
>>>>>>            goto out_put_queue_kobj;
>>>>> If the kobject_add() fails here, then we jump to the label out_put_queue_kobj,
>>>>> where we release/put disk->queue_kobj. That would decrement the kref of
>>>>> disk->queue_kobj and possibly bring it to zero.
>>>>
>>>>
>>>> Since we remove the kobject_init() into alloc disk, when the kobject_add() fails here,
>>>>
>>>> it should return without kobject_del/put().
>>>
>>> Yes, sorry I didn't noticed.
>>>>
>>>>
>>>> If kobject_add() succeeds but later steps fail, we should call kobject_del() to rollback.
>>>>
>>>>
>>>> The current error handling with kobject_put() in blk_register_queue() is indeed problematic.
>>>>
>>>>
>>>>> Next time, when we call add_disk() again without invoking kobject_init()
>>>>> (because the initialization is now moved outside add_disk()), the refcount
>>>>> of disk->queue_kobj — which was previously released — would now go for a
>>>>> toss. Wouldn't that lead to use-after-free or inconsistent state?
>>>>>
>>>>>> @@ -986,5 +985,4 @@ void blk_unregister_queue(struct gendisk *disk)
>>>>>>            elevator_set_none(q);
>>>>>>        blk_debugfs_remove(disk);
>>>>>> -    kobject_put(&disk->queue_kobj);
>>>>>>    }
>>>>> I'm thinking a case where add_disk() fails after the queue is registered.
>>>>> In that case, we call blk_unregister_queue() — which would ideally put()
>>>>> the disk->queue_kobj.
>>>>> But if we skip that put() in blk_unregister_queue() (and that's what we do
>>>>> above), and then later retry add_disk(), wouldn’t kobject_add() from
>>>>> blk_register_queue() complain loudly — since we’re trying to add a kobject
>>>>> that was already added previously?
>>>
>>> This is exactly the problem reported orginally, now is the same
>>> procedures before 2bd85221a625:
>>>
>>> 1) allocate memory: kobject_init
>>> 2) register queue: kobject_add
>>> 3) unregister queue: kobject_del
>>> 4) free memory: kobject_put
>>>
>>> Noted that kobject_add is corresponding to kobject_del, and they don't
>>> grab/release kobject reference. 2) and 3) can be executed multiple
>>> times, the only thing that I noticed is the following uevent:
>>>
>>> kobject_uevent(&disk->queue_kobj, KOBJ_ADD);
>>>
>>> Looks like the uevent is only valid for the first one, if first add_disk
>>> failed and then queue is registered again, there won't be uevent again,
>>> see state_add_uevent_sent.
>>>
>> Why do you think so? We always send the "add" uevent when we register
>> queue and then send "remove" uevent when the queue is unregistered. This
>> behavior should remain intact with this change. The kobj->state_add_uevent_sent
>> is only used for sending "remove" event during automatic cleanup of kobject.
>> It shouldn't have any side effect while we re-register queue or retry
>> add_disk(). Or am I missing something here?
> 
> Yes, turns out I misread the code after I tested and found that user
> didn't get the queue uevent. Just dig deeper and realize this is due
> to dev_uevent_filter() from the top devices_kset stop the queue kobj
> uevent.
> 
> So, if I don't misread the code now, looks like the kobject_uevent()
> call to queue_kobj is useless.
> 
Yes that's correct. And so this patch doesn't alter the queue_kobj  uevent behavior and so we're good here.
Thanks,
--Nilay


