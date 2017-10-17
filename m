Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] block/aoe: Convert timers to use timer_setup()
From: Jens Axboe <axboe@kernel.dk>
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Ed L. Cashin" <ed.cashin@acm.org>,
 linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20171005231354.GA109107@beast>
 <8a7183b5-d9d8-af74-6ce8-aa005468a83b@kernel.dk>
 <CAGXu5jK3aGwt1j=A022y2zvKOqjNxzigHuiUqfJTnqMU4-B7dw@mail.gmail.com>
 <e883e5c0-f3b6-af74-a06b-e6162f93a32d@kernel.dk>
Message-ID: <513a4b27-0040-72f8-f5c7-e35649686b5b@kernel.dk>
Date: Tue, 17 Oct 2017 10:21:47 -0600
MIME-Version: 1.0
In-Reply-To: <e883e5c0-f3b6-af74-a06b-e6162f93a32d@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/17/2017 10:09 AM, Jens Axboe wrote:
> On 10/16/2017 06:03 PM, Kees Cook wrote:
>> On Fri, Oct 6, 2017 at 7:19 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>> On 10/05/2017 05:13 PM, Kees Cook wrote:
>>>> In preparation for unconditionally passing the struct timer_list pointer to
>>>> all timer callbacks, switch to using the new timer_setup() and from_timer()
>>>> to pass the timer pointer explicitly.
>>>
>>> Applied to for-4.15/timer
>>
>> Hi,
>>
>> I just wanted to check what your timer plans were for merging this
>> into -next (I'm doing rebasing to find out which maintainers I need to
>> resend patches to, and I noticed block hasn't appeared in -next, but I
>> know you've pulled patches...)
> 
> It should be in for-next, since I wrote that email. It's in my
> for-4.15/timer branch, which is also merged into my for-next branch
> (which is the one that Stephen pulls).

Just pulled in for-next, and it seems to contain what it should.
If you see missing block related timer patches in for-next, then
they haven't been applied to my tree yet.

axboe@dell:[.]home/axboe/git/linux-next $ git log drivers/block/aoe/
commit a79c192c7cdb639ad1b059cedbf3dfa68427a170
Author: Kees Cook <keescook@chromium.org>
Date:   Thu Oct 5 16:13:54 2017 -0700

    block/aoe: Convert timers to use timer_setup()
[...]

-- 
Jens Axboe
