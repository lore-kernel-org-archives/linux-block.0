Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DE8C433DF
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 04:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6070207E8
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 04:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FI3lbHe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgE0EOq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 00:14:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55252 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgE0EOp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 00:14:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04R4C2aM066218;
        Wed, 27 May 2020 04:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=JwmbuGn8jcO4XV5+XlKrFmQBXTK9+t55gEiM2IbzS64=;
 b=FI3lbHe29PVMz4YFy5b3RPGE2bZdieSbuFNpmj3p7n9EIhb3jwjBOpXdpOJk9zcUP4iP
 L9CJtNi4rQp2HIwZJlAC/xUUBtLlJCPAgw6LlMcPoWAy5J9Lh8VEvYsW3iLlsQEY6nCe
 2MqRtBJXGHiNrwVip1xP9+O89YPTgok7irwIB1BcBh04D40JlL98pXCu0SwFkBOA7ico
 HewsHFmfqeFFCaVrOKy4qy69vEi90CM2znJ5SBHZZkHWD9/BWSqOTzsRtiTW3N3FOl1W
 7NBLq5QGEjSyn/ybsy3TOoOHNzYWfWIGqAeO+mQM9obAW3t59Um+b0KeOu5DndtelPos Zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 316u8qw6yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 May 2020 04:14:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04R4DXQX042637;
        Wed, 27 May 2020 04:14:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 317j5qhg20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 May 2020 04:14:33 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04R4EVi2021359;
        Wed, 27 May 2020 04:14:31 GMT
Received: from [10.159.159.251] (/10.159.159.251)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 May 2020 21:14:31 -0700
Subject: Re: nvme double __blk_mq_complete_request() bugs
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <c77b0998-5112-4d6b-b51c-41d2b901009d@default>
 <86a0321e-d260-ef8c-db9f-b804fc92c670@grimberg.me>
 <49f32df9-81a9-4c15-9950-aceff8fb291e@oracle.com>
 <20200525164516.GC73686@C02WT3WMHTD6>
 <d5c51f9c-3706-bc22-1a67-3695880d4918@oracle.com>
