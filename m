Return-Path: <SRS0=3pRW=3I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749A2C33CB1
	for <linux-block@archiver.kernel.org>; Sun, 19 Jan 2020 06:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6BD2071C
	for <linux-block@archiver.kernel.org>; Sun, 19 Jan 2020 06:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgASG1U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Jan 2020 01:27:20 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9663 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbgASG1T (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Jan 2020 01:27:19 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 08CAC7AFB64B14A4709A;
        Sun, 19 Jan 2020 14:27:17 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.66) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Sun, 19 Jan 2020
 14:27:16 +0800
Subject: Re: [PATCH] nbd: fix potential NULL pointer fault in connect and
 disconnect process
To:     Josef Bacik <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>
References: <20200117115005.37006-1-sunke32@huawei.com>
 <875eaffb-d1e1-2d7e-09c9-81bab345e707@toxicpanda.com>
From:   "sunke (E)" <sunke32@huawei.com>
Message-ID: <8bfc7d03-8944-f435-4ae6-e50b62911621@huawei.com>
Date:   Sun, 19 Jan 2020 14:27:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <875eaffb-d1e1-2d7e-09c9-81bab345e707@toxicpanda.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.66]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



在 2020/1/17 22:18, Josef Bacik 写道:
> On 1/17/20 6:50 AM, Sun Ke wrote:
>> Connect and disconnect a nbd device repeatedly, will cause
>> NULL pointer fault.
>>
>> It will appear by the steps:
>> 1. Connect the nbd device and disconnect it, but now nbd device
>>     is not disconnected totally.
>> 2. Connect the same nbd device again immediately, it will fail
>>     in nbd_start_device with a EBUSY return value.
>> 3. Wait a second to make sure the last config_refs is reduced
>>     and run nbd_config_put to disconnect the nbd device totally.
>> 4. Start another process to open the nbd_device, config_refs
>>     will increase and at the same time disconnect it.
>>
>> To fix it, add a NBD_HAS_STARTED flag. Set it in nbd_start_device_ioctl
>> and nbd_genl_connect if nbd device is started successfully.
>> Clear it in nbd_config_put. Test it in nbd_genl_disconnect and
>> nbd_genl_reconfigure.
> 
> I don't doubt what you are seeing, but what exactly are we NULL pointer 
> dereferencing?  I can't quite figure it out from the steps.
The root case is when do disconnect, pointers in structure nbd_device 
will not be free immeditily, it should wait for the last config_refs to 
be decreased.

I got this kernel NULL pointer dereference report:

