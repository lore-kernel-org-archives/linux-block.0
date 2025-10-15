Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37006482EB
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760532680; cv=none; b=GaeunKivXewOQow2q1ZBMZODKTtekFoYr+fK7kog/lmQyOmz74dCfZgWsd60Kf191N+PjPnmRVokO8R/nQ6BfIhbtzgY86L55ER1DEI5dBg9lN5LrE4L/cGx2eLsos9ZvtDHs+rUX8khrHAKntM6/6tPDGIPLSr/ipVxLEydESA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760532680; c=relaxed/simple;
	bh=rKuXjlbYil1e6UdLuF1GlSOzbgSo7wnba/AuMXCerbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ra0Nxw9Vz5VfGH7XySb0lAzyP5JOIA9zmAfOyBIRXZwK40396hhaQJmXndF1Kn4Z/Khy9HOcm4vaiQMDOStEwpl2V8DTGzgfB40g3v3bs4ImHCVvRbIy5KeJAljMzEGRlzreDgGFUWFJVVOenfMgQGaWIV2v2hZQOIBxGmU+0lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kuSPb+We; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kuSPb+We"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FBRq1t017989;
	Wed, 15 Oct 2025 12:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YZ1cy/
	SvjcTDpVCLp/sEWlomgcHufTwXhQsOZfvvX1o=; b=kuSPb+WefOefgAPAWKvInJ
	I6f+Fsgc48a8ytYcvUEE+CpibCJM44lg6fT0TU0I2l8U5utrCkHNCWpG75uL6WO8
	XefZjAqhkFh3roTBlY4Il/wf5du/nzF/7uqq/bZSk3WVBBEW86QjvGyiQ1CKqv7G
	A6IV7TKMsp1cx+WkJQYgTV5dxoS51BzqZO+pkVr2vEmMYMSmlS1KXXn8APUzLPwn
	KPAv1mrAwVt7DtBM2WNKzXM9RydKVVkcPN36WBe/bnhRlimGa7aH3habfCiHuQ6e
	kQ0xahSWhvw8VtyfwQ+GiRLl1cplSfBT9kv56skv0iIjjloTY17O1tbWfYut4M0g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew03pd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 12:51:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59FB3nY7015041;
	Wed, 15 Oct 2025 12:51:15 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sjg5fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 12:51:15 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59FCpE1a9044650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 12:51:14 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A5625805F;
	Wed, 15 Oct 2025 12:51:14 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8317A58043;
	Wed, 15 Oct 2025 12:51:12 +0000 (GMT)
Received: from [9.61.83.49] (unknown [9.61.83.49])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Oct 2025 12:51:12 +0000 (GMT)
Message-ID: <95f56935-9df0-4012-9d82-8f10b021c9f5@linux.ibm.com>
Date: Wed, 15 Oct 2025 18:21:10 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] WARNING: possible circular locking dependency
 detected at pcpu_alloc_noprof+0x8a3/0xd90 and
 __blk_mq_update_nr_hw_queues+0x76c/0xca0
To: Yi Zhang <yi.zhang@redhat.com>, linux-block <linux-block@vger.kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <CAHj4cs8F=OV9s3La2kEQ34YndgfZP-B5PHS4Z8_b9euKG6J4mw@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAHj4cs8F=OV9s3La2kEQ34YndgfZP-B5PHS4Z8_b9euKG6J4mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nsu3UnLyP-DzT8zJyjOxdsAZjkcn6TGP
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68ef98c4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8EaD_eMaxu-p8quV64sA:9 a=QEXdDO2ut3YA:10 a=HhbK4dLum7pmb74im6QT:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX14ya6Nl7iUWl
 Yz/kzyEKF0u74iUpepJrwc/8k+7JNnMzZLo1BM83i7Mn3QDYDce2B+iOd5jVQwSl+I1oz+0cYFd
 k1NBeYe21HnqoeMx2pIFJ2raR44GwXRoiEbfeoMqW+BQNQhjfvBnTe5hDxYAm95FQ7mlhXT9Xva
 rAn1RrW90gGqAbeFKXhTR4bmVDbJ49pQGAmVBIEsgHhDSsDX67W2213G133ZLatNSwzS81nReWe
 0iRmuKUyTFxPeOaCBmviKk6CfGHu804jVkTFB/DQ0X/4Z/vJZz5w9/yLViIZBxpQkqr4ALWSUkt
 lGFpg9drzMvt5agpBTfS2YTJ0JxvhO3Lj9Gaa7QfK3C5WByQw9bKkeBZmgndu5X43m/E4vkXbzn
 9wyuxpbTcxgERk1PmtWfxieY3OUZhw==
X-Proofpoint-GUID: nsu3UnLyP-DzT8zJyjOxdsAZjkcn6TGP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014



