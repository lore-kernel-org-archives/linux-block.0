Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:23931 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1761989AbdLSKpG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Dec 2017 05:45:06 -0500
Message-ID: <5A38EDAF.5070407@cn.fujitsu.com>
Date: Tue, 19 Dec 2017 18:45:03 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
To: Omar Sandoval <osandov@osandov.com>
CC: Eryu Guan <eguan@redhat.com>, <fstests@vger.kernel.org>,
        <linux-block@vger.kernel.org>
Subject: Re: [PATCH] generic/473: test return EBUSY from BLKRRPART for mounted
 whole-dev
References: <1511956946-16667-1-git-send-email-yangx.jy@cn.fujitsu.com> <20171204082923.GF2749@eguan.usersys.redhat.com> <5A251225.7080905@cn.fujitsu.com> <20171204092558.GH2749@eguan.usersys.redhat.com> <5A2519F4.5040102@cn.fujitsu.com> <20171204182953.GA16308@vader.DHCP.thefacebook.com>
In-Reply-To: <20171204182953.GA16308@vader.DHCP.thefacebook.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2017/12/05 2:29, Omar Sandoval wrote:
> On Mon, Dec 04, 2017 at 05:48:36PM +0800, Xiao Yang wrote:
>> On 2017/12/04 17:25, Eryu Guan wrote:
>>> On Mon, Dec 04, 2017 at 05:15:17PM +0800, Xiao Yang wrote:
>>>> On 2017/12/04 16:29, Eryu Guan wrote:
>>>>> On Wed, Nov 29, 2017 at 08:02:26PM +0800, Xiao Yang wrote:
>>>>>> If the entire block device is formatted with a filesystem and
>>>>>> mounted, running "blockdev --rereadpt" should fail and return
>>>>>> EBUSY instead of pass.
>>>>>>
>>>>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>>>> As we have blktests[1] now, I think this may fit in blktests better?
>>>> Hi Eryu,
>>>>
>>>> Do you think test cases which use scsi_debug module should be moved into
>>>> blktests?
>>>> (e.g. generic/108, generic/349, generic/350, generic/351)
>>> I don't think they need to be moved to blktests. Most other tests that
>>> take use of scsi_debug are for filesystem testing, e.g. generic/108.
>>> generic/349 generic/35[01] are a bit special, they were there before
>>> blktests was announced available, so they're in a special blockdev group
>>> and not in the auto group. If Omar agrees, I think they can be ported to
>>> blktests.
>> Hi Eryu,
>>
>> Thanks for your explanation, and i will try to send it to blktests.
>>
>> Thanks,
>> Xiao Yang
> I agree, the three tests Eryu mentioned and this new test would be a
> good fit for blktests. Let me know if you need any help porting, things
> are a little different from xfstests.
Hi Omar,

With gcc v4.4.7 on RHEL6, i got the following compiler error:
----------------------------------------------------------------------------------------------------------------------
[root@RHEL6U9GA_Intel64 blktests]# make
make -C src all
make[1]: Entering directory `/root/blktests/src'
cc -Wall -o sg/syzkaller1 -O2 sg/syzkaller1.c
sg/syzkaller1.c: In function �segv_handler�:
sg/syzkaller1.c:118: warning: implicit declaration of function 
�__atomic_load_n�
sg/syzkaller1.c:118: error: �__ATOMIC_RELAXED� undeclared (first use in 
this function)
sg/syzkaller1.c:118: error: (Each undeclared identifier is reported only 
once
sg/syzkaller1.c:118: error: for each function it appears in.)
sg/syzkaller1.c: In function �syz_open_dev�:
sg/syzkaller1.c:204: warning: implicit declaration of function 
�__atomic_fetch_add�
sg/syzkaller1.c:204: error: �__ATOMIC_SEQ_CST� undeclared (first use in 
this function)
sg/syzkaller1.c:204: warning: implicit declaration of function 
�__atomic_fetch_sub�
sg/syzkaller1.c: In function �test�:
sg/syzkaller1.c:406: error: �__ATOMIC_SEQ_CST� undeclared (first use in 
this function)
make[1]: *** [sg/syzkaller1] Error 1
make[1]: Leaving directory `/root/blktests/src'
make: *** [all] Error 2
-----------------------------------------------------------------------------------------------------------------------

It seems that __atomic_* functions are not available, and could you tell 
me how to fix
the compiler error?

Thanks,
Xiao Yang
>
>
