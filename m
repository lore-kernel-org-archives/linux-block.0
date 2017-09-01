Return-Path: <axboe@kernel.dk>
Subject: Re: blk_get_request sleeps in schedule
To: Suraj Choudhari <surajschoudhari@gmail.com>,
 linux-block <linux-block@vger.kernel.org>
References: <CAGvB2rNiyP58+TTgc-D9RzesvQWx1RgjjepQBujhZQa5Cx-f9A@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1640da78-2453-6523-416a-b59995554f88@kernel.dk>
Date: Fri, 1 Sep 2017 08:46:36 -0600
MIME-Version: 1.0
In-Reply-To: <CAGvB2rNiyP58+TTgc-D9RzesvQWx1RgjjepQBujhZQa5Cx-f9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/31/2017 08:37 PM, Suraj Choudhari wrote:
> Hello,
> 
> On my test system, blk_get_request() continuously hangs in schedule().
> 
> schedule+0x35/0x80
> schedule_timeout+0x237/0x2d0
> io_schedule_timeout+0xa6/0x110
> get_request+0x258/0x760
> blk_get_request+0x7f/0x100
> 
> I suspect the problem might be due to __get_request returning ENOMEM,
> leading to sleep in schedule().
> 
> static struct request *__get_request(struct request_list *rl, unsigned
> int op, struct bio *bio, gfp_t gfp_mask)   {
> ...
> /*
> * The queue is full and the allocating
> * process is not a "batcher", and not
> * exempted by the IO scheduler
> */
> return ERR_PTR(-ENOMEM);
> ...
> 
> if (rl->count[is_sync] >= (3 * q->nr_requests / 2))
> return ERR_PTR(-ENOMEM);
> ...
> 
> }
> 
> However, there is no significant memory pressure or IO load on my test
> system, I wonder why the __get_request might be failing leading to
> sleep.
> 
> Any possible cause?   Any suggestions are welcome!

You're missing a lot of detail here. What kernel are you using? What
storage device hw/driver are you seeing this on? What are you doing
to reproduce it?

Basically all the things that someone would need to know, to have
any sort of educated guess as to what is going on.

-- 
Jens Axboe
