Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 05/14] blk-mq: allow software queue to map to multiple
 hardware queues
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-6-axboe@kernel.dk> <1540834474.196084.64.camel@acm.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d1a8f544-0c38-c002-f61f-bf2a104040ca@kernel.dk>
Date: Mon, 29 Oct 2018 11:35:45 -0600
MIME-Version: 1.0
In-Reply-To: <1540834474.196084.64.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On 10/29/18 11:34 AM, Bart Van Assche wrote:
> On Mon, 2018-10-29 at 10:37 -0600, Jens Axboe wrote:
>> The mapping used to be dependent on just the CPU location, but
>> now it's a tuple of { type, cpu} instead. This is a prep patch
>> for allowing a single software queue to map to multiple hardware
>> queues. No functional changes in this patch.
> 
> A nitpick: mathematicians usually use the { } notation for sets and () for
> tuples. See also https://en.wikipedia.org/wiki/Tuple.

Alright :-)

>> +		/* wrap */
>> +		BUG_ON(!hctx->nr_ctx);
> 
> Another nitpick: how about changing the "wrap" comment into "detect integer
> overflow" or so to make the purpose of the BUG_ON() statement more clear?

Sure, I'll improve that one too.

-- 
Jens Axboe
