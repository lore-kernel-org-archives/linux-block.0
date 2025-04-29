Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11322BF3DE
	for <linux-block@vger.kernel.org>; Tue, 29 Apr 2025 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745922193; cv=none; b=rOc5PIsiQK0yIJJN3AWRhIRJvD5s8zEoyHyA16V42zxkIcMUo8XTUM8z1UGgbaKh8RWCIiUsLsTkLW4Yl7NTn/V4m6W9wtHHi1brzMgpWnp3o09xLhlbQ+RzaMslVB4zne+/4y/sPjkcEN+1vqj0Kd5U02vpzmRuQjexK6H3DDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745922193; c=relaxed/simple;
	bh=ur+40QuNv2iigt9ujJ4Bmcp6e0RLpAOGKAH+rtKZEwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=es4fTGrvFgatbWMAUm8WEJR90VFeU884d/5jkm6ei3gkxOziNAMVL/F5nhoP1dSNgTmgYJMCfmOMCzuItgyIw9kkdSa0fUC+3z5RG9WU2VRxY/NfTBbyOM6W1uJjypBkvEC2y4xN8oIuhb00uIaJgHZ4Wbn3sGbUk2jaFcVdcF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FHgV82Gy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FHgV82Gy"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TA4ME0000481;
	Tue, 29 Apr 2025 10:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6hAgDC
	yg/aJ+H3WB/xmArBWUZRXkUtjM73EebrAdWjw=; b=FHgV82GyEU2OvF5VJ/qKYv
	v11UndplDeZtajesUBcGYgFpMfCCu80uPJ8QqSu0216C9puA2xAxXQUtgUko123f
	JZCa2K4+gd4ctd2+msHTH3CX0A3zuwiVdhfD/iYSUhEXgJFp74ul0NnYedQaGVyZ
	KJ3rEv1o4BEQNs8T/YylMiRZb+/TebioJd86RxXAc+sRkW7LKZcc6eokG4FLsiI4
	w4XpJBpTJb93rAgb2ZpfltIyCR7MueTkZsWNmDDA1dUbZ6ggbTzJ8G9LneAlfSMC
	Ttaq7n0TfsDcDhwe81cDfocU/nr/61TvF7BI0pPlSfPLkVfQ+3eDFnH/Y7AZCsfg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46avpk82j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 10:22:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53TA6G75001893;
	Tue, 29 Apr 2025 10:22:56 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469bamjndh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 10:22:55 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53TAMtOo10224146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 10:22:55 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BCA058062;
	Tue, 29 Apr 2025 10:22:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C3E058057;
	Tue, 29 Apr 2025 10:22:53 +0000 (GMT)
Received: from [9.109.198.140] (unknown [9.109.198.140])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Apr 2025 10:22:52 +0000 (GMT)
Message-ID: <5e81717f-1b64-4302-b321-c12aee697a0b@linux.ibm.com>
Date: Tue, 29 Apr 2025 15:52:51 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 08/20] block: don't allow to switch elevator if
 updating nr_hw_queues is in-progress
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-9-ming.lei@redhat.com>
 <748f3e46-51c1-47f8-8614-64efb30dd4ff@linux.ibm.com>
 <aA2WIiHJprr_bmJ5@fedora>
 <ab875b11-9591-4034-bb11-ed8a35454a75@linux.ibm.com>
 <aBA84hnKcddOff4W@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aBA84hnKcddOff4W@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=d4b1yQjE c=1 sm=1 tr=0 ts=6810a881 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=QrVfWSKv7Cy2Tqlc27EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: n9SO4u1ydfeAonNOnT0e85u3YUiNQwsh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA3NSBTYWx0ZWRfX6ge3b2JQIaU6 Rxp10IHsVev4Q5JdBSyJoxj5uYSExCmM4fX+S/6vku5UD6M7mryHMVi4E6uDOocqsUmcCYTBD2F bmIc/6oWqNr2n9v9z4QwtwLSHSMJT9WBaa0i2QJWfp2kjekYuNxLbQaB8CX/TP2sE6AdJ/0PYJ8
 MIY/oxF+c6yfL0bQzqFvYi14XPCy+pr9R3bUgHIdHxrCBoqrzX/17qRpLdvE095Iy0J0s1/mSGK atwN/CeWm71ry8TqsfuKwIs5/3Jq6TrrHtTNtyuCt//G2vHxlpojkG/LLMhceEAN7XtUf1q/J4z oAIYMP5R25F4BHS6u3K8jaBXAJCqQvzfPMv/1sRJ0zpAf6V5mCqyl+CWnRcW2Lr94Ynez2YdDKn
 65zEt8gMdUKTzMwVDA4O0OfMGZkXMslM/FFDcG1xgOdeJx3VDmUCTkW01/ZaTtgQhhntiQnQ
