Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 12/17] blk-mq-sched: export way for drivers to insert
 request
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org
References: <20181011165909.32615-1-axboe@kernel.dk>
 <20181011165909.32615-13-axboe@kernel.dk>
 <20181014184935.GA1944@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8fcbef11-84a4-80a8-2fc0-e11b5db55721@kernel.dk>
Date: Sun, 14 Oct 2018 12:56:17 -0600
MIME-Version: 1.0
In-Reply-To: <20181014184935.GA1944@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/14/18 12:49 PM, Christoph Hellwig wrote:
> On Thu, Oct 11, 2018 at 10:59:04AM -0600, Jens Axboe wrote:
>> We'll need this for the IDE conversion, which queues sense requests.
> 
> Why can't the ide code use blk_execute_rq_nowait?

Yeah it can, I made that change and dropped this patch.

-- 
Jens Axboe
