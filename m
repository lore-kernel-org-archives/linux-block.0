Return-Path: <lars.ellenberg@linbit.com>
Date: Mon, 4 Jul 2016 10:09:36 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Roland Kammerer <roland.kammerer@linbit.com>,
	"Alasdair G. Kergon" <agk@redhat.com>,
	Zdenek Kabelac <zkabelac@redhat.com>
Subject: Re: [PATCH 0/3] offload bios to a thread
Message-ID: <20160704080935.GM3239@soda.linbit>
References: <alpine.LRH.2.02.1606282014380.7298@file01.intranet.prod.int.rdu2.redhat.com>
 <20160630194023.GA21338@redhat.com>
 <20160630231518.GA22518@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160630231518.GA22518@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jun 30, 2016 at 07:15:18PM -0400, Mike Snitzer wrote:
> > Lars, please feel free to see if this set addresses the similar deadlock
> > you saw/fixed with drbd.

I'm pretty sure it will help, but will confirm.

> > We need to converge on an acceptable fix for
> > this problem -- preferably sooner rather than later!
> > 
> > Conversely, Mikulas: if you can easily reproduce the dm-snapshot
> > deadlock please try Lars' fix to see if it is workable for our DM needs.
> 
> I hadn't reviewed Lars' patch yet but Mikulas pointed out to me that
> Lars' patch is focused on the blk_queue_split() path -- and given that
> DM doesn't use this function (nor do DM devices even have a 'bio_split'
> bioset, see commit dbba42d8a9e) it won't fix the DM (snapshot) deadlock.

Don't you get it implicitly when using dm-mq -> blk-mq?

    Lars
	
