Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AC4C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6A32081B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6A32081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeK2Awx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:52:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49528 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727802AbeK2Aww (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 19:52:52 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wASDmnjW123819
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 08:51:08 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p1tve3xu4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 08:51:08 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 28 Nov 2018 13:51:07 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Nov 2018 13:51:04 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wASDp3fe19202234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Nov 2018 13:51:03 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43146B2066;
        Wed, 28 Nov 2018 13:51:03 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17D19B2068;
        Wed, 28 Nov 2018 13:51:02 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.134.2])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 28 Nov 2018 13:51:02 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 022A716C3125; Wed, 28 Nov 2018 05:51:02 -0800 (PST)
Date:   Wed, 28 Nov 2018 05:51:02 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, tj@kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH] block: use rcu_work instead of call_rcu to avoid sleep
 in softirq
Reply-To: paulmck@linux.ibm.com
References: <20181128084201.69211-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128084201.69211-1-yuyufen@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18112813-0064-0000-0000-0000037CAAE5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010137; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01123993; UDB=6.00583537; IPR=6.00904123;
 MB=3.00024366; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-28 13:51:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112813-0065-0000-0000-00003B7CCD0D
Message-Id: <20181128135102.GV4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811280123
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 28, 2018 at 04:42:01PM +0800, Yufen Yu wrote:
> We recently got a stack by syzkaller like this:
> 
> BUG: sleeping function called from invalid context at mm/slab.h:361
> in_atomic(): 1, irqs_disabled(): 0, pid: 6644, name: blkid
> INFO: lockdep is turned off.
> CPU: 1 PID: 6644 Comm: blkid Not tainted 4.4.163-514.55.6.9.x86_64+ #76
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
>  0000000000000000 5ba6a6b879e50c00 ffff8801f6b07b10 ffffffff81cb2194
>  0000000041b58ab3 ffffffff833c7745 ffffffff81cb2080 5ba6a6b879e50c00
>  0000000000000000 0000000000000001 0000000000000004 0000000000000000
> Call Trace:
>  <IRQ>  [<ffffffff81cb2194>] __dump_stack lib/dump_stack.c:15 [inline]
>  <IRQ>  [<ffffffff81cb2194>] dump_stack+0x114/0x1a0 lib/dump_stack.c:51
>  [<ffffffff8129a981>] ___might_sleep+0x291/0x490 kernel/sched/core.c:7675
>  [<ffffffff8129ac33>] __might_sleep+0xb3/0x270 kernel/sched/core.c:7637
>  [<ffffffff81794c13>] slab_pre_alloc_hook mm/slab.h:361 [inline]
>  [<ffffffff81794c13>] slab_alloc_node mm/slub.c:2610 [inline]
>  [<ffffffff81794c13>] slab_alloc mm/slub.c:2692 [inline]
>  [<ffffffff81794c13>] kmem_cache_alloc_trace+0x2c3/0x5c0 mm/slub.c:2709
>  [<ffffffff81cbe9a7>] kmalloc include/linux/slab.h:479 [inline]
>  [<ffffffff81cbe9a7>] kzalloc include/linux/slab.h:623 [inline]
>  [<ffffffff81cbe9a7>] kobject_uevent_env+0x2c7/0x1150 lib/kobject_uevent.c:227
>  [<ffffffff81cbf84f>] kobject_uevent+0x1f/0x30 lib/kobject_uevent.c:374
>  [<ffffffff81cbb5b9>] kobject_cleanup lib/kobject.c:633 [inline]
>  [<ffffffff81cbb5b9>] kobject_release+0x229/0x440 lib/kobject.c:675
>  [<ffffffff81cbb0a2>] kref_sub include/linux/kref.h:73 [inline]
>  [<ffffffff81cbb0a2>] kref_put include/linux/kref.h:98 [inline]
>  [<ffffffff81cbb0a2>] kobject_put+0x72/0xd0 lib/kobject.c:692
>  [<ffffffff8216f095>] put_device+0x25/0x30 drivers/base/core.c:1237
>  [<ffffffff81c4cc34>] delete_partition_rcu_cb+0x1d4/0x2f0 block/partition-generic.c:232
>  [<ffffffff813c08bc>] __rcu_reclaim kernel/rcu/rcu.h:118 [inline]
>  [<ffffffff813c08bc>] rcu_do_batch kernel/rcu/tree.c:2705 [inline]
>  [<ffffffff813c08bc>] invoke_rcu_callbacks kernel/rcu/tree.c:2973 [inline]
>  [<ffffffff813c08bc>] __rcu_process_callbacks kernel/rcu/tree.c:2940 [inline]
>  [<ffffffff813c08bc>] rcu_process_callbacks+0x59c/0x1c70 kernel/rcu/tree.c:2957
>  [<ffffffff8120f509>] __do_softirq+0x299/0xe20 kernel/softirq.c:273
>  [<ffffffff81210496>] invoke_softirq kernel/softirq.c:350 [inline]
>  [<ffffffff81210496>] irq_exit+0x216/0x2c0 kernel/softirq.c:391
>  [<ffffffff82c2cd7b>] exiting_irq arch/x86/include/asm/apic.h:652 [inline]
>  [<ffffffff82c2cd7b>] smp_apic_timer_interrupt+0x8b/0xc0 arch/x86/kernel/apic/apic.c:926
>  [<ffffffff82c2bc25>] apic_timer_interrupt+0xa5/0xb0 arch/x86/entry/entry_64.S:746
>  <EOI>  [<ffffffff814cbf40>] ? audit_kill_trees+0x180/0x180
>  [<ffffffff8187d2f7>] fd_install+0x57/0x80 fs/file.c:626
>  [<ffffffff8180989e>] do_sys_open+0x45e/0x550 fs/open.c:1043
>  [<ffffffff818099c2>] SYSC_open fs/open.c:1055 [inline]
>  [<ffffffff818099c2>] SyS_open+0x32/0x40 fs/open.c:1050
>  [<ffffffff82c299e1>] entry_SYSCALL_64_fastpath+0x1e/0x9a
> 
> In softirq context, we call rcu callback function delete_partition_rcu_cb(),
> which may allocate memory by kzalloc with GFP_KERNEL flag. If the
> allocation cannot be satisfied, it may sleep. However, That is not allowed
> in softirq contex.
> 
> Although we found this problem on linux 4.4, the latest kernel version
> seems to have this problem as well. And it is very similar to the
> previous one:
> 	https://lkml.org/lkml/2018/7/9/391
> 
> Fix it by using RCU workqueue, which allows sleep.
> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>

Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>

