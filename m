Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block fixes for 4.20-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-block <linux-block@vger.kernel.org>
References: <08927d57-4155-b97e-0229-77b65b9eeb32@kernel.dk>
 <CAHk-=wjxZyGmXC6m_YyDyy5BMKrMHZW4iE9GO__LZKD-t5S1Tw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a17a076e-2f55-b6d3-0507-a4e427aca70e@kernel.dk>
Date: Fri, 9 Nov 2018 15:37:40 -0700
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjxZyGmXC6m_YyDyy5BMKrMHZW4iE9GO__LZKD-t5S1Tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/9/18 3:35 PM, Linus Torvalds wrote:
> On Fri, Nov 9, 2018 at 1:29 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> A select set of fixes that should go into this release. This pull
>> request contains:
> 
> This is part of a final few "ack" emails, pointing out that there is
> now automation in place if you cc lkml in your pull request.
> 
> That automation will parse the pull request and automatically send an
> ack when the end result gets merged into mainline, so I'll stop the
> manual process.
> 
> But it currently only works on lkml (I think - maybe Konstantin
> enabled it for all lists that get tracked by lore.kernel.org), so this
> pull request probably won't get an automated response due to just
> going to linux-block.
> 
> Just a heads-up.

Thanks for the heads-up. I haven't gotten linux-block tracked by lore
yet, but will do so.

-- 
Jens Axboe
