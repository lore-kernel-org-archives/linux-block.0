Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 23 Mar 2017 11:38:32 -0400
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Tahsin Erdogan <tahsin@google.com>,
	Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 02/11] block: Fix race of bdev open with gendisk shutdown
Message-ID: <20170323153832.GB3241@htj.duckdns.org>
References: <20170313151410.5586-1-jack@suse.cz>
 <20170313151410.5586-3-jack@suse.cz>
 <20170321161907.GB30919@htj.duckdns.org>
 <20170323002105.GB18402@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170323002105.GB18402@quack2.suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hello, Jan.

On Thu, Mar 23, 2017 at 01:21:05AM +0100, Jan Kara wrote:
> > * A bdi is the object which knows which request_queue it's associated
> >   and when that association dies.
> 
> So bdi is associated with a request_queue but it does not have any
> direct pointer or reference to it. It is the request_queue that points to
> bdi. However you are right that bdi_unregister() call is telling bdi that
> the device is going away.
> 
> > * bdev is permanently associated with a bdi.
> 
> Yes.
> 
> > So, it's kinda weird to look up the request_queue again on each open
> > and then verify that the bd_bdi and request_queue match.  I think it
> > would make more sense to skip disk look up and just go through bdi to
> > determine the associated request_queue as that's the primary nexus
> > object tying everything up now.
> 
> So I was thinking about this as well. The problem is that you cannot really
> keep a reference to request_queue (or gendisk) from block device inode or
> bdi as that could unexpectedly pin the driver in memory after user thinks
> everything should be cleaned up. So I think we really do have to establish
> the connection between block device inode and request_queue / gendisk on
> opening of the block device and drop the reference when the block device is
> closed.

Hmmm... but for bdi to be able to serve as the sever point, it must
know when it gets disassociated (del_gendisk) and be able to safely
clear its pointer and reject further access to the request_queue.  I
think we're trying to shift that synchronization to the open path but
no matter where we do that we have to do that anyway and it'll likely
be the more straight-forward to do it at the sever point.

Thanks.

-- 
tejun
