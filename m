Return-Path: <ming.lei@redhat.com>
Date: Sat, 6 Jan 2018 16:47:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH] mq-deadline: make it clear that __dd_dispatch_request()
 works on all hw queues
Message-ID: <20180106084707.GB27437@ming.t460p>
References: <2c4afe1c-fb16-0d48-7c5c-2b063a16dbd1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2c4afe1c-fb16-0d48-7c5c-2b063a16dbd1@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jan 05, 2018 at 02:56:38PM -0700, Jens Axboe wrote:
> Don't pass in the hardware queue to __dd_dispatch_request(), since it
> leads the reader to believe that we are returning a request for that
> specific hardware queue. That's not how mq-deadline works, the state
> for determining which request to serve next is shared across all
> hardware queues for a device.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming
