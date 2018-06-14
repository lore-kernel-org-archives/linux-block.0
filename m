Return-Path: <hare@suse.de>
Date: Thu, 14 Jun 2018 17:29:54 +0200
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Mel Gorman <mgorman@suse.com>, Hannes
 Reinecke <hare@suse.com>
Subject: Re: [PATCH] brd: Allow ramdisk to be allocated on selected NUMA
 node
Message-ID: <20180614172954.79965d13@pentland.suse.de>
In-Reply-To: <08318d74-d81c-29e5-5350-525df96eaacb@kernel.dk>
References: <20180614133832.110947-1-hare@suse.de>
	<08318d74-d81c-29e5-5350-525df96eaacb@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Thu, 14 Jun 2018 08:47:33 -0600
Jens Axboe <axboe@kernel.dk> wrote:

> On 6/14/18 7:38 AM, Hannes Reinecke wrote:
> > For performance reasons we should be able to allocate all memory
> > from a given NUMA node, so this patch adds a new parameter
> > 'rd_numa_node' to allow the user to specify the NUMA node id.
> > When restricing fio to use the same NUMA node I'm seeing a
> > performance boost of more than 200%.  
> 
> Looks fine to me. One comment.
> 
> > @@ -342,6 +343,10 @@ static int max_part = 1;
> >  module_param(max_part, int, 0444);
> >  MODULE_PARM_DESC(max_part, "Num Minors to reserve between
> > devices"); 
> > +static int rd_numa_node = NUMA_NO_NODE;
> > +module_param(rd_numa_node, int, 0444);
> > +MODULE_PARM_DESC(rd_numa_node, "NUMA node number to allocate RAM
> > disk on.");  
> 
> This could feasibly be 0644, as there would be nothing wrong with
> altering this at runtime.
> 

While we could it would not change the allocation of _existing_ ram
devices, making behaviour rather unpredictable.
Hence I did decide against it (and yes, I actually thought about it).

But if you insist ...

Cheers,

Hannes
