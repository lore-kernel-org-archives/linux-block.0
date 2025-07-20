Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90AA94F
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753021595; cv=none; b=iTSXyGfbGfYrKpnMs2pKhQLdDerKC0nCLisTAsLH9Q/fQzgEkQ5cbykPzeiRYO9L5HC1zP+rMmu3PabNoWTZ150b3/RD+7iLJZTs2+2ltaHFwgjt2cZTn23bOWiSc280q343VCIxFSxAAweSxocvmbt0OzbUFWZ45r19uorzln4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753021595; c=relaxed/simple;
	bh=zxZNSMCoFWwUWiKp5IL6fBUfxhBAsHVGA0+ZXKLA7b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJwoj5Ynxi3TRN2URY3zph7DJLwASNqXeA8+CX4BrRQRzEFNLQlDWPwOYANpZKbNragdc6XRZot12OV7oE4+5D7K2en2Q8bn8nYkQzxFxAVlieBSuaeK67ddaUI4ueGy5tcqgN8gyrOMdHF59XMazGepiOJ79ofincLX4LOVsYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EExW0FjL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EExW0FjL"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KAqIi5000513;
	Sun, 20 Jul 2025 14:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NzCwh8
	F+rhXpxb4qHyWihLlQn7/yUY9Js6DYBe0WdWE=; b=EExW0FjLnFbrluKHY0EG/R
	2ctUVwpzevaJVMqse5rh3Yc1loh9m+m8fNtpLR4APrXLJScLMEiWzfTQ/DUi0zCh
	e31syFW/Tc33dYGVp4bUnPYaPwMSjGMhZ53F8UOPL9obCY9d+c4r1cfylnZHA9us
	TwXuB7N/3bCHX9WNZK24mI9M1AtTllow/TXXFy/yvnNtn0/AXMYfeFbdfNR3mnqn
	H3Ur5hNOKev/Tmg2BhBN8EavdVUOOJvCnq0owDHe9A/amPfZWM5FSxj8LUzDY8ej
	PMLKm2torQ+DVsw4v9TjaZHqH6T8doG549A04hpfch7V2/HNc3oUuHoYrJkLVd1w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805usvq96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 14:26:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56KAxUEB024951;
	Sun, 20 Jul 2025 14:26:04 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 480nptaa6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 14:26:04 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56KEQ3Ga19530302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 14:26:04 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C244258051;
	Sun, 20 Jul 2025 14:26:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 490125805C;
	Sun, 20 Jul 2025 14:25:59 +0000 (GMT)
Received: from [9.43.22.10] (unknown [9.43.22.10])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 20 Jul 2025 14:25:58 +0000 (GMT)
Message-ID: <4fb0220a-f27f-431f-a502-647622082736@linux.ibm.com>
Date: Sun, 20 Jul 2025 19:55:57 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] block: restore two stage elevator switch while running
 nr_hw_queue update
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, yi.zhang@redhat.com, hch@lst.de,
        yukuai1@huaweicloud.com, axboe@kernel.dk, shinichiro.kawasaki@wdc.com,
        yukuai3@huawei.com, gjoyce@ibm.com
References: <20250718133232.626418-1-nilay@linux.ibm.com>
 <aHze7aUyAs01ftVU@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aHze7aUyAs01ftVU@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDEzNiBTYWx0ZWRfX7+suzilU4P4b
 Tzm29XLZ4Mh0aF2ICTFV5Y5RDGB8SgUA6ue6rHw9Ck4OBwd8wF+F5hvEi2iKsrEc+jqmnFmWbfY
 DlH1kwirjm6iPPqiOeghcgtV735gHJ3zzam434ndqnaDSlF60cUCfwYRoZfTYWIvqDC3I7TJMdg
 /2UAvU6si+z/4TJgK+b0AsuSvdb5qGOkLeyVgMIVS5q/Qr5YPbADjIaPDmllSD03eQLIqsOTLW4
 bnV+UPzx91pQqJlVnzKEA+GwmdKhn8EqiDA8aG3ezfrbYpTlNScIIjEIjFrHZvmBlCgDSWAoVVb
 wUUhy2CWQsgmJvdlbCi9PdcvgfYL7bllfCSDD8m85Zova2sKpyF4dl6NpUozy14EZLFDpXUxZaj
 z6sRpQeEfOPJO7DyG1TqnuIzhM0deTxnLQIWVDhOk8fafGslRo5EckbdSyE9VI9b3E1XZHi7
