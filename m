Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DA9223DE8;
	Thu,  7 Aug 2025 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567559; cv=none; b=cAlMUa5anBWt8D4mZXy5xuumffkyIxEHwWYwe5ltz7ixLeKb+jlpq+zRnhyu3m2KaIA4rI2rY2q5HlxciJ+Rx3u3Zq+Dgo3if6txKuDniynW9aneX6y5O6p6SlHMnRUjydhXdeIUz4AkYvgpUk2Z8DB3e81xrS+W/4p4hpVUzKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567559; c=relaxed/simple;
	bh=O+Gp1WDPR1zKNL2eACyYRIa65npWpWeI2RQg5Kl7t88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgH57FbkcZhc6LKl0Iy5PJ75JjIRW8fqwwR67RyJRJxxVyElcOFMvaZ/CpBMjfW4UOAL4UZQMrGdxSeo2p6XY/T8SAqTCQRfjICgSLz6Q6k28Dv9jaqW90y428lnMM1p6y2Wd3H0iorXgcZTKNPiE3hUQnD3NnAWlefERNpxG40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KELnS1FR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KELnS1FR"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5770Rh66021506;
	Thu, 7 Aug 2025 11:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BTQHC2
	aC2tbH1wEMSIkNmofgsFKydHAcYdDRMTIS3gI=; b=KELnS1FRFy1qDUCVKhVOWv
	ZzK1ntN6uoQp2Jxn/SlRHeWHPQ/oHTkFBeP7lSkwz5jx0OaHS/xsnCAMHwaiAkVZ
	kwNvecb38Qyauaum4GF7uILxu08pFPES/XeZ329i3t6kPELpMOxsaffuZSKGhnCG
	U5fvOEg+IROBx5nvJdwSVZt70LT7cyDvvCEB0o8PwZ6Z+JT2vCg9Nrye6T3RF75q
	3MXsWAMVoy0Eb8CdMCYtuBbjeMJKnApMdhG6CFFvr/uzt0PqXA9sPSf2lC84uXO7
	N433iMWmayXNbDkiXgJIt3d7dynRf0fF59vu8x9pJJ65LiaVGeUmLmsTHGy9dT/g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq621ubp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 11:47:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5779eeZR022647;
	Thu, 7 Aug 2025 11:47:10 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwqgdqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 11:47:10 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 577Bl9VJ60359118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Aug 2025 11:47:10 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD14258066;
	Thu,  7 Aug 2025 11:47:09 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A044958057;
	Thu,  7 Aug 2025 11:47:06 +0000 (GMT)
Received: from [9.109.198.214] (unknown [9.109.198.214])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Aug 2025 11:47:06 +0000 (GMT)
Message-ID: <470ab442-e5eb-4fa8-bde7-d6d2d1115a5a@linux.ibm.com>
Date: Thu, 7 Aug 2025 17:17:05 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix kobject double initialization in add_disk
To: Zheng Qixing <zhengqixing@huaweicloud.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        houtao1@huawei.com, zhengqixing@huawei.com
References: <20250807072056.2627592-1-zhengqixing@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250807072056.2627592-1-zhengqixing@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA5MCBTYWx0ZWRfX0KtKCmJ/SIJ0
 hoPkHabkBmXTAiJ6wnDfbj4JnyMCQ2klEbQ7eAemZjijHU6YI8eWmH5I0UvVSs8nMoSi35gQm0q
 /6U7O6C6MjX2LGyjqwke3VWfiCIbeyc+voKscU9+P+4ABtWvxmO7GWZ3Ctfvk6mtJw1mkT67PVo
 HToeiIDrm5qvxP7DJwKu2vZO5Xf+trKWmLZW39P7ju0XbMNAU4wD9IbKOcjVihIWKcR0gcYOcQ9
 CeuflSMtxQqnUpJfv5npxFt1rJihrK0Oya4CcNhi8aMvAYyyXMyho8CLT1kwraJiTzpAdffpghX
 v6yYY7EDxBrVbfDqZFJT4eCBKVMVX/LgIMNQWye8kF3i3VgZ0MxnvYyS6HtB2Jhtx2xewQ/1Zde
 hzMjuEUTUrp2hjgeGYQIeUFNQl6wNasxyR+ELoUHLdcvpAZmavpupotGa59XjEAIOS2uZZvY
