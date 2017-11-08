Return-Path: <hch@lst.de>
Date: Wed, 8 Nov 2017 09:54:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 4/5] nvme: implement multipath access to nvme subsystems
Message-ID: <20171108085417.GA19990@lst.de>
References: <20171102183034.9320-1-hch@lst.de> <20171102183034.9320-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171102183034.9320-5-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Can I get a review for this one?  The only changes vs the previously
reviewed versions is that we don't use the multipath code at all for
subsystems that aren't multiported, and that there is an explicit
opt-out at compile and module load time, so it shouldn't be that hard
to review for those who reviewed the previous versions.
