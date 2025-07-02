Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B8F2E54A9
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465851; cv=none; b=f6YoUU7CvyvV6sQUya8pna9xfwAEvRlqEQIRKV5Id3Dp8CE4HU2kSnZJR1gHi1VHiBWexJn9p4WZJnBv/6qJcn6BEdNQTWzoGS0vYHJrpHhMk1h7yRqOg+2xayNnBXpn81hFHeUvsBKj4DbKuCH9yQMOuHyUgLCP2VlpZtM07Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465851; c=relaxed/simple;
	bh=hseUkirTxGljPBMoY0vMVjI95POkVV5+LFIZorJmp+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rmi+QYRJfXlYTbON7n/1IxX6aotwxH+zaRZtoziv0iZwG3f+dtAlYDoUZM/e5uy/j1aEzFJIKIY1/lDZn+yNGtqaiHF2/o7NW724/fCTaWVgD2ZUsUudufGrOvLxpegYvKxkVeSXYAuuinKq4SGZ9llyum8SNcw8UysC4sca6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EPUglIoK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EPUglIoK"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562DZXBU015295;
	Wed, 2 Jul 2025 14:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PTtLYC
	N/AwpDfPvZeKFeqefWr6grqVIUhrSGuTxD2Bk=; b=EPUglIoKQ7zftwN/WzojTH
	OPT3z+o8r3wwLsEQsFFhAEXHqFs15DQ9ofpWp2YgkeFsP5EJ0iEQ/YUQ+mYbeD39
	mJ+VNqBBMbG4upnepCJdEaGL7bFtpbuPww1FsSfQi/QKdTOQUO3d5RCxCUDMhvJL
	kMFd7s7mfR4arPioRJFWtcUzy205UCORIOeOaatSeABDGCMU+S/ewDe+3fiMqbaO
	GPI42OlWc7RZJ7Dk+4wTIwPw8Km1kb7H8iNj8camSEcD9JTU1gZ97Zlelpw2qBF/
	KmHrPTZWusWFCEtkAEpexA5re0H7B8sFoLJmVuzMDFtReTPV4n7ILPR3lmbEJbFw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j830x0uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 14:17:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 562DvOwY021909;
	Wed, 2 Jul 2025 14:17:18 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47juqpqx92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 14:17:18 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 562EHH9428443376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Jul 2025 14:17:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E29C58056;
	Wed,  2 Jul 2025 14:17:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 590235803F;
	Wed,  2 Jul 2025 14:17:13 +0000 (GMT)
Received: from [9.43.77.202] (unknown [9.43.77.202])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Jul 2025 14:17:12 +0000 (GMT)
Message-ID: <1b1b8767-2e08-496a-89db-385edf592d23@linux.ibm.com>
Date: Wed, 2 Jul 2025 19:47:11 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 0/3] block: move sched_tags allocation/de-allocation
 outside of locking context
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com, hare@suse.de,
        axboe@kernel.dk, sth@linux.ibm.com, gjoyce@ibm.com,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20250701081954.57381-1-nilay@linux.ibm.com>
 <CAHj4cs9ABpwaoywocFAHP+3k=oWsqBKbM5GFbCedgjEyxzpChA@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAHj4cs9ABpwaoywocFAHP+3k=oWsqBKbM5GFbCedgjEyxzpChA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KzV-1TJoSTKQbWM1stYkQyfSp7ZEtphQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDExNyBTYWx0ZWRfX2UCAEdYwN1Z8 iW843M2M97H0DjZTsYFwb6jGujsYdaGYvDTPBvcB41JD1Yq0xYhlF9Iiimj+VuZZ8f9VtEaLJJp 0Nke+SS/tuxIULsvbE0s7CEjr4ug2elvJU2X11jJfVut70MO1ZQGMY1xRaAghZFyle5TeQXT4G0
 qkTFbJU08sQ8ifHdQ0HfbIE+OS7rinYaH6oe5c5DHKTcTHlyjN+JxQCVMVM+8Kt9x9nE1mALc0c 419SW5BXu/1NJU/5Vu0kKll3mU/QguXratR/RbTi9iSvce4FrXprARK/dzBgHN83O11SJeWOplC eibGXTZr7EQ9Pv+ELGb4Bk1uyl5Tacg0wemuNszicGp5Yl81vtQ6eX97wwizKEYZKERpv3hci24
 gPBJ1ABJv/RwXpL1YoKJCQfDQC234mh/LuAuSol1cGgqtmIF5Dfywlgpoygw3vJzX9UmzVpP
