Return-Path: <msnitzer@redhat.com>
Date: Tue, 24 Oct 2017 17:40:00 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 06/17] block: introduce GENHD_FL_HIDDEN
Message-ID: <20171024213959.GB23307@redhat.com>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171023145126.2471-7-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 23 2017 at 10:51am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> With this flag a driver can create a gendisk that can be used for I/O
> submission inside the kernel, but which is not registered as user
> facing block device.  This will be useful for the NVMe multipath
> implementation.

Having the NVme driver go to such lengths to hide its resources from
upper layers is certainly the work of an evil genius experiencing some
serious territorial issues.  Not sugar-coating it.. you wouldn't.

I kept meaning to reply to your earlier iterations on this series to
ask: can we please get a CONFIG_NVME_MULTIPATHING knob to make it so
that the NVMe driver doesn't implicitly consume (and hide) all
per-controler devices?

Ah well.  There is only one correct way to do NVMe multipathing after
all right?
