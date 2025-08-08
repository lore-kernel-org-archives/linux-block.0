Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A849E8F6E;
	Fri,  8 Aug 2025 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754639530; cv=none; b=nhGpYpQgYT5xVkr+5Fa64TxEADyUFgJRvWEHmJfYREDWFCYlLg5C15KR7287fE3tT4MDBAFGDPUg47S3fm147Zfmqq9eCbAkanIKpMkU/Pcs08Wsg64xalwDRsPPvhd65K+hBOLODFPfbSDsExBmLwH0ivz9xwvi5H5Ps5PtbeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754639530; c=relaxed/simple;
	bh=bD2Nt3U83KofcdYohqZGF1CDHdJ3UQejpzxkkBobqEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iskiPHvVOsuVj9GvguQYMmMR9X1agpcUEuWQnMdb0rsH9SeqUW72nTJNPn1Z4HqVUUYMxIoCKnP+ysnAq0mFwGgLv1TQ3Ps65mo9soUPK4gzdOJyui4Ze4yeprAZgc1KoRJBDWf7xsMJrHbbuxx+b7LTrKRiNQoDJbRKg3kySxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VSxXFNCC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VSxXFNCC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577NTI3i021569;
	Fri, 8 Aug 2025 07:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jsoDhs
	pvGkRt4ExZ3rMCocY4AMN2BPFHYhSHrJ3hxFg=; b=VSxXFNCCmkn8DVRk5XCipS
	qJSsLzvz4K0Nbhe61wY2tKYOU5nQk3f8kflI/BUMuApUjEuFXoWML5Eu1/oa+9R/
	NcY4zkySOpIbJi0NmzNeWeyduD/0A475UEjOcWXNIxmuSA/G/lLh1tQUc8VfXYDT
	b6nWEwOiqJxXBhhROCUUWRkZbPGoYxa7fgesxoGX8oKow557L5mutqGKSq+ZGR+u
	dwwMzYrZEtp917VnoDuWWWEStlSW6SPUYT1YTGjhYxQJhFdTsIj+sjMv6zERcUoC
	xR7RX7eq/5tUEmCSwCx39H6gjPKrBOhZxgVW2x4oQrw4XdhOkHRmKq2sfZPhH0hQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq6273hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 07:51:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5786B9Gk001586;
	Fri, 8 Aug 2025 07:51:34 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwr4q56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 07:51:34 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5787pXbH32899728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 07:51:34 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD55E58068;
	Fri,  8 Aug 2025 07:51:33 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AFBE58066;
	Fri,  8 Aug 2025 07:51:30 +0000 (GMT)
Received: from [9.61.149.61] (unknown [9.61.149.61])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Aug 2025 07:51:29 +0000 (GMT)
Message-ID: <967708f4-146d-404a-9e0f-b9f613de7772@linux.ibm.com>
Date: Fri, 8 Aug 2025 13:21:28 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: fix kobject double initialization in add_disk
To: Yu Kuai <yukuai1@huaweicloud.com>,
        Zheng Qixing <zhengqixing@huaweicloud.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
        zhengqixing@huawei.com, lilingfeng3@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20250808053609.3237836-1-zhengqixing@huaweicloud.com>
 <c959d486-57d9-4fec-abab-0a7172dbfd32@linux.ibm.com>
 <864cbfad-a8bf-0ce4-1e21-6b079cc017fd@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <864cbfad-a8bf-0ce4-1e21-6b079cc017fd@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA2NCBTYWx0ZWRfX1UwbsHfQnCMC
 WuzxEZi7HzsguE95Q1JthTgrtMK91EuR4OTQXSjGYGJZq4J8HaZ3wK5mzwQTd/x6Cb1H5cTJ+c6
 9n/ig/Xt7dQhXyn5lb5aQcE1YuS1t6leFeSn1TkLdoogB5AAP5ofOIWmb1n4vFICYHo3y9gA0/D
 tJ3F8bXJ7keDRgMIMThmiVpToyNntmBc2xY1AzmfTohKxt6o2zLO7uG0V9GB+FnASuEiLFqgdng
 Btg+zBo63UgqgU5JSt6/zy1NGYHp3fmxXtsg+BiqjyHYPj+h7Ldozp/fx8Wo6oJF1bDuAtVtUSe
 g0SVbi7CGPydgRFQYAAP75VWUBQvk4c6fDfVVpVw4kvEIyFm+kFneAJ5GQdwUx6bl2RclZEpoe/
 x4gVjU7xO2CphsQOX/4pXOuEo4IbRWYs7HLnumVFcZOJKVv3x3nhJ45x+FCuVftJxT2kEXhM
X-Proofpoint-GUID: 1yci2_VCG0t2yL9sj1IBzj0e3yJvVqt7
X-Authority-Analysis: v=2.4 cv=BIuzrEQG c=1 sm=1 tr=0 ts=6895ac8e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8
 a=VnNF1IyMAAAA:8 a=xPKOu_X6RL3fBLi_u08A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1yci2_VCG0t2yL9sj1IBzj0e3yJvVqt7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 malwarescore=0 phishscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508080064



