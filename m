Return-Path: <axboe@kernel.dk>
Subject: Re: possible deadlock in blk_trace_remove
To: Eric Biggers <ebiggers3@gmail.com>
Cc: syzbot
 <bot+583353673e394aa41e5fb68ddc8b8d9d5c8d576f@syzkaller.appspotmail.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
References: <001a1141f8dc4440a9055e53896e@google.com>
 <20171203202434.GD844@zzz.localdomain>
 <9f7ab661-7d57-3e84-769c-6d103557f342@kernel.dk>
 <20171204004427.GA13374@zzz.localdomain>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <33f25849-1aff-8464-6467-47ce55d1c0b1@kernel.dk>
Date: Sun, 3 Dec 2017 17:47:36 -0700
MIME-Version: 1.0
In-Reply-To: <20171204004427.GA13374@zzz.localdomain>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 12/03/2017 05:44 PM, Eric Biggers wrote:
> On Sun, Dec 03, 2017 at 05:24:32PM -0700, Jens Axboe wrote:
>> On 12/03/2017 01:24 PM, Eric Biggers wrote:
>>> On Sun, Nov 19, 2017 at 02:36:01AM -0800, syzbot wrote:
>>>> Hello,
>>>>
>>>> syzkaller hit the following crash on
>>>> d9e0e63d9a6f88440eb201e1491fcf730272c706
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
>>>> compiler: gcc (GCC) 7.1.1 20170620
>>>> .config is attached
>>>> Raw console output is attached.
>>>>
>>>> Unfortunately, I don't have any reproducer for this bug yet.
>>>>
>>>>
>>>> Use struct sctp_sack_info instead
>>>>
>>>> ============================================
>>>> WARNING: possible recursive locking detected
>>>> 4.14.0-rc8-next-20171110+ #40 Not tainted
>>>> --------------------------------------------
>>>> syz-executor6/21462 is trying to acquire lock:
>>>>  (&q->blk_trace_mutex){+.+.}, at: [<ffffffff81760261>]
>>>> blk_trace_remove+0x21/0x40 kernel/trace/blktrace.c:373
>>>>
>>>> but task is already holding lock:
>>>>  (&q->blk_trace_mutex){+.+.}, at: [<ffffffff81763b38>]
>>>> blk_trace_setup+0x38/0x70 kernel/trace/blktrace.c:606
>>>>
>>>> other info that might help us debug this:
>>>>  Possible unsafe locking scenario:
>>>
>>> #syz fix: blktrace: fix trace mutex deadlock
>>
>> This is fixed in current -git.
>>
> 
> I know, but syzbot needed to be told what commit fixes the bug.
> See https://github.com/google/syzkaller/blob/master/docs/syzbot.md

Ah gotcha.

-- 
Jens Axboe