X-Authority-Analysis: v=2.4 cv=Nd/m13D4 c=1 sm=1 tr=0 ts=687cfc7d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=7M-EbNbzV3xz3eqwAD4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: et24tjmbNtQrEfNVF9tkbf-F02i_NTqG
X-Proofpoint-GUID: et24tjmbNtQrEfNVF9tkbf-F02i_NTqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507200136



On 7/20/25 5:49 PM, Ming Lei wrote:
> On Fri, Jul 18, 2025 at 07:02:09PM +0530, Nilay Shroff wrote:
>> The kmemleak reports memory leaks related to elevator resources that
>> were originally allocated in the ->init_hctx() method. The following
>> leak traces are observed after running blktests:
>>
>> unreferenced object 0xffff8881b82f7400 (size 512):
>>   comm "check", pid 68454, jiffies 4310588881
>>   hex dump (first 32 bytes):
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace (crc 5bac8b34):
>>     __kvmalloc_node_noprof+0x55d/0x7a0
>>     sbitmap_init_node+0x15a/0x6a0
>>     kyber_init_hctx+0x316/0xb90
>>     blk_mq_init_sched+0x419/0x580
>>     elevator_switch+0x18b/0x630
>>     elv_update_nr_hw_queues+0x219/0x2c0
>>     __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>>     blk_mq_update_nr_hw_queues+0x3a/0x60
>>     0xffffffffc09ceb80
>>     0xffffffffc09d7e0b
>>     configfs_write_iter+0x2b1/0x470
>>     vfs_write+0x527/0xe70
>>     ksys_write+0xff/0x200
>>     do_syscall_64+0x98/0x3c0
>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> unreferenced object 0xffff8881b82f6000 (size 512):
>>   comm "check", pid 68454, jiffies 4310588881
>>   hex dump (first 32 bytes):
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace (crc 5bac8b34):
>>     __kvmalloc_node_noprof+0x55d/0x7a0
>>     sbitmap_init_node+0x15a/0x6a0
>>     kyber_init_hctx+0x316/0xb90
>>     blk_mq_init_sched+0x419/0x580
>>     elevator_switch+0x18b/0x630
>>     elv_update_nr_hw_queues+0x219/0x2c0
>>     __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>>     blk_mq_update_nr_hw_queues+0x3a/0x60
>>     0xffffffffc09ceb80
>>     0xffffffffc09d7e0b
>>     configfs_write_iter+0x2b1/0x470
>>     vfs_write+0x527/0xe70
>>     ksys_write+0xff/0x200
>>     do_syscall_64+0x98/0x3c0
>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> unreferenced object 0xffff8881b82f5800 (size 512):
>>   comm "check", pid 68454, jiffies 4310588881
>>   hex dump (first 32 bytes):
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace (crc 5bac8b34):
>>     __kvmalloc_node_noprof+0x55d/0x7a0
>>     sbitmap_init_node+0x15a/0x6a0
>>     kyber_init_hctx+0x316/0xb90
>>     blk_mq_init_sched+0x419/0x580
>>     elevator_switch+0x18b/0x630
>>     elv_update_nr_hw_queues+0x219/0x2c0
>>     __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>>     blk_mq_update_nr_hw_queues+0x3a/0x60
>>     0xffffffffc09ceb80
>>     0xffffffffc09d7e0b
>>     configfs_write_iter+0x2b1/0x470
>>     vfs_write+0x527/0xe70
>>
>>     ksys_write+0xff/0x200
>>     do_syscall_64+0x98/0x3c0
>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> The issue arises while we run nr_hw_queue update,  Specifically, we first
>> reallocate hardware contexts (hctx) via __blk_mq_realloc_hw_ctxs(), and
>> then later invoke elevator_switch() (assuming q->elevator is not NULL).
>> The elevator switch code would first exit old elevator (elevator_exit)
>> and then switches to the new elevator. The elevator_exit loops through
>> each hctx and invokes the elevator’s per-hctx exit method ->exit_hctx(),
>> which releases resources allocated during ->init_hctx().
>>
>> This memleak manifests when we reduce the num of h/w queues - for example,
>> when the initial update sets the number of queues to X, and a later update
>> reduces it to Y, where Y < X. In this case, we'd loose the access to old
>> hctxs while we get to elevator exit code because __blk_mq_realloc_hw_ctxs
>> would have already released the old hctxs. As we don't now have any
>> reference left to the old hctxs, we don't have any way to free the
>> scheduler resources (which are allocate in ->init_hctx()) and kmemleak
>> complains about it.
>>
>> This issue was caused due to the commit 596dce110b7d ("block: simplify
>> elevator reattachment for updating nr_hw_queues"). That change unified
>> the two-stage elevator teardown and reattachment into a single call that
>> occurs after __blk_mq_realloc_hw_ctxs() has already freed the hctxs.
>>
>> This patch restores the previous two-stage elevator switch logic during
>> nr_hw_queues updates. First, the elevator is switched to 'none', which
>> ensures all scheduler resources are properly freed. Then, the hardware
>> contexts (hctxs) are reallocated, and the software-to-hardware queue
>> mappings are updated. Finally, the original elevator is reattached. This
>> sequence prevents loss of references to old hctxs and avoids the scheduler
>> resource leaks reported by kmemleak.
>>
>> Reported-by : Yi Zhang <yi.zhang@redhat.com>
>> Fixes: 596dce110b7d ("block: simplify elevator reattachment for updating nr_hw_queues")
>> Closes: https://lore.kernel.org/all/CAHj4cs8oJFvz=daCvjHM5dYCNQH4UXwSySPPU4v-WHce_kZXZA@mail.gmail.com/
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>> Changes from v1:
>>     - Updated commit message with kmemleak trace generated using null-blk
>>       (Yi Zhang)
>>     - The elevator module could be removed while nr_hw_queue update is
>>       running, so protect elevator switch using elevator_get() and 
>>       elevator_put() (Ming Lei)
>>     - Invoke elv_update_nr_hw_queues() from blk_mq_elv_switch_back() and 
>>       that way avoid elevator code restructuring in a patch which fixes
>>       a regression. (Ming Lei)
>>
>> ---
>>  block/blk-mq.c   | 86 +++++++++++++++++++++++++++++++++++++++++++-----
>>  block/blk.h      |  2 +-
>>  block/elevator.c |  6 ++--
>>  3 files changed, 81 insertions(+), 13 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 4806b867e37d..fa25d6d36790 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -4966,6 +4966,62 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>>  	return ret;
>>  }
>>  
>> +/*
>> + * Switch back to the elevator type stored in the xarray.
>> + */
>> +static void blk_mq_elv_switch_back(struct request_queue *q,
>> +		struct xarray *elv_tbl)
>> +{
>> +	struct elevator_type *e = xa_load(elv_tbl, q->id);
>> +
>> +	/* The elv_update_nr_hw_queues unfreezes the queue. */
>> +	elv_update_nr_hw_queues(q, e);
>> +
>> +	/* Drop the reference acquired in blk_mq_elv_switch_none. */
>> +	if (e)
>> +		elevator_put(e);
>> +}
>> +
>> +/*
>> + * Stores elevator type in xarray and set current elevator to none. It uses
>> + * q->id as an index to store the elevator type into the xarray.
>> + */
>> +static int blk_mq_elv_switch_none(struct request_queue *q,
>> +		struct xarray *elv_tbl)
>> +{
>> +	int ret = 0;
>> +
>> +	lockdep_assert_held_write(&q->tag_set->update_nr_hwq_lock);
>> +
>> +	/*
>> +	 * Accessing q->elevator without holding q->elevator_lock is safe here
>> +	 * because we're called from nr_hw_queue update which is protected by
>> +	 * set->update_nr_hwq_lock in the writer context. So, scheduler update/
>> +	 * switch code (which acquires the same lock in the reader context)
>> +	 * can't run concurrently.
>> +	 */
>> +	if (q->elevator) {
>> +
>> +		ret = xa_insert(elv_tbl, q->id, q->elevator->type, GFP_KERNEL);
>> +		if (ret) {
>> +			WARN_ON_ONCE(1);
>> +			goto out;
>> +		}
>> +		/*
>> +		 * Before we switch elevator to 'none', take a reference to
>> +		 * the elevator module so that while nr_hw_queue update is
>> +		 * running, no one can remove elevator module. We'd put the
>> +		 * reference to elevator module later when we switch back
>> +		 * elevator.
>> +		 */
>> +		__elevator_get(q->elevator->type);
>> +
>> +		elevator_set_none(q);
>> +	}
>> +out:
>> +	return ret;
>> +}
>> +
>>  static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>  							int nr_hw_queues)
>>  {
>> @@ -4973,6 +5029,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>  	int prev_nr_hw_queues = set->nr_hw_queues;
>>  	unsigned int memflags;
>>  	int i;
>> +	struct xarray elv_tbl;
>>  
>>  	lockdep_assert_held(&set->tag_list_lock);
>>  
>> @@ -4984,6 +5041,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>  		return;
>>  
>>  	memflags = memalloc_noio_save();
>> +
>> +	xa_init(&elv_tbl);
>> +
>>  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>>  		blk_mq_debugfs_unregister_hctxs(q);
>>  		blk_mq_sysfs_unregister_hctxs(q);
>> @@ -4992,11 +5052,17 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>>  	list_for_each_entry(q, &set->tag_list, tag_set_list)
>>  		blk_mq_freeze_queue_nomemsave(q);
>>  
>> -	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0) {
>> -		list_for_each_entry(q, &set->tag_list, tag_set_list)
>> -			blk_mq_unfreeze_queue_nomemrestore(q);
>> -		goto reregister;
>> -	}
>> +	/*
>> +	 * Switch IO scheduler to 'none', cleaning up the data associated
>> +	 * with the previous scheduler. We will switch back once we are done
>> +	 * updating the new sw to hw queue mappings.
>> +	 */
>> +	list_for_each_entry(q, &set->tag_list, tag_set_list)
>> +		if (blk_mq_elv_switch_none(q, &elv_tbl))
>> +			goto switch_back;
> 
> The partial `switch_back` need to be careful. If switching to none is
> failed for one queue, the other remained will be switched back to none
> no matter if the previous scheduler is none or not. Maybe return type of
> blk_mq_elv_switch_none() can be defined as 'void' simply for avoiding the
> trouble.
> 
Hmm, maybe not. I think in the case of a partial failure while switching the
scheduler to 'none', only those queues whose scheduler was actually switched
to 'none' would be switched back to their previous scheduler.

Let's consider an example scenario:
We have three queues — q1, q2, and q3 — all sharing the same tagset.

Initially:
- q1 uses scheduler s1
- q2 uses scheduler s2
- q3 uses scheduler s3

Now, during the nr_hw_queue update, we invoke blk_mq_elv_switch_none() to
temporarily switch all schedulers to 'none'. Suppose the switch fails specifically
for q3. In this case:
- q1 and q2 successfully switched to 'none'
- q3 remains with its original scheduler s3
- We save the original scheduler mappings in an xarray as follows:
  x[q1->id] = s1
  x[q2->id] = s2
  x[q3->id] = 0   // Indicates no change was made

Since the switch failed for q3, we then invoke blk_mq_elv_switch_back(), which 
internally calls elv_update_nr_hw_queues() to restore the previous schedulers:

For q1: x[q1->id] = s1 => scheduler is restored to s1
For q2: x[q2->id] = s2 => scheduler is restored to s2
For q3: x[q3->id] = 0  => no scheduler switch attempted, q3 continues to use s3

So based on this flow, the current implementation appears to correctly handle partial
failures — only those queues that were successfully switched to 'none' are switched back.

Let me know if you think there's a scenario where this logic might still break.

Thanks,
--Nilay
