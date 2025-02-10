Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D0022FF58
	for <linux-block@vger.kernel.org>; Mon, 10 Feb 2025 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194632; cv=none; b=bdPAqzH46JkHWynBTz78tTEhla3t2T3bIhKlh4ZO2bQdCfgGdmx4bj5KwPt10QMWuC/ozvO2DJa84W/1Lypo7kHY2PaN07HBxjg91V6o5GIWykKpSDPds45fFnZMSyFuk2Mb5pQAuIkU2dW21y9QSM5BZCHnW+fwacv7a61xhEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194632; c=relaxed/simple;
	bh=4lvL+OGPx6BuEf8PfbuoZnpI0cjlEyVuBZExXP04Bow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMzjRyd+kaTOsko8upqC9tYT0Wjj/yPeySP82/7NBNkLCivflw9J3jgdG2IPvikTtLxdEIfx5EFWS+ZdmD6Xi0xpcOCva90H9pmmGOelEK8PcTB+XOtFqTC9tPIaEEw6gplQflxb2gfn6QhNq3t598OcfZ1l/XJ6wjIgenDAElA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TPVH6j0a; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TPVH6j0a"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A7XF99021503;
	Mon, 10 Feb 2025 13:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4a+uwn
	uDVIE893jKGXM5U4NV+5VvPxtFNmQbkX9D+Q8=; b=TPVH6j0acB+0qMKZtpqaw9
	PwNXlr7+q3UFIIcwe84V72UgQ1yJMGc/kpTLX5dG5KKGDYFDcG+iuxToZz6x9yOb
	CxwFvqtCULal/LXC5lTYjn1cLVzEYNXWRBDHZ4eEZJ3qXoDRl4zRtfiZ+O+Yjfy4
	5eT21IULVgnLXdd6oOD8oC3B4jNSrgdjP0xmXQ9QxciZ/edtA3aFIuflZOznzWlb
	MPHzeizkBcHB1rXjDZij2zM0FRUk3ebFF77g2c59OFRwCZJywn4MQpNZLvLUbrWl
	ny0VmKtjM1cgude7tagHBOs8sE771y4F32p6E44H/0TiYLqWoUTSKL4r2PC8weeQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44qd5nsmr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 13:37:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51ABJS7a021713;
	Mon, 10 Feb 2025 13:37:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44phksep1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 13:37:03 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51ADb37Z26739336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 13:37:03 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4486258043;
	Mon, 10 Feb 2025 13:37:03 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 701A958055;
	Mon, 10 Feb 2025 13:37:01 +0000 (GMT)
Received: from [9.109.198.172] (unknown [9.109.198.172])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Feb 2025 13:37:01 +0000 (GMT)
Message-ID: <15c24003-c48e-4ca6-856f-5f42944e32a2@linux.ibm.com>
Date: Mon, 10 Feb 2025 19:06:59 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] block: don't grab q->debugfs_mutex
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        hch <hch@lst.de>
References: <20250209122035.1327325-1-ming.lei@redhat.com>
 <20250209122035.1327325-8-ming.lei@redhat.com>
 <vc2tk5rrg4xs4vkxwirokp2ugzg6fpbmhlenw7xvjgpndkzere@peyfaxxwefj3>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <vc2tk5rrg4xs4vkxwirokp2ugzg6fpbmhlenw7xvjgpndkzere@peyfaxxwefj3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EmiHzNd_L1-e_2FLfVboRWpHJKOTusWk
X-Proofpoint-ORIG-GUID: EmiHzNd_L1-e_2FLfVboRWpHJKOTusWk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_07,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502100113



On 2/10/25 6:22 AM, Shinichiro Kawasaki wrote:
> On Feb 09, 2025 / 20:20, Ming Lei wrote:
>> All block internal state for dealing adding/removing debugfs entries
>> have been removed, and debugfs can sync everything for us in fs level,
>> so don't grab q->debugfs_mutex for adding/removing block internal debugfs
>> entries.
>>
>> Now q->debugfs_mutex is only used for blktrace, meantime move creating
>> queue debugfs dir code out of q->sysfs_lock. Both the two locks are
>> connected with queue freeze IO lock.  Then queue freeze IO lock chain
>> with debugfs lock is cut.
>>
>> The following lockdep report can be fixed:
>>
>> https://lore.kernel.org/linux-block/ougniadskhks7uyxguxihgeuh2pv4yaqv4q3emo4gwuolgzdt6@brotly74p6bs/
>>
>> Follows contexts which adds/removes debugfs entries:
>>
>> - update nr_hw_queues
>>
>> - add/remove disks
>>
>> - elevator switch
>>
>> - blktrace
>>
>> blktrace only adds entries under disk top directory, so we can ignore it,
>> because it can only work iff disk is added. Also nothing overlapped with
>> the other two contex, blktrace context is fine.
>>
>> Elevator switch is only allowed after disk is added, so there isn't race
>> with add/remove disk. blk_mq_update_nr_hw_queues() always restores to
>> previous elevator, so no race between these two. Elevator switch context
>> is fine.
>>
>> So far blk_mq_update_nr_hw_queues() doesn't hold debugfs lock for
>> adding/removing hctx entries, there might be race with add/remove disk,
>> which is just fine in reality:
>>
>> - blk_mq_update_nr_hw_queues() is usually for error recovery, and disk
>> won't be added/removed at the same time
>>
>> - even though there is race between the two contexts, it is just fine,
>> since hctx won't be freed until queue is dead
>>
>> - we never see reports in this area without holding debugfs in
>> blk_mq_update_nr_hw_queues()
>>
>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 

