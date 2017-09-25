Return-Path: <hch@lst.de>
Date: Mon, 25 Sep 2017 18:19:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 7/9] nvme: track shared namespaces
Message-ID: <20170925161939.GA12952@lst.de>
References: <20170925134031.10548-1-hch@lst.de> <20170925134031.10548-8-hch@lst.de> <20170925161155.GC8463@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170925161155.GC8463@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 25, 2017 at 10:11:55AM -0600, Keith Busch wrote:
> Looks good; I can live with 'nvme_ns_head'.

I hate it :)  But so far no one has come up with a good name.
