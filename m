Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A51B1FE45A;
	Tue,  1 Apr 2025 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508449; cv=none; b=eGfB1TcHk+WQ3yBEeUAZ+DQdgz76HcMODq2XYHSakPgRHpFb3bOumiCZNdcgL4TsuanyNUyoreLXew26Et1P3aVqk+IlAkUNZqdwu9+AlBtqU5XXbtR/fjZDMyeJg6ZgMyX8wlrkmlRO4yismKKArhx3qmbmEO/dHnWH1oraHys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508449; c=relaxed/simple;
	bh=AM6EGTxAV8kCPWzzaYCBS3T6sHYmD3wVlbRPdlhn6c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Whiepse7rEZfxAwp6wHFETjJokBCRG2TJHnqqsQGGQCwFR8v2PWU+SU+KfFbvBDfor7sbv9tiEN0yx0z2FTwCQGYR/fE4QMC2Asf7+K9c/eKuvh44gq6iR4htd90h8cRG4SaaMRBr3O8h0416WipAWTSOMbQ8KhVqwjH59N5Khc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KnpG495j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KnpG495j"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531ApCM5026644;
	Tue, 1 Apr 2025 11:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=q6yDem
	qQC9wC37TTtJqpj/PkDM3gnD7ozWivhmMoJnU=; b=KnpG495jqHz+17UiZ3p90x
	GL6Uerfu6sLsF2R27rc8HcNmVaOZZPBOYO8fJxpK+n0LPFYwEU+k7HqAFI3tT5a7
	pn7Ok8lhyNYqCktsla+UIK63AFhe7dh7h+VKLtMGhUum2P231Jf3Xn8fNYKVSgA0
	tJK7ksCHwHDB5+G5bIcmbkMUyNatCNuVu6Buxgw7+lJPfktbd14FfAKY1JEhOkAu
	a+/1vCugI1PZLHybKB/jJ4ztLAv865SzIC+vEfr1dEQLE9IypMqk9uZgLI7JK6VS
	aDZF5EyN7DeEEzJ5GnAE5h+flqIJBIrxMXBIsZdNmVqnUV+adhnkh8jnq9cH2C9w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qu32dq0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 11:54:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 531A67DL005478;
	Tue, 1 Apr 2025 11:54:01 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pww2a19k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 11:54:01 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 531Bs0fU7799324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Apr 2025 11:54:00 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58C895805B;
	Tue,  1 Apr 2025 11:54:00 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 300015804B;
	Tue,  1 Apr 2025 11:53:58 +0000 (GMT)
Received: from [9.109.198.185] (unknown [9.109.198.185])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Apr 2025 11:53:57 +0000 (GMT)
Message-ID: <462d4e8a-dd95-48fe-b9fe-a558057f9595@linux.ibm.com>
Date: Tue, 1 Apr 2025 17:23:56 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] possible deadlock in elv_iosched_store
To: Ming Lei <ming.lei@redhat.com>,
        syzbot <syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <67e6b425.050a0220.2f068f.007b.GAE@google.com>
 <Z-dUCLvf06SfTOHy@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z-dUCLvf06SfTOHy@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Dc2hoSW8aFLuENX5uuX7levF5G0gDR48
X-Proofpoint-ORIG-GUID: Dc2hoSW8aFLuENX5uuX7levF5G0gDR48
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010072



