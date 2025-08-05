Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79A71922F5
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413554; cv=none; b=aiV4N84ANNWLnZm6RTGAgbYhDaZEUm6sOxdLPCDDxRAKE/BjT36mTQUECYmabDTawjataN27/cCLaRNR8KCbAx04e9lIeEd88O+vKH5NcbAy8qaRyaqkuTfbOlTfRzIi2gkwJ5jo0I3Hl4X6Ty175edgkSoAG3MFwIQe0LWsJrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413554; c=relaxed/simple;
	bh=J490mIPsRhD0XAnpGXjr4NRQmpNAkbN79VGRGXl8JjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pJALdSfNZhYZUD7NCJ/xq+plLEJdnoNfPXpldr79uRXDwThsX5LOeg6proND1cf7grxiRL2XOaFDNuOZQ1GV5jDSyM//+hTIbcRGuZ5iYNGq4J5a2aWnGlOyZ6opFlTyRGzQ350pisuKXS+e/Tk80gwkbWLJfBFUarNVA31jCUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BTEXe6UG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BTEXe6UG"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5759Jq0B026927;
	Tue, 5 Aug 2025 17:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=at88DU
	g2qtIvFvmv+hKL3f29WOZTh+XkfMCmeJSUahM=; b=BTEXe6UGk3mK4AeNaNTowj
	MQrRRYYVqDsJIaeitgF0NWA0hRpVKKu0C7jb1uJYJEyq0817RJT1VHA1dkGtT6yr
	86seK3mHewzBahj31BdCOHDm/ZyptwXnIOQwdJoKg0ZG3354vRoERrn4em23gioI
	d4kQRmRJxSByjM6Utb5xOcwdkJcksnwGkHlAHpQHBB6PufLUBd+xejFw1jtL1puE
	m+8qCs8YC6QP33QWjm9/4sNdpElH/44qKjNDOPBvJOIWl8Eo1zrOSN64fH52Monc
	YgVCOCe1H4BbFnFSottF8npzreXKPOjQdhlVxsbK15qCFbVeYTUVAvGr+rYVObGA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48a4aa3vch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 17:05:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 575EG1iM001973;
	Tue, 5 Aug 2025 17:05:43 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 489y7ku7gp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 17:05:43 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 575H5hh413632236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 17:05:43 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D41458052;
	Tue,  5 Aug 2025 17:05:43 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0195F58045;
	Tue,  5 Aug 2025 17:05:40 +0000 (GMT)
Received: from [9.43.35.190] (unknown [9.43.35.190])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 17:05:39 +0000 (GMT)
Message-ID: <897eaaa4-31c7-4661-b5d4-3e2bef1fca1e@linux.ibm.com>
Date: Tue, 5 Aug 2025 22:35:38 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block: blk-rq-qos: replace static key with atomic
 bitop
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, kch@nvidia.com,
        shinichiro.kawasaki@wdc.com, hch@lst.de, gjoyce@ibm.com
References: <20250804122125.3271397-1-nilay@linux.ibm.com>
 <aJC4tDUsk42Nb9Df@fedora>
 <682f0f43-733a-4c04-91ed-5665815128bc@linux.ibm.com>
 <aJH8qDEzV4tiG2wE@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aJH8qDEzV4tiG2wE@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -2NEaNWm9BIk5EtK9sStth0VYL6dXASb
X-Authority-Analysis: v=2.4 cv=dNummPZb c=1 sm=1 tr=0 ts=689239e8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=H-vn61tTS7pdGyjCI4YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -2NEaNWm9BIk5EtK9sStth0VYL6dXASb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDExOCBTYWx0ZWRfXzpddwcmdXEB/
 UsOIoE7CQwqzuLxCgY797xeigJ1T/DyMTrTXqOt5FNuB0/YqSI7vMPOVN1AMOHnkCVnkRDhWJUd
 ZDhta0EluKYzU3zRWPeMj/cOBNxv+JwMIBpfpVRtpOMBeLwMKE3P4PothzVCe6b5LMs6HtPs4oD
 Pmk5Et1tVA6AZBDts2eMUI8ttoV0k8kP8tb08GrCxnw5PApjWpqBL4UYh4reZc76664vLRVDU8D
 QjUTrC/Kn/pjrZUOQoMrxYenngSKYCs7/d3ITftpPpP9TgNKNF3xo/kPyAIkK+F273glEFPCyyQ
 CxyB7xiENbWOGoHr3Yp+oxMjnKknluyVhpZ36kQgyfEz0Red9I3xRgp0FMcnYksN8gE4emsbNLZ
 NnYETiH/5ipdHH5PL63eBcIA8FHRDBWhsAu6nCiAqQ/DsQV0dNMnExqMAWCMltPap+LKuhc+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050118



