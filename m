Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180522150119.GA8295@localhost.localdomain>
References: <20180521231131.6685-1-keith.busch@intel.com> <20180521231131.6685-4-keith.busch@intel.com>
 <20180522024910.GD20430@ming.t460p> <20180522142030.GR5528@localhost.localdomain>
 <CACVXFVNT5qiamN0ydXzNYDWE0szi2fTsAAmyG9Q884LEqUhSdQ@mail.gmail.com>
 <20180522144636.GS5528@localhost.localdomain> <CACVXFVNWK-r6FrsNOmmETZXf9MLPQUNR3Nmf_hmDgaOUivpbYQ@mail.gmail.com>
 <20180522150119.GA8295@localhost.localdomain>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 22 May 2018 23:07:07 +0800
Message-ID: <CACVXFVO5sujPWiAJJgA6E=Exmb1c8FTyN-7+YEvNQ+0c_Psh8w@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
To: Keith Busch <keith.busch@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	linux-nvme <linux-nvme@lists.infradead.org>, Ming Lei <ming.lei@redhat.com>,
	Keith Busch <keith.busch@intel.com>, Bart Van Assche <bart.vanassche@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 11:01 PM, Keith Busch
<keith.busch@linux.intel.com> wrote:
> On Tue, May 22, 2018 at 10:57:40PM +0800, Ming Lei wrote:
>> OK, that still depends on driver's behaviour, even though it is true
>> for NVMe,  you still have to audit other drivers about this sync
>> because it is required by your patch.
>
> Okay, forget about nvme for a moment here. Please run this thought
> experiment to decide if what you're saying is even plausible for any
> block driver with the existing implementation:
>
> Your scenario has a driver return EH_HANDLED for a timed out request. The
> timeout work then completes the request. The request may then be
> reallocated for a new command and dispatched.

Yes.

>
> At approximately the same time, you're saying the driver that returned
> EH_HANDLED may then call blk_mq_complete_request() in reference to the
> *old* request that it returned EH_HANDLED for, incorrectly completing

Because this request has been completed above by blk-mq timeout,
then this old request won't be completed any more via blk_mq_complete_request()
either from normal path or what ever, such as cancel.

> the new request before it is done. That will inevitably lead to data
> corruption. Is that happening today in any driver?

No such issue since current blk-mq makes sure one req is only completed
once, but your patch changes to depend on driver to make sure that.


thanks,
Ming Lei
