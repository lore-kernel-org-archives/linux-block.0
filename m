Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 1 Mar 2017 11:26:32 -0500
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	NeilBrown <neilb@suse.de>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 0/13 v2] block: Fix block device shutdown related races
Message-ID: <20170301162632.GA3662@htj.duckdns.org>
References: <20170221170958.21845-1-jack@suse.cz>
 <20170228165441.GH15287@htj.duckdns.org>
 <20170301153700.GJ20512@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170301153700.GJ20512@quack2.suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hello, Jan.

On Wed, Mar 01, 2017 at 04:37:00PM +0100, Jan Kara wrote:
> > The other thing which came to mind is that the congested->__bdi sever
> > semantics.  IIRC, that one was also to support the "bdi must go away now"
> > behavior.  As bdi is refcnted now, I think we can probably just let cong
> > hold onto the bdi rather than try to sever the ref there.
> 
> So currently I get away with __bdi not being a proper refcounted reference.
> If we were to remove the clearing of __bdi, we'd have to make it into
> refcounted reference which is sligthly ugly as we need to special-case
> embedded bdi_writeback_congested structures. Maybe it will be a worthwhile
> cleanup but for now I left it alone...

Yeah, absolutely, it's an additional step that we can take later.
Nothing urgent.

Thanks.

-- 
tejun
