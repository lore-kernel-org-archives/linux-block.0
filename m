Return-Path: <axboe@kernel.dk>
Date: Sun, 23 Apr 2017 16:58:25 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>
Cc: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>
Subject: Re: [PATCH 0/5] lightnvm: pblk extra patches for 4.12
Message-ID: <20170423225823.GA5767@kernel.dk>
References: <1492817569-13532-1-git-send-email-javier@cnexlabs.com>
 <49082c5d-963c-d463-3a84-206308d9bff2@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <49082c5d-963c-d463-3a84-206308d9bff2@lightnvm.io>
List-ID: <linux-block@vger.kernel.org>

On Sun, Apr 23 2017, Matias Bj�rling wrote:
> On 04/22/2017 01:32 AM, Javier Gonz�lez wrote:
> >Hi Matias,
> >
> >This is a couple of bug fixes for the pblk release patch.
> >
> >Thanks,
> >Javier
> >
> >Javier Gonz�lez (5):
> >  lightnvm: pblk: fix race condition on line retry
> >  lightnvm: pblk: fix bad error check
> >  lightnvm: pblk: fix memory leak on error path
> >  lightnvm: pblk: free metadata on line alloc failure
> >  lightnvm: pblk: fix erase counters on error fail
> >
> > drivers/lightnvm/pblk-core.c  | 60 ++++++++++++++++++++++++++-----------------
> > drivers/lightnvm/pblk-gc.c    |  2 +-
> > drivers/lightnvm/pblk-init.c  |  9 ++++---
> > drivers/lightnvm/pblk-map.c   |  4 +--
> > drivers/lightnvm/pblk-rl.c    |  6 +++--
> > drivers/lightnvm/pblk-write.c |  7 +++--
> > drivers/lightnvm/pblk.h       |  6 ++---
> > 7 files changed, 57 insertions(+), 37 deletions(-)
> >
> 
> Hi Jens,
> 
> Could you pick these up as well? This will properly be the last for
> the 4.12 window. Thank you!

Yep, added for 4.12, thanks.

-- 
Jens Axboe
