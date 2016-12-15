Return-Path: <BATV+337c622ab1ce6acfb71b+4862+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 15 Dec 2016 00:45:53 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Stefan Haberland <sth@linux.vnet.ibm.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	hoeppner@linux.vnet.ibm.com, sebott@linux.vnet.ibm.com
Subject: Re: [RFC] block: check partition alignment
Message-ID: <20161215084553.GA19716@infradead.org>
References: <20161214164706.45543-1-sth@linux.vnet.ibm.com>
 <20161214170719.GA3599@infradead.org>
 <5824c17b-a7d7-60a1-6bb7-287257aaf67a@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5824c17b-a7d7-60a1-6bb7-287257aaf67a@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Dec 15, 2016 at 10:33:47AM +0900, Damien Le Moal wrote:
> For a regular block device, I agree. But in Stephan case, I think that
> the check really needs to be against the physical block size, with the
> added condition that the bdev is a DASD device (similarly to the zone
> alignment check for zoned block devices).

Then they need to expose a chunk_size.  physical block size is defined
as not having a meaning for the kernel.
