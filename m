Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF079C433DB
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 08:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D97764E77
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 08:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhBVIjq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 03:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhBVIjn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 03:39:43 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A616CC061574;
        Mon, 22 Feb 2021 00:39:02 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id n8so18071367wrm.10;
        Mon, 22 Feb 2021 00:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NDKFrp9F6/y1igRI90XgA2aDEor3w6tbIvsGtkSu0Qw=;
        b=Ml3ap+cde7a/DXPl+wLsSZpYKUVb3PMyBG7IjEpl7T1w202i0/LpdYEnnbiRytkDiq
         RBY9jjbLK+ZyeJCvcr5zaBa7q8p4PvfiCWP+pimsCMHRt8fhL1Gdafn+nDpKpqixTvrD
         kI9oE5iypNUH+z+uTRrwh0/9tcGOMeyqY2tpt6Tkd1d7zbMlrHAT8p/hZ5t51DpYtvjF
         gPGoAzXWFFYzxA2AU/Kd7MP0Q5AtaxLzbGLA1EncN1QQ3R2rO80KITPVPsM9A8uw8Pxk
         vxX4RWuxY+D0Q5i3jRsF7oPfHA5b3NcbxDvBR4S5/ZOCsa0p7UK6HDLMZ3ybKvdGgaSC
         HaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NDKFrp9F6/y1igRI90XgA2aDEor3w6tbIvsGtkSu0Qw=;
        b=s9RlpvMIsM+izeXL5JHQJOEeSQLp22X+cmLEgHqqE49wqPTLgsEBEZBMX0FyXvoRd4
         YdrLnfZg8ldXVCvHLpVW9sLt3mSaOj2F7NeIfMS1rRjBUwQ0/Wn+/Tnm6x9ZK8wl6I18
         NHXQt4FoWyCnotAAJXpYhM2CFGvr4s37a2ogsPSIbyDdCpWb5Ge8Unt1Y/Smr0wGoti0
         e/RvmxaJK3QZf4TviNpsxUeAxaRiwcvvDVHLyCVVebv6U7RVhSNn8mzJUGi1ogSMAri7
         aPjzFIoAC/OrAY0m2bQQv2X89MLzTClpYB7ceVVfx/Ahg0d9+TdQAKN/2Jiu26dV0Tc3
         D6hA==
X-Gm-Message-State: AOAM531wdnS6meARVem+CGJ+2tlX8PUETJj58UwjER9RzhWiUcYXNwKG
        /xDkJmnEdCs7A7fIlJkOUJA=
X-Google-Smtp-Source: ABdhPJxfO34MTcMJAvLxNLqx94wLOLSN5dTiAqLL4iqnOBT6MJvotoCWjDloXXXLe8WYyOc0S4X/Rw==
X-Received: by 2002:a05:6000:1546:: with SMTP id 6mr20334564wry.398.1613983141390;
        Mon, 22 Feb 2021 00:39:01 -0800 (PST)
Received: from [192.168.1.101] ([37.171.239.209])
        by smtp.gmail.com with ESMTPSA id d20sm29885090wrc.12.2021.02.22.00.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 00:39:00 -0800 (PST)
Subject: Re: KASAN: use-after-free Read in nbd_genl_connect
To:     syzbot <syzbot+429d3f82d757c211bff3@syzkaller.appspotmail.com>,
        axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000bda69205bbe88a09@google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <db587e0d-816d-a0bf-feb4-b581bec3252a@gmail.com>