[  256.454582] Dev nbd0: unable to read RDB block 0
[  256.455611] Dev nbd0: unable to read RDB block 0
[  256.457528] Dev nbd0: unable to read RDB block 0
[  256.458742] Dev nbd0: unable to read RDB block 0
[  256.516375] Dev nbd0: unable to read RDB block 0
[  257.468970] BUG: kernel NULL pointer dereference, address: 
0000000000000020
[  257.469645] #PF: supervisor write access in kernel mode
[  257.470445] #PF: error_code(0x0002) - not-present page
[  257.470888] PGD 12ecb7067 P4D 12ecb7067 PUD 12f3f2067 PMD 0
[  257.471384] Oops: 0002 [#1] SMP
[  257.471671] CPU: 1 PID: 1651 Comm: nbd-client Not tainted 
5.5.0-rc5-00039-gae6088216ce4 #22
[  257.472501] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS ?-20180531_142017-buildhw-08.phx2.fedoraproject.org-1.fc28 04/01/2014
[  257.473776] RIP: 0010:mutex_lock+0x29/0x60
[  257.474593] Code: 00 0f 1f 44 00 00 53 48 89 fb 48 83 05 cf f8 01 02 
01 e8 ea bd ff ff 48 83 05 ca f8 01 02 01 31 c0 65 48 8b 14 25 00 7d 01 
00 <f0> 48 0f b1 13 74 f
[  257.476221] RSP: 0018:ffffc900004cfa10 EFLAGS: 00010246
[  257.476670] RAX: 0000000000000000 RBX: 0000000000000020 RCX: 
0000000000000000
[  257.477289] RDX: ffff88812f524a00 RSI: ffffffff82e44212 RDI: 
0000000000000020
[  257.477999] RBP: ffffc900004cfab0 R08: ffff88813bc6c110 R09: 
0000000000000000
[  257.478617] R10: 8080808080808080 R11: 0000000000000018 R12: 
ffff88813584b000
[  257.479228] R13: ffffffff838b1f00 R14: ffffc900004cfbb8 R15: 
ffffc900004cfa40
[  257.479871] FS:  00007f0c30d75b40(0000) GS:ffff88813bc40000(0000) 
knlGS:0000000000000000
[  257.480569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  257.481336] CR2: 0000000000000020 CR3: 000000012f5ea000 CR4: 
00000000000006e0
[  257.481980] Call Trace:
[  257.482262]  flush_workqueue+0x91/0x690
[  257.482627]  ? nbd_size_update+0x180/0x180 [nbd]
[  257.483063]  nbd_disconnect_and_put+0x80/0xd0 [nbd]
[  257.483497]  nbd_genl_disconnect+0x153/0x2d0 [nbd]
[  257.483969]  genl_rcv_msg+0x2ab/0x620
[  257.484302]  ? netlink_unicast+0x3b8/0x5e0
[  257.484663]  ? __nlmsg_put+0x78/0x90
[  257.485009]  ? genl_family_rcv_msg_attrs_parse+0x1a0/0x1a0
[  257.485488]  netlink_rcv_skb+0x5a/0x1a0
[  257.485849]  genl_rcv+0x34/0x60
[  257.486129]  netlink_unicast+0x2a4/0x5e0
[  257.486468]  netlink_sendmsg+0x369/0x6b0
[  257.486854]  ? rw_copy_check_uvector+0x50/0x1d0
[  257.487257]  ____sys_sendmsg+0x1f7/0x370
[  257.487604]  ? copy_msghdr_from_user+0xff/0x1e0
[  257.488016]  ___sys_sendmsg+0x8c/0xe0
[  257.488335]  ? copy_msghdr_from_user+0xff/0x1e0
[  257.488730]  ? ___sys_recvmsg+0xa1/0xe0
[  257.489091]  ? handle_mm_fault+0x199/0x390
[  257.489454]  __sys_sendmsg+0x6b/0xe0
[  257.489766]  __x64_sys_sendmsg+0x23/0x30
[  257.490149]  do_syscall_64+0xab/0x410
[  257.490474]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  257.490942] RIP: 0033:0x7f0c3047cb87
[  257.491288] Code: 64 89 02 48 c7 c0 ff ff ff ff eb b9 0f 1f 80 00 00 
00 00 8b 05 6a 2b 2c 00 48 63 d2 48 63 ff 85 c0 75 18 b8 2e 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 8
[  257.492940] RSP: 002b:00007ffefb59db28 EFLAGS: 00000246 ORIG_RAX: 
000000000000002e
[  257.493627] RAX: ffffffffffffffda RBX: 00000000023b0120 RCX: 
00007f0c3047cb87
[  257.494497] RDX: 0000000000000000 RSI: 00007ffefb59db60 RDI: 
0000000000000003
[  257.495116] RBP: 00000000023b01f0 R08: 0000000000000014 R09: 
0000000000000002
[  257.495731] R10: 0000000000000006 R11: 0000000000000246 R12: 
00000000023b0030
[  257.496356] R13: 00007ffefb59db60 R14: 0000000000000001 R15: 
00000000ffffffff
[  257.496989] Modules linked in: nbd
[  257.497580] CR2: 0000000000000020

Thanks,

Ke

> 
>>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>>   drivers/block/nbd.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index b4607dd96185..ddd364e208ab 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -83,6 +83,7 @@ struct link_dead_args {
>>   #define NBD_DESTROY_ON_DISCONNECT    0
>>   #define NBD_DISCONNECT_REQUESTED    1
>> +#define NBD_HAS_STARTED                2
>>   struct nbd_config {
>>       u32 flags;
>> @@ -1215,6 +1216,7 @@ static void nbd_config_put(struct nbd_device *nbd)
>>           nbd->disk->queue->limits.discard_alignment = 0;
>>           blk_queue_max_discard_sectors(nbd->disk->queue, UINT_MAX);
>>           blk_queue_flag_clear(QUEUE_FLAG_DISCARD, nbd->disk->queue);
>> +        clear_bit(NBD_HAS_STARTED, &nbd->flags);
>>           mutex_unlock(&nbd->config_lock);
>>           nbd_put(nbd);
>> @@ -1290,6 +1292,8 @@ static int nbd_start_device_ioctl(struct 
>> nbd_device *nbd, struct block_device *b
>>       ret = nbd_start_device(nbd);
>>       if (ret)
>>           return ret;
>> +    else
>> +        set_bit(NBD_HAS_STARTED, &nbd->flags);
> 
> The else is superfluous here.  Thanks,
> 
> Josef
> 
> .

