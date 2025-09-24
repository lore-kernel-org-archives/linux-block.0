Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07FA21B9F1
	for <linux-block@vger.kernel.org>; Wed, 24 Sep 2025 03:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758683632; cv=none; b=nLh/ibcDdpk7ViB9QVOz0qEJJNZi0jEIrkDJD5DgoKAdf0woEf8djG6iSoCHxH6XB7CWRxPcoCKZr4GEFUnvZXdUTVDWAvMio7ZfeJM9II+3iRHO/Tsf0kORxVIGu4QeJjnqcQyp+UjZskatgFt5vYmjUOrsBlLXZOtY4//kRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758683632; c=relaxed/simple;
	bh=K0xNwMvGI3R7U8T1UJM4oTJ3ZO0vXSz9/cntCFxwE0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hE4C/0KAxWvKEULgNCP7tge+1azSVCXJznVi4Mh3XlprPjrI7LgNOTqoRQYItEitTQFZFD86QXxaQTUQT//j59egU06iyB89EZiQGZoz4WlCMhRrV8Gp7Okfua7kCXdsAJUwI8NvRc+O4vdBCBnODLy+P0WAkKVD3pMW2QDZP48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ACTk/6jJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ACTk/6jJ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NL6F2S010833;
	Wed, 24 Sep 2025 03:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=I6Maem
	MGSvSfAXBOpuyCOJPYsC7/MUjjPUQ4tWSLdyk=; b=ACTk/6jJiIGMdccjSvz8a/
	H4hTM38GesoUwJmJbfgNIQZLOHe8C9s14KL9OmvkTJqC6QAlQ4nprB4Rv+1jO4vq
	ZtggUJwBJmohsT4o1wbBXJTPc1/jzAEBe/EOGYh4/DxGLJdT4a5K/f/OJ3tgfqEO
	C15o+DG6OH8Ckulvcyyd3pU5GJN9XcYu0VnKkwwGvK111K2RwbeL0YIdkOKpYiTE
	SHN3OTjU3WRzEcE240QURiG8x7KjRTkW0b5xCLzHv/VmxyX0k6rfHWRNmyb+yktH
	lZXmRI1hdE2pB3uQj78coTCi/XzGocFhFfFzoKC5a8OzBGzJEK79qNvao2Ck0UmQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwym9cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 03:13:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58O28u9r030336;
	Wed, 24 Sep 2025 03:13:41 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a16anp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 03:13:41 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58O3DfaD22479476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 03:13:41 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1632258043;
	Wed, 24 Sep 2025 03:13:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 640FC58055;
	Wed, 24 Sep 2025 03:13:39 +0000 (GMT)
Received: from [9.43.27.25] (unknown [9.43.27.25])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Sep 2025 03:13:39 +0000 (GMT)
Message-ID: <2415128a-e1fd-41a8-832f-f6a43219e6d1@linux.ibm.com>
Date: Wed, 24 Sep 2025 08:43:33 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] WARNING: possible circular locking dependency
 detected at pcpu_alloc_noprof+0x128/0xeb8 and elevator_change+0x138/0x440
To: Yi Zhang <yi.zhang@redhat.com>,
        Linux Block Devices <linux-block@vger.kernel.org>
