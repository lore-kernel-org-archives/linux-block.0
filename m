Return-Path: <keith.busch@linux.intel.com>
Date: Tue, 22 May 2018 09:01:19 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Message-ID: <20180522150119.GA8295@localhost.localdomain>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com>
 <20180522024910.GD20430@ming.t460p>
 <20180522142030.GR5528@localhost.localdomain>
 <CACVXFVNT5qiamN0ydXzNYDWE0szi2fTsAAmyG9Q884LEqUhSdQ@mail.gmail.com>
 <20180522144636.GS5528@localhost.localdomain>
 <CACVXFVNWK-r6FrsNOmmETZXf9MLPQUNR3Nmf_hmDgaOUivpbYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVNWK-r6FrsNOmmETZXf9MLPQUNR3Nmf_hmDgaOUivpbYQ@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 10:57:40PM +0800, Ming Lei wrote:
> OK, that still depends on driver's behaviour, even though it is true
> for NVMe,  you still have to audit other drivers about this sync
> because it is required by your patch.

Okay, forget about nvme for a moment here. Please run this thought
experiment to decide if what you're saying is even plausible for any
block driver with the existing implementation:

Your scenario has a driver return EH_HANDLED for a timed out request. The
timeout work then completes the request. The request may then be
reallocated for a new command and dispatched.

At approximately the same time, you're saying the driver that returned
EH_HANDLED may then call blk_mq_complete_request() in reference to the
*old* request that it returned EH_HANDLED for, incorrectly completing
the new request before it is done. That will inevitably lead to data
corruption. Is that happening today in any driver?
