Return-Path: <dvyukov@google.com>
MIME-Version: 1.0
In-Reply-To: <0e998b77-14f0-aee0-8d32-bc1dd96fcc4c@kernel.dk>
References: <00000000000082922905692da9e1@google.com> <0e998b77-14f0-aee0-8d32-bc1dd96fcc4c@kernel.dk>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 6 Apr 2018 16:57:13 +0200
Message-ID: <CACT4Y+Y0TVJLDA5-0RGq-a-A6KKLKHZtA4pwUH2rtvR0hkiZQQ@mail.gmail.com>
Subject: Re: WARNING: lock held when returning to user space!
To: Jens Axboe <axboe@kernel.dk>
Cc: syzbot <syzbot+31e8daa8b3fc129e75f2@syzkaller.appspotmail.com>,
	linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	syzkaller-bugs@googlegroups.com, Omar Sandoval <osandov@osandov.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Apr 6, 2018 at 4:27 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 4/6/18 7:02 AM, syzbot wrote:
>> Hello,
>>
>> syzbot hit the following crash on upstream commit
>> 38c23685b273cfb4ccf31a199feccce3bdcb5d83 (Fri Apr 6 04:29:35 2018 +0000)
>> Merge tag 'armsoc-drivers' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
>> syzbot dashboard link:
>> https://syzkaller.appspot.com/bug?extid=31e8daa8b3fc129e75f2
>>
>> So far this crash happened 9 times on upstream.
>> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6407930337296384
>> syzkaller reproducer:
>> https://syzkaller.appspot.com/x/repro.syz?id=4942413340606464
>> Raw console output:
>> https://syzkaller.appspot.com/x/log.txt?id=4764483918495744
>> Kernel config:
>> https://syzkaller.appspot.com/x/.config?id=-5813481738265533882
>> compiler: gcc (GCC) 8.0.1 20180301 (experimental)
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+31e8daa8b3fc129e75f2@syzkaller.appspotmail.com
>> It will help syzbot understand when the bug is fixed. See footer for
>> details.
>> If you forward the report, please keep this part and the footer.
>>
>>
>> ================================================
>> WARNING: lock held when returning to user space!
>> 4.16.0+ #3 Not tainted
>> ------------------------------------------------
>> syzkaller433111/4462 is leaving the kernel with locks still held!
>> 1 lock held by syzkaller433111/4462:
>>   #0: 0000000003a06fae (&lo->lo_ctl_mutex/1){+.+.}, at: lo_ioctl+0x8d/0x1ec0
>> drivers/block/loop.c:1363
>
> Is this a new regression? Omar did just fiddle with the locking a bit,
> seems suspicious.

Looking at:
https://syzkaller.appspot.com/bug?extid=31e8daa8b3fc129e75f2
It first happened 4 hours ago and 9 times since then, so probably a
just introduced regression.


> --
> Jens Axboe
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0e998b77-14f0-aee0-8d32-bc1dd96fcc4c%40kernel.dk.
> For more options, visit https://groups.google.com/d/optout.
