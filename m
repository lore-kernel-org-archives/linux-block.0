Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 7 Mar 2017 14:43:49 -0500
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	NeilBrown <neilb@suse.de>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 02/11] block: Fix race of bdev open with gendisk shutdown
Message-ID: <20170307194349.GF31179@htj.duckdns.org>
References: <20170306163404.1238-1-jack@suse.cz>
 <20170306163404.1238-3-jack@suse.cz>
 <20170306220459.GJ26127@htj.duckdns.org>
 <20170307111420.GF2578@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170307111420.GF2578@quack2.suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Tue, Mar 07, 2017 at 12:14:20PM +0100, Jan Kara wrote:
> > Given that this isn't a super hot path, I think it'd be far better to
> > stick to a simpler synchronization mechanism.
> 
> I'd be happy to do so however struct gendisk does not have any lock in it
> and introducing a special lock just for that seems awkward.

I think even a awkward shared lock is better than memory barriers.
Barriers are the trickiest locking construct to get right and we
really shouldn't using that unless absolutely necessary.

Thanks.

-- 
tejun
