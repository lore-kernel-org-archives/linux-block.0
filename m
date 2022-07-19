Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92D1C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Jul 2022 06:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiGSGry (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jul 2022 02:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiGSGrx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jul 2022 02:47:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C5A2611E
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 23:47:52 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ln8V15fsNzkXPg;
        Tue, 19 Jul 2022 14:45:29 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 14:47:50 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 14:47:49 +0800
Subject: Re: [PATCH blktests v2] nbd: add a module load and device connect
 test
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
References: <20220707035610.3175550-1-sunke32@huawei.com>
 <20220707124945.c2rd677hjwkd7mim@shindev>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <06a95726-8811-eca2-2039-e0686d87fb87@huawei.com>
Date:   Tue, 19 Jul 2022 14:47:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220707124945.c2rd677hjwkd7mim@shindev>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



在 2022/7/7 20:49, Shinichiro Kawasaki 写道:
> On Jul 07, 2022 / 11:56, Sun Ke wrote:
>> This is a regression test for commit 06c4da89c24e
>> nbd: call genl_unregister_family() first in nbd_cleanup()
> 
> Hello Sun, thanks for the patch.
> 
> I reverted the commit 06c4da89c24e from the kernel v5.19-rc5 and observed this
> test case passes. I checked dmesg and saw kernel message below. Kernel did not
> report the BUG which was noted in the commit 06c4da89c24e. Instead, nbd driver
> printed out an error "couldn't allocate config".
> 
> Jul 07 20:47:01 redsun45q unknown: run blktests nbd/004 at 2022-07-07 20:47:01
> Jul 07 20:47:01 redsun45q kernel: couldn't allocate config
> Jul 07 20:47:01 redsun45q kernel: couldn't allocate config
> Jul 07 20:47:01 redsun45q kernel: couldn't allocate config
> Jul 07 20:47:01 redsun45q kernel: sysfs: cannot create duplicate filename '/devices/virtual/block/nbd0'
> Jul 07 20:47:01 redsun45q kernel: CPU: 0 PID: 1043 Comm: modprobe Not tainted 5.19.0-rc5+ #2
> Jul 07 20:47:01 redsun45q kernel: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> Jul 07 20:47:01 redsun45q kernel: Call Trace:
> Jul 07 20:47:01 redsun45q kernel:  <TASK>
> Jul 07 20:47:01 redsun45q kernel:  dump_stack_lvl+0x5b/0x74
> Jul 07 20:47:01 redsun45q kernel:  sysfs_warn_dup.cold+0x17/0x23
> ...
> 
> or sysfs printed out an warning:
> 
> [  366.098479] run blktests nbd/004 at 2022-07-07 21:17:22
> [  366.747180] sysfs: cannot create duplicate filename '/devices/virtual/block/nbd0'
> [  366.749653] CPU: 0 PID: 1508 Comm: modprobe Not tainted 5.19.0-rc5+ #2
> [  366.751680] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebui
> lt.qemu.org 04/01/2014
> [  366.755169] Call Trace:
> [  366.755991]  <TASK>
> [  366.756722]  dump_stack_lvl+0x5b/0x74
> [  366.757909]  sysfs_warn_dup.cold+0x17/0x23
> ...
> 
I retry it on commit 98d40e76652e, it can reproduce the Bug.

localhost login: [   45.522685] run blktests nbd/004 at 2022-07-19 14:55:21
[   45.622340] debugfs: Directory 'nbd0' with parent 'block' already 
present!
[   45.643911] BUG: kernel NULL pointer dereference, address: 
0000000000000098
[   45.645771] #PF: supervisor write access in kernel mode
[   45.647176] #PF: error_code(0x0002) - not-present page
[   45.648501] PGD 178ebf067 P4D 178ebf067 PUD 17486a067 PMD 0
[   45.649830] Oops: 0002 [#1] PREEMPT SMP
[   45.650732] CPU: 0 PID: 1620 Comm: nbd-client Not tainted 
5.18.0-rc3-00087-g98d40e76652e #4
[   45.652677] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 
04/01/2014
[   45.655724] RIP: 0010:down_write+0x2d/0x90
[   45.656709] Code: 00 00 55 48 89 fd 48 83 05 1f 3e 19 09 01 e8 fa ad 
ff ff 48 83 05 1a 3e 19 09 01 31 c0 ba 01 00 00 00 48 83 05 d3 3c 19 09 
01 <f0> 48 00
[   45.660640] RSP: 0018:ffffc90000663998 EFLAGS: 00010202
[   45.661327] RAX: 0000000000000000 RBX: ffff8881029d03c0 RCX: 
0000000000000000
[   45.662252] RDX: 0000000000000001 RSI: ffffffffbfa44a80 RDI: 
0000000000000098
[   45.663172] RBP: 0000000000000098 R08: 0000000000000000 R09: 
0000000000000228
[   45.664090] R10: 0000000000000150 R11: ffff88817f6da850 R12: 
0000000000000000
[   45.665004] R13: ffff88817f6db00c R14: 0000000000000000 R15: 
ffff88817f6daa00
[   45.665926] FS:  00007f74958f7b40(0000) GS:ffff888237c00000(0000) 
knlGS:0000000000000000
[   45.666962] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   45.667707] CR2: 0000000000000098 CR3: 0000000174850000 CR4: 
00000000000006f0
[   45.668629] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   45.669548] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   45.670469] Call Trace:
[   45.670810]  <TASK>
[   45.671098]  start_creating+0xa2/0x1e0
[   45.671601]  debugfs_create_dir+0x1a/0x1e0
[   45.672142]  nbd_start_device+0x153/0x4c0 [nbd]
[   45.672742]  nbd_genl_connect+0x305/0xbd4 [nbd]
[   45.673345]  genl_family_rcv_msg_doit.isra.0+0x102/0x1b0
[   45.674047]  genl_rcv_msg+0xfc/0x2b0
[   45.674521]  ? nbd_genl_reconfigure+0xbe0/0xbe0 [nbd]
[   45.675190]  ? genl_family_rcv_msg_doit.isra.0+0x1b0/0x1b0
[   45.675907]  netlink_rcv_skb+0x62/0x180
[   45.676420]  genl_rcv+0x34/0x60
[   45.676831]  netlink_unicast+0x272/0x5a0
[   45.677344]  netlink_sendmsg+0x3a3/0x6e0
[   45.677846]  ? iovec_from_user+0x60/0x300
[   45.678362]  ? netlink_rcv_skb+0x180/0x180
[   45.678885]  ____sys_sendmsg+0x1da/0x300
[   45.679391]  ? ____sys_recvmsg+0x130/0x220
[   45.679915]  ___sys_sendmsg+0x8e/0xf0
[   45.680394]  ? ___sys_recvmsg+0xa2/0xf0
[   45.680887]  __sys_sendmsg+0x6d/0xe0
[   45.681356]  __x64_sys_sendmsg+0x23/0x30
[   45.681858]  do_syscall_64+0x35/0x80
[   45.682318]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   45.682960] RIP: 0033:0x7f7494b11b87


