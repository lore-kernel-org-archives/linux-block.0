Return-Path: <rsalvaterra@gmail.com>
MIME-Version: 1.0
References: <CALjTZvapU2xc84D7Nqjk+vrF35cAOPzDTd6dRaXpuO=Lcap5Sg@mail.gmail.com>
 <20181026062743.GA21483@ming.t460p> <CALjTZvaAc1HBXWHuhaCMsWwJLZEvPy_gvX2U2Lzcj6iVVktWNQ@mail.gmail.com>
 <20181028010156.GB26731@ming.t460p>
In-Reply-To: <20181028010156.GB26731@ming.t460p>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Sun, 28 Oct 2018 08:53:03 +0000
Message-ID: <CALjTZvZtmTCvLQph95rNQk73L23h=1QaODny_ZOf9F1MjcsMFQ@mail.gmail.com>
Subject: Re: Bug: swap discard issue with zram caused by "block: don't deal
 with discard limit in blkdev_issue_discard()"
To: ming.lei@redhat.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Sun, 28 Oct 2018 at 01:02, Ming Lei <ming.lei@redhat.com> wrote:
>
> On Fri, Oct 26, 2018 at 08:50:20AM +0100, Rui Salvaterra wrote:
> > On Fri, 26 Oct 2018 at 07:27, Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > The patch titled with 'block: make sure discard bio is aligned with l=
ogical block size'
> > > in the list may fix this issue, please test and see if it works.
> > >
> > > Thanks,
> > > Ming
> >
> > Hi, Ming,
> >
> > Thanks for the quick reply. Unfortunately, it doesn't seem to apply
> > cleanly to 4.19. To which tree/tag/commit should I apply the series?
>
> The whole patchset is against linus tree (44786880df196a4200).
>
> I am sure that the 1st patch can be applied cleanly against v4.19, and
> it is enough for fixing this issue, please double check.
>
> [ming@ming linux]$ git log --oneline -1
> 84df9525b0c2 Linux 4.19
> [ming@ming linux]$ git am ~/emails/blk/181026\ \[PATCH\ 1=E2=88=953\]\ bl=
ock\:\ make\ sure\ discard\ bio\ is\ aligned\ with\ logical\ block\ size.em=
l
> Applying: block: make sure discard bio is aligned with logical block size
> [ming@ming linux]$
>
>
> Thanks,
> Ming

Hi, Ming,

You're, right, of course. I had reverted the aforementioned commit, so
the patch set obviously wouldn't apply anymore. After checking out
v4.19 again, everything went smoothly. I confirm the patch set fixes
the issue for me, which means this series is

Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>

Thanks again,

Rui
