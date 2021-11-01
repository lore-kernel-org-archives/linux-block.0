Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BFDC433F5
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 08:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207FF610E5
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 08:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhKAIJE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 04:09:04 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:26141 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhKAII6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 04:08:58 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HjQXs1cxxz1DHxH;
        Mon,  1 Nov 2021 16:04:13 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 1 Nov 2021 16:06:12 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 1 Nov 2021 16:06:11 +0800
Subject: Re: [PATCH 0/2] nbd: fix sanity check for first_minor
From:   "yukuai (C)" <yukuai3@huawei.com>
To:     Pavel Skripkin <paskripkin@gmail.com>, <josef@toxicpanda.com>,
        <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <luomeng12@huawei.com>, Christoph Hellwig <hch@lst.de>
References: <20211021122936.758221-1-yukuai3@huawei.com>
 <72fb140d-609b-c035-bdd6-d2b8639c116b@gmail.com>
 <17182476-e5bf-f493-9d9b-fedb2d9c8e1a@huawei.com>
 <92d9f001-f77b-8263-53a6-aab83daccef9@huawei.com>
 <9199b0a5-8286-024f-1343-ea386140c206@huawei.com>
Message-ID: <7f899408-a01c-6300-9296-b5335ab259aa@huawei.com>
Date:   Mon, 1 Nov 2021 16:06:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9199b0a5-8286-024f-1343-ea386140c206@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/10/25 21:41, yukuai (C) wrote:
> On 2021/10/21 21:37, yukuai (C) wrote:
>> On 2021/10/21 21:13, yukuai (C) wrote:
>>> On 2021/10/21 20:35, Pavel Skripkin wrote:
>>>> On 10/21/21 15:29, Yu Kuai wrote:
>>>>> Yu Kuai (2):
>>>>>    nbd: fix max value for 'first_minor'
>>>>>    nbd: fix possible overflow for 'first_minor' in nbd_dev_add()
>>>>>
>>>>>   drivers/block/nbd.c | 6 +++---
>>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>
>>>> Hi, Yu!
>>>>
>>>> Thank you for the fix, but this wrong check should be just removed, 
>>>> since root case of wrong sysfs file creation was fixed, as Christoph 
>>>> said [1]
>>
>> Hi, Christoph
>>
>> By the way, if we remove the checking, there will be two kernel warnings
>> when the problem happens. Maybe keeping the checking is better?
> 
> friendly ping ...
friendly ping ...
>>
>> [   19.860640] sysfs: cannot create duplicate filename '/dev/block/43:0'
>> [   19.861659] CPU: 1 PID: 872 Comm: modprobe Not tainted 
>> 5.15.0-rc6-next-20211020-00001-g2f1
>> [   19.863175] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
>> BIOS ?-20190727_0738364
>> [   19.865183] Call Trace:
>> [   19.866512]  <TASK>
>> [   19.866863]  ? dump_stack_lvl+0x73/0x9f
>> [   19.867941]  ? dump_stack+0x13/0x1b
>> [   19.868475]  ? sysfs_warn_dup.cold+0x27/0x45
>> [   19.869075]  ? sysfs_do_create_link_sd.isra.0+0x131/0x150
>> [   19.869818]  ? sysfs_create_link+0x29/0x60
>> [   19.870459]  ? device_add+0xbd6/0xf60
>> [   19.871032]  ? _printk+0x5f/0x7d
>> [   19.871518]  ? device_add_disk+0x153/0x5d0
>> [   19.872160]  ? nbd_dev_add+0x30e/0x470 [nbd]
>> [   19.872828]  ? 0xffffffffc0060000
>> [   19.873332]  ? nbd_init+0x1dc/0x1000 [nbd]
>> [   19.873924]  ? do_one_initcall+0x71/0x3a0
>> [   19.874534]  ? gcov_event+0x70/0x690
>> [   19.875058]  ? do_init_module+0xa6/0x350
>> [   19.875587]  ? load_module+0x2587/0x2720
>> [   19.876130]  ? kernel_read+0x31/0xb0
>> [   19.876638]  ? kernel_read_file+0x15a/0x360
>> [   19.877271]  ? __do_sys_finit_module+0xe5/0x190
>> [   19.877951]  ? __do_sys_finit_module+0xe5/0x190
>> [   19.878563]  ? __x64_sys_finit_module+0x1e/0x30
>> [   19.879182]  ? do_syscall_64+0x35/0x80
>> [   19.879700]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [   19.880413]  </TASK>
>> [   19.880806] ------------[ cut here ]------------
>> [   19.881502] WARNING: CPU: 1 PID: 872 at block/genhd.c:543 
>> device_add_disk+0x2af/0x5d0
>> [   19.882695] Modules linked in: nbd(+)
>> [   19.883290] CPU: 1 PID: 872 Comm: modprobe Not tainted 
>> 5.15.0-rc6-next-20211020-00001-g2f1
>> [   19.884823] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
>> BIOS ?-20190727_0738364
>> [   19.886866] RIP: 0010:device_add_disk+0x2af/0x5d0
>> [   19.887606] Code: 6e f2 f2 0b 01 49 8b 76 48 48 8b 3d db 03 f3 0b 
>> e8 f6 ec a9 ff 48 83 050
>> [   19.890456] RSP: 0018:ffffc90000e47c70 EFLAGS: 00010202
>> [   19.891293] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
>> 00000000000ae001
>> [   19.892274] RDX: 00000000000ac001 RSI: ffffffff91b5906b RDI: 
>> 0000000000000000
>> [   19.893318] RBP: ffff8881034ad600 R08: 0000000000000000 R09: 
>> ffffffff915e2e69
>> [   19.894425] R10: 0000000000000014 R11: 0000000000000001 R12: 
>> 00000000ffffffef
>> [   19.895544] R13: 0000000000000000 R14: ffff88817d720600 R15: 
>> ffff88817d720648
>> [   19.896652] FS:  00007fc08c7a7040(0000) GS:ffff88882f640000(0000) 
>> knlGS:0000000000000000
>> [   19.897902] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   19.898768] CR2: 00007fc08bcf0395 CR3: 000000017c467000 CR4: 
>> 00000000000006e0
>> [   19.899754] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
>> 0000000000000000
>> [   19.900856] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
>> 0000000000000400
>> [   19.901989] Call Trace:
>> [   19.902387]  <TASK>
>> [   19.902732]  nbd_dev_add+0x30e/0x470 [nbd]
>> [   19.903395]  ? 0xffffffffc0060000
>> [   19.903917]  nbd_init+0x1dc/0x1000 [nbd]
>> [   19.904536]  do_one_initcall+0x71/0x3a0
>> [   19.905166]  ? gcov_event+0x70/0x690
>> [   19.905745]  do_init_module+0xa6/0x350
>> [   19.906351]  load_module+0x2587/0x2720
>> [   19.906932]  ? kernel_read+0x31/0xb0
>> [   19.907509]  ? kernel_read_file+0x15a/0x360
>> [   19.908195]  ? __do_sys_finit_module+0xe5/0x190
>> [   19.908894]  __do_sys_finit_module+0xe5/0x190
>> [   19.909591]  __x64_sys_finit_module+0x1e/0x30
>> [   19.910289]  do_syscall_64+0x35/0x80
>> [   19.910855]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [   19.911652] RIP: 0033:0x7fc08bc7a4e9
>> [   19.912231] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 
>> 00 48 89 f8 48 89 f7 488
>> [   19.915026] RSP: 002b:00007fff0ddf6fd8 EFLAGS: 00000246 ORIG_RAX: 
>> 0000000000000139
>> [   19.916080] RAX: ffffffffffffffda RBX: 00005596400853e0 RCX: 
>> 00007fc08bc7a4e9
>> [   19.917180] RDX: 0000000000000000 RSI: 000055963fe1bc26 RDI: 
>> 0000000000000003
>> [   19.918302] RBP: 000055963fe1bc26 R08: 0000000000000000 R09: 
>> 0000000000000000
>> [   19.919412] R10: 0000000000000003 R11: 0000000000000246 R12: 
>> 0000000000000000
>> [   19.920524] R13: 00005596400854f0 R14: 0000000000040000 R15: 
>> 00005596400853e0
>> [   19.921629]  </TASK>
>> [   19.922005] ---[ end trace e09ecf130812479d ]---
>>
>> Thanks,
>> Kuai
>>>
>>> Hi, Pavel
>>>
>>> Thanks for your response, with the root cause fixed, patch 1 is not
>>> needed anymore. However, the overflow case in patch 2 is still
>>> possible.
>>>
>>> Does anyone plan to remove the checking?
>>>
>>> Thanks,
>>> Kuai
>>>>
>>>>
>>>>
>>>>
>>>> [1] https://lore.kernel.org/lkml/20211011073556.GA10735@lst.de/
>>>>
>>>>
>>>>
>>>> With regards,
>>>> Pavel Skripkin
>>>> .
>>>>
