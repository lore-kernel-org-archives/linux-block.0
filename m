Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3380221558;
	Fri,  8 Aug 2025 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637376; cv=none; b=El9UzyTkrUcKJgnp5oMSM1QhlKCrvngFGx2jUCStrG61XOG05QJdvUtmPAu1BMDuxHMaP1CQ4zyFm++LD5a+qIGXQSyo7/I4JaOmEvXmpxJkbMmLxIYQUROsaE6Y3ct4v2YWpMCaClCI5DKzbgOwDHm6hcNzJyUc0SlXktBthGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637376; c=relaxed/simple;
	bh=KgDhuu6by5SCsNCyVw7SHLvGFDEMJx7iqHyRlOydBSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TwG96oTxG/sowPX6WbxGaOaEn9Tn3w25SB8CPAUsRSQrPN/fJMBOoobUt2uWeOnKlfDUbLGWOZIX0c4jp0FbOu0dLBsiuBv8PU4t83XKpOfPruJv3LLZIUtoHaXrhsQ9LF4T0tfLpbVSlqz83n15ikS7Qcf82MxVsGkAbuMEuwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ckl44kHL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ckl44kHL"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577JtULI017807;
	Fri, 8 Aug 2025 07:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Dob1tp
	VpygO+cDGyRJUKD7KIDfz80MrF/Lt3AXcIbDk=; b=ckl44kHLqOm72AuUD9kmn2
	931Rgjfo6QBjXDmikn72kAcfwzfpyU8Z3wVSAMdndUcp1CzpeERXR/FVr0Yda/mp
	zemGsXljNAH7QY19FDeDQax02yOsittXggAKyFgVuuazjpe05VBI18YgqVEmpEMH
	ShM0ixND+0fF+NdO7cO6mOY8eU+OpIHR+nuWYQWpJ/O2AEU7ubZu7rormnMVNCoD
	cZA5svT9PuLhJMLgr24+mkygc1ewthMsPK33CTqq0bCqIQLeWIkeqL6gFOC73qV/
	bHdd82qUxQqOHJJf1BJ64L4MPYc9w8kci+qOIjGE2bz1iB2dyPFnZ7wS6XbGdq1Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63xnxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 07:15:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5786FVfF020606;
	Fri, 8 Aug 2025 07:15:46 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwn4hv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 07:15:46 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5787Fj3p8782244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 07:15:45 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C814E58054;
	Fri,  8 Aug 2025 07:15:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5040858055;
	Fri,  8 Aug 2025 07:15:42 +0000 (GMT)
Received: from [9.61.149.61] (unknown [9.61.149.61])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Aug 2025 07:15:41 +0000 (GMT)
Message-ID: <c959d486-57d9-4fec-abab-0a7172dbfd32@linux.ibm.com>
Date: Fri, 8 Aug 2025 12:45:40 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: fix kobject double initialization in add_disk
To: Zheng Qixing <zhengqixing@huaweicloud.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        houtao1@huawei.com, zhengqixing@huawei.com, lilingfeng3@huawei.com
References: <20250808053609.3237836-1-zhengqixing@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250808053609.3237836-1-zhengqixing@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA1NSBTYWx0ZWRfXyx2E3WpqY5Ft
 92g1xe70XNsWanTi+qIE0HzVeLwzrBu/S9RGK2Chq84fVXMRcAcpscfkxmQyqkY1BpgqS2rKCcF
 hFJZzOOM16uR7iHENfj9sE7fDxHq8VdJ6c+ntmM+4EsjWI+zdtCd4KywT88SqTaA7uCJtqu6e/Y
 hObrguKIZQMmkrw3IZDxtzjX1x0LWGaL9f5+U6ppvEvxOJtb1BLR6/ijiP35OH49hCm3+JrZXKT
 GSf1/7FZRlbrJuERIQ5QzW039HGX1jfP0mcxNK2esZWYP11WkUo44XV8necAXY9w9Avr7AjV6ZD
 OIh0I/QfPgcFJKy96sVZR2De6R9aKdNtV9TZwlKFviR18uZvpsFwZ0YbCfcxhTXNC+5+N2tPFBp
 3EyHPlsrJavIfWsJCEGdA/KFfRDP1U2fyYa767KDG5ih/sCwszVgOLskRo2km7ZmPZWTIOPa
X-Proofpoint-ORIG-GUID: uklbmKmKKepFh_BRF0x8SFcbWhKnrqUt
X-Authority-Analysis: v=2.4 cv=LreSymdc c=1 sm=1 tr=0 ts=6895a422 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8
 a=9IXjlSgd8CJL-Pz1-EkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uklbmKmKKepFh_BRF0x8SFcbWhKnrqUt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508080055



On 8/8/25 11:06 AM, Zheng Qixing wrote:
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
>  block/blk-sysfs.c | 12 +++++-------
>  block/blk.h       |  1 +
>  block/genhd.c     |  2 ++
>  3 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 396cded255ea..c5cf79a20842 100644
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
> @@ -875,15 +875,14 @@ int blk_register_queue(struct gendisk *disk)
>  	struct request_queue *q = disk->queue;
>  	int ret;
>  
> -	kobject_init(&disk->queue_kobj, &blk_queue_ktype);
>  	ret = kobject_add(&disk->queue_kobj, &disk_to_dev(disk)->kobj, "queue");
>  	if (ret < 0)
> -		goto out_put_queue_kobj;
> +		return ret;
>  
>  	if (queue_is_mq(q)) {
>  		ret = blk_mq_sysfs_register(disk);
>  		if (ret)
> -			goto out_put_queue_kobj;
> +			goto out_del_queue_kobj;
>  	}
>  	mutex_lock(&q->sysfs_lock);
>  
> @@ -934,8 +933,8 @@ int blk_register_queue(struct gendisk *disk)
>  	mutex_unlock(&q->sysfs_lock);
>  	if (queue_is_mq(q))
>  		blk_mq_sysfs_unregister(disk);
> -out_put_queue_kobj:
> -	kobject_put(&disk->queue_kobj);
> +out_del_queue_kobj:
> +	kobject_del(&disk->queue_kobj);
>  	return ret;
>  }
>  
> @@ -986,5 +985,4 @@ void blk_unregister_queue(struct gendisk *disk)
>  		elevator_set_none(q);
>  
>  	blk_debugfs_remove(disk);
> -	kobject_put(&disk->queue_kobj);
>  }
Shouldn't we replace kobject_put() with kobject_del() here in 
blk_unregister_queue()? 

Thanks,
--Nilay
