Return-Path: <hch@lst.de>
Date: Wed, 16 May 2018 19:31:58 +0200
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"israelr@mellanox.com" <israelr@mellanox.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"sebott@linux.ibm.com" <sebott@linux.ibm.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"maxg@mellanox.com" <maxg@mellanox.com>,
	"tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH v9 2/2] blk-mq: Rework blk-mq timeout handling again
Message-ID: <20180516173158.GA6022@lst.de>
References: <20180515225124.20428-1-bart.vanassche@wdc.com> <20180515225124.20428-6-bart.vanassche@wdc.com> <20180516125110.GA32078@lst.de> <8058d72fef475caffa78c962bc4220f5f8fa3dde.camel@wdc.com> <20180516162432.GA4398@lst.de> <bd17181940994eb459e84e4d5940b1af8a725ded.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bd17181940994eb459e84e4d5940b1af8a725ded.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 16, 2018 at 04:47:54PM +0000, Bart Van Assche wrote:
> I think your patch changes the order of changing the request state and
> calling mod_timer(). In my patch the request state and the deadline are
> updated first and mod_timer() is called afterwards. I think your patch
> changes the order of these operations into the following:
> (1) __blk_mq_start_request() sets the request deadline.
> (2) __blk_mq_start_request() calls __blk_add_timer() which in turn calls
>     mod_timer().
> (3) __blk_mq_start_request() changes the request state into MQ_RQ_IN_FLIGHT.
> 
> In the unlikely event of a significant delay between (2) and (3) it can
> happen that the timer fires and examines and ignores the request because
> its state differs from MQ_RQ_IN_FLIGHT. If the request for which this
> happened times out its timeout will only be handled the next time
> blk_mq_timeout_work() is called. Is this the behavior you intended?

We can move the timer manipulation after the change easily I think.
It would make sense to add comments explaining the ordering.
