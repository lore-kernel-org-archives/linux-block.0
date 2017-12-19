Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:27092 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1762216AbdLSK7Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Dec 2017 05:59:16 -0500
Message-ID: <5A38F100.5090305@cn.fujitsu.com>
Date: Tue, 19 Dec 2017 18:59:12 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
To: Johannes Thumshirn <jthumshirn@suse.de>
CC: Omar Sandoval <osandov@osandov.com>, Eryu Guan <eguan@redhat.com>,
        <fstests@vger.kernel.org>, <linux-block@vger.kernel.org>
Subject: Re: [PATCH] generic/473: test return EBUSY from BLKRRPART for mounted
 whole-dev
References: <1511956946-16667-1-git-send-email-yangx.jy@cn.fujitsu.com> <20171204082923.GF2749@eguan.usersys.redhat.com>        <5A251225.7080905@cn.fujitsu.com>       <20171204092558.GH2749@eguan.usersys.redhat.com>        <5A2519F4.5040102@cn.fujitsu.com>       <20171204182953.GA16308@vader.DHCP.thefacebook.com>     <5A38EDAF.5070407@cn.fujitsu.com> <mqd3747at09.fsf@linux-x5ow.site>
In-Reply-To: <mqd3747at09.fsf@linux-x5ow.site>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2017/12/19 18:53, Johannes Thumshirn wrote:
> Xiao Yang<yangx.jy@cn.fujitsu.com>  writes:
>> [root@RHEL6U9GA_Intel64 blktests]# make
>> make -C src all
>> make[1]: Entering directory `/root/blktests/src'
>> cc -Wall -o sg/syzkaller1 -O2 sg/syzkaller1.c
>> sg/syzkaller1.c: In function ‘segv_handler’:
>> sg/syzkaller1.c:118: warning: implicit declaration of function
>> ‘__atomic_load_n’
>> sg/syzkaller1.c:118: error: ‘__ATOMIC_RELAXED’ undeclared (first use
>> in this function)
>> sg/syzkaller1.c:118: error: (Each undeclared identifier is reported
>> only once
>> sg/syzkaller1.c:118: error: for each function it appears in.)
>> sg/syzkaller1.c: In function ‘syz_open_dev’:
>> sg/syzkaller1.c:204: warning: implicit declaration of function
>> ‘__atomic_fetch_add’
>> sg/syzkaller1.c:204: error: ‘__ATOMIC_SEQ_CST’ undeclared (first use
>> in this function)
>> sg/syzkaller1.c:204: warning: implicit declaration of function
>> ‘__atomic_fetch_sub’
>> sg/syzkaller1.c: In function ‘test’:
>> sg/syzkaller1.c:406: error: ‘__ATOMIC_SEQ_CST’ undeclared (first use
>> in this function)
>> make[1]: *** [sg/syzkaller1] Error 1
>> make[1]: Leaving directory `/root/blktests/src'
>> make: *** [all] Error 2
>> -----------------------------------------------------------------------------------------------------------------------
>>
>> It seems that __atomic_* functions are not available, and could you
>> tell me how to fix
>> the compiler error?
> It seems like gcc 4.4 is too old to handle __ATOMIC_*. The oldest
> version of gcc I tried was 4.8 which could handle this code perfectly
> fine.
>
> I think we need hacks in the makefile to see which compiler version we
> have and conditionally compile the code.
Hi Johannes,

Thanks for your quick reply.  i will try to fix it as you suggested.

Thanks,
Xiao Yang
> Byte,
>          Johannes
>
