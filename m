Return-Path: <hch@lst.de>
Date: Mon, 28 May 2018 17:24:32 +0200
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
Subject: Re: [PATCH 03/14] nvme: return BLK_EH_DONE from ->timeout
Message-ID: <20180528152432.GA18796@lst.de>
References: <20180523121941.8632-1-hch@lst.de> <20180523121941.8632-4-hch@lst.de> <d17e44a1-8946-56df-a039-f4afa2be7329@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d17e44a1-8946-56df-a039-f4afa2be7329@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 23, 2018 at 03:27:35PM +0200, Hannes Reinecke wrote:
> Is there a way of _testing_ this patch?

Use the error injection framework Johannes wrote?  Use blktests
(but make sure you have a fixed version of test 011).

> It looks pretty dodgy, just replacing BLK_EH_HANDLED with 
> BLK_EH_NOT_HANDLED.
> And, as nothing else has changed, would imply that we can do it on 
> older/stable versions, too.
> Which means that the original code was buggy to start with.
> Hence a test here would be really beneficial.

NVMe always completed the requests itself, so not too much changed.