Message-ID: <23a7ee2c-c9ce-f21d-3685-ebfe9e7fbaea@oracle.com>
Date:   Tue, 26 May 2020 21:14:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d5c51f9c-3706-bc22-1a67-3695880d4918@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 suspectscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270029
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/26/20 6:04 PM, Dongli Zhang wrote:
> Hi Keith,
> 
> On 5/25/20 9:45 AM, Keith Busch wrote:
>> On Sun, May 24, 2020 at 07:33:02AM -0700, Dongli Zhang wrote:
>>>>> After code analysis, I think this is for nvme-pci as well.
>>>>>
>>>>>                                         nvme_process_cq()
>>>>>                                         -> nvme_handle_cqe()
>>>>>                                            -> nvme_end_request()
>>>>>                                               -> blk_mq_complete_request()
>>>>> nvme_reset_work()
>>>>> -> nvme_dev_disable()
>>>>>     -> nvme_reap_pending_cqes()
>>>>>        -> nvme_process_cq()
>>>>>           -> nvme_handle_cqe()
>>>>>              -> nvme_end_request()
>>>>>                 -> blk_mq_complete_request()
>>>>>                    -> __blk_mq_complete_request()
>>>>>                                                  -> __blk_mq_complete_request()
>>>>
>>>> nvme_dev_disable will first disable the queues before reaping the pending cqes so
>>>> it shouldn't have this issue.
>>>>
>>>
>>> Would you mind help explain how nvme_dev_disable() would avoid this issue?
>>>
>>> nvme_dev_disable() would:
>>>
>>> 1. freeze all the queues so that new request would not enter and submit
>>> 2. NOT wait for freezing during live reset so that q->q_usage_counter is not
>>> guaranteed to be zero.
>>> 3. quiesce all the queues so that new request would not dispatch
>>> 4. delete the queue and free irq
>>>
>>> However, I do not find a mechanism to prevent if a nvme_end_request() is already
>>> in progress.
>>>
>>> E.g., suppose __blk_mq_complete_request() is already triggered on cpu 3 and
>>> waiting for its first line "WRITE_ONCE(rq->state, MQ_RQ_COMPLETE)" to be
>>> executed ... while another cpu is doing live reset. I do not see how to prevent
>>> such race.
>>
>> The queues and their interrupts are torn and synchronized down before the reset
>> reclaims uncompleted requests. There's no other context that can be running
>> completions at that point.
> 
> Thank you very much for the clarification.
> 
> There are 3 cases for a nvme request to complete.
> 
> 1. In the context of irq.
> 
> While I did not test with source code, I think it is because
> nvme_suspend_queue()-->pci_free_irq() which would wait for all infligh IRQ
> handler with __synchronize_hardirq().
> 
> 2. In the context of irq thread when threaded irq is involved.
> 
> The nvme_suspend_queue()-->pci_free_irq() would finally wait for the stop of irq
> thread by kthread_stop(action->thread). Therefore, there is not any IRQ handler
> running in kernel thread.
> 
> 3. In the context of blk_poll().
> 
> I do not find a mechanism to protect the race in this case.
> 
> By adding mdelay() to code, I am able to reproduce the below race on purpose.
> 
> 
> [  235.223975] ==================================================================
> [  235.224878] BUG: KASAN: null-ptr-deref in blk_mq_free_request+0x363/0x510
> [  235.225674] Write of size 4 at addr 0000000000000198 by task swapper/3/0
> [  235.226456]
> [  235.226772] ==================================================================
> [  235.227633] BUG: kernel NULL pointer dereference, address: 0000000000000198
> [  235.228447] #PF: supervisor write access in kernel mode
> [  235.229062] #PF: error_code(0x0002) - not-present page
> [  235.229667] PGD 0 P4D 0
> [  235.229976] Oops: 0002 [#1] SMP KASAN PTI
> [  235.230451] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G    B
> 5.7.0-rc5+ #1
> [  235.231347] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> [  235.232692] RIP: 0010:blk_mq_free_request+0x367/0x510
> [  235.233286] Code: 89 df 5b 5d 41 5c 41 5d 41 5e 41 5f e9 a2 dc ff ff 48 8d ba
> 98 01 00 00 be 04 00 00 00 48 89 14 24 e8 fd 69 9a ff 48 8b 14 24 <f0> ff 8a 98
> 01 00 00 e9 e2 fe ff ff 48 83 c4 08 48 89 ef be 03 00
> [  235.235503] RSP: 0018:ffff8881f7389be0 EFLAGS: 00010046
> [  235.236114] RAX: 0000000000000000 RBX: ffff8881f21b9680 RCX: ffffffff816e05b1
> [  235.236941] RDX: 0000000000000000 RSI: 0000000000000046 RDI: 0000000000000046
> [  235.237770] RBP: 0000000000000001 R08: fffffbfff0af5869 R09: fffffbfff0af5869
> [  235.238598] R10: ffffffff857ac347 R11: fffffbfff0af5868 R12: ffff8881f21b969c
> [  235.239424] R13: ffff8881f0f62738 R14: ffffe8ffffd884c0 R15: ffff8881f21b9698
> [  235.240255] FS:  0000000000000000(0000) GS:ffff8881f7380000(0000)
> knlGS:0000000000000000
> [  235.241192] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  235.241863] CR2: 0000000000000198 CR3: 00000001eb886004 CR4: 0000000000360ee0
> [  235.242695] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  235.243523] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  235.244349] Call Trace:
> [  235.244645]  <IRQ>
> [  235.244890]  blk_mq_complete_request+0x266/0x460
> [  235.245432]  nvmet_req_complete+0xd/0xb0
> [  235.245898]  iomap_dio_bio_end_io+0x336/0x480
> [  235.246409]  blk_update_request+0x320/0x960
> [  235.246904]  blk_mq_end_request+0x4e/0x4d0
> [  235.247391]  blk_mq_complete_request+0x266/0x460
> [  235.247937]  virtblk_done+0x164/0x300
> [  235.248372]  ? loop_queue_work.cold.44+0x5e/0x5e
> [  235.248915]  ? rcu_accelerate_cbs+0x5d/0x1a70
> [  235.249429]  ? virtqueue_get_used_addr+0x140/0x140
> [  235.249990]  vring_interrupt+0x16d/0x280
> [  235.250454]  __handle_irq_event_percpu+0xdd/0x470
> [  235.251010]  handle_irq_event_percpu+0x6e/0x130
> [  235.251544]  ? rcu_accelerate_cbs_unlocked+0x110/0x110
> [  235.252145]  ? __handle_irq_event_percpu+0x470/0x470
> [  235.252729]  ? _raw_spin_lock+0x75/0xd0
> [  235.253181]  ? _raw_write_lock+0xd0/0xd0
> [  235.253645]  handle_irq_event+0xc2/0x158
> [  235.254107]  handle_edge_irq+0x1e9/0x7a0
> [  235.254572]  do_IRQ+0x94/0x1e0
> [  235.254936]  common_interrupt+0xf/0xf
> [  235.255368]  </IRQ>
> [  235.255629] RIP: 0010:native_safe_halt+0xe/0x10
> [  235.256162] Code: e9 f2 fe ff ff 48 89 df e8 2f dc f8 fd eb a4 cc cc cc cc cc
> cc cc cc cc cc cc cc cc e9 07 00 00 00 0f 00 2d a4 7d 4a 00 fb f4 <c3> 90 e9 07
> 00 00 00 0f 00 2d 94 7d 4a 00 f4 c3 cc cc 41 56 41 55
> [  235.258314] RSP: 0018:ffff8881f61ffdd8 EFLAGS: 00000246 ORIG_RAX:
> ffffffffffffffde
> [  235.259194] RAX: ffffffff83bc59f0 RBX: dffffc0000000000 RCX: ffffffff83bc6639
> [  235.260022] RDX: 1ffff1103ec398e8 RSI: 0000000000000008 RDI: ffff8881f61cc740
> [  235.260850] RBP: 0000000000000003 R08: ffffed103ec398e9 R09: ffffed103ec398e9
> [  235.261681] R10: ffff8881f61cc747 R11: ffffed103ec398e8 R12: ffffffff84e5c4c0
> [  235.262508] R13: 0000000000000003 R14: 1ffff1103ec3ffc4 R15: 0000000000000000
> [  235.263338]  ? __cpuidle_text_start+0x8/0x8
> [  235.263832]  ? default_idle_call+0x29/0x60
> [  235.264315]  ? tsc_verify_tsc_adjust+0x68/0x1f0
> [  235.264849]  default_idle+0x1a/0x2b0
> [  235.265273]  do_idle+0x2fd/0x3b0
> [  235.265658]  ? arch_cpu_idle_exit+0x40/0x40
> [  235.266151]  ? schedule_idle+0x56/0x90
> [  235.266595]  cpu_startup_entry+0x14/0x20
> [  235.267057]  start_secondary+0x2a6/0x340
> [  235.267522]  ? set_cpu_sibling_map+0x1fb0/0x1fb0
> [  235.268066]  secondary_startup_64+0xb6/0xc0
> [  235.268561] Modules linked in:
> [  235.268929] CR2: 0000000000000198
> [  235.269330] ---[ end trace f8fa823705a3dbe7 ]---
> [  235.269875] RIP: 0010:blk_mq_free_request+0x367/0x510
> [  235.270466] Code: 89 df 5b 5d 41 5c 41 5d 41 5e 41 5f e9 a2 dc ff ff 48 8d ba
> 98 01 00 00 be 04 00 00 00 48 89 14 24 e8 fd 69 9a ff 48 8b 14 24 <f0> ff 8a 98
> 01 00 00 e9 e2 fe ff ff 48 83 c4 08 48 89 ef be 03 00
> [  235.272622] RSP: 0018:ffff8881f7389be0 EFLAGS: 00010046
> [  235.273230] RAX: 0000000000000000 RBX: ffff8881f21b9680 RCX: ffffffff816e05b1
> [  235.274063] RDX: 0000000000000000 RSI: 0000000000000046 RDI: 0000000000000046
> [  235.274890] RBP: 0000000000000001 R08: fffffbfff0af5869 R09: fffffbfff0af5869
> [  235.275717] R10: ffffffff857ac347 R11: fffffbfff0af5868 R12: ffff8881f21b969c
> [  235.276545] R13: ffff8881f0f62738 R14: ffffe8ffffd884c0 R15: ffff8881f21b9698
> [  235.277371] FS:  0000000000000000(0000) GS:ffff8881f7380000(0000)
> knlGS:0000000000000000
> [  235.278307] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  235.278977] CR2: 0000000000000198 CR3: 00000001eb886004 CR4: 0000000000360ee0
> [  235.279805] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  235.280632] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  235.281459] Kernel panic - not syncing: Fatal exception in interrupt
> [  235.282474] Kernel Offset: 0x400000 from 0xffffffff81000000 (relocation
> range: 0xffffffff80000000-0xffffffffbfffffff)
> [  235.283695] ---[ end Kernel panic - not syncing: Fatal exception in interrupt
> ]---


