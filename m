Return-Path: <hch@lst.de>
Date: Tue, 29 May 2018 10:17:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 08/14] nvmet: implement the changed namespaces log
Message-ID: <20180529081712.GD1416@lst.de>
References: <20180526102735.31404-1-hch@lst.de> <20180526102735.31404-9-hch@lst.de> <20180528065342.hi74ewwbvkoqsj6x@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180528065342.hi74ewwbvkoqsj6x@linux-x5ow.site>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 28, 2018 at 08:53:42AM +0200, Johannes Thumshirn wrote:
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> 
> As a side note, what happens if more than 1024 Namespaces are changed
> (apart from setting the 1st element to 0xffffffff and zeroing out the
> rest)?
> 
> The Spec is pretty silent in this regard.

The spec is completly clear on this:

>From 5.14.1.4:

"If more than 1024 namespaces have changed attributes since the last time the
 log page was read, the first entry in the log page shall be set to FFFFFFFFh
 and the remainder of the list shall be zero-filled."

Once we don't know what changed we'll have to do a full rescan using
Identify.
