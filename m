Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A56259499
	for <linux-block@vger.kernel.org>; Fri, 20 Dec 2024 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734689881; cv=none; b=SluXRT6NU8DNdLtLM64VehJlTkpaz6lzDJuzt2CIM/VDc+mEDMbjaPqodo0sYH++KKpXUrXTIOnCNDaB2vD2ImK5xv8muKIWlcwgBloQ3j9POIrU/zakVCjib47ruiuswnQdu87ELkpPJ//6l93/6Lx2X1wrraZZySQu+qkOvd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734689881; c=relaxed/simple;
	bh=RVvqRjC/Jzv6HryJ+Gp8kC7crAwdMwiZ0asU9RjSoCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qn/wtuj29S15o4eQiKg/CzSK1zhP+kcNvS4P2vpq9HvFez0fEUnzRKfHm0KDfuc0VH08eMFHxqI9D0comIYbss6+IpcS7pcjfwaZCLPTQt8HTCGWM7fchJSyhQC2c+T7KObEcxRFGqdveuaVP8JhN/VAE6+HTgSQ4kie9qzXW+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pa57yXQS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pa57yXQS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK1IUd9027132;
	Fri, 20 Dec 2024 10:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CoxXbz
	9qpc2Z5USId5wljpk/HZmjZgvU/ljcpe4Vd6g=; b=Pa57yXQSj9pe4N9jpe09iC
	8qTCj80U8vi0a/Bpg83ig+b7UdiUMg90kLlXC4GRlphHyMXwE/XHeUYCy/QsoXTm
	uKCepdLFAIX/wqy6f/zluqLKndGTHzgbTJSqEea4asaYROFoXtDg/5rlPPELjnMM
	c8XGVb09BNHcgqZ0ratgBwjroh9b0ptoesniZWZC5DcC9c6dpk7Ko4wqfXDHyZ4r
	kxkr70wFkVDbovEHjCKljObEN1pgqlD0O7nloI8dy/pTqlW0nYRSZnnXFeirk4IQ
	1/UGtVoQ04YjzX1maf0rk8rQfvhUZ6cVNT7P/6RkT1z3+lj/1NO2TTT8Kfcs3IYg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mmy5cpat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 10:17:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK8Qhjk014335;
	Fri, 20 Dec 2024 10:17:56 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hmqyht8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 10:17:56 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BKAHusl23069288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Dec 2024 10:17:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59AB258053;
	Fri, 20 Dec 2024 10:17:56 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FACE58043;
	Fri, 20 Dec 2024 10:17:55 +0000 (GMT)
Received: from [9.171.21.204] (unknown [9.171.21.204])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Dec 2024 10:17:55 +0000 (GMT)
Message-ID: <cff2a318-fafa-41ce-8138-0ca379ef5774@linux.ibm.com>
Date: Fri, 20 Dec 2024 15:47:53 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] WARNING: possible circular locking dependency
 detected at blk_unregister_queue+0x9c/0x290 and sd_remove+0x85/0x130 [sd_mod]
To: Yi Zhang <yi.zhang@redhat.com>, linux-block <linux-block@vger.kernel.org>
References: <CAHj4cs_RU-tzrtn+F8kXBP+4zCH_mA1pqzwAL8oWNGZiLxXHLQ@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAHj4cs_RU-tzrtn+F8kXBP+4zCH_mA1pqzwAL8oWNGZiLxXHLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cBIeO-VrmavmV4XKBNxvdb5ik6EfrnTt
X-Proofpoint-GUID: cBIeO-VrmavmV4XKBNxvdb5ik6EfrnTt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200082



