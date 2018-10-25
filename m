Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 23/28] block: kill lld busy
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-24-axboe@kernel.dk> <1540503738.66186.63.camel@acm.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <08581975-c2df-fa1e-34f2-7183bc2cfb8b@kernel.dk>
Date: Thu, 25 Oct 2018 16:18:56 -0600
MIME-Version: 1.0
In-Reply-To: <1540503738.66186.63.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 3:42 PM, Bart Van Assche wrote:
> On Thu, 2018-10-25 at 15:10 -0600, Jens Axboe wrote:
>> Nobody sets the helper, so we always return 0. Kill it.
> 
> How about changing the description of this patch into something
> like "Now that the blk_lld_busy() and blk_queue_lld_busy() callers
> have been removed, also remove the implementations of these functions."?

Sure, I can improve the commit message.

-- 
Jens Axboe