X-Proofpoint-GUID: n9SO4u1ydfeAonNOnT0e85u3YUiNQwsh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=948 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290075



On 4/29/25 8:13 AM, Ming Lei wrote:
>> I couldn't recreate it on my setup using above blktests.
> It is reproduced in my test vm every time after killing the nested variant:
> 
> [   74.257200] ======================================================
> [   74.259369] WARNING: possible circular locking dependency detected
> [   74.260772] 6.15.0-rc3_ublk+ #547 Not tainted
> [   74.261950] ------------------------------------------------------
> [   74.263281] check/5077 is trying to acquire lock:
> [   74.264492] ffff888105f1fd18 (kn->active#119){++++}-{0:0}, at: __kernfs_remove+0x213/0x680
> [   74.266006]
>                but task is already holding lock:
> [   74.267998] ffff88828a661e20 (&q->q_usage_counter(queue)#14){++++}-{0:0}, at: del_gendisk+0xe5/0x180
> [   74.269631]
>                which lock already depends on the new lock.
> 
> [   74.272645]
>                the existing dependency chain (in reverse order) is:
> [   74.274804]
>                -> #3 (&q->q_usage_counter(queue)#14){++++}-{0:0}:
> [   74.277009]        blk_queue_enter+0x4c2/0x630
> [   74.278218]        blk_mq_alloc_request+0x479/0xa00
> [   74.279539]        scsi_execute_cmd+0x151/0xba0
> [   74.281078]        sr_check_events+0x1bc/0xa40
> [   74.283012]        cdrom_check_events+0x5c/0x120
> [   74.284892]        disk_check_events+0xbe/0x390
> [   74.286181]        disk_check_media_change+0xf1/0x220
> [   74.287455]        sr_block_open+0xce/0x230
> [   74.288528]        blkdev_get_whole+0x8d/0x200
> [   74.289702]        bdev_open+0x614/0xc60
> [   74.290882]        blkdev_open+0x1f6/0x360
> [   74.292215]        do_dentry_open+0x491/0x1820
> [   74.293309]        vfs_open+0x7a/0x440
> [   74.294384]        path_openat+0x1b7e/0x2ce0
> [   74.295507]        do_filp_open+0x1c5/0x450
> [   74.296616]        do_sys_openat2+0xef/0x180
> [   74.297667]        __x64_sys_openat+0x10e/0x210
> [   74.298768]        do_syscall_64+0x92/0x180
> [   74.299800]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   74.300971]
>                -> #2 (&disk->open_mutex){+.+.}-{4:4}:
> [   74.302700]        __mutex_lock+0x19c/0x1990
> [   74.303682]        bdev_open+0x6cd/0xc60
> [   74.304613]        bdev_file_open_by_dev+0xc4/0x140
> [   74.306008]        disk_scan_partitions+0x191/0x290
> [   74.307716]        __add_disk_fwnode+0xd2a/0x1140
> [   74.309394]        add_disk_fwnode+0x10e/0x220
> [   74.311039]        nvme_alloc_ns+0x1833/0x2c30
> [   74.312669]        nvme_scan_ns+0x5a0/0x6f0
> [   74.314151]        async_run_entry_fn+0x94/0x540
> [   74.315719]        process_one_work+0x86a/0x14a0
> [   74.317287]        worker_thread+0x5bb/0xf90
> [   74.318228]        kthread+0x371/0x720
> [   74.319085]        ret_from_fork+0x31/0x70
> [   74.319941]        ret_from_fork_asm+0x1a/0x30
> [   74.320808]
>                -> #1 (&set->update_nr_hwq_sema){.+.+}-{4:4}:
> [   74.322311]        down_read+0x8e/0x470
> [   74.323135]        elv_iosched_store+0x17a/0x210
> [   74.324036]        queue_attr_store+0x234/0x340
> [   74.324881]        kernfs_fop_write_iter+0x39b/0x5a0
> [   74.325771]        vfs_write+0x5df/0xec0
> [   74.326514]        ksys_write+0xff/0x200
> [   74.327262]        do_syscall_64+0x92/0x180
> [   74.328018]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   74.328963]
>                -> #0 (kn->active#119){++++}-{0:0}:
> [   74.330433]        __lock_acquire+0x145f/0x2260
> [   74.331329]        lock_acquire+0x163/0x300
> [   74.332221]        kernfs_drain+0x39d/0x450
> [   74.333002]        __kernfs_remove+0x213/0x680
> [   74.333792]        kernfs_remove_by_name_ns+0xa2/0x100
> [   74.334589]        remove_files+0x8d/0x1b0
> [   74.335326]        sysfs_remove_group+0x7c/0x160
> [   74.336118]        sysfs_remove_groups+0x55/0xb0
> [   74.336869]        __kobject_del+0x7d/0x1d0
> [   74.337637]        kobject_del+0x38/0x60
> [   74.338340]        blk_unregister_queue+0x153/0x2c0
> [   74.339125]        __del_gendisk+0x252/0x9d0
> [   74.339959]        del_gendisk+0xe5/0x180
> [   74.340756]        sr_remove+0x7b/0xd0
> [   74.341429]        device_release_driver_internal+0x36d/0x520
> [   74.342353]        bus_remove_device+0x1ef/0x3f0
> [   74.343172]        device_del+0x3be/0x9b0
> [   74.343951]        __scsi_remove_device+0x27f/0x340
> [   74.344724]        sdev_store_delete+0x87/0x120
> [   74.345508]        kernfs_fop_write_iter+0x39b/0x5a0
> [   74.346287]        vfs_write+0x5df/0xec0
> [   74.347170]        ksys_write+0xff/0x200
> [   74.348312]        do_syscall_64+0x92/0x180
> [   74.349519]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   74.350797]
>                other info that might help us debug this:
> 
> [   74.353554] Chain exists of:
>                  kn->active#119 --> &disk->open_mutex --> &q->q_usage_counter(queue)#14
> 
> [   74.355535]  Possible unsafe locking scenario:
> 
> [   74.356650]        CPU0                    CPU1
> [   74.357328]        ----                    ----
> [   74.358026]   lock(&q->q_usage_counter(queue)#14);
> [   74.358749]                                lock(&disk->open_mutex);
> [   74.359561]                                lock(&q->q_usage_counter(queue)#14);
> [   74.360488]   lock(kn->active#119);
> [   74.361113]
>                 *** DEADLOCK ***
> 
> [   74.362574] 6 locks held by check/5077:
> [   74.363193]  #0: ffff888114640420 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0xff/0x200
> [   74.364274]  #1: ffff88829abb6088 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x25b/0x5a0
> [   74.365937]  #2: ffff8881176ca0e0 (&shost->scan_mutex){+.+.}-{4:4}, at: sdev_store_delete+0x7f/0x120
> [   74.367643]  #3: ffff88828521c380 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0x90/0x520
> [   74.369464]  #4: ffff8881176ca380 (&set->update_nr_hwq_sema){.+.+}-{4:4}, at: del_gendisk+0xdd/0x180
> [   74.370961]  #5: ffff88828a661e20 (&q->q_usage_counter(queue)#14){++++}-{0:0}, at: del_gendisk+0xe5/0x180
> [   74.372050]
 
This has baffled me as I don't understand how could read lock in
elv_iosched_store (ruuning in context #1) depends on (same) read
lock in add_disk_fwnode (running under another context #2) as 
both locks are represented by the same rw semaphore. As we see 
above both elv_iosched_store and add_disk_fwnode bot run under
different contexts and so ideally they should be able to run
concurrently acquiring the same read lock.

>>>>  
>>>> On another note, if we suspect possible one-depth recursion for the same 
>>>> class of lock then then we should use SINGLE_DEPTH_NESTING (instead of using
>>>> 1 here) for subclass. But still I am not clear why this lock needs nesting.
>>> It is just one false positive, because elv_iosched_store() won't happen
>>> when adding disk.
>>>
>> Yes, but how could we avoid false positive? It's probably because of commit 
>> ffa1e7ada456 ("block: Make request_queue lockdep splats show up earlier"). How about adding manual dependency of fs-reclaim on freeze-lock after we add 
>> the disk. Currently that manual dependency is added in blk_alloc_queue.
> Please see the above trace, which isn't related with commit ffa1e7ada456,
> and the lock chain doesn't include 'fs_reclaim' at all.
> 
> commit ffa1e7ada456 isn't wrong too, which just helps us to expose deadlock
> risk early.
Yes I am not against this commit and now looking at the above splat I don't
blame this commit.

Thanks,
--Nilay