Cc: Changhui Zhong <czhong@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <CAGVVp+VNW4M-5DZMNoADp6o2VKFhi7KxWpTDkcnVyjO0=-D5+A@mail.gmail.com>
 <CAHj4cs_rk9ODLg7516z9EfKc4tGT9w0rn=xbnCCZyNGZbFP9yA@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAHj4cs_rk9ODLg7516z9EfKc4tGT9w0rn=xbnCCZyNGZbFP9yA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68d361e6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=sWKEhP36mHoA:10 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=3TKSKdlWR0ypXShANKgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: M5GzUg2-qKTaVqEoHuB0FulTBxkn9Tiw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfX7REY0haHKlUo
 Ho6J13AAzmPnO3TIJvT47lIwCEeYQwuHgwFf6oQVF8K0cPshJfxbB/CSyPPSFtiHXYlZ6moSrQ6
 VQTY+deFHIwR9ZTghEsRfBooPAvIpRW8ETxBJSdxMVRNaXHJKVKCmpWyrcO6UpeG9vlwENpzKDZ
 xpmcfvovNyI0HVfzi11wi4p9bGzN0B2hRKQZlaWCBma7+lYhhWKT+70On/X/4DFbSH8JPF0MHic
 2bFmdejmAPp93mIwZ+I91wsnrPDOnMFMX7gkHg/IvNfuDRkBX2GXh8VWLFVsIJrypMVa7rM+Nsw
 3Xj/g9PVF04CVRkC5xlXt8uDM9gUFuJkgylgtk3fir7ZG4n9aLt83mkzIx30njdXeKfYzmRFLHr
 B7ZttRWo
X-Proofpoint-ORIG-GUID: M5GzUg2-qKTaVqEoHuB0FulTBxkn9Tiw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_08,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200015



