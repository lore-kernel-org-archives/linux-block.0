Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] First set of block changes for 4.14-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <c1aab1af-4dba-b324-0972-c3933816ecc8@kernel.dk>
 <CA+55aFwrpd+fz3jxK3d6dckFcApc=aCZOrsKogxRYZozwUdHrg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <dfc0dc22-00c3-a28b-93d5-15dad2e55d9f@kernel.dk>
Date: Thu, 7 Sep 2017 13:27:58 -0600
MIME-Version: 1.0
In-Reply-To: <CA+55aFwrpd+fz3jxK3d6dckFcApc=aCZOrsKogxRYZozwUdHrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/07/2017 01:04 PM, Linus Torvalds wrote:
> On Tue, Sep 5, 2017 at 7:31 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Note that you'll hit a conflict in block/bio-integrity.c and
>> mm/page_io.c, since we had fixes later in the 4.13 series for both of
>> those that ended up conflicting with new changes. Both are trivial to
>> fix up, I've included my resolution at the end of this email.
> 
> Actually, the _real_ conflict is with commit 8e654f8fbff5 ("zram: read
> page from backing device") and the preceding code, which added a
> "zram->bdev" that is the backing dev for the zram device.

Which was committed yesterday? It was not from my tree. I try to keep
an eye out for potential conflicts or issues.

> And then it does
> 
>      bio->bi_bdev = zram->bdev;
> 
> but now the block layer has AGAIN changed some stupid internal detail
> for no obvious reason, so now it doesn't work.
> 
> My initial thought was to just do
> 
>     bio->bi_disk = zram->disk;
> 
> instead, which *syntactically* seems to make sense, and match things
> up in the obvious way.
> 
> But when I actually thought about it more, I decided that's bullshit.
> "zram->disk" is not the backing device at all, it's the zram interface
> itself.
> 
> The correct resolution seems to be
> 
>     bio_set_dev(bio, zram->bdev);
> 
> but *dammit*, Jens, this insane crazy constant "let's randomly change
> block layer details around" needs to STOP.
> 
> This has been going on for too many releases by now. What the f*ck is
> *wrong* with you and Christoph that you can't just leave this thing
> alone?
> 
> Stop the pointless churn already.
> 
> When I saw your comment:
> 
>   It's a quiet series this round, which I think we needed after
>   the churn of the last few series.
> 
> I was like "finally". And then this shows that you were just lying,
> and the pointless churn is still happening.
> 
> Stop it. Really.
> 
> Here's a hint: if some stupid change requires you to mindlessly do 150
> changes using a wrapper helper, it's churn.
> 
> We need *stability* by now, after these crazy changes. Make sure that happens.

I am pushing back, but I can't embargo any sort of API change. This one has
good reasoning behind it, which is actually nicely explained in the commit
itself. It's not pointless churn, which I would define as change just for
the sake of change itself. Or pointless cleanups.

That said, there are no plans to mix anything up for the next release.
We've had more frivolous changes in past releases, I don't expect that
to happen again. 

-- 
Jens Axboe
