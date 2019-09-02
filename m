Return-Path: <SRS0=3Les=W5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5096C3A59E
	for <linux-block@archiver.kernel.org>; Mon,  2 Sep 2019 21:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A871B21881
	for <linux-block@archiver.kernel.org>; Mon,  2 Sep 2019 21:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfIBVaY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Sep 2019 17:30:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfIBVaY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Sep 2019 17:30:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 437234E927;
        Mon,  2 Sep 2019 21:30:23 +0000 (UTC)
Received: from [10.10.120.198] (ovpn-120-198.rdu2.redhat.com [10.10.120.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EFA860BF3;
        Mon,  2 Sep 2019 21:30:21 +0000 (UTC)
Subject: Re: [PATCH 2/2 v3] nbd: fix possible page fault for nbd disk
To:     Xiubo Li <xiubli@redhat.com>, josef@toxicpanda.com, axboe@kernel.dk
References: <20190822075923.11996-1-xiubli@redhat.com>
 <20190822075923.11996-3-xiubli@redhat.com> <5D686498.5090602@redhat.com>
 <78d16d10-1d06-6ce1-7c51-64c42e51f549@redhat.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5D6D89ED.6020700@redhat.com>
Date:   Mon, 2 Sep 2019 16:30:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <78d16d10-1d06-6ce1-7c51-64c42e51f549@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 02 Sep 2019 21:30:23 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/29/2019 07:58 PM, Xiubo Li wrote:
> On 2019/8/30 7:49, Mike Christie wrote:
>> On 08/22/2019 02:59 AM, xiubli@redhat.com wrote:
>>> From: Xiubo Li <xiubli@redhat.com>
>>>
>>> When the NBD_CFLAG_DESTROY_ON_DISCONNECT flag is set and at the same
>>> time when the socket is closed due to the server daemon is restarted,
>>> just before the last DISCONNET is totally done if we start a new
>>> connection
>>> by using the old nbd_index, there will be crashing randomly, like:
>>>
>>> <3>[  110.151949] block nbd1: Receive control failed (result -32)
>>> <1>[  110.152024] BUG: unable to handle page fault for address:
>>> 0000058000000840
>>> <1>[  110.152063] #PF: supervisor read access in kernel mode
>>> <1>[  110.152083] #PF: error_code(0x0000) - not-present page
>>> <6>[  110.152094] PGD 0 P4D 0
>>> <4>[  110.152106] Oops: 0000 [#1] SMP PTI
>>> <4>[  110.152120] CPU: 0 PID: 6698 Comm: kworker/u5:1 Kdump: loaded
>>> Not tainted 5.3.0-rc4+ #2
>>> <4>[  110.152136] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
>>> <4>[  110.152166] Workqueue: knbd-recv recv_work [nbd]
>>> <4>[  110.152187] RIP: 0010:__dev_printk+0xd/0x67
>>> <4>[  110.152206] Code: 10 e8 c5 fd ff ff 48 8b 4c 24 18 65 48 33 0c
>>> 25 28 00 [...]
>>> <4>[  110.152244] RSP: 0018:ffffa41581f13d18 EFLAGS: 00010206
>>> <4>[  110.152256] RAX: ffffa41581f13d30 RBX: ffff96dd7374e900 RCX:
>>> 0000000000000000
>>> <4>[  110.152271] RDX: ffffa41581f13d20 RSI: 00000580000007f0 RDI:
>>> ffffffff970ec24f
>>> <4>[  110.152285] RBP: ffffa41581f13d80 R08: ffff96dd7fc17908 R09:
>>> 0000000000002e56
>>> <4>[  110.152299] R10: ffffffff970ec24f R11: 0000000000000003 R12:
>>> ffff96dd7374e900
>>> <4>[  110.152313] R13: 0000000000000000 R14: ffff96dd7374e9d8 R15:
>>> ffff96dd6e3b02c8
>>> <4>[  110.152329] FS:  0000000000000000(0000)
>>> GS:ffff96dd7fc00000(0000) knlGS:0000000000000000
>>> <4>[  110.152362] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> <4>[  110.152383] CR2: 0000058000000840 CR3: 0000000067cc6002 CR4:
>>> 00000000001606f0
>>> <4>[  110.152401] Call Trace:
>>> <4>[  110.152422]  _dev_err+0x6c/0x83
>>> <4>[  110.152435]  nbd_read_stat.cold+0xda/0x578 [nbd]
>>> <4>[  110.152448]  ? __switch_to_asm+0x34/0x70
>>> <4>[  110.152468]  ? __switch_to_asm+0x40/0x70
>>> <4>[  110.152478]  ? __switch_to_asm+0x34/0x70
>>> <4>[  110.152491]  ? __switch_to_asm+0x40/0x70
>>> <4>[  110.152501]  ? __switch_to_asm+0x34/0x70
>>> <4>[  110.152511]  ? __switch_to_asm+0x40/0x70
>>> <4>[  110.152522]  ? __switch_to_asm+0x34/0x70
>>> <4>[  110.152533]  recv_work+0x35/0x9e [nbd]
>>> <4>[  110.152547]  process_one_work+0x19d/0x340
>>> <4>[  110.152558]  worker_thread+0x50/0x3b0
>>> <4>[  110.152568]  kthread+0xfb/0x130
>>> <4>[  110.152577]  ? process_one_work+0x340/0x340
>>> <4>[  110.152609]  ? kthread_park+0x80/0x80
>>> <4>[  110.152637]  ret_from_fork+0x35/0x40
>>>
>>> This is very easy to reproduce by running the nbd-runner.
>>>
>>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>>> ---
>>>   drivers/block/nbd.c | 36 +++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 35 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>>> index 8c2f17b99224..a25b59725c6e 100644
>>> --- a/drivers/block/nbd.c
>>> +++ b/drivers/block/nbd.c
>>> @@ -26,6 +26,7 @@
>>>   #include <linux/ioctl.h>
>>>   #include <linux/mutex.h>
>>>   #include <linux/compiler.h>
>>> +#include <linux/completion.h>
>>>   #include <linux/err.h>
>>>   #include <linux/kernel.h>
>>>   #include <linux/slab.h>
>>> @@ -80,6 +81,9 @@ struct link_dead_args {
>>>   #define NBD_RT_DESTROY_ON_DISCONNECT    6
>>>   #define NBD_RT_DISCONNECT_ON_CLOSE    7
>>>   +#define NBD_DESTROY_ON_DISCONNECT    0
>>> +#define NBD_DISCONNECT_REQUESTED    1
>>> +
>>>   struct nbd_config {
>>>       u32 flags;
>>>       unsigned long runtime_flags;
>>> @@ -112,6 +116,9 @@ struct nbd_device {
>>>       struct list_head list;
>>>       struct task_struct *task_recv;
>>>       struct task_struct *task_setup;
>>> +
>>> +    struct completion destroy_complete;
>>> +    unsigned long flags;
>>>   };
>>>     #define NBD_CMD_REQUEUED    1
>>> @@ -222,6 +229,16 @@ static void nbd_dev_remove(struct nbd_device *nbd)
>>>           disk->private_data = NULL;
>>>           put_disk(disk);
>>>       }
>>> +
>>> +    /*
>>> +     * Place this in the last just before the nbd is freed to
>>> +     * make sure that the disk and the related kobject are also
>>> +     * totally removed to avoid duplicate creation of the same
>>> +     * one.
>>> +     */
>>> +    if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags))
>>> +        complete(&nbd->destroy_complete);
>>> +
>>>       kfree(nbd);
>>>   }
>>>   @@ -230,8 +247,8 @@ static void nbd_put(struct nbd_device *nbd)
>>>       if (refcount_dec_and_mutex_lock(&nbd->refs,
>>>                       &nbd_index_mutex)) {
>>>           idr_remove(&nbd_index_idr, nbd->index);
>>> -        mutex_unlock(&nbd_index_mutex);
>>>           nbd_dev_remove(nbd);
>>> +        mutex_unlock(&nbd_index_mutex);
>>>       }
>>>   }
>>>   @@ -1103,6 +1120,7 @@ static int nbd_disconnect(struct nbd_device
>>> *nbd)
>>>         dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
>>>       set_bit(NBD_RT_DISCONNECT_REQUESTED, &config->runtime_flags);
>>> +    set_bit(NBD_DISCONNECT_REQUESTED, &nbd->flags);
>>>       send_disconnects(nbd);
>>>       return 0;
>>>   }
>>> @@ -1596,6 +1614,7 @@ static int nbd_dev_add(int index)
>>>       nbd->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
>>>           BLK_MQ_F_BLOCKING;
>>>       nbd->tag_set.driver_data = nbd;
>>> +    init_completion(&nbd->destroy_complete);
>>>         err = blk_mq_alloc_tag_set(&nbd->tag_set);
>>>       if (err)
>>> @@ -1761,6 +1780,16 @@ static int nbd_genl_connect(struct sk_buff
>>> *skb, struct genl_info *info)
>>>           mutex_unlock(&nbd_index_mutex);
>>>           return -EINVAL;
>>>       }
>>> +
>>> +    if (test_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags) &&
>> Why does this have to be set? If this is not set would you end up
>> hitting the config_refs check:
>>
>> if (refcount_read(&nbd->config_refs)) {
>>
>> and possibly returning failure?
> 
> Yeah, this is a good question. Before I have also tried to fix it with
> this, but it still won't work for me.
> 
> From my test cases almost more than 50% times, the crash will be hit in
> the gap just after the nbd->config already been released, and before the
> nbd itself not yet, so the nbd->config_refs will be 0.
> 
> 
>>
>> If you moved the complete() to nbd_config_put would it work if this bit
>> was set or not?
> 
> Tried it already, it still won't work.
> 
> There is one case that when disconnecting the nbd device, the userspace
> service will do the open()/release()  things, please see [1], and the
> sequence is not the same every time, if the
> NBD_CFLAG_DESTROY_ON_DISCONNECT bit is set the crash still exists.
> 
> So sometimes when the nbd_put() called from the nbd_config_put(), the
> &nbd->refs in nbd_put won't be 0, it could be 1. And it will be 0 just
> after the release() is triggered later.
> 
> So I just place the complete() before "free(nbd);", or there will be
> another Call trace will be seen very often:

Did this happen because you race with

nbd_put->nbd_dev_remove->del_gendisk->device_del->sysfs_remove_dir

? If so, does that still happen after you moved

mutex_unlock(&nbd_index_mutex);

in nbd_put? It seems before that part of your patch was added we could
hit this race and got the duplicate sysfs entry trace below:

1. nbd_put -> idr_remove.
2. nbd_put drops mutex.
3. nbd_genl_connect takes mutex (index != -1 for this call).
4. nbd_genl_connect-> idr_find fails due to remove in #1.
5. nbd_genl_connect->nbd_dev_add is then able to try to add the device
to sysfs before the nbd_put->nbd_dev_remove path has deleted the device.


When you now do the idr and sysfs removal and idr addition/search and
sysfs addition all under the nbd_index_mutex it shouldn't happen anymore.




> 
>    2489 Aug 20 18:10:04 lxbfd2 kernel: sysfs: cannot create duplicate
> filename '/devices/virtual/block/nbd0'
>    2490 Aug 20 18:10:04 lxbfd2 kernel: CPU: 0 PID: 8635 Comm: nbd-clid
> Kdump: loaded Tainted: G      D 5.1.18-300.fc30.x86_64 #1
>    2491 Aug 20 18:10:04 lxbfd2 kernel: Hardware name: Red Hat KVM, BIOS
> 0.5.1 01/01/2011
>    2492 Aug 20 18:10:04 lxbfd2 kernel: Call Trace:
>    2493 Aug 20 18:10:04 lxbfd2 kernel: dump_stack+0x5c/0x80
>    2494 Aug 20 18:10:04 lxbfd2 kernel: sysfs_warn_dup.cold+0x17/0x2d
>    2495 Aug 20 18:10:04 lxbfd2 kernel: sysfs_create_dir_ns+0xb6/0xd0
>    2496 Aug 20 18:10:04 lxbfd2 kernel: kobject_add_internal+0xb7/0x280
>    2497 Aug 20 18:10:04 lxbfd2 kernel: kobject_add+0x7e/0xb0
>    2498 Aug 20 18:10:04 lxbfd2 kernel: ? _cond_resched+0x15/0x30
>    2499 Aug 20 18:10:04 lxbfd2 kernel: device_add+0x12b/0x690
>    2500 Aug 20 18:10:04 lxbfd2 kernel: __device_add_disk+0x1b5/0x470
>    2501 Aug 20 18:10:04 lxbfd2 kernel: nbd_dev_add+0x21d/0x2b0 [nbd]
>    2502 Aug 20 18:10:04 lxbfd2 kernel: nbd_genl_connect+0x16e/0x630 [nbd]
>    2503 Aug 20 18:10:04 lxbfd2 kernel: genl_family_rcv_msg+0x1a9/0x3b0
>    2504 Aug 20 18:10:04 lxbfd2 kernel: ? __switch_to_asm+0x35/0x70
>    2505 Aug 20 18:10:04 lxbfd2 kernel: ? __switch_to_asm+0x41/0x70
>    2506 Aug 20 18:10:04 lxbfd2 kernel: ? __switch_to+0x11f/0x4c0
>    2507 Aug 20 18:10:04 lxbfd2 kernel: ? __switch_to_asm+0x41/0x70
>    [...]
> 
