Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA9E266EFC;
	Thu, 21 Aug 2025 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778291; cv=none; b=OyNLiYrjnijjUvCCqadGQtRYGmqWF6EzOwUsHNtHQd4P7miUqBOpGZGFEwtGLhcAkOH26CeVsfxI/ECJaJ3m+vDZHMwIL6kUjKVU8yReCq3rk2SA2lrudzjxr2+LR7NoTyB0wwMOlxXrIc08+rM43c/g5qpEE3hLgXeYksLLD8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778291; c=relaxed/simple;
	bh=FtArH35druLhsJnz9jbR8nYmOaml9tQjYXVPifsAUo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qm33KBmbvanHFbon4HjIEJePhgHc1BqQzwQXwwiTJ0X2/71Y3OV1TDhM1JAQ+1K66AJ6FL1DJuh4Gcr0xj4axECL8h/CY8RpsVSNyWf3obMG2pifTQT1OyPsjRfjRu5scfRr07Bl9pQD2K9+Ufs0aGBUm/RRktnqRh/PcG2FR1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qFSlvCu3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qFSlvCu3"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9a4TA014571;
	Thu, 21 Aug 2025 12:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nRrgwF
	eE6ZlnyF9z1fSS/WdvsnSGBXfjusIhpAeTT8w=; b=qFSlvCu3pfKl2EG5kIV9iH
	djS16Xvq4aVRKVRwFK6652v6+0Hus14yxADoZ6umSEHdJQvEEe3fud0CJ2K0IO/a
	auYti5kBVHRPJxF1/zcYp8z1R8FplOSthpTvgS3wjnFI656RXoqlaNSGmx2i4Glr
	bNElPcmt8INEZn3j3NJPhkGHpQKdJ5Jyc7XIt0C2Y+MfJO30wW3MQT4CF2ciqX75
	RD44HwtnlHiYdiZ27x6GlQwyhQasuiD186w7UEwz2vRz1ftpPvOvkTEhRAS9oQ8g
	MOV9h8pWRYTFThabJ0bqrEQNKCm/7tvdOjbQjIhyLY2J9jCCht+UgkGSN/YtPxXg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vgg71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 12:11:09 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57LC354M023242;
	Thu, 21 Aug 2025 12:11:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vgg6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 12:11:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57LB3ksI024773;
	Thu, 21 Aug 2025 12:11:07 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my5w054e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 12:11:07 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57LCB7kb13632170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 12:11:07 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAC8C58054;
	Thu, 21 Aug 2025 12:11:06 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D7D858050;
	Thu, 21 Aug 2025 12:11:04 +0000 (GMT)
Received: from [9.109.198.214] (unknown [9.109.198.214])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Aug 2025 12:11:03 +0000 (GMT)
Message-ID: <4f2bd603-dbd9-434c-9dfe-f2d4f1becd82@linux.ibm.com>
Date: Thu, 21 Aug 2025 17:41:02 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BREGRESSION=5D_6=2E17-rc2=3A_lockdep_circular_dep?=
 =?UTF-8?Q?endency_at_boot_introduced_by_8f5845e0743b_=28=E2=80=9Cblock=3A_r?=
 =?UTF-8?Q?estore_default_wbt_enablement=E2=80=9D=29?=
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, sunjunchao@bytedance.com,
        axboe@kernel.dk, yukuai3@huawei.com, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <CABXGCsMDOWXM8SQbmNsiXTh6ej87JKah3Wh_ze2dzG5mO5W98g@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CABXGCsMDOWXM8SQbmNsiXTh6ej87JKah3Wh_ze2dzG5mO5W98g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4x75yBG1SbPl4z242MXNhaAlzK8hFm1H
X-Authority-Analysis: v=2.4 cv=IrhHsL/g c=1 sm=1 tr=0 ts=68a70cdd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=5KLPUuaC_9wA:10 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=qLL1wuzRjSbufqrXM_8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=P8gMff4ppgpy92pg1mm4:22
 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfXwX4GMP40sS+P
 k/p6KfJvDSgbBkyJ64I24b0xBbke5R7ErEY9E1R5YziAj/8kTK7pw76RrQMaK+LBfl54FbVBIRJ
 nIspcGMOIBI/yRIii7U+offZEeN0pe+KJ+HJ/tbdykcuCVMsfw+Qa+irdnxYGHfKvlnk3Pcw2e1
 WT6ndxxCXhbMOuwGQJWLotoVfblt2SBCpqre8BG8bWwe6sNQB9eRg3ftyqBOB/GRKXiCxm6uihc
 tjpN7KSNSouIkW+VcJDLCL/stWiuzYtrTG9nhZpV9TlS73rM6JOVdtzMkb26NyLs2sRmhIWYT8W
 3XqHXVg15lZI4PiR2dPRdMqVh0JFZGUfxnFh91fIzKSlxCpeqoiQT0SfYz3pXyT6o6spWjbTxtn
 dM+HHi0cmYBHJHPytk88Ngk2F19GUw==
X-Proofpoint-ORIG-GUID: aLjRscC2XaQP4_ASVNUXg9ho8H7E3ncD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222

