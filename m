Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v11 0/8] blk-mq: Implement runtime power management
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20180926210110.20362-1-bvanassche@acm.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3cc2cde0-150d-c3d7-aed4-5db7909b39c3@kernel.dk>
Date: Wed, 26 Sep 2018 15:12:05 -0600
MIME-Version: 1.0
In-Reply-To: <20180926210110.20362-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/26/18 3:01 PM, Bart Van Assche wrote:
> Hello Jens,
> 
> One of the pieces that is missing before blk-mq can be made the default
> is implementing runtime power management support for blk-mq.  This patch
> series not only implements runtime power management for blk-mq but also
> fixes a starvation issue in the power management code for the legacy
> block layer. Please consider this patch series for the upstream kernel.

Thanks Bart, applied for 4.20.

-- 
Jens Axboe
