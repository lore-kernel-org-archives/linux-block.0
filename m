Return-Path: <keith.busch@linux.intel.com>
Date: Tue, 22 May 2018 09:17:57 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Message-ID: <20180522151757.GB8295@localhost.localdomain>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com>
 <20180522024910.GD20430@ming.t460p>
 <20180522142030.GR5528@localhost.localdomain>
 <CACVXFVNT5qiamN0ydXzNYDWE0szi2fTsAAmyG9Q884LEqUhSdQ@mail.gmail.com>
 <20180522144636.GS5528@localhost.localdomain>
 <CACVXFVNWK-r6FrsNOmmETZXf9MLPQUNR3Nmf_hmDgaOUivpbYQ@mail.gmail.com>
 <20180522150119.GA8295@localhost.localdomain>
 <CACVXFVO5sujPWiAJJgA6E=Exmb1c8FTyN-7+YEvNQ+0c_Psh8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVO5sujPWiAJJgA6E=Exmb1c8FTyN-7+YEvNQ+0c_Psh8w@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 11:07:07PM +0800, Ming Lei wrote:
> > At approximately the same time, you're saying the driver that returned
> > EH_HANDLED may then call blk_mq_complete_request() in reference to the
> > *old* request that it returned EH_HANDLED for, incorrectly completing
> 
> Because this request has been completed above by blk-mq timeout,
> then this old request won't be completed any more via blk_mq_complete_request()
> either from normal path or what ever, such as cancel.
 
> > the new request before it is done. That will inevitably lead to data
> > corruption. Is that happening today in any driver?
> 
> No such issue since current blk-mq makes sure one req is only completed
> once, but your patch changes to depend on driver to make sure that.

The blk-mq timeout complete makes the request available for allocation
as a new command, at which point blk_mq_complete_request can be called
again. If a driver is somehow relying on blk-mq to prevent a double
completion for a previously completed request context, they're already
in a lot of trouble.