[...]

> 
> [  115.085704] [   T1023] run blktests block/002 at 2025-02-10 09:22:22
> [  115.383653] [   T1054] sd 9:0:0:0: [sdd] Synchronizing SCSI cache
> [  115.641933] [   T1055] scsi_debug:sdebug_driver_probe: scsi_debug: trim poll_queues to 0. poll_q/nr_hw = (0/1)
> [  115.642961] [   T1055] scsi host9: scsi_debug: version 0191 [20210520]
>                             dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
> [  115.646207] [   T1055] scsi 9:0:0:0: Direct-Access     Linux    scsi_debug       0191 PQ: 0 ANSI: 7
> [  115.648225] [      C0] scsi 9:0:0:0: Power-on or device reset occurred
> [  115.654243] [   T1055] sd 9:0:0:0: Attached scsi generic sg3 type 0
> [  115.656248] [    T100] sd 9:0:0:0: [sdd] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
> [  115.658403] [    T100] sd 9:0:0:0: [sdd] Write Protect is off
> [  115.659125] [    T100] sd 9:0:0:0: [sdd] Mode Sense: 73 00 10 08
> [  115.661621] [    T100] sd 9:0:0:0: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
> [  115.669276] [    T100] sd 9:0:0:0: [sdd] permanent stream count = 5
> [  115.673375] [    T100] sd 9:0:0:0: [sdd] Preferred minimum I/O size 512 bytes
> [  115.673974] [    T100] sd 9:0:0:0: [sdd] Optimal transfer size 524288 bytes
> [  115.710112] [    T100] sd 9:0:0:0: [sdd] Attached SCSI disk
> 
> [  116.464802] [   T1079] ======================================================
> [  116.465540] [   T1079] WARNING: possible circular locking dependency detected
> [  116.466107] [   T1079] 6.14.0-rc1+ #253 Not tainted
> [  116.466581] [   T1079] ------------------------------------------------------
> [  116.467141] [   T1079] blktrace/1079 is trying to acquire lock:
> [  116.467708] [   T1079] ffff88810539d1e0 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0x99/0x120
> [  116.468439] [   T1079] 
>                           but task is already holding lock:
> [  116.469052] [   T1079] ffff88810a5fd758 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: relay_file_read+0xa3/0x8a0
> [  116.469901] [   T1079] 
>                           which lock already depends on the new lock.
> 
> [  116.470762] [   T1079] 
>                           the existing dependency chain (in reverse order) is:
> [  116.473187] [   T1079] 
>                           -> #5 (&sb->s_type->i_mutex_key#3){++++}-{4:4}:
> [  116.475670] [   T1079]        down_read+0x9b/0x470
> [  116.477001] [   T1079]        lookup_one_unlocked+0xe9/0x120
> [  116.478333] [   T1079]        lookup_positive_unlocked+0x1d/0x90
> [  116.479648] [   T1079]        debugfs_lookup+0x47/0xa0
> [  116.480833] [   T1079]        blk_mq_debugfs_unregister_sched_hctx+0x23/0x50
> [  116.482215] [   T1079]        blk_mq_exit_sched+0xb6/0x2b0
> [  116.483466] [   T1079]        elevator_switch+0x12a/0x4b0
> [  116.484676] [   T1079]        elv_iosched_store+0x29f/0x380
> [  116.485841] [   T1079]        queue_attr_store+0x313/0x480
> [  116.487078] [   T1079]        kernfs_fop_write_iter+0x39e/0x5a0
> [  116.488358] [   T1079]        vfs_write+0x5f9/0xe90
> [  116.489460] [   T1079]        ksys_write+0xf6/0x1c0
> [  116.490582] [   T1079]        do_syscall_64+0x93/0x180
> [  116.491694] [   T1079]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  116.492996] [   T1079] 
>                           -> #4 (&eq->sysfs_lock){+.+.}-{4:4}:
> [  116.495135] [   T1079]        __mutex_lock+0x1aa/0x1360
> [  116.496363] [   T1079]        elevator_switch+0x11f/0x4b0
> [  116.497499] [   T1079]        elv_iosched_store+0x29f/0x380
> [  116.498660] [   T1079]        queue_attr_store+0x313/0x480
> [  116.499752] [   T1079]        kernfs_fop_write_iter+0x39e/0x5a0
> [  116.500884] [   T1079]        vfs_write+0x5f9/0xe90
> [  116.501964] [   T1079]        ksys_write+0xf6/0x1c0
> [  116.503056] [   T1079]        do_syscall_64+0x93/0x180
> [  116.504194] [   T1079]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  116.505356] [   T1079] 
In the above dependency chain, I see that thread #5 is waiting on &sb->s_type->i_mutex_key
after acquiring q->sysfs_lock and eq->sysfs_lock. And thread #4 would have acquired 
q->sysfs_lock and now pending on eq->sysfs_lock. But then how is it possible that two threads
are able to acquire q->sysfs_lock at the same time (assuming this is for the same request_queue). 
Is this a false-positive report from lockdep? Or am I missing something?

Thanks,
--Nilay


