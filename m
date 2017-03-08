Return-Path: <jack@suse.cz>
Date: Wed, 8 Mar 2017 15:25:58 +0100
From: Jan Kara <jack@suse.cz>
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	NeilBrown <neilb@suse.de>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 02/11] block: Fix race of bdev open with gendisk shutdown
Message-ID: <20170308142558.GG19740@quack2.suse.cz>
References: <20170306163404.1238-1-jack@suse.cz>
 <20170306163404.1238-3-jack@suse.cz>
 <20170306220459.GJ26127@htj.duckdns.org>
 <20170307111420.GF2578@quack2.suse.cz>
 <20170307194349.GF31179@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170307194349.GF31179@htj.duckdns.org>
List-ID: <linux-block@vger.kernel.org>

On Tue 07-03-17 14:43:49, Tejun Heo wrote:
> Hello,
> 
> On Tue, Mar 07, 2017 at 12:14:20PM +0100, Jan Kara wrote:
> > > Given that this isn't a super hot path, I think it'd be far better to
> > > stick to a simpler synchronization mechanism.
> > 
> > I'd be happy to do so however struct gendisk does not have any lock in it
> > and introducing a special lock just for that seems awkward.
> 
> I think even a awkward shared lock is better than memory barriers.
> Barriers are the trickiest locking construct to get right and we
> really shouldn't using that unless absolutely necessary.

OK, I'll try to come up with something.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