On 12/20/24 06:00, Yi Zhang wrote:
> Hi
> 
> I reproduced this issue on 6.13.0-rc3 with blktests block/032, and
> latest linux-block/for-next also has this issue,
> please help check it and let me know if you need any info/test for it, thanks.
> 
> [ 8522.205802] run blktests block/032 at 2024-12-19 17:50:39
> [ 8522.686638] scsi_debug:sdebug_driver_probe: scsi_debug: trim
> poll_queues to 0. poll_q/nr_hw = (0/1)
> [ 8522.714725] scsi 10:0:0:0: Power-on or device reset occurred
> [ 8525.172661] XFS (sde): Block device removal (0x20) detected at
> fs_bdev_mark_dead+0x7e/0xb0 (fs/xfs/xfs_super.c:1184).  Shutting down
> filesystem.
> [ 8525.187369] XFS (sde): Please unmount the filesystem and rectify
> the problem(s)
> [ 8525.208802]
> [ 8525.210316] ======================================================
> [ 8525.216502] WARNING: possible circular locking dependency detected
> [ 8525.222689] 6.13.0-rc3+ #1 Not tainted
> [ 8525.226443] ------------------------------------------------------
> [ 8525.232630] check/29929 is trying to acquire lock:
> [ 8525.237431] ffff8882aa0d6f38 (&q->sysfs_lock){+.+.}-{4:4}, at:
> blk_unregister_queue+0x9c/0x290
> [ 8525.246070]
> [ 8525.246070] but task is already holding lock:
> [ 8525.251903] ffff8882aa0d69f0
> (&q->q_usage_counter(queue)#11){++++}-{0:0}, at: sd_remove+0x85/0x130
> [sd_mod]
> [ 8525.261681]
> [ 8525.261681] which lock already depends on the new lock.
> [ 8525.261681]
> [ 8525.269862]
> [ 8525.269862] the existing dependency chain (in reverse order) is:
> [ 8525.277341]
> [ 8525.277341] -> #2 (&q->q_usage_counter(queue)#11){++++}-{0:0}:
> [ 8525.284672]        __lock_acquire+0xc94/0x1cf0
> [ 8525.289126]        lock_acquire+0x177/0x3e0
> [ 8525.293322]        blk_queue_enter+0x391/0x4b0
> [ 8525.297774]        blk_mq_alloc_request+0x499/0x8c0
> [ 8525.302663]        scsi_execute_cmd+0x10d/0x6d0
> [ 8525.307204]        read_capacity_16+0x1ad/0xb90 [sd_mod]
> [ 8525.312525]        sd_read_capacity+0x4c3/0x9d0 [sd_mod]
> [ 8525.317847]        sd_revalidate_disk.isra.0+0xa98/0x2240 [sd_mod]
> [ 8525.324035]        sd_probe+0x6e3/0xdb0 [sd_mod]
> [ 8525.328661]        really_probe+0x1e3/0x920
> [ 8525.332856]        __driver_probe_device+0x18a/0x3d0
> [ 8525.337833]        driver_probe_device+0x49/0x120
> [ 8525.342545]        __device_attach_driver+0x15e/0x270
> [ 8525.347607]        bus_for_each_drv+0x106/0x190
> [ 8525.352149]        __device_attach_async_helper+0x19a/0x240
> [ 8525.357731]        async_run_entry_fn+0x96/0x4f0
> [ 8525.362356]        process_one_work+0xe64/0x16a0
> [ 8525.366985]        worker_thread+0x588/0xce0
> [ 8525.371266]        kthread+0x2f6/0x3e0
> [ 8525.375027]        ret_from_fork+0x30/0x70
> [ 8525.379135]        ret_from_fork_asm+0x1a/0x30
> [ 8525.383591]
> [ 8525.383591] -> #1 (&q->limits_lock){+.+.}-{4:4}:
> [ 8525.389699]        __lock_acquire+0xc94/0x1cf0
> [ 8525.394145]        lock_acquire+0x177/0x3e0
> [ 8525.398341]        __mutex_lock+0x17c/0x1570
> [ 8525.402620]        __blk_mq_update_nr_hw_queues+0x98f/0xe80
> [ 8525.408202]        blk_mq_update_nr_hw_queues+0x29/0x40
> [ 8525.413430]        sdebug_change_qdepth+0x112/0x170 [scsi_debug]
> [ 8525.419470]        scsi_debug_bus_reset+0x156/0x1a0 [scsi_debug]
> [ 8525.425494]        configfs_write_iter+0x2b4/0x480
> [ 8525.430295]        vfs_write+0x9b8/0xf60
> [ 8525.434228]        ksys_write+0xf4/0x1d0
> [ 8525.438164]        do_syscall_64+0x8c/0x180
> [ 8525.442357]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 8525.447939]
> [ 8525.447939] -> #0 (&q->sysfs_lock){+.+.}-{4:4}:
> [ 8525.453960]        check_prev_add+0x1b7/0x2360
> [ 8525.458406]        validate_chain+0xa42/0xe00
> [ 8525.462767]        __lock_acquire+0xc94/0x1cf0
> [ 8525.467221]        lock_acquire+0x177/0x3e0
> [ 8525.471416]        __mutex_lock+0x17c/0x1570
> [ 8525.475697]        blk_unregister_queue+0x9c/0x290
> [ 8525.480497]        del_gendisk+0x25a/0xa10
> [ 8525.484606]        sd_remove+0x85/0x130 [sd_mod]
> [ 8525.489233]        device_release_driver_internal+0x36d/0x530
> [ 8525.494989]        bus_remove_device+0x1ed/0x3f0
> [ 8525.499617]        device_del+0x33b/0x8c0
> [ 8525.503637]        __scsi_remove_device+0x26b/0x330
> [ 8525.508525]        sdev_store_delete+0x83/0x120
> [ 8525.513057]        kernfs_fop_write_iter+0x355/0x520
> [ 8525.518032]        vfs_write+0x9b8/0xf60
> [ 8525.521967]        ksys_write+0xf4/0x1d0
> [ 8525.525903]        do_syscall_64+0x8c/0x180
> [ 8525.530096]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 8525.535676]
> [ 8525.535676] other info that might help us debug this:
> [ 8525.535676]
> [ 8525.543675] Chain exists of:
> [ 8525.543675]   &q->sysfs_lock --> &q->limits_lock -->
> &q->q_usage_counter(queue)#11
> [ 8525.543675]
> [ 8525.555601]  Possible unsafe locking scenario:
> [ 8525.555601]
> [ 8525.561520]        CPU0                    CPU1
> [ 8525.566052]        ----                    ----
> [ 8525.570586]   lock(&q->q_usage_counter(queue)#11);
> [ 8525.575395]                                lock(&q->limits_lock);
> [ 8525.581496]
> lock(&q->q_usage_counter(queue)#11);
> [ 8525.588820]   lock(&q->sysfs_lock);
> [ 8525.592322]
> [ 8525.592322]  *** DEADLOCK ***
> [ 8525.592322]

Well this is currently being discussed here[1]. I don't know yet how 
it would be fixed. But we have to wait...

[1]https://lore.kernel.org/all/20241216080206.2850773-1-ming.lei@redhat.com/

Thanks,
--Nilay

