Return-Path: <rsalvaterra@gmail.com>
MIME-Version: 1.0
References: <CALjTZvapU2xc84D7Nqjk+vrF35cAOPzDTd6dRaXpuO=Lcap5Sg@mail.gmail.com>
 <20181026062743.GA21483@ming.t460p>
In-Reply-To: <20181026062743.GA21483@ming.t460p>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Fri, 26 Oct 2018 08:50:20 +0100
Message-ID: <CALjTZvaAc1HBXWHuhaCMsWwJLZEvPy_gvX2U2Lzcj6iVVktWNQ@mail.gmail.com>
Subject: Re: Bug: swap discard issue with zram caused by "block: don't deal
 with discard limit in blkdev_issue_discard()"
To: ming.lei@redhat.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, 26 Oct 2018 at 07:27, Ming Lei <ming.lei@redhat.com> wrote:
>
> The patch titled with 'block: make sure discard bio is aligned with logical block size'
> in the list may fix this issue, please test and see if it works.
>
> Thanks,
> Ming

Hi, Ming,

Thanks for the quick reply. Unfortunately, it doesn't seem to apply
cleanly to 4.19. To which tree/tag/commit should I apply the series?

Thanks,

Rui