On 8/21/25 12:26 PM, Mikhail Gavrilov wrote:
> Hi,
> 
> After commit 8f5845e0743b (“block: restore default wbt enablement”)
> I started seeing a lockdep warning about a circular locking dependency
> on every boot.
> 
> Bisect
> git bisect identifies 8f5845e0743bf3512b71b3cb8afe06c192d6acc4 as the
> first bad commit.
> Reverting this commit on top of 6.17.0-rc2-git-b19a97d57c15 makes the
> warning disappear completely.
> 
> The warning looks like this:
> [   12.595070] nvme nvme0: 32/0/0 default/read/poll queues
> [   12.595566] nvme nvme1: 32/0/0 default/read/poll queues
> 
> [   12.610697] ======================================================
> [   12.610705] WARNING: possible circular locking dependency detected
> [   12.610714] 6.17.0-rc2-git-b19a97d57c15+ #158 Not tainted
> [   12.610726] ------------------------------------------------------
> [   12.610734] kworker/u129:3/911 is trying to acquire lock:
> [   12.610743] ffffffff899ab700 (cpu_hotplug_lock){++++}-{0:0}, at:
> static_key_slow_inc+0x16/0x40
> [   12.610760]
>                but task is already holding lock:
> [   12.610769] ffff8881d166d570
> (&q->q_usage_counter(io)#4){++++}-{0:0}, at:
> blk_mq_freeze_queue_nomemsave+0x16/0x30
> [   12.610787]
>                which lock already depends on the new lock.
> 
> [   12.610798]
>                the existing dependency chain (in reverse order) is:
> [   12.610971]
>                -> #2 (&q->q_usage_counter(io)#4){++++}-{0:0}:
> [   12.611246]        __lock_acquire+0x56a/0xbe0
> [   12.611381]        lock_acquire.part.0+0xc7/0x270
> [   12.611518]        blk_alloc_queue+0x5cd/0x720
> [   12.611649]        blk_mq_alloc_queue+0x143/0x250
> [   12.611780]        __blk_mq_alloc_disk+0x18/0xd0
> [   12.611906]        nvme_alloc_ns+0x240/0x1930 [nvme_core]
> [   12.612042]        nvme_scan_ns+0x320/0x3b0 [nvme_core]
> [   12.612170]        async_run_entry_fn+0x94/0x540
> [   12.612289]        process_one_work+0x87a/0x14e0
> [   12.612406]        worker_thread+0x5f2/0xfd0
> [   12.612527]        kthread+0x3b0/0x770
> [   12.612641]        ret_from_fork+0x3ef/0x510
> [   12.612760]        ret_from_fork_asm+0x1a/0x30
> [   12.612875]
>                -> #1 (fs_reclaim){+.+.}-{0:0}:
> [   12.613102]        __lock_acquire+0x56a/0xbe0
> [   12.613215]        lock_acquire.part.0+0xc7/0x270
> [   12.613327]        fs_reclaim_acquire+0xd9/0x130
> [   12.613444]        __kmalloc_cache_node_noprof+0x60/0x4e0
> [   12.613560]        amd_pmu_cpu_prepare+0x123/0x670
> [   12.613674]        cpuhp_invoke_callback+0x2c8/0x9c0
> [   12.613791]        __cpuhp_invoke_callback_range+0xbd/0x1f0
> [   12.613904]        _cpu_up+0x2f8/0x6c0
> [   12.614015]        cpu_up+0x11e/0x1c0
> [   12.614124]        cpuhp_bringup_mask+0xea/0x130
> [   12.614231]        bringup_nonboot_cpus+0xa9/0x170
> [   12.614335]        smp_init+0x2b/0xf0
> [   12.614443]        kernel_init_freeable+0x23f/0x2e0
> [   12.614545]        kernel_init+0x1c/0x150
> [   12.614643]        ret_from_fork+0x3ef/0x510
> [   12.614744]        ret_from_fork_asm+0x1a/0x30
> [   12.614840]
>                -> #0 (cpu_hotplug_lock){++++}-{0:0}:
> [   12.615029]        check_prev_add+0xe1/0xcf0
> [   12.615126]        validate_chain+0x4cf/0x740
> [   12.615221]        __lock_acquire+0x56a/0xbe0
> [   12.615316]        lock_acquire.part.0+0xc7/0x270
> [   12.615414]        cpus_read_lock+0x40/0xe0
> [   12.615508]        static_key_slow_inc+0x16/0x40
> [   12.615602]        rq_qos_add+0x264/0x440
> [   12.615696]        wbt_init+0x3b2/0x510
> [   12.615793]        blk_register_queue+0x334/0x470
> [   12.615887]        __add_disk+0x5fd/0xd50
> [   12.615980]        add_disk_fwnode+0x113/0x590
> [   12.616073]        nvme_alloc_ns+0x7be/0x1930 [nvme_core]
> [   12.616173]        nvme_scan_ns+0x320/0x3b0 [nvme_core]
> [   12.616272]        async_run_entry_fn+0x94/0x540
> [   12.616366]        process_one_work+0x87a/0x14e0
> [   12.616464]        worker_thread+0x5f2/0xfd0
> [   12.616558]        kthread+0x3b0/0x770
> [   12.616651]        ret_from_fork+0x3ef/0x510
> [   12.616749]        ret_from_fork_asm+0x1a/0x30
> [   12.616841]
>                other info that might help us debug this:
> 
> [   12.617108] Chain exists of:
>                  cpu_hotplug_lock --> fs_reclaim --> &q->q_usage_counter(io)#4
> 
> [   12.617385]  Possible unsafe locking scenario:
> 
> [   12.617570]        CPU0                    CPU1
> [   12.617662]        ----                    ----
> [   12.617755]   lock(&q->q_usage_counter(io)#4);
> [   12.617847]                                lock(fs_reclaim);
> [   12.617940]                                lock(&q->q_usage_counter(io)#4);
> [   12.618035]   rlock(cpu_hotplug_lock);
> [   12.618129]
>                 *** DEADLOCK ***
> 
This one is already being addressed here: 
https://lore.kernel.org/all/20250814082612.500845-1-nilay@linux.ibm.com/

Thanks,
--Nilay
