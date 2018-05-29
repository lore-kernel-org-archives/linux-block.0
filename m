Return-Path: <hch@lst.de>
Date: Tue, 29 May 2018 10:13:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 06/14] nvmet: add a new nvmet_zero_sgl helper
Message-ID: <20180529081319.GC1416@lst.de>
References: <20180526102735.31404-1-hch@lst.de> <20180526102735.31404-7-hch@lst.de> <20180528063656.i4adgrkbqmrtzaeh@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180528063656.i4adgrkbqmrtzaeh@linux-x5ow.site>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 28, 2018 at 08:36:56AM +0200, Johannes Thumshirn wrote:
> Don't we already have this? Or is it a re-send? It looks so awefully familiar to me...

It was part of my ANA series, like many changes in this series.
