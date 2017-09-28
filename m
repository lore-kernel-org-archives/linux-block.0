Return-Path: <keith.busch@intel.com>
Date: Thu, 28 Sep 2017 09:53:16 -0600
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 8/9] nvme: implement multipath access to nvme subsystems
Message-ID: <20170928155315.GK8463@localhost.localdomain>
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170925134031.10548-9-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 25, 2017 at 03:40:30PM +0200, Christoph Hellwig wrote:
> The new block devices nodes for multipath access will show up as
> 
> 	/dev/nvm-subXnZ

Just thinking ahead ... Once this goes in, someone will want to boot their
OS from a multipath target. It was a pain getting installers to recognize
/dev/nvmeXnY as an install destination. I'm not sure if installers have
gotten any better in the last 5 years about recognizing new block names.
