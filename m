Return-Path: <jack@suse.cz>
Date: Wed, 1 Mar 2017 16:37:00 +0100
From: Jan Kara <jack@suse.cz>
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	NeilBrown <neilb@suse.de>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 0/13 v2] block: Fix block device shutdown related races
Message-ID: <20170301153700.GJ20512@quack2.suse.cz>
References: <20170221170958.21845-1-jack@suse.cz>
 <20170228165441.GH15287@htj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170228165441.GH15287@htj.duckdns.org>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Tue 28-02-17 11:54:41, Tejun Heo wrote:
> It generally looks good to me.

Thanks for review!

> The only worry I have is around wb_shutdown() synchronization and if that
> is actually an issue it shouldn't be too difficult to fix.

Yeah, I'll have a look at that.

> The other thing which came to mind is that the congested->__bdi sever
> semantics.  IIRC, that one was also to support the "bdi must go away now"
> behavior.  As bdi is refcnted now, I think we can probably just let cong
> hold onto the bdi rather than try to sever the ref there.

So currently I get away with __bdi not being a proper refcounted reference.
If we were to remove the clearing of __bdi, we'd have to make it into
refcounted reference which is sligthly ugly as we need to special-case
embedded bdi_writeback_congested structures. Maybe it will be a worthwhile
cleanup but for now I left it alone...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
