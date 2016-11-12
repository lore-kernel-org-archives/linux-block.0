Subject: Re: [GIT PULL] Block fixes for 4.9-rc
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <21b1c040-ea27-847d-326a-266224516814@fb.com>
 <CA+55aFzjUTzokY8MHYXFPhr0W037Qzhu1EchGoAkkFUgrkV+CA@mail.gmail.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <88377c67-f091-ce96-f508-376d633adb7e@fb.com>
Date: Fri, 11 Nov 2016 18:24:31 -0700
MIME-Version: 1.0
In-Reply-To: <CA+55aFzjUTzokY8MHYXFPhr0W037Qzhu1EchGoAkkFUgrkV+CA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/11/2016 05:45 PM, Linus Torvalds wrote:
> On Fri, Nov 11, 2016 at 4:11 PM, Jens Axboe <axboe@fb.com> wrote:
>> Hi Linus,
>>
>> Three small (really, one liners all of them!) fixes that should go into
>> this series:
>
> What about the aoeblk one? That seems to have come in with a tester
> lately. From your original email:
>
>  "I'm wondering if this is bio iteration breakage. aoeblk does this weird
>   inc/dec of page counts, which should not be needed. At least others
>   would be hit by this as well. In any case, should suffice for a test,
>   before we look further. Can anyone test with this debug patch?"
>
> Anyway, that bug seems to have been around forever and I'm not seeing
> a lot of complaints, but I thought I'd ask.

I was going to queue that one up for 4.10, but we can go with 4.9 as
well. I don't think it's a huge deal. And, as per the below, looks like
I'm sending another round next week anyway.

> Your oneliners pulled. Except when I pull, I don't actually get this one:
>
>     Matias Bjørling (1):
>           lightnvm: invalid offset calculation for lba_shift
>
> but since you know how very deeply I care about lighnvm, I'm not
> finding it in myself to worry about why that one was missing.

Yes, I remember you made that clear :-)

I forgot to push that one out after applying the other day, apparently,
and missed that git request-pull complained. But worry not, I'll include
that in the next round. It's still a merge window regression.

-- 
Jens Axboe