> It would be the better to catch these error and warning message in the test
> case. For example, following hunk will catch it.
> 
> diff --git a/tests/nbd/004 b/tests/nbd/004
> index 6b2c5ff..9277c10 100755
> --- a/tests/nbd/004
> +++ b/tests/nbd/004
> @@ -47,6 +47,12 @@ test() {
>          } 2>/dev/null
> 
>          _stop_nbd_server_netlink
> +
> +       if _dmesg_since_test_start | grep -q -e "couldn't allocate config" \
> +          -e "cannot create duplicate filename"; then
> +               echo "Fail"
> +       fi
> +
>          echo "Test complete"
>   }
> 
> 
>>
>> Two concurrent processes，one load and unlock nbd module
>> cyclically, the other one connect and disconnect nbd device cyclically.
>> Last for 10 seconds.
>>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>> v1->v2:
>> 1.change install/uninstall to load/unlock
> 
> My guess is that Christoph meant "load/unload".
> 
>> 2.use _have_modules instead
>>
>>   tests/nbd/004     | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/nbd/004.out |  2 ++
>>   tests/nbd/rc      | 18 ++++++++++++++++++
>>   3 files changed, 72 insertions(+)
>>   create mode 100755 tests/nbd/004
>>   create mode 100644 tests/nbd/004.out
>>
>> diff --git a/tests/nbd/004 b/tests/nbd/004
>> new file mode 100755
>> index 0000000..6b2c5ff
>> --- /dev/null
>> +++ b/tests/nbd/004
>> @@ -0,0 +1,52 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2022 Sun Ke
>> +#
>> +# Regression test for commit 06c4da89c24e
>> +# nbd: call genl_unregister_family() first in nbd_cleanup()
>> +
>> +. tests/nbd/rc
>> +
>> +DESCRIPTION="module load/unlock concurrently with connect/disconnect"
>> +QUICK=1
>> +
>> +requires() {
>> +	_have_modules
> 
> This helper function needs an argument as the module name to check, nbd.
> 