On 8/5/25 6:14 PM, Ming Lei wrote:
> On Tue, Aug 05, 2025 at 10:28:14AM +0530, Nilay Shroff wrote:
>>
>>
>> On 8/4/25 7:12 PM, Ming Lei wrote:
>>> On Mon, Aug 04, 2025 at 05:51:09PM +0530, Nilay Shroff wrote:
>>>> This patchset replaces the use of a static key in the I/O path (rq_qos_
>>>> xxx()) with an atomic queue flag (QUEUE_FLAG_QOS_ENABLED). This change
>>>> is made to eliminate a potential deadlock introduced by the use of static
>>>> keys in the blk-rq-qos infrastructure, as reported by lockdep during 
>>>> blktests block/005[1].
>>>>
>>>> The original static key approach was introduced to avoid unnecessary
>>>> dereferencing of q->rq_qos when no blk-rq-qos module (e.g., blk-wbt or
>>>> blk-iolatency) is configured. While efficient, enabling a static key at
>>>> runtime requires taking cpu_hotplug_lock and jump_label_mutex, which 
>>>> becomes problematic if the queue is already frozen — causing a reverse
>>>> dependency on ->freeze_lock. This results in a lockdep splat indicating
>>>> a potential deadlock.
>>>>
>>>> To resolve this, we now gate q->rq_qos access with a q->queue_flags
>>>> bitop (QUEUE_FLAG_QOS_ENABLED), avoiding the static key and the associated
>>>> locking altogether.
>>>>
>>>> I compared both static key and atomic bitop implementations using ftrace
>>>> function graph tracer over ~50 invocations of rq_qos_issue() while ensuring
>>>> blk-wbt/blk-iolatency were disabled (i.e., no QoS functionality). For
>>>> easy comparision, I made rq_qos_issue() noinline. The comparision was
>>>> made on PowerPC machine.
>>>>
>>>> Static Key (disabled : QoS is not configured):
>>>> 5d0: 00 00 00 60     nop    # patched in by static key framework (not taken)
>>>> 5d4: 20 00 80 4e     blr    # return (branch to link register)
>>>>
>>>> Only a nop and blr (branch to link register) are executed — very lightweight.
>>>>
>>>> atomic bitop (QoS is not configured):
>>>> 5d0: 20 00 23 e9     ld      r9,32(r3)     # load q->queue_flags
>>>> 5d4: 00 80 29 71     andi.   r9,r9,32768   # check QUEUE_FLAG_QOS_ENABLED (bit 15)
>>>> 5d8: 20 00 82 4d     beqlr                 # return if bit not set
>>>>
>>>> This performs an ld and and andi. before returning. Slightly more work, 
>>>> but q->queue_flags is typically hot in cache during I/O submission.
>>>>
>>>> With Static Key (disabled):
>>>> Duration (us): min=0.668 max=0.816 avg≈0.750
>>>>
>>>> With atomic bitop QUEUE_FLAG_QOS_ENABLED (bit not set):
>>>> Duration (us): min=0.684 max=0.834 avg≈0.759
>>>>
>>>> As expected, both versions are almost similar in cost. The added latency
>>>> from an extra ld and andi. is in the range of ~9ns.
>>>>
>>>> There're two patches in the series. The first patch replaces static key
>>>> with QUEUE_FLAG_QOS_ENABLED. The second patch ensures that we disable
>>>> the QUEUE_FLAG_QOS_ENABLED when the queue no longer has any associated
>>>> rq_qos policies.
>>>>
>>>> As usual, feedback and review comments are welcome!
>>>>
>>>> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
>>>
>>>
>>> Another approach is to call memalloc_noio_save() in cpu hotplug code...
>>>
>> Yes that would help fix this. However per the general usage of GFP_NOIO scope in 
>> kernel, it is used when we're performing memory allocations in a context where I/O
>> must not be initiated, because doing so could cause deadlocks or recursion. 
>>
>> So we typically, use GFP_NOIO in a code path that is already doing I/O, such as:
>> - In block layer context: during request submission 
>> - Filesystem writeback, or swap-out.
>> - Memory reclaim or writeback triggered by memory pressure.
> 
> If you grep blk_mq_freeze_queue, you will see the above list is far from
> enough, :-)
> 
Yes you were correct:-) I didn't cover all cases but only a subset.

>>
>> The cpu hotplug code may not be running in any of the above context. So
>> IMO, adding memalloc_noio_save() in the cpu hotplug code would not be 
>> a good idea, isn't it?
> 
> The reasoning(A -> B) looks correct, but the condition A is obviously not.
> 
Regarding the use of memalloc_noio_save() in CPU hotplug code:
Notably this issue isn't limited to the CPU hotplug subsystem itself. 
In reality, the cpu_hotplug_lock is widely used across various kernel 
subsystems—not just in CPU hotplug-specific paths. There are several
code paths outside of the hotplug core that acquire cpu_hotplug_lock
and subsequently perform memory allocations using GFP_KERNEL.

