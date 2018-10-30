Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 09/14] blk-mq: ensure that plug lists don't straddle
 hardware queues
To: Ming Lei <ming.lei@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-10-axboe@kernel.dk>
 <1540841278.196084.84.camel@acm.org>
 <2e8ae405-6cc2-ce7b-a6a3-ca2e19549e40@kernel.dk>
 <32904af4-90b1-1762-5c46-4d52808cb601@kernel.dk>
 <20181030080856.GA13582@ming.t460p>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4ab88ae2-9b04-9ffb-a837-c1d386f3bb5c@kernel.dk>
Date: Tue, 30 Oct 2018 11:22:49 -0600
MIME-Version: 1.0
In-Reply-To: <20181030080856.GA13582@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/30/18 2:08 AM, Ming Lei wrote:
> Requests can be added to plug list from different ctx because of
> preemption. However, blk_mq_sched_insert_requests() requires that
> all requests in 'hctx_list' belong to same ctx. 

Yeah, I tried to get around it, but I think I'll just respin and keep
the 'ctx' argument to keep that perfectly clear. It'll work just fine
with different ctxs, but they will end up on a non-matching ctx which
isn't ideal.

-- 
Jens Axboe
