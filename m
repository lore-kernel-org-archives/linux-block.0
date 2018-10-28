Return-Path: <ming.lei@redhat.com>
Date: Sun, 28 Oct 2018 09:01:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Bug: swap discard issue with zram caused by "block: don't deal
 with discard limit in blkdev_issue_discard()"
Message-ID: <20181028010156.GB26731@ming.t460p>
References: <CALjTZvapU2xc84D7Nqjk+vrF35cAOPzDTd6dRaXpuO=Lcap5Sg@mail.gmail.com>
 <20181026062743.GA21483@ming.t460p>
 <CALjTZvaAc1HBXWHuhaCMsWwJLZEvPy_gvX2U2Lzcj6iVVktWNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CALjTZvaAc1HBXWHuhaCMsWwJLZEvPy_gvX2U2Lzcj6iVVktWNQ@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 26, 2018 at 08:50:20AM +0100, Rui Salvaterra wrote:
> On Fri, 26 Oct 2018 at 07:27, Ming Lei <ming.lei@redhat.com> wrote:
> >
> > The patch titled with 'block: make sure discard bio is aligned with logical block size'
> > in the list may fix this issue, please test and see if it works.
> >
> > Thanks,
> > Ming
> 
> Hi, Ming,
> 
> Thanks for the quick reply. Unfortunately, it doesn't seem to apply
> cleanly to 4.19. To which tree/tag/commit should I apply the series?

The whole patchset is against linus tree (44786880df196a4200).

I am sure that the 1st patch can be applied cleanly against v4.19, and
it is enough for fixing this issue, please double check.

[ming@ming linux]$ git log --oneline -1
84df9525b0c2 Linux 4.19
[ming@ming linux]$ git am ~/emails/blk/181026\ \[PATCH\ 1∕3\]\ block\:\ make\ sure\ discard\ bio\ is\ aligned\ with\ logical\ block\ size.eml
Applying: block: make sure discard bio is aligned with logical block size
[ming@ming linux]$ 


Thanks,
Ming
