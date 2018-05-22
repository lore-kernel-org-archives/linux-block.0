Return-Path: <keith.busch@intel.com>
Date: Tue, 22 May 2018 14:26:58 -0600
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Sebastian Ott <sebott@linux.ibm.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v13] blk-mq: Rework blk-mq timeout handling again
Message-ID: <20180522202657.GA8961@localhost.localdomain>
References: <20180522162515.20650-1-bart.vanassche@wdc.com>
 <bc1946d4-7627-3885-68c9-5db6c13b585c@kernel.dk>
 <fee466b8-8e39-adc6-efa4-e50ffa60a663@kernel.dk>
 <448d63e9-cfcd-0bc8-abf3-30296590f1d6@kernel.dk>
 <cd0693cc-a56d-665c-bc14-7e2653b91cb0@kernel.dk>
 <e414a6f8-79a9-0faa-e186-beb3b528acd5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e414a6f8-79a9-0faa-e186-beb3b528acd5@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 01:38:06PM -0600, Jens Axboe wrote:
> I guess it would be cleaner to actually do the transition, in
> blk_mq_rq_timed_out():
> 
>         case BLK_EH_HANDLED:                                                    
>                 if (blk_mq_change_rq_state(req, MQ_RQ_TIMED_OUT,                
>                                                 MQ_RQ_COMPLETE))                
>                         __blk_mq_complete_request(req);                         
>                 break;        
> 
> This works for me.

Works for me as well on manual fault injection tests.

I think this change above goes back to Christoph's point earlier on usage
of BLK_EH_HANDLED. Is the driver supposed to return BLK_EH_NOT_HANDLED
when the driver actually knows the request has been completed before
returning the status?
