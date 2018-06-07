Return-Path: <hch@lst.de>
Date: Thu, 7 Jun 2018 13:24:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] blktrace: display failfast and driver-specific flags
Message-ID: <20180607112423.GB10742@lst.de>
References: <20180607083009.41793-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180607083009.41793-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

Good idea to display the flags, but the characters aren't really
very self-describing.  Should we prefix each with an f maybe?
