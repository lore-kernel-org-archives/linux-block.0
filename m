Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0873EC43381
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 16:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1F6A64DD3
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 16:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhBVQFf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 11:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbhBVQEy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 11:04:54 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A70C06178A
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 08:02:53 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id v3so9568781qtw.4
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 08:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=czGWY8uQnq3owWtXa46dSideyOqa5Jj4FvgK5VnXqPg=;
        b=oUBe0oGw2gSJ31bJBZaKmUahxYkjXth/ex9h84mlmIBNYGn0ZbovD+2HbZiCF7pgdM
         il/TP9I7kZtHvNJLV8r0VzJY+xNEU6tCqSXn+boAaQR25exb05Fe/vUOh+82q0RE6Twd
         m/1n1N9uSav8dkK/VPJLdjMxO6YKp7sSr/cu1Fem0VjxiXKLPKQLIAdRMONVhJwVK1+c
         Fty1otWJyvHNYt+/g0VXcmYtreI39T/1GcCssdwdSw38yAcewdr5M+KQ5hqMLoFEqDQw
         PX2WLqZLajDuCsdd7mLk/c5SKyjMDOgJFGWt4RreqUzhUxfzBf0yaPJe7WYvi4zn9sJL
         CCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=czGWY8uQnq3owWtXa46dSideyOqa5Jj4FvgK5VnXqPg=;
        b=K2bn/WNzbClLTvU1iEOswTmaCt4fhBIPFarGeDE8wfIZ0ZJVtLjN79xL7z5Z2UEiKM
         ELkk9I58YPEcC0obn3Vp6jUAgeSlf0bO9L7BdLp/+KvobmQQsmRgrhW2jmir1rTN1Kg+
         jBPEXoG/qiAHI2RhDsCI91Ywu52unI/n+Ps8uZAjD5QVx+AMCwoIwLulxKT7gCATbBor
         76m2f8WAZXT7GzDpboz6P4BZnGOGW3/i7VnbDX8Miy3PVUjYw4pSq2aQNfGDM/4StXtq
         UBnChsUQahDx72g7s3O2EIJfViC802wfvPb6xgKtwUd6zftIhgxrGL4Iz0rubyeKSeIo
         F+3w==
X-Gm-Message-State: AOAM5326074qYGsh+hI2nOGbpf4/DJ5tk5iu/AyKoVgRV7sGk/VR9D/6
        C0hXaNjSU6fW00KBw2ImPn6mbA==
X-Google-Smtp-Source: ABdhPJxUaZLr72X+IitGiZdhvcdjbXqJ8JGYNuaWzIyHsZqL8oZ3TGdKCtzxFvdCJQIoO0kqCuOa9A==
X-Received: by 2002:ac8:6e86:: with SMTP id c6mr1726430qtv.203.1614009772088;
        Mon, 22 Feb 2021 08:02:52 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v145sm12948098qka.27.2021.02.22.08.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 08:02:51 -0800 (PST)
Subject: Re: KASAN: use-after-free Read in nbd_genl_connect
To:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+429d3f82d757c211bff3@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000bda69205bbe88a09@google.com>
 <20210222093444.2782-1-hdanton@sina.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <02ee51c8-90eb-7f51-b725-441211504ff1@toxicpanda.com>
