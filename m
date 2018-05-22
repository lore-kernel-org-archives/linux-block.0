Return-Path: <hch@lst.de>
Date: Tue, 22 May 2018 23:02:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Tejun Heo <tj@kernel.org>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Sebastian Ott <sebott@linux.ibm.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v13] blk-mq: Rework blk-mq timeout handling again
Message-ID: <20180522210208.GA25444@lst.de>
References: <20180522162515.20650-1-bart.vanassche@wdc.com> <bc1946d4-7627-3885-68c9-5db6c13b585c@kernel.dk> <fee466b8-8e39-adc6-efa4-e50ffa60a663@kernel.dk> <448d63e9-cfcd-0bc8-abf3-30296590f1d6@kernel.dk> <cd0693cc-a56d-665c-bc14-7e2653b91cb0@kernel.dk> <e414a6f8-79a9-0faa-e186-beb3b528acd5@kernel.dk> <20180522202657.GA8961@localhost.localdomain> <ae9b2c1e-c132-3f0c-b63b-1867d28d14c3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ae9b2c1e-c132-3f0c-b63b-1867d28d14c3@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 02:29:21PM -0600, Jens Axboe wrote:
> > of BLK_EH_HANDLED. Is the driver supposed to return BLK_EH_NOT_HANDLED
> > when the driver actually knows the request has been completed before
> > returning the status?
> 
> If the driver knows it's completed, it'd have to return BLK_EH_NOT_HANDLED.
> Or BLK_EH_HANDLED would work too, since the above state transition would
> then fail.

Btw, I think we should just kill off BLK_EH_HANDLED.  WIP totally
untested progress toward that is here:

http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-eh-ret

The only real missing bit is SCSI overloading the value for internal
use.