On 8/8/25 12:53 PM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/08 15:15, Nilay Shroff 写道:
>>
>>
>> On 8/8/25 11:06 AM, Zheng Qixing wrote:
>>> From: Zheng Qixing <zhengqixing@huawei.com>
>>>
>>> Device-mapper can call add_disk() multiple times for the same gendisk
>>> due to its two-phase creation process (dm create + dm load). This leads
>>> to kobject double initialization errors when the underlying iSCSI devices
>>> become temporarily unavailable and then reappear.
>>>
>>> However, if the first add_disk() call fails and is retried, the queue_kobj
>>> gets initialized twice, causing:
>>>
>>> kobject: kobject (ffff88810c27bb90): tried to init an initialized object,
>>> something is seriously wrong.
>>>   Call Trace:
>>>    <TASK>
>>>    dump_stack_lvl+0x5b/0x80
>>>    kobject_init.cold+0x43/0x51
>>>    blk_register_queue+0x46/0x280
>>>    add_disk_fwnode+0xb5/0x280
>>>    dm_setup_md_queue+0x194/0x1c0
>>>    table_load+0x297/0x2d0
>>>    ctl_ioctl+0x2a2/0x480
>>>    dm_ctl_ioctl+0xe/0x20
>>>    __x64_sys_ioctl+0xc7/0x110
>>>    do_syscall_64+0x72/0x390
>>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> Fix this by separating kobject initialization from sysfs registration:
>>>   - Initialize queue_kobj early during gendisk allocation
>>>   - add_disk() only adds the already-initialized kobject to sysfs
>>>   - del_gendisk() removes from sysfs but doesn't destroy the kobject
>>>   - Final cleanup happens when the disk is released
>>>
>>> Fixes: 2bd85221a625 ("block: untangle request_queue refcounting from sysfs")
>>> Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
>>> Closes: https://lore.kernel.org/all/83591d0b-2467-433c-bce0-5581298eb161@huawei.com/
>>> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
>>> ---
>>>   block/blk-sysfs.c | 12 +++++-------
>>>   block/blk.h       |  1 +
>>>   block/genhd.c     |  2 ++
>>>   3 files changed, 8 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>>> index 396cded255ea..c5cf79a20842 100644
>>> --- a/block/blk-sysfs.c
>>> +++ b/block/blk-sysfs.c
>>> @@ -847,7 +847,7 @@ static void blk_queue_release(struct kobject *kobj)
>>>       /* nothing to do here, all data is associated with the parent gendisk */
>>>   }
>>>   -static const struct kobj_type blk_queue_ktype = {
>>> +const struct kobj_type blk_queue_ktype = {
>>>       .default_groups = blk_queue_attr_groups,
>>>       .sysfs_ops    = &queue_sysfs_ops,
>>>       .release    = blk_queue_release,
>>> @@ -875,15 +875,14 @@ int blk_register_queue(struct gendisk *disk)
>>>       struct request_queue *q = disk->queue;
>>>       int ret;
>>>   -    kobject_init(&disk->queue_kobj, &blk_queue_ktype);
>>>       ret = kobject_add(&disk->queue_kobj, &disk_to_dev(disk)->kobj, "queue");
>>>       if (ret < 0)
>>> -        goto out_put_queue_kobj;
>>> +        return ret;
>>>         if (queue_is_mq(q)) {
>>>           ret = blk_mq_sysfs_register(disk);
>>>           if (ret)
>>> -            goto out_put_queue_kobj;
>>> +            goto out_del_queue_kobj;
>>>       }
>>>       mutex_lock(&q->sysfs_lock);
>>>   @@ -934,8 +933,8 @@ int blk_register_queue(struct gendisk *disk)
>>>       mutex_unlock(&q->sysfs_lock);
>>>       if (queue_is_mq(q))
>>>           blk_mq_sysfs_unregister(disk);
>>> -out_put_queue_kobj:
>>> -    kobject_put(&disk->queue_kobj);
>>> +out_del_queue_kobj:
>>> +    kobject_del(&disk->queue_kobj);
>>>       return ret;
>>>   }
>>>   @@ -986,5 +985,4 @@ void blk_unregister_queue(struct gendisk *disk)
>>>           elevator_set_none(q);
>>>         blk_debugfs_remove(disk);
>>> -    kobject_put(&disk->queue_kobj);
>>>   }
>> Shouldn't we replace kobject_put() with kobject_del() here in
>> blk_unregister_queue()?
> 
> Looks like you missed that kobject_del() is called before the
> kobject_put().
> 
>         /* Now that we've deleted all child objects, we can delete the queue. */
>         kobject_uevent(&disk->queue_kobj, KOBJ_REMOVE);
>         kobject_del(&disk->queue_kobj);
> 
>         if (queue_is_mq(q))
>                 elevator_set_none(q);
> 
>         blk_debugfs_remove(disk);
>         kobject_put(&disk->queue_kobj);
> 
>>
Oh yes I missed to notice it since that was not part of the
patch. Thanks! 

This patch now looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


