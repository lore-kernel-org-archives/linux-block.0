Return-Path: <hch@lst.de>
Date: Mon, 28 May 2018 17:25:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>, Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>, Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	Rafael David Tinoco <rafael.tinoco@canonical.com>,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 04/14] nbd: complete requests from ->timeout
Message-ID: <20180528152536.GB18796@lst.de>
References: <20180523121941.8632-1-hch@lst.de> <20180523121941.8632-5-hch@lst.de> <b0303d04-322a-e64f-7465-225e9fdc833a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b0303d04-322a-e64f-7465-225e9fdc833a@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 23, 2018 at 03:28:38PM +0200, Hannes Reinecke wrote:
> Again, some testcase would be nice ...

For this one I don't have an actual test case.  I'll have to defer
to the nbd maintainers for that.
