Return-Path: <mpatocka@redhat.com>
Date: Mon, 4 Jul 2016 18:27:57 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
cc: Mike Snitzer <snitzer@redhat.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Roland Kammerer <roland.kammerer@linbit.com>,
        "Alasdair G. Kergon" <agk@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>
Subject: Re: [PATCH 0/3] offload bios to a thread
In-Reply-To: <20160704080935.GM3239@soda.linbit>
Message-ID: <alpine.LRH.2.02.1607041824110.16388@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1606282014380.7298@file01.intranet.prod.int.rdu2.redhat.com> <20160630194023.GA21338@redhat.com> <20160630231518.GA22518@redhat.com> <20160704080935.GM3239@soda.linbit>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>



On Mon, 4 Jul 2016, Lars Ellenberg wrote:

> On Thu, Jun 30, 2016 at 07:15:18PM -0400, Mike Snitzer wrote:
> > > Lars, please feel free to see if this set addresses the similar deadlock
> > > you saw/fixed with drbd.
> 
> I'm pretty sure it will help, but will confirm.
> 
> > > We need to converge on an acceptable fix for
> > > this problem -- preferably sooner rather than later!
> > > 
> > > Conversely, Mikulas: if you can easily reproduce the dm-snapshot
> > > deadlock please try Lars' fix to see if it is workable for our DM needs.
> > 
> > I hadn't reviewed Lars' patch yet but Mikulas pointed out to me that
> > Lars' patch is focused on the blk_queue_split() path -- and given that
> > DM doesn't use this function (nor do DM devices even have a 'bio_split'
> > bioset, see commit dbba42d8a9e) it won't fix the DM (snapshot) deadlock.
> 
> Don't you get it implicitly when using dm-mq -> blk-mq?
> 
>     Lars

There were observed deadlocks just between dm targets, caused by queuing 
bios on current->bio_list.

The underlying block device was not involved in the deadlocks. Therefore I 
conclude that changing the behavior of blk_queue_split would not resolve 
these deadlocks (because dm targets do not use blk_queue_split).

Mikulas