X-Authority-Analysis: v=2.4 cv=MOlgmNZl c=1 sm=1 tr=0 ts=68653f70 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pDldeuzRFnFpWiKfMDUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KzV-1TJoSTKQbWM1stYkQyfSp7ZEtphQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020117



On 7/2/25 7:23 PM, Yi Zhang wrote:
> Hi Nilay
> 
> With the patch on the latest linux-block/for-next, I reproduced the
> following WARNING with blktests block/005, here is the full log:
> 
> [  342.845331] run blktests block/005 at 2025-07-02 09:48:55
> 
> [  343.835605] ======================================================
> [  343.841783] WARNING: possible circular locking dependency detected
> [  343.847966] 6.16.0-rc4.fix+ #3 Not tainted
> [  343.852073] ------------------------------------------------------
> [  343.858250] check/1365 is trying to acquire lock:
> [  343.862957] ffffffff98141db0 (pcpu_alloc_mutex){+.+.}-{4:4}, at:
> pcpu_alloc_noprof+0x8eb/0xd70
> [  343.871587]
>                but task is already holding lock:
> [  343.877421] ffff888300cfb040 (&q->elevator_lock){+.+.}-{4:4}, at:
> elevator_change+0x152/0x530
> [  343.885958]
>                which lock already depends on the new lock.
> 
> [  343.894131]
>                the existing dependency chain (in reverse order) is:
> [  343.901609]
>                -> #3 (&q->elevator_lock){+.+.}-{4:4}:
> [  343.907891]        __lock_acquire+0x6f1/0xc00
> [  343.912259]        lock_acquire.part.0+0xb6/0x240
> [  343.916966]        __mutex_lock+0x17b/0x1690
> [  343.921247]        elevator_change+0x152/0x530
> [  343.925692]        elv_iosched_store+0x205/0x2f0
> [  343.930312]        queue_attr_store+0x23b/0x300
> [  343.934853]        kernfs_fop_write_iter+0x357/0x530
> [  343.939829]        vfs_write+0x9bc/0xf60
> [  343.943763]        ksys_write+0xf3/0x1d0
> [  343.947695]        do_syscall_64+0x8c/0x3d0
> [  343.951883]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  343.957462]
>                -> #2 (&q->q_usage_counter(io)#4){++++}-{0:0}:
> [  343.964440]        __lock_acquire+0x6f1/0xc00
> [  343.968799]        lock_acquire.part.0+0xb6/0x240
> [  343.973507]        blk_alloc_queue+0x5c5/0x710
> [  343.977959]        blk_mq_alloc_queue+0x14e/0x240
> [  343.982666]        __blk_mq_alloc_disk+0x15/0xd0
> [  343.987294]        nvme_alloc_ns+0x208/0x1690 [nvme_core]
> [  343.992727]        nvme_scan_ns+0x362/0x4c0 [nvme_core]
> [  343.997978]        async_run_entry_fn+0x96/0x4f0
> [  344.002599]        process_one_work+0x8cd/0x1950
> [  344.007226]        worker_thread+0x58d/0xcf0
> [  344.011499]        kthread+0x3d8/0x7a0
> [  344.015259]        ret_from_fork+0x406/0x510
> [  344.019532]        ret_from_fork_asm+0x1a/0x30
> [  344.023980]
>                -> #1 (fs_reclaim){+.+.}-{0:0}:
> [  344.029654]        __lock_acquire+0x6f1/0xc00
> [  344.034015]        lock_acquire.part.0+0xb6/0x240
> [  344.038727]        fs_reclaim_acquire+0x103/0x150
> [  344.043433]        prepare_alloc_pages+0x15f/0x600
> [  344.048230]        __alloc_frozen_pages_noprof+0x14a/0x3a0
> [  344.053722]        __alloc_pages_noprof+0xd/0x1d0
> [  344.058438]        pcpu_alloc_pages.constprop.0+0x104/0x420
> [  344.064017]        pcpu_populate_chunk+0x38/0x80
> [  344.068644]        pcpu_alloc_noprof+0x650/0xd70
> [  344.073265]        iommu_dma_init_fq+0x183/0x730
> [  344.077893]        iommu_dma_init_domain+0x566/0x990
> [  344.082866]        iommu_setup_dma_ops+0xca/0x230
> [  344.087571]        bus_iommu_probe+0x1f8/0x4a0
> [  344.092020]        iommu_device_register+0x153/0x240
> [  344.096993]        iommu_init_pci+0x53c/0x1040
> [  344.101447]        amd_iommu_init_pci+0xb6/0x5c0
> [  344.106066]        state_next+0xaf7/0xff0
> [  344.110080]        iommu_go_to_state+0x21/0x80
> [  344.114535]        amd_iommu_init+0x15/0x70
> [  344.118728]        pci_iommu_init+0x29/0x70
> [  344.122914]        do_one_initcall+0x100/0x5a0
> [  344.127361]        do_initcalls+0x138/0x1d0
> [  344.131556]        kernel_init_freeable+0x8b7/0xbd0
> [  344.136442]        kernel_init+0x1b/0x1f0
> [  344.140456]        ret_from_fork+0x406/0x510
> [  344.144735]        ret_from_fork_asm+0x1a/0x30
> [  344.149182]
>                -> #0 (pcpu_alloc_mutex){+.+.}-{4:4}:
> [  344.155379]        check_prev_add+0xf1/0xce0
> [  344.159653]        validate_chain+0x470/0x580
> [  344.164019]        __lock_acquire+0x6f1/0xc00
> [  344.168378]        lock_acquire.part.0+0xb6/0x240
> [  344.173085]        __mutex_lock+0x17b/0x1690
> [  344.177365]        pcpu_alloc_noprof+0x8eb/0xd70
> [  344.181984]        kyber_queue_data_alloc+0x16d/0x660
> [  344.187047]        kyber_init_sched+0x14/0x90
> [  344.191413]        blk_mq_init_sched+0x264/0x4e0
> [  344.196033]        elevator_switch+0x186/0x6a0
> [  344.200478]        elevator_change+0x305/0x530
> [  344.204924]        elv_iosched_store+0x205/0x2f0
> [  344.209545]        queue_attr_store+0x23b/0x300
> [  344.214084]        kernfs_fop_write_iter+0x357/0x530
> [  344.219051]        vfs_write+0x9bc/0xf60
> [  344.222976]        ksys_write+0xf3/0x1d0
> [  344.226902]        do_syscall_64+0x8c/0x3d0
> [  344.231088]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  344.236660]

Thanks for the report!

I see that the above warning is different from the one addressed by the
current patchset. In the warning you've reported, the kyber elevator 
allocates per-CPU data after acquiring ->elevator_lock, which introduces
a per-CPU lock dependency on the ->elevator_lock.

In contrast, the current patchset addresses a separate issue [1] that arises
due to elevator tag allocation. This allocation occurs after both ->freeze_lock
and ->elevator_lock are held. Internally, elevator tags allocation sets up 
per-CPU sbitmap->alloc_hint, which also introduces a similar per-CPU lock
dependency on ->elevator_lock.

That said, I'll plan to address the issue you've just reported in a separate
patch, once the current patchset is merged. 

Thanks,
--Nilay

[1]https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/



