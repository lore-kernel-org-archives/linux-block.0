Return-Path: <axboe@kernel.dk>
Date: Wed, 28 Feb 2018 12:08:29 -0700
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v5 0/6] Fix races between blkcg code and request queue
 initialization and cleanup
Message-ID: <20180228190824.GA10814@kernel.dk>
References: <20180228181533.29402-1-bart.vanassche@wdc.com>
 <5fe43ee3-2982-6d6d-2461-519fa02d00cd@kernel.dk>
 <1519844492.2777.11.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519844492.2777.11.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 28 2018, Bart Van Assche wrote:
> On Wed, 2018-02-28 at 11:19 -0700, Jens Axboe wrote:
> > Didn't Ming ack the first three?
> 
> Hello Jens,
> 
> This morning I did what I usually do before I repost a patch series, namely to
> look at the replies to individual patches for reviewed-by tags. That's how I
> overlooked the following (see also https://marc.info/?l=linux-block&m=151947628418213):
> 
> "For patches 1 ~ 3: Reviewed-by: Ming Lei <ming.lei@redhat.com>"
> 
> Do you want me to repost this series?

No that's OK, I can add them. Just wanted to double check.

-- 
Jens Axboe
