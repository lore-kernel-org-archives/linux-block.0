Return-Path: <hch@lst.de>
Date: Wed, 20 Sep 2017 16:55:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: nvme multipath support V2
Message-ID: <20170920145546.GB4709@lst.de>
References: <20170918231453.27128-1-hch@lst.de> <20170920110959.hwvujtis6ywnbb5p@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170920110959.hwvujtis6ywnbb5p@linux-x5ow.site>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 20, 2017 at 01:09:59PM +0200, Johannes Thumshirn wrote:
> Using your patchset and doing the sanme double connect trick I get the same
> two block devices of cause.
> 
> How do I connect using both paths?

Same as above.  But now in addition to the /dev/nvmeXnY devices you
should also see a /dev/nvme/nsZ device.  The sysfs entry for it shows
which paths it belongs to.