On 3/29/25 7:29 AM, Ming Lei wrote:
> On Fri, Mar 28, 2025 at 07:37:25AM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    1a9239bb4253 Merge tag 'net-next-6.15' of git://git.kernel..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1384b43f980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c7163a109ac459a8
>> dashboard link: https://syzkaller.appspot.com/bug?extid=4c7e0f9b94ad65811efb
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178cfa4c580000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a8ca4c580000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/fc7dc9f0d9a7/disk-1a9239bb.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/f555a3ae03d3/vmlinux-1a9239bb.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/55f6ea74eaf2/bzImage-1a9239bb.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
>>
> 
> ...
> 
>>
>> If you want syzbot to run the reproducer, reply with:
>> #syz test: git://repo/address.git branch-or-commit-hash
>> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ae8494d88897..d7a103dc258b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4465,14 +4465,12 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
>  	return NULL;
>  }
>  
> -static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> -						struct request_queue *q)
> +static void __blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> +				     struct request_queue *q)
>  {
>  	struct blk_mq_hw_ctx *hctx;
>  	unsigned long i, j;
>  
> -	/* protect against switching io scheduler  */
> -	mutex_lock(&q->elevator_lock);
>  	for (i = 0; i < set->nr_hw_queues; i++) {
>  		int old_node;
>  		int node = blk_mq_get_hctx_node(set, i);
> @@ -4505,7 +4503,19 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  
>  	xa_for_each_start(&q->hctx_table, j, hctx, j)
>  		blk_mq_exit_hctx(q, set, hctx, j);
> -	mutex_unlock(&q->elevator_lock);
> +}
> +
> +static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> +				   struct request_queue *q, bool lock)
> +{
> +	if (lock) {
> +		/* protect against switching io scheduler  */
> +		mutex_lock(&q->elevator_lock);
> +		__blk_mq_realloc_hw_ctxs(set, q);
> +		mutex_unlock(&q->elevator_lock);
> +	} else {
> +		__blk_mq_realloc_hw_ctxs(set, q);
> +	}
>  
>  	/* unregister cpuhp callbacks for exited hctxs */
>  	blk_mq_remove_hw_queues_cpuhp(q);
> @@ -4537,7 +4547,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>  
>  	xa_init(&q->hctx_table);
>  
> -	blk_mq_realloc_hw_ctxs(set, q);
> +	blk_mq_realloc_hw_ctxs(set, q, false);
>  	if (!q->nr_hw_queues)
>  		goto err_hctxs;
>  
> @@ -5033,7 +5043,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  fallback:
>  	blk_mq_update_queue_map(set);
>  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> -		blk_mq_realloc_hw_ctxs(set, q);
> +		blk_mq_realloc_hw_ctxs(set, q, true);
>  
>  		if (q->nr_hw_queues != set->nr_hw_queues) {
>  			int i = prev_nr_hw_queues;
> 

This patch looks good to me, however after we fix this one, I found another splat. 
I see that these new splats are side effect of commit ffa1e7ada456 ("block: Make 
request_queue lockdep splats show up earlier").

IMO in the block layer code (unless it's in an IO submission path or a path where we 
have already frozen queue) we may still want to allow memory allocation with GFP_KERNEL. 
So in that sense, for example, we may acquire ->elevator_lock followed by fs_reclaim. 
Or in another words, shouldn't it be legitimate to acquire blk layer specific lock and 
then allocate memory using GFP_KERNEL assuming we haven't freezed queue or we're not in 
IO submission path. But this commit ffa1e7ada456 ("block: Make request_queue lockdep
splats show up earlier") now showing up some false-positive splat as well, please see
below:

======================================================
WARNING: possible circular locking dependency detected
6.14.0+ #147 Not tainted
------------------------------------------------------
bash/5903 is trying to acquire lock:
c0000000ba0c6ad8 (&q->elevator_lock){+.+.}-{4:4}, at: elv_iosched_store+0x11c/0x5d4

but task is already holding lock:
c0000000ba0c65b8 (&q->q_usage_counter(io)#20){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x28/0x40

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&q->q_usage_counter(io)#20){++++}-{0:0}:
       blk_alloc_queue+0x3a8/0x3e4
       blk_mq_alloc_queue+0x88/0x11c
       __blk_mq_alloc_disk+0x34/0xd8
       null_add_dev+0x3c8/0x914 [null_blk]
       null_init+0x1e0/0x4bc [null_blk]
       do_one_initcall+0x8c/0x4b8
       do_init_module+0x7c/0x2c4
       init_module_from_file+0xb4/0x108
       idempotent_init_module+0x26c/0x368
       sys_finit_module+0x98/0x150
       system_call_exception+0x134/0x360
       system_call_vectored_common+0x15c/0x2ec

-> #1 (fs_reclaim){+.+.}-{0:0}:
       fs_reclaim_acquire+0xe4/0x120
       kmem_cache_alloc_noprof+0x74/0x570
       __kernfs_new_node+0x98/0x378
       kernfs_new_node+0x80/0xc4
       kernfs_create_dir_ns+0x44/0xec
       sysfs_create_dir_ns+0x94/0x160
       kobject_add_internal+0xf4/0x3c8
       kobject_add+0x70/0x10c
       elv_register_queue+0x70/0x14c
       blk_register_queue+0x1d8/0x2bc
       add_disk_fwnode+0x3b4/0x5d0
       sd_probe+0x3bc/0x5b4 [sd_mod]
       really_probe+0x104/0x4c4
       __driver_probe_device+0xb8/0x200
       driver_probe_device+0x54/0x128
       __driver_attach_async_helper+0x7c/0x150
       async_run_entry_fn+0x60/0x1bc
       process_one_work+0x2ac/0x7e4
       worker_thread+0x238/0x460
       kthread+0x158/0x188
       start_kernel_thread+0x14/0x18

-> #0 (&q->elevator_lock){+.+.}-{4:4}:
       __lock_acquire+0x1b6c/0x2ae0
       lock_acquire+0x140/0x430
       __mutex_lock+0xf0/0xb00
       elv_iosched_store+0x11c/0x5d4
       queue_attr_store+0x12c/0x164
       sysfs_kf_write+0x6c/0xb0
       kernfs_fop_write_iter+0x1ac/0x2a8
       vfs_write+0x410/0x584
       ksys_write+0x84/0x140
       system_call_exception+0x134/0x360
       system_call_vectored_common+0x15c/0x2ec

other info that might help us debug this:

Chain exists of:
  &q->elevator_lock --> fs_reclaim --> &q->q_usage_counter(io)#20

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#20);
                               lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#20);
  lock(&q->elevator_lock);

 *** DEADLOCK ***

5 locks held by bash/5903:
 #0: c00000005cb7f400 (sb_writers#3){.+.+}-{0:0}, at: ksys_write+0x84/0x140
 #1: c000000008711288 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x168/0x2a8
 #2: c00000000a1e2c08 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x174/0x2a8
 #3: c0000000ba0c65b8 (&q->q_usage_counter(io)#20){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x28/0x40
 #4: c0000000ba0c65f0 (&q->q_usage_counter(queue)#21){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x28/0x40

stack backtrace:
CPU: 17 UID: 0 PID: 5903 Comm: bash Kdump: loaded Not tainted 6.14.0+ #147 VOLUNTARY 
Hardware name: IBM,9043-MRX POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.00 (NM1060_028) hv:phyp pSeries
Call Trace:
[c0000000955df580] [c0000000011a7ef8] dump_stack_lvl+0x108/0x18c (unreliable)
[c0000000955df5b0] [c000000000225b0c] print_circular_bug+0x448/0x604
[c0000000955df660] [c000000000225f14] check_noncircular+0x24c/0x26c
[c0000000955df730] [c00000000022c3e8] __lock_acquire+0x1b6c/0x2ae0
[c0000000955df860] [c000000000229700] lock_acquire+0x140/0x430
[c0000000955df960] [c0000000011e84e8] __mutex_lock+0xf0/0xb00
[c0000000955dfa90] [c0000000008fb6f8] elv_iosched_store+0x11c/0x5d4
[c0000000955dfb50] [c000000000903ec0] queue_attr_store+0x12c/0x164
[c0000000955dfc60] [c0000000007ca58c] sysfs_kf_write+0x6c/0xb0
[c0000000955dfca0] [c0000000007c8df0] kernfs_fop_write_iter+0x1ac/0x2a8
[c0000000955dfcf0] [c0000000006a8c9c] vfs_write+0x410/0x584
[c0000000955dfdc0] [c0000000006a9148] ksys_write+0x84/0x140
[c0000000955dfe10] [c000000000031814] system_call_exception+0x134/0x360
[c0000000955dfe50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec
   
What do you think?

Thanks,
--Nilay
