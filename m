Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v10 0/8] blk-mq: Implement runtime power management
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Tejun Heo <tj@kernel.org>
References: <20180921203122.49743-1-bvanassche@acm.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d5bfdeec-8fa1-b81c-7032-90121edb5f65@kernel.dk>
Date: Fri, 21 Sep 2018 20:32:34 -0600
MIME-Version: 1.0
In-Reply-To: <20180921203122.49743-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/21/18 2:31 PM, Bart Van Assche wrote:
> Hello Jens,
> 
> One of the pieces that is missing before blk-mq can be made the default is
> implementing runtime power management support for blk-mq.  This patch series
> not only implements runtime power management for blk-mq but also fixes a
> starvation issue in the power management code for the legacy block
> layer. Please consider this patch series for the upstream kernel.

I think we're getting really close on this one, but I really want
Tejun to review 5/8.

-- 
Jens Axboe