You can observe this by grepping for usages of cpu_hotplug_lock throughout
the kernel. This means that adding memalloc_noio_save() solely within the
CPU hotplug code wouldn't address the broader problem.

I also experimented with placing memalloc_noio_save() in CPU hotplug path,
and as expected, I still encountered a lockdep splat—indicating that the 
root cause lies deeper in the general locking and allocation order around
cpu_hotplug_lock and memory reclaim behavior. Please see below the new 
lockdep splat observed (after adding memalloc_noio_save() in CPU hotplug
code):

======================================================
WARNING: possible circular locking dependency detected
6.16.0+ #14 Not tainted
------------------------------------------------------
check/4628 is trying to acquire lock:
c0000000027b30c8 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_slow_inc+0x24/0x50

but task is already holding lock:
c0000000cb825d28 (&q->q_usage_counter(io)#18){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x28/0x40

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&q->q_usage_counter(io)#18){++++}-{0:0}:
       __lock_acquire+0x6b4/0x103c
       lock_acquire.part.0+0xd0/0x26c
       blk_alloc_queue+0x3ac/0x3e8
       blk_mq_alloc_queue+0x88/0x11c
       __blk_mq_alloc_disk+0x34/0xd8
       nvme_alloc_ns+0xdc/0x6ac [nvme_core]
       nvme_scan_ns+0x234/0x2d4 [nvme_core]
       async_run_entry_fn+0x60/0x1cc
       process_one_work+0x2ac/0x7e4
       worker_thread+0x238/0x460
       kthread+0x158/0x188
       start_kernel_thread+0x14/0x18

-> #2 (fs_reclaim){+.+.}-{0:0}:
       __lock_acquire+0x6b4/0x103c
       lock_acquire.part.0+0xd0/0x26c
       fs_reclaim_acquire+0xe0/0x120
       __kmalloc_cache_noprof+0x78/0x5d0
       jump_label_add_module+0x1b0/0x528
       jump_label_module_notify+0xb0/0x114
       notifier_call_chain+0xac/0x248
       blocking_notifier_call_chain_robust+0x88/0x134
       load_module+0x938/0xba0
       init_module_from_file+0xb4/0x108
       idempotent_init_module+0x26c/0x358
       sys_finit_module+0x98/0x140
       system_call_exception+0x134/0x360
       system_call_vectored_common+0x15c/0x2ec

-> #1 (jump_label_mutex){+.+.}-{4:4}:
       __lock_acquire+0x6b4/0x103c
       lock_acquire.part.0+0xd0/0x26c
       __mutex_lock+0xf0/0xf60
       jump_label_init+0x74/0x194
       early_init_devtree+0x110/0x534
       early_setup+0xc4/0x2a0
       start_here_multiplatform+0x84/0xa0

-> #0 (cpu_hotplug_lock){++++}-{0:0}:
       check_prev_add+0x170/0x1248
       validate_chain+0x7f0/0xba8
       __lock_acquire+0x6b4/0x103c
       lock_acquire.part.0+0xd0/0x26c
       cpus_read_lock+0x6c/0x18c
       static_key_slow_inc+0x24/0x50
       rq_qos_add+0x108/0x1c0
       wbt_init+0x17c/0x234
       elevator_change_done+0x228/0x2ac
       elv_iosched_store+0x144/0x1f0
       queue_attr_store+0x12c/0x164
       sysfs_kf_write+0x74/0xc4
       kernfs_fop_write_iter+0x1a8/0x2a4
       vfs_write+0x45c/0x65c
       ksys_write+0x84/0x140
       system_call_exception+0x134/0x360
       system_call_vectored_common+0x15c/0x2ec

other info that might help us debug this:

Chain exists of:
  cpu_hotplug_lock --> fs_reclaim --> &q->q_usage_counter(io)#18

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#18);
                               lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#18);
  rlock(cpu_hotplug_lock);
 *** DEADLOCK ***

7 locks held by check/4628:
 #0: c0000000b6a92418 (sb_writers#3){.+.+}-{0:0}, at: ksys_write+0x84/0x140
 #1: c0000000b79f5488 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x164/0x2a4
 #2: c000000009aef2b8 (kn->active#58){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x170/0x2a4
 #3: c0000000cc512190 (&set->update_nr_hwq_lock){++++}-{4:4}, at: elv_iosched_store+0x124/0x1f0
 #4: c0000000cb825f30 (&q->rq_qos_mutex){+.+.}-{4:4}, at: wbt_init+0x160/0x234
 #5: c0000000cb825d28 (&q->q_usage_counter(io)#18){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x28/0x40
 #6: c0000000cb825d60 (&q->q_usage_counter(queue)#15){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x28/0x40


Thanks,
--Nilay