X-Proofpoint-GUID: tQupf28WFtjmVrYyJRnYp1eBwVucnonL
X-Authority-Analysis: v=2.4 cv=BIuzrEQG c=1 sm=1 tr=0 ts=6894923f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8
 a=FUuygD7Wb4d3zBr_g5QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tQupf28WFtjmVrYyJRnYp1eBwVucnonL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 clxscore=1011
 malwarescore=0 phishscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508070090



On 8/7/25 12:50 PM, Zheng Qixing wrote:
> From: Zheng Qixing <zhengqixing@huawei.com>
> 
> Device-mapper can call add_disk() multiple times for the same gendisk
> due to its two-phase creation process (dm create + dm load). This leads
> to kobject double initialization errors when the underlying iSCSI devices
> become temporarily unavailable and then reappear.
> 
> However, if the first add_disk() call fails and is retried, the queue_kobj
> gets initialized twice, causing:
> 
> kobject: kobject (ffff88810c27bb90): tried to init an initialized object,
> something is seriously wrong.
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x5b/0x80
>   kobject_init.cold+0x43/0x51
>   blk_register_queue+0x46/0x280
>   add_disk_fwnode+0xb5/0x280
>   dm_setup_md_queue+0x194/0x1c0
>   table_load+0x297/0x2d0
>   ctl_ioctl+0x2a2/0x480
>   dm_ctl_ioctl+0xe/0x20
>   __x64_sys_ioctl+0xc7/0x110
>   do_syscall_64+0x72/0x390
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fix this by separating kobject initialization from sysfs registration:
>  - Initialize queue_kobj early during gendisk allocation
>  - add_disk() only adds the already-initialized kobject to sysfs
>  - del_gendisk() removes from sysfs but doesn't destroy the kobject
>  - Final cleanup happens when the disk is released
> 
> Fixes: 2bd85221a625 ("block: untangle request_queue refcounting from sysfs")
> Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
> Closes: https://lore.kernel.org/all/83591d0b-2467-433c-bce0-5581298eb161@huawei.com/
> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
> ---
>  block/blk-sysfs.c | 4 +---
>  block/blk.h       | 1 +
>  block/genhd.c     | 2 ++
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 396cded255ea..37d8654faff9 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -847,7 +847,7 @@ static void blk_queue_release(struct kobject *kobj)
>  	/* nothing to do here, all data is associated with the parent gendisk */
>  }
>  
> -static const struct kobj_type blk_queue_ktype = {
> +const struct kobj_type blk_queue_ktype = {
>  	.default_groups = blk_queue_attr_groups,
>  	.sysfs_ops	= &queue_sysfs_ops,
>  	.release	= blk_queue_release,
> @@ -875,7 +875,6 @@ int blk_register_queue(struct gendisk *disk)
>  	struct request_queue *q = disk->queue;
>  	int ret;
>  
> -	kobject_init(&disk->queue_kobj, &blk_queue_ktype);
>  	ret = kobject_add(&disk->queue_kobj, &disk_to_dev(disk)->kobj, "queue");
>  	if (ret < 0)
>  		goto out_put_queue_kobj;

If the kobject_add() fails here, then we jump to the label out_put_queue_kobj,
where we release/put disk->queue_kobj. That would decrement the kref of 
disk->queue_kobj and possibly bring it to zero. 
Next time, when we call add_disk() again without invoking kobject_init() 
(because the initialization is now moved outside add_disk()), the refcount
of disk->queue_kobj — which was previously released — would now go for a
toss. Wouldn't that lead to use-after-free or inconsistent state?

> @@ -986,5 +985,4 @@ void blk_unregister_queue(struct gendisk *disk)
>  		elevator_set_none(q);
>  
>  	blk_debugfs_remove(disk);
> -	kobject_put(&disk->queue_kobj);
>  }

I'm thinking a case where add_disk() fails after the queue is registered. 
In that case, we call blk_unregister_queue() — which would ideally put()
the disk->queue_kobj.
But if we skip that put() in blk_unregister_queue() (and that's what we do
above), and then later retry add_disk(), wouldn’t kobject_add() from 
blk_register_queue() complain loudly — since we’re trying to add a kobject
that was already added previously?

Thanks,
--Nilay

