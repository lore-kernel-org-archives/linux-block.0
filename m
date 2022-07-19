Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9BAC43334
	for <linux-block@archiver.kernel.org>; Tue, 19 Jul 2022 06:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiGSGWs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jul 2022 02:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbiGSGWs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jul 2022 02:22:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D9A2872D
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 23:22:46 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ln7vH4898zVgLl;
        Tue, 19 Jul 2022 14:18:51 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 14:22:36 +0800
Received: from [10.174.178.31] (10.174.178.31) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 14:22:35 +0800
Subject: Re: [PATCH blktests v2] nbd: add a module load and device connect
 test
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
References: <20220707035610.3175550-1-sunke32@huawei.com>
 <20220707124945.c2rd677hjwkd7mim@shindev>
From:   Sun Ke <sunke32@huawei.com>
Message-ID: <d4d5c222-77fe-9932-529e-af63164fa343@huawei.com>
Date:   Tue, 19 Jul 2022 14:22:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220707124945.c2rd677hjwkd7mim@shindev>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.31]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Sorry for missing the reply, I will improve it in v3.

Thanks.
Sun Ke