> ---
>  block/partition-generic.c | 8 +++++---
>  include/linux/genhd.h     | 2 +-
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/block/partition-generic.c b/block/partition-generic.c
> index d3d14e81fb12..5f8db5c5140f 100644
> --- a/block/partition-generic.c
> +++ b/block/partition-generic.c
> @@ -249,9 +249,10 @@ struct device_type part_type = {
>  	.uevent		= part_uevent,
>  };
> 
> -static void delete_partition_rcu_cb(struct rcu_head *head)
> +static void delete_partition_work_fn(struct work_struct *work)
>  {
> -	struct hd_struct *part = container_of(head, struct hd_struct, rcu_head);
> +	struct hd_struct *part = container_of(to_rcu_work(work), struct hd_struct,
> +					rcu_work);
> 
>  	part->start_sect = 0;
>  	part->nr_sects = 0;
> @@ -262,7 +263,8 @@ static void delete_partition_rcu_cb(struct rcu_head *head)
>  void __delete_partition(struct percpu_ref *ref)
>  {
>  	struct hd_struct *part = container_of(ref, struct hd_struct, ref);
> -	call_rcu(&part->rcu_head, delete_partition_rcu_cb);
> +	INIT_RCU_WORK(&part->rcu_work, delete_partition_work_fn);
> +	queue_rcu_work(system_wq, &part->rcu_work);
>  }
> 
>  /*
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 70fc838e6773..0c5ee17b4d88 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -129,7 +129,7 @@ struct hd_struct {
>  	struct disk_stats dkstats;
>  #endif
>  	struct percpu_ref ref;
> -	struct rcu_head rcu_head;
> +	struct rcu_work rcu_work;
>  };
> 
>  #define GENHD_FL_REMOVABLE			1
> -- 
> 2.16.2.dirty
> 

