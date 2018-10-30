Return-Path: <prvs=834be3197=sblbir@amzn.com>
Date: Tue, 30 Oct 2018 02:53:29 +0000
From: Balbir Singh <sblbir@amzn.com>
To: Jens Axboe <axboe@kernel.dk>
CC: Balbir Singh <sblbir@amazon.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add cmd_flags to print_req_error
Message-ID: <20181030025329.GA2121@dev-dsk-sblbir-2a-88e651b2.us-west-2.amazon.com>
References: <20181029005732.21040-1-sblbir@amazon.com>
 <543de76a-e43a-9f4d-c781-e3251ea0e749@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <543de76a-e43a-9f4d-c781-e3251ea0e749@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 29, 2018 at 04:39:05PM -0600, Jens Axboe wrote:
> On 10/28/18 6:57 PM, Balbir Singh wrote:
> > I ran into a bug where after hibernation due to incompatible
> > backends, the block driver returned BLK_STS_NOTSUPP, with the
> > current message it's hard to find out what the command flags
> > were. Adding req->cmd_flags help make the problem easier to
> > diagnose.
> 
> I recently did the same thing to debug something, so I like
> this change. One comment:
> 
> > +	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu flags %llx\n",
> > +				__func__, blk_errors[idx].name,
> > +				req->rq_disk ?  req->rq_disk->disk_name : "?",
> > +				(unsigned long long)blk_rq_pos(req),
> > +				(unsigned long long)req->cmd_flags);
> 
> Why are you casting it to unsigned long long for printing? A simple
> %x should suffice, no cast necessary.
>

Thanks! resent

I was looking at blk_dump_rq_flags() and tried to do something similar.
I agree a %x is sufficient, I was trying to be consistent. We can fix
that path up if needed.
 
> -- 
> Jens Axboe
> 
> 