Date:   Mon, 22 Feb 2021 09:38:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <000000000000bda69205bbe88a09@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2/22/21 9:25 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f40ddce8 Linux 5.11
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=179e8d22d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e53d04227c52a0df
> dashboard link: https://syzkaller.appspot.com/bug?extid=429d3f82d757c211bff3
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d190cad00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13dc8a82d00000
> 
> Bisection is inconclusive: the issue happens on the oldest tested release.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1128ae60d00000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1328ae60d00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1528ae60d00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+429d3f82d757c211bff3@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:71 [inline]
> BUG: KASAN: use-after-free in atomic_read include/asm-generic/atomic-instrumented.h:27 [inline]
> BUG: KASAN: use-after-free in refcount_dec_not_one+0x71/0x1e0 lib/refcount.c:76
> Read of size 4 at addr ffff888014ca19a0 by task syz-executor980/8540
> 
> CPU: 0 PID: 8540 Comm: syz-executor980 Not tainted 5.11.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x107/0x163 lib/dump_stack.c:120
>  print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:230
>  __kasan_report mm/kasan/report.c:396 [inline]
>  kasan_report.cold+0x79/0xd5 mm/kasan/report.c:413
>  check_memory_region_inline mm/kasan/generic.c:179 [inline]
>  check_memory_region+0x13d/0x180 mm/kasan/generic.c:185
>  instrument_atomic_read include/linux/instrumented.h:71 [inline]
>  atomic_read include/asm-generic/atomic-instrumented.h:27 [inline]
>  refcount_dec_not_one+0x71/0x1e0 lib/refcount.c:76
>  refcount_dec_and_mutex_lock+0x19/0x140 lib/refcount.c:115
>  nbd_put drivers/block/nbd.c:248 [inline]
>  nbd_genl_connect+0xee7/0x1560 drivers/block/nbd.c:1980
>  genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:739
>  genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
>  genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:800
>  netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2494
>  genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
>  netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
>  netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
>  netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  sock_sendmsg+0xcf/0x120 net/socket.c:672
>  ____sys_sendmsg+0x6e8/0x810 net/socket.c:2345
>  ___sys_sendmsg+0xf3/0x170 net/socket.c:2399
>  __sys_sendmsg+0xe5/0x1b0 net/socket.c:2432
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x440709
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd63e9cc88 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 000000000000e3fb RCX: 0000000000440709
> RDX: 0000000000000000 RSI: 0000000020000340 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffd63e9ce28
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd63e9cc9c
> R13: 431bde82d7b634db R14: 00000000004ae018 R15: 00000000004004a0
> 
> Allocated by task 8536:
>  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
>  kasan_set_track mm/kasan/common.c:46 [inline]
>  set_alloc_info mm/kasan/common.c:401 [inline]
>  ____kasan_kmalloc.constprop.0+0x82/0xa0 mm/kasan/common.c:429
>  kmalloc include/linux/slab.h:552 [inline]
>  kzalloc include/linux/slab.h:682 [inline]
>  nbd_dev_add+0x44/0x8e0 drivers/block/nbd.c:1673
>  nbd_genl_connect+0x59c/0x1560 drivers/block/nbd.c:1838
>  genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:739
>  genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
>  genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:800
>  netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2494
>  genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
>  netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
>  netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
>  netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  sock_sendmsg+0xcf/0x120 net/socket.c:672
>  ____sys_sendmsg+0x6e8/0x810 net/socket.c:2345
>  ___sys_sendmsg+0xf3/0x170 net/socket.c:2399
>  __sys_sendmsg+0xe5/0x1b0 net/socket.c:2432
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Freed by task 8540:
>  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
>  kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
>  kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:356
>  ____kasan_slab_free+0xe1/0x110 mm/kasan/common.c:362
>  kasan_slab_free include/linux/kasan.h:192 [inline]
>  slab_free_hook mm/slub.c:1547 [inline]
>  slab_free_freelist_hook+0x5d/0x150 mm/slub.c:1580
>  slab_free mm/slub.c:3143 [inline]
>  kfree+0xdb/0x3b0 mm/slub.c:4139
>  nbd_dev_remove drivers/block/nbd.c:243 [inline]
>  nbd_put.part.0+0x180/0x1d0 drivers/block/nbd.c:251
>  nbd_put drivers/block/nbd.c:295 [inline]
>  nbd_config_put+0x6dd/0x8c0 drivers/block/nbd.c:1242
>  nbd_genl_connect+0xeb7/0x1560 drivers/block/nbd.c:1978
>  genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:739
>  genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
>  genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:800
>  netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2494
>  genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
>  netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
>  netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
>  netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  sock_sendmsg+0xcf/0x120 net/socket.c:672
>  ____sys_sendmsg+0x6e8/0x810 net/socket.c:2345
>  ___sys_sendmsg+0xf3/0x170 net/socket.c:2399
>  __sys_sendmsg+0xe5/0x1b0 net/socket.c:2432
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> The buggy address belongs to the object at ffff888014ca1800
>  which belongs to the cache kmalloc-1k of size 1024
> The buggy address is located 416 bytes inside of
>  1024-byte region [ffff888014ca1800, ffff888014ca1c00)
> The buggy address belongs to the page:
> page:0000000086766889 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x14ca0
> head:0000000086766889 order:3 compound_mapcount:0 compound_pincount:0
> flags: 0xfff00000010200(slab|head)
> raw: 00fff00000010200 ffffea0000929400 0000000200000002 ffff888010c41140
> raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff888014ca1880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888014ca1900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff888014ca1980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                ^
>  ffff888014ca1a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff888014ca1a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 

This might be caused by :

commit a2c97909f97ef32b76e856572fba4f77e1885fe6
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Thu Apr 6 17:02:07 2017 -0400

    nbd: add a flag to destroy an nbd device on disconnect
   
    For ease of management it would be nice for users to specify that the
    device node for a nbd device is destroyed once it is disconnected and
    there are no more users.  Add a client flag and enable this operation to
    happen.
   
    Signed-off-by: Josef Bacik <jbacik@fb.com>
    Signed-off-by: Jens Axboe <axboe@fb.com>
