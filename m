Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 28 Feb 2017 11:54:41 -0500
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	NeilBrown <neilb@suse.de>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 0/13 v2] block: Fix block device shutdown related races
Message-ID: <20170228165441.GH15287@htj.duckdns.org>
References: <20170221170958.21845-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170221170958.21845-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hello,

It generally looks good to me.  The only worry I have is around
wb_shutdown() synchronization and if that is actually an issue it
shouldn't be too difficult to fix.  The other thing which came to mind
is that the congested->__bdi sever semantics.  IIRC, that one was also
to support the "bdi must go away now" behavior.  As bdi is refcnted
now, I think we can probably just let cong hold onto the bdi rather
than try to sever the ref there.

Thanks a lot for working on this!

-- 
tejun
