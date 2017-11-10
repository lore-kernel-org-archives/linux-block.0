Return-Path: <hch@lst.de>
Date: Fri, 10 Nov 2017 09:44:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: nvme multipath support V7
Message-ID: <20171110084420.GA4603@lst.de>
References: <20171109174450.17142-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171109174450.17142-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

I've updated the git tree with the Kconfig type fix, the instance
fixup from Keith (plus extensive comments explaning the issue) and
the various reviews.  I'll wait for the buildbot a and do a little
more manual testing and will send it to Jens in the afternoon.