Date:   Mon, 22 Feb 2021 11:02:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210222093444.2782-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/21 4:34 AM, Hillf Danton wrote:
> Mon, 22 Feb 2021 00:25:18 -0800
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    f40ddce8 Linux 5.11
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=179e8d22d00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e53d04227c52a0df
>> dashboard link: https://syzkaller.appspot.com/bug?extid=429d3f82d757c211bff3
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d190cad00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13dc8a82d00000
>>
>> Bisection is inconclusive: the issue happens on the oldest tested release.
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1128ae60d00000
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1328ae60d00000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1528ae60d00000
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+429d3f82d757c211bff3@syzkaller.appspotmail.com
>>
>> ==================================================================
>> BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:71 [inline]
>> BUG: KASAN: use-after-free in atomic_read include/asm-generic/atomic-instrumented.h:27 [inline]
>> BUG: KASAN: use-after-free in refcount_dec_not_one+0x71/0x1e0 lib/refcount.c:76
>> Read of size 4 at addr ffff888014ca19a0 by task syz-executor980/8540
>>
>> CPU: 0 PID: 8540 Comm: syz-executor980 Not tainted 5.11.0-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Call Trace:
>>   __dump_stack lib/dump_stack.c:79 [inline]
>>   dump_stack+0x107/0x163 lib/dump_stack.c:120
>>   print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:230
>>   __kasan_report mm/kasan/report.c:396 [inline]
>>   kasan_report.cold+0x79/0xd5 mm/kasan/report.c:413
>>   check_memory_region_inline mm/kasan/generic.c:179 [inline]
>>   check_memory_region+0x13d/0x180 mm/kasan/generic.c:185
>>   instrument_atomic_read include/linux/instrumented.h:71 [inline]
>>   atomic_read include/asm-generic/atomic-instrumented.h:27 [inline]
>>   refcount_dec_not_one+0x71/0x1e0 lib/refcount.c:76
>>   refcount_dec_and_mutex_lock+0x19/0x140 lib/refcount.c:115
>>   nbd_put drivers/block/nbd.c:248 [inline]
> 
> This put is unbalanced, given the 1978 line below.
> 
>>   nbd_genl_connect+0xee7/0x1560 drivers/block/nbd.c:1980
>>   genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:739
>>   genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
>>   genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:800
>>   netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2494
>>   genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
>>   netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
>>   netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
>>   netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
>>   sock_sendmsg_nosec net/socket.c:652 [inline]
>>   sock_sendmsg+0xcf/0x120 net/socket.c:672
>>   ____sys_sendmsg+0x6e8/0x810 net/socket.c:2345
>>   ___sys_sendmsg+0xf3/0x170 net/socket.c:2399
>>   __sys_sendmsg+0xe5/0x1b0 net/socket.c:2432
>>   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> RIP: 0033:0x440709
>> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007ffd63e9cc88 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>> RAX: ffffffffffffffda RBX: 000000000000e3fb RCX: 0000000000440709
>> RDX: 0000000000000000 RSI: 0000000020000340 RDI: 0000000000000003
>> RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffd63e9ce28
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd63e9cc9c
>> R13: 431bde82d7b634db R14: 00000000004ae018 R15: 00000000004004a0
>>
>> Allocated by task 8536:
>>   kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
>>   kasan_set_track mm/kasan/common.c:46 [inline]
>>   set_alloc_info mm/kasan/common.c:401 [inline]
>>   ____kasan_kmalloc.constprop.0+0x82/0xa0 mm/kasan/common.c:429
>>   kmalloc include/linux/slab.h:552 [inline]
>>   kzalloc include/linux/slab.h:682 [inline]
>>   nbd_dev_add+0x44/0x8e0 drivers/block/nbd.c:1673
>>   nbd_genl_connect+0x59c/0x1560 drivers/block/nbd.c:1838
>>   genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:739
>>   genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
>>   genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:800
>>   netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2494
>>   genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
>>   netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
>>   netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
>>   netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
>>   sock_sendmsg_nosec net/socket.c:652 [inline]
>>   sock_sendmsg+0xcf/0x120 net/socket.c:672
>>   ____sys_sendmsg+0x6e8/0x810 net/socket.c:2345
>>   ___sys_sendmsg+0xf3/0x170 net/socket.c:2399
>>   __sys_sendmsg+0xe5/0x1b0 net/socket.c:2432
>>   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> Freed by task 8540:
>>   kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
>>   kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
>>   kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:356
>>   ____kasan_slab_free+0xe1/0x110 mm/kasan/common.c:362
>>   kasan_slab_free include/linux/kasan.h:192 [inline]
>>   slab_free_hook mm/slub.c:1547 [inline]
>>   slab_free_freelist_hook+0x5d/0x150 mm/slub.c:1580
>>   slab_free mm/slub.c:3143 [inline]
>>   kfree+0xdb/0x3b0 mm/slub.c:4139
>>   nbd_dev_remove drivers/block/nbd.c:243 [inline]
>>   nbd_put.part.0+0x180/0x1d0 drivers/block/nbd.c:251
>>   nbd_put drivers/block/nbd.c:295 [inline]
>>   nbd_config_put+0x6dd/0x8c0 drivers/block/nbd.c:1242
>>   nbd_genl_connect+0xeb7/0x1560 drivers/block/nbd.c:1978
>>   genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:739
>>   genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
>>   genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:800
>>   netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2494
>>   genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
>>   netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
>>   netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
>>   netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
>>   sock_sendmsg_nosec net/socket.c:652 [inline]
>>   sock_sendmsg+0xcf/0x120 net/socket.c:672
>>   ____sys_sendmsg+0x6e8/0x810 net/socket.c:2345
>>   ___sys_sendmsg+0xf3/0x170 net/socket.c:2399
>>   __sys_sendmsg+0xe5/0x1b0 net/socket.c:2432
>>   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> The buggy address belongs to the object at ffff888014ca1800
>>   which belongs to the cache kmalloc-1k of size 1024
>> The buggy address is located 416 bytes inside of
>>   1024-byte region [ffff888014ca1800, ffff888014ca1c00)
>> The buggy address belongs to the page:
>> page:0000000086766889 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x14ca0
>> head:0000000086766889 order:3 compound_mapcount:0 compound_pincount:0
>> flags: 0xfff00000010200(slab|head)
>> raw: 00fff00000010200 ffffea0000929400 0000000200000002 ffff888010c41140
>> raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>>   ffff888014ca1880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>   ffff888014ca1900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> ffff888014ca1980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>                                 ^
>>   ffff888014ca1a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>   ffff888014ca1a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ==================================================================
> 
> If the quick fix will be able to survive syzbot tests then we can
> remove the put_dev on stack.
> 
> --- x/drivers/block/nbd.c
> +++ y/drivers/block/nbd.c
> @@ -1908,6 +1908,7 @@ again:
>   				&config->runtime_flags);
>   			set_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags);
>   			put_dev = true;
> +			refcount_inc(&nbd->refs);
>   		} else {
>   			clear_bit(NBD_DESTROY_ON_DISCONNECT, &nbd->flags);
>   		}
> 

That's not it, it's a race between one thread disconnecting while the other 
thread is connecting.  At this point we expect the ref count to be 2, but this 
isn't the case if we raced in and got a ref on our index while a config was 
exiting, we'll have a refcount of 1.  I'll make sure I can reproduce and then 
fix it properly.  Thanks,

Josef