On 10/15/25 6:00 PM, Yi Zhang wrote:
> Hi
> I reproduced the issue below with blktests block/040 on the latest
> linux-block/for-next, please help check it, and let me know if you
> need any info/test for it. Thanks.
> 
> dmesg:
> [  283.273904] run blktests block/040 at 2025-10-15 08:23:18
> [  283.607382] null_blk: disk nullb1 created
> 
> [  284.828241] ======================================================
> [  284.834421] WARNING: possible circular locking dependency detected
> [  284.840599] 6.18.0-rc1+ #4 Not tainted
> [  284.844360] ------------------------------------------------------
> [  284.850539] check/1726 is trying to acquire lock:
> [  284.855245] ffffffffb3d47210 (pcpu_alloc_mutex){+.+.}-{4:4}, at:
> pcpu_alloc_noprof+0x8a3/0xd90
> [  284.863876]
>                but task is already holding lock:
> [  284.869710] ffff88821320ca68
> (&q->q_usage_counter(io)#30){++++}-{0:0}, at:
> __blk_mq_update_nr_hw_queues+0x76c/0xca0
> [  284.880160]
>                which lock already depends on the new lock.
> 
> [  284.888332]
>                the existing dependency chain (in reverse order) is:
> [  284.895812]
>                -> #2 (&q->q_usage_counter(io)#30){++++}-{0:0}:
> [  284.902875]        __lock_acquire+0x57c/0xbd0
> [  284.907243]        lock_acquire.part.0+0xbd/0x260
> [  284.911950]        blk_alloc_queue+0x5ca/0x710
> [  284.916402]        blk_mq_alloc_queue+0x14b/0x230
> [  284.921109]        __blk_mq_alloc_disk+0x18/0xd0
> [  284.925728]        null_add_dev+0x7b6/0x1410 [null_blk]
> [  284.930973]        nullb_device_power_store+0x1e6/0x280 [null_blk]
> [  284.937159]        configfs_write_iter+0x2ac/0x460
> [  284.941959]        vfs_write+0x525/0xfd0
> [  284.945888]        ksys_write+0xf9/0x1d0
> [  284.949822]        do_syscall_64+0x94/0x760
> [  284.954015]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  284.959588]
>                -> #1 (fs_reclaim){+.+.}-{0:0}:
> [  284.965266]        __lock_acquire+0x57c/0xbd0
> [  284.969632]        lock_acquire.part.0+0xbd/0x260
> [  284.974340]        fs_reclaim_acquire+0xc9/0x110
> [  284.978965]        prepare_alloc_pages+0x159/0x5a0
> [  284.983761]        __alloc_frozen_pages_noprof+0x151/0x3b0
> [  284.989253]        __alloc_pages_noprof+0x10/0x1b0
> [  284.994045]        pcpu_alloc_pages.isra.0+0xcf/0x3d0
> [  284.999109]        pcpu_populate_chunk+0x35/0x70
> [  285.003735]        pcpu_alloc_noprof+0x775/0xd90
> [  285.008353]        iommu_dma_init_fq+0x197/0x750
> [  285.012973]        iommu_dma_init_domain+0x553/0x990
> [  285.017939]        iommu_setup_dma_ops+0xd2/0x1a0
> [  285.022645]        bus_iommu_probe+0x1ee/0x4b0
> [  285.027099]        iommu_device_register+0x186/0x270
> [  285.032064]        iommu_init_pci+0xb8f/0xc20
> [  285.036426]        amd_iommu_init_pci+0x80/0x4e0
> [  285.041051]        state_next+0x297/0x5d0
> [  285.045064]        iommu_go_to_state+0x2b/0x60
> [  285.049512]        pci_iommu_init+0x3b/0x70
> [  285.053707]        do_one_initcall+0xa7/0x260
> [  285.058072]        do_initcalls+0x1b4/0x1f0
> [  285.062259]        kernel_init_freeable+0x4ae/0x540
> [  285.067139]        kernel_init+0x1c/0x150
> [  285.071160]        ret_from_fork+0x393/0x480
> [  285.075441]        ret_from_fork_asm+0x1a/0x30
> [  285.079895]
>                -> #0 (pcpu_alloc_mutex){+.+.}-{4:4}:
> [  285.086091]        check_prev_add+0xf1/0xcd0
> [  285.090364]        validate_chain+0x487/0x570
> [  285.094725]        __lock_acquire+0x57c/0xbd0
> [  285.099092]        lock_acquire.part.0+0xbd/0x260
> [  285.103797]        __mutex_lock+0x1a7/0x1ae0
> [  285.108079]        pcpu_alloc_noprof+0x8a3/0xd90
> [  285.112699]        sbitmap_init_node+0x287/0x730
> [  285.117325]        sbitmap_queue_init_node+0x2e/0x3e0
> [  285.122379]        blk_mq_init_tags+0x15f/0x2c0
> [  285.126921]        blk_mq_alloc_map_and_rqs+0xa6/0x310
> [  285.132067]        __blk_mq_alloc_map_and_rqs+0x104/0x1f0
> [  285.137467]        blk_mq_realloc_tag_set_tags+0x1e8/0x300
> [  285.142952]        __blk_mq_update_nr_hw_queues+0x7b4/0xca0
> [  285.148526]        blk_mq_update_nr_hw_queues+0x3b/0x60
> [  285.153759]        nullb_update_nr_hw_queues+0x1a9/0x370 [null_blk]
> [  285.160032]        nullb_device_submit_queues_store+0xdb/0x170 [null_blk]
> [  285.166827]        configfs_write_iter+0x2ac/0x460
> [  285.171621]        vfs_write+0x525/0xfd0
> [  285.175555]        ksys_write+0xf9/0x1d0
> [  285.179481]        do_syscall_64+0x94/0x760
> [  285.183674]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  285.189250]
>                other info that might help us debug this:
> 
> [  285.197248] Chain exists of:
>                  pcpu_alloc_mutex --> fs_reclaim --> &q->q_usage_counter(io)#30
> 
I think we need to break pcpu_alloc_mutex dependency on the ->freeze_lock. 
We already fixed one such dependency while allocating sched-tags earlier
under this commit 04225d13aef1 ("block: fix potential deadlock while running
nr_hw_queue update"). But it seems we do have one more such dependency exists
while allocating non-sched/driver tags. I'll prepare and submit the fix.

Thanks,
--Nilay 