I copied the wrong callstack for another issue.

Here is the callstack I reproduced for "nvme-pci: avoid race between
nvme_reap_pending_cqes() and nvme_poll()".

[  432.997264] ------------[ cut here ]------------
[  432.997265] refcount_t: underflow; use-after-free.
[  432.997303] WARNING: CPU: 2 PID: 836 at lib/refcount.c:28
refcount_warn_saturate+0xb0/0x150
[  432.997304] Modules linked in:
[  432.997313] CPU: 2 PID: 836 Comm: fio Not tainted 5.7.0-rc7+ #22
[  432.997315] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[  432.997320] RIP: 0010:refcount_warn_saturate+0xb0/0x150
[  432.997323] Code: 4b 84 d9 02 01 e8 ae 8f 4d ff 0f 0b eb d0 80 3d 39 84 d9 02
00 75 c7 48 c7 c7 60 9f 75 b3 c6 05 29 84 d9 02 01 e8 8e 8f 4d ff <0f> 0b eb b0
80 3d 17 84 d9 02 00 75 a7 48 c7 c7 20 a0 75 b3 c6 05
[  432.997324] RSP: 0018:ffff8881e18173c8 EFLAGS: 00010282
[  432.997326] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
[  432.997327] RDX: 0000000000000002 RSI: 0000000000000007 RDI: ffffffffb4d70de0
[  432.997328] RBP: ffff8881f08a63d0 R08: ffffed103ee64501 R09: ffffed103ee64501
[  432.997330] R10: ffff8881f7322803 R11: ffffed103ee64500 R12: ffffe8ffffc00500
[  432.997331] R13: 0000000000000000 R14: ffff8881f08a6300 R15: ffff8881f589d3c0
[  432.997333] FS:  00007f2257ba8ec0(0000) GS:ffff8881f7300000(0000)
knlGS:0000000000000000
[  432.997334] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  432.997335] CR2: 00007ffb53b82010 CR3: 00000001f38d6001 CR4: 0000000000360ee0
[  432.997338] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  432.997339] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  432.997340] Call Trace:
[  432.997349]  blk_mq_complete_request+0x135/0x490
[  432.997353]  nvme_poll+0x49a/0xa80
[  432.997356]  blk_poll+0x5b0/0xb90
[  432.997359]  ? blk_mq_alloc_request_hctx+0x310/0x310
[  432.997361]  ? submit_bio+0x97/0x370
[  432.997362]  ? generic_make_request+0x8e0/0x8e0
[  432.997371]  ? unlock_page+0x3a/0x60
[  432.997374]  ? bio_release_pages.part.45+0x165/0x2d0
[  432.997377]  ? memset+0x1f/0x40
[  432.997380]  __blkdev_direct_IO_simple+0x515/0x7d0
[  432.997384]  ? blkdev_write_iter+0x3f0/0x3f0
[  432.997388]  ? __sched_text_start+0x8/0x8
[  432.997390]  ? __switch_to_asm+0x40/0x70
[  432.997392]  ? __switch_to_asm+0x34/0x70
[  432.997393]  ? __switch_to_asm+0x40/0x70
[  432.997395]  ? apic_timer_interrupt+0xa/0x20
[  432.997399]  ? blkdev_iopoll+0x160/0x160
[  432.997401]  ? filemap_check_errors+0x4b/0xd0
[  432.997403]  blkdev_direct_IO+0xdaf/0x1160
[  432.997404]  ? __schedule+0x815/0x16a0
[  432.997406]  ? __sched_text_start+0x8/0x8
[  432.997410]  ? deref_stack_reg+0xab/0xe0
[  432.997411]  ? blkdev_write_end+0x70/0x70
[  432.997413]  ? apic_timer_interrupt+0xa/0x20
[  432.997414]  ? apic_timer_interrupt+0xa/0x20
[  432.997417]  ? bio_release_pages.part.45+0x165/0x2d0
[  432.997420]  generic_file_read_iter+0x251/0x1b70
[  432.997424]  ? _raw_spin_unlock_irq+0x3b/0x60
[  432.997426]  ? __switch_to_asm+0x34/0x70
[  432.997428]  ? __schedule+0x815/0x16a0
[  432.997429]  ? __switch_to_asm+0x34/0x70
[  432.997431]  ? __sched_text_start+0x8/0x8
[  432.997433]  ? pagecache_get_page+0x520/0x520
[  432.997434]  ? apic_timer_interrupt+0xa/0x20
[  432.997436]  ? apic_timer_interrupt+0xa/0x20
[  432.997437]  ? apic_timer_interrupt+0xa/0x20
[  432.997440]  do_iter_readv_writev+0x485/0x6e0
[  432.997442]  ? no_seek_end_llseek_size+0x20/0x20
[  432.997445]  ? security_file_permission+0x19a/0x390
[  432.997447]  do_iter_read+0x1e5/0x590
[  432.997450]  vfs_readv+0xc7/0x130
[  432.997451]  ? __switch_to_asm+0x34/0x70
[  432.997453]  ? compat_rw_copy_check_uvector+0x300/0x300
[  432.997455]  ? __switch_to_asm+0x40/0x70
[  432.997456]  ? __switch_to_asm+0x40/0x70
[  432.997458]  ? __switch_to_asm+0x34/0x70
[  432.997459]  ? __switch_to_asm+0x40/0x70
[  432.997461]  ? __switch_to_asm+0x34/0x70
[  432.997462]  ? __switch_to_asm+0x40/0x70
[  432.997464]  ? _raw_spin_unlock_irq+0x3b/0x60
[  432.997466]  ? apic_timer_interrupt+0xa/0x20
[  432.997467]  ? apic_timer_interrupt+0xa/0x20
[  432.997470]  do_preadv+0x14c/0x1f0
[  432.997472]  ? __ia32_sys_readv+0xa0/0xa0
[  432.997475]  do_syscall_64+0x91/0x330
[  432.997477]  ? prepare_exit_to_usermode+0xfc/0x1d0
[  432.997479]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  432.997486] RIP: 0033:0x7f2255a55950
[  432.997488] Code: 66 2e 0f 1f 84 00 00 00 00 00 e8 ab 9d 01 00 41 89 d9 41 89
c7 45 31 c0 4d 89 f2 44 89 ea 4c 89 e6 89 ef b8 47 01 00 00 0f 05 <48> 3d 00 f0
ff ff 77 32 44 89 ff 48 89 44 24 08 e8 db 9d 01 00 48
[  432.997489] RSP: 002b:00007ffd0051ce10 EFLAGS: 00000246 ORIG_RAX:
0000000000000147
[  432.997491] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f2255a55950
[  432.997492] RDX: 0000000000000001 RSI: 000055e73f7f78b0 RDI: 0000000000000003
[  432.997493] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000001
[  432.997494] R10: 0000000043ac2000 R11: 0000000000000246 R12: 000055e73f7f78b0
[  432.997494] R13: 0000000000000001 R14: 0000000043ac2000 R15: 0000000000000000
[  432.997497] ---[ end trace 276357d6d1512fac ]---

Dongli Zhang


> 
> 
> 
> I have sent the below for feedback.
> 
> https://lore.kernel.org/linux-nvme/20200527004955.19463-1-dongli.zhang@oracle.com/T/#u
> 
> Thank you very much!
> 
> Dongli Zhang
> 
