Return-Path: <keith.busch@intel.com>
Date: Tue, 22 May 2018 14:44:13 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"sebott@linux.ibm.com" <sebott@linux.ibm.com>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"maxg@mellanox.com" <maxg@mellanox.com>,
	"tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH v13] blk-mq: Rework blk-mq timeout handling again
Message-ID: <20180522204412.GB9005@localhost.localdomain>
References: <20180522162515.20650-1-bart.vanassche@wdc.com>
 <20180522203349.GB8961@localhost.localdomain>
 <632c16e5c06edb13c93d61f9164584da470d8a24.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <632c16e5c06edb13c93d61f9164584da470d8a24.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 08:36:27PM +0000, Bart Van Assche wrote:
> 
> Have you noticed that if blk_mq_complete_request() encounters a request with
> state MQ_RQ_TIMED_OUT that it doesn't call __blk_mq_complete_request()? I think
> the code in blk_mq_complete_request() together with the above code guarantees
> that __blk_mq_complete_request() is only called once per request generation.

Okay, now to the BLK_EH_NOT_HANDLED case: that's supposedly the correct
status to return if the driver knows blk_mq_complete_request() was called
prior to returning from the timeout handler, so we need a similiar check
there, right?