On 9/24/25 6:44 AM, Yi Zhang wrote:
> The issue still can be reproduced on the latest linux-block/for-next
> with blktest block/005
> 
> On Fri, Aug 8, 2025 at 1:24 PM Changhui Zhong <czhong@redhat.com> wrote:
>>
>> Hello,
>>
>> the following warning was triggered by 'blktests block/020' tests on
>> aarch64 platform,
>> please help check and let me know if you need any info/test, thanks.
>>
>> repo：https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>> branch：for-next
>> INFO: HEAD of cloned kernel：
>> commit 20c74c07321713217b2f84c55dfd717729aa6111
>> Merge: f1815afd0877 407728da41cd
>> Author: Jens Axboe <axboe@kernel.dk>
>> Date:   Mon Aug 4 09:23:02 2025 -0600
>>
>>     Merge branch 'block-6.17' into for-next
>>
>>     * block-6.17:
>>       block, bfq: Reorder struct bfq_iocq_bfqq_data
>>
>> dmesg log：
>>
>> [  670.939355] run blktests block/020 at 2025-08-07 07:10:45
>> [  673.008290] restraintd[3128]: *** Current Time: Thu Aug 07 07:10:47
>> 2025  Localwatchdog at: Thu Aug 07 12:00:47 2025
>> [  695.875845]
>> [  695.877344] ======================================================
>> [  695.883515] WARNING: possible circular locking dependency detected
>> [  695.889684] 6.16.0+ #1 Not tainted
>> [  695.893075] ------------------------------------------------------
>> [  695.899243] check/12334 is trying to acquire lock:
>> [  695.904022] ffffa1f3ed4291f0 (pcpu_alloc_mutex){+.+.}-{4:4}, at:
>> pcpu_alloc_noprof+0x128/0xeb8
>> [  695.912635]
>> [  695.912635] but task is already holding lock:
>> [  695.918455] ffff0800bee44578 (&q->elevator_lock){+.+.}-{4:4}, at:
>> elevator_change+0x138/0x440
>> [  695.926975]
>> [  695.926975] which lock already depends on the new lock.
>> [  695.926975]
>> [  695.935139]
>> [  695.935139] the existing dependency chain (in reverse order) is:
>> [  695.942608]
>> [  695.942608] -> #3 (&q->elevator_lock){+.+.}-{4:4}:
>> [  695.948868]        __lock_acquire+0x4bc/0x990
>> [  695.953216]        lock_acquire.part.0+0x174/0x2a8
>> [  695.957997]        lock_acquire+0xa0/0x1b8
>> [  695.962083]        __mutex_lock+0x158/0x1090
>> [  695.966343]        mutex_lock_nested+0x2c/0x40
>> [  695.970775]        elevator_change+0x138/0x440
>> [  695.975208]        elv_iosched_store+0x214/0x2c0
>> [  695.979814]        queue_attr_store+0x200/0x270
>> [  695.984335]        sysfs_kf_write+0xcc/0x120
>> [  695.988595]        kernfs_fop_write_iter+0x288/0x430
>> [  695.993549]        new_sync_write+0x214/0x4d0
>> [  695.997895]        vfs_write+0x440/0x5b0
>> [  696.001806]        ksys_write+0xf8/0x1f0
>> [  696.005718]        __arm64_sys_write+0x74/0xb0
>> [  696.010151]        invoke_syscall.constprop.0+0xdc/0x1e8
>> [  696.015454]        do_el0_svc+0x154/0x1d0
>> [  696.019453]        el0_svc+0x54/0x180
>> [  696.023105]        el0t_64_sync_handler+0xa0/0xe8
>> [  696.027799]        el0t_64_sync+0x1ac/0x1b0
>> [  696.031971]
>> [  696.031971] -> #2 (&q->q_usage_counter(io)#6){++++}-{0:0}:
>> [  696.038926]        __lock_acquire+0x4bc/0x990
>> [  696.043272]        lock_acquire.part.0+0x174/0x2a8
>> [  696.048052]        lock_acquire+0xa0/0x1b8
>> [  696.052138]        blk_alloc_queue+0x4e8/0x608
>> [  696.056571]        blk_mq_alloc_queue+0x150/0x240
>> [  696.061265]        __blk_mq_alloc_disk+0x28/0x1d8
>> [  696.065958]        null_add_dev+0x680/0x1188 [null_blk]
>> [  696.071183]        nullb_device_power_store+0x1f4/0x340 [null_blk]
>> [  696.077357]        configfs_write_iter+0x24c/0x378
>> [  696.082138]        new_sync_write+0x214/0x4d0
>> [  696.086484]        vfs_write+0x440/0x5b0
>> [  696.090395]        ksys_write+0xf8/0x1f0
>> [  696.094306]        __arm64_sys_write+0x74/0xb0
>> [  696.098739]        invoke_syscall.constprop.0+0xdc/0x1e8
>> [  696.104040]        do_el0_svc+0x154/0x1d0
>> [  696.108039]        el0_svc+0x54/0x180
>> [  696.111690]        el0t_64_sync_handler+0xa0/0xe8
>> [  696.116383]        el0t_64_sync+0x1ac/0x1b0
>> [  696.120555]
>> [  696.120555] -> #1 (fs_reclaim){+.+.}-{0:0}:
>> [  696.126206]        __lock_acquire+0x4bc/0x990
>> [  696.130553]        lock_acquire.part.0+0x174/0x2a8
>> [  696.135333]        lock_acquire+0xa0/0x1b8
>> [  696.139420]        fs_reclaim_acquire+0x140/0x170
>> [  696.144114]        __alloc_frozen_pages_noprof+0x17c/0x4f0
>> [  696.149588]        __alloc_pages_noprof+0x1c/0xb0
>> [  696.154281]        pcpu_alloc_pages.isra.0+0x12c/0x448
>> [  696.159409]        pcpu_populate_chunk+0x4c/0x98
>> [  696.164016]        pcpu_alloc_noprof+0x3b0/0xeb8
>> [  696.168624]        iommu_dma_init_fq+0x148/0x690
>> [  696.173231]        iommu_dma_init_domain+0x488/0x6a0
>> [  696.178185]        iommu_setup_dma_ops+0x138/0x210
>> [  696.182965]        bus_iommu_probe+0x1b0/0x3e8
>> [  696.187398]        iommu_device_register+0x15c/0x240
>> [  696.192351]        arm_smmu_device_probe+0xbe8/0x1260
>> [  696.197393]        platform_probe+0xcc/0x198
>> [  696.201654]        really_probe+0x188/0x800
>> [  696.205826]        __driver_probe_device+0x164/0x360
>> [  696.210779]        driver_probe_device+0x64/0x1a8
>> [  696.215472]        __driver_attach+0x180/0x490
>> [  696.219904]        bus_for_each_dev+0x104/0x1a0
>> [  696.224424]        driver_attach+0x44/0x68
>> [  696.228509]        bus_add_driver+0x23c/0x4e8
>> [  696.232855]        driver_register+0x15c/0x3a8
>> [  696.237287]        __platform_driver_register+0x64/0x98
>> [  696.242502]        arm_smmu_driver_init+0x28/0x40
>> [  696.247197]        do_one_initcall+0xd4/0x370
>> [  696.251544]        do_initcalls+0x1b0/0x200
>> [  696.255716]        kernel_init_freeable+0x280/0x2c0
>> [  696.260582]        kernel_init+0x28/0x160
>> [  696.264581]        ret_from_fork+0x10/0x20
>> [  696.268668]
>> [  696.268668] -> #0 (pcpu_alloc_mutex){+.+.}-{4:4}:
>> [  696.274840]        check_prev_add+0xec/0x658
>> [  696.279100]        validate_chain+0x2dc/0x340
>> [  696.283446]        __lock_acquire+0x4bc/0x990
>> [  696.287792]        lock_acquire.part.0+0x174/0x2a8
>> [  696.292572]        lock_acquire+0xa0/0x1b8
>> [  696.296658]        __mutex_lock+0x158/0x1090
>> [  696.300917]        _mutex_lock_killable+0x2c/0x40
>> [  696.305610]        pcpu_alloc_noprof+0x128/0xeb8
>> [  696.310217]        kyber_queue_data_alloc+0x150/0x580
>> [  696.315258]        kyber_init_sched+0x28/0xb0
>> [  696.319605]        blk_mq_init_sched+0x1f0/0x410
>> [  696.324213]        elevator_switch+0x184/0x5a0
>> [  696.328645]        elevator_change+0x29c/0x440
>> [  696.333077]        elv_iosched_store+0x214/0x2c0
>> [  696.337684]        queue_attr_store+0x200/0x270
>> [  696.342204]        sysfs_kf_write+0xcc/0x120
>> [  696.346463]        kernfs_fop_write_iter+0x288/0x430
>> [  696.351416]        new_sync_write+0x214/0x4d0
>> [  696.355761]        vfs_write+0x440/0x5b0
>> [  696.359672]        ksys_write+0xf8/0x1f0
>> [  696.363585]        __arm64_sys_write+0x74/0xb0
>> [  696.368017]        invoke_syscall.constprop.0+0xdc/0x1e8
>> [  696.373318]        do_el0_svc+0x154/0x1d0
>> [  696.377317]        el0_svc+0x54/0x180
>> [  696.380969]        el0t_64_sync_handler+0xa0/0xe8
>> [  696.385663]        el0t_64_sync+0x1ac/0x1b0
>> [  696.389835]
>> [  696.389835] other info that might help us debug this:
>> [  696.389835]
>> [  696.397826] Chain exists of:
>> [  696.397826]   pcpu_alloc_mutex --> &q->q_usage_counter(io)#6 -->
>> &q->elevator_lock
>> [  696.397826]
>> [  696.409731]  Possible unsafe locking scenario:
>> [  696.409731]
>> [  696.415638]        CPU0                    CPU1
>> [  696.420155]        ----                    ----
>> [  696.424673]   lock(&q->elevator_lock);
>> [  696.428412]                                lock(&q->q_usage_counter(io)#6);
>> [  696.435364]                                lock(&q->elevator_lock);
>> [  696.441620]   lock(pcpu_alloc_mutex);
>> [  696.445272]
>> [  696.445272]  *** DEADLOCK ***
>> [  696.445272]

Yes, this one still needs to be addressed. The earlier fix handled a similar issue, 
but it was a different case, as described here:
https://lore.kernel.org/all/1b1b8767-2e08-496a-89db-385edf592d23@linux.ibm.com/

I will work on the fix to address the above issue.

Thanks,
--Nilay
