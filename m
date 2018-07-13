Return-Path: <keith.busch@linux.intel.com>
Date: Fri, 13 Jul 2018 09:43:46 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"keith.busch@intel.com" <keith.busch@intel.com>,
	"hch@lst.de" <hch@lst.de>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Message-ID: <20180713154346.GA18955@localhost.localdomain>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com>
 <c42d13289e38df93bb35e9876b803420e40b03d3.camel@wdc.com>
 <20180712192437.GA16839@localhost.localdomain>
 <7cad25b821c3a640e036f28ff1bbe51e7362d25d.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7cad25b821c3a640e036f28ff1bbe51e7362d25d.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jul 12, 2018 at 10:24:42PM +0000, Bart Van Assche wrote:
> Before commit 12f5b9314545 ("blk-mq: Remove generation seqeunce"), if a
> request completion was reported after request timeout processing had
> started, completion handling was skipped. The following code in
> blk_mq_complete_request() realized that:
> 
> 	if (blk_mq_rq_aborted_gstate(rq) != rq->gstate)
> 		__blk_mq_complete_request(rq);
> 
> Since commit 12f5b9314545, if a completion occurs after request timeout
> processing has started, that completion is processed if the request has the
> state MQ_RQ_IN_FLIGHT. blk_mq_rq_timed_out() does not modify the request
> state unless the block driver timeout handler modifies it, e.g. by calling
> blk_mq_end_request() or by calling blk_mq_requeue_request(). The typical
> behavior of scsi_times_out() is to queue sending of a SCSI abort and hence
> not to change the request state immediately. In other words, if a request
> completion occurs during or shortly after a timeout occurred then
> blk_mq_complete_request() will call __blk_mq_complete_request() and will
> complete the request, although that is not allowed because timeout handling
> has already started. Do you agree with this analysis?

Yes, it's different, and that was the whole point. No one made that a
secret either. Are you saying you want timeout software to take priority
over handling hardware events?
