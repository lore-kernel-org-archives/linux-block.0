Return-Path: <keith.busch@linux.intel.com>
Date: Mon, 4 Jun 2018 13:59:09 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 13/14] nvme: use the changed namespaces list log to clear
 ns data changed AENs
Message-ID: <20180604195908.GC8205@localhost.localdomain>
References: <20180526102735.31404-1-hch@lst.de>
 <20180526102735.31404-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180526102735.31404-14-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Sat, May 26, 2018 at 12:27:34PM +0200, Christoph Hellwig wrote:
> Per section 5.2 we need to issue the corresponding log page to clear an
> AEN, so for a namespace data changed AEN we need to read the changed
> namespace list log.  And once we read that log anyway we might as well
> use it to optimize the rescan.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I'm a little concerned about this. Userspace might be reading the same
log page. Since the contents of the page may change each time its read,
it's possible the driver will see only a subset of changed namespaces
at the point it gets to read the log page, missing a chance to
revalidate others.
