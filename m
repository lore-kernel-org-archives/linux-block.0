Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] Add cmd_flags to print_req_error
To: Balbir Singh <sblbir@amazon.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181029005732.21040-1-sblbir@amazon.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <543de76a-e43a-9f4d-c781-e3251ea0e749@kernel.dk>
Date: Mon, 29 Oct 2018 16:39:05 -0600
MIME-Version: 1.0
In-Reply-To: <20181029005732.21040-1-sblbir@amazon.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/28/18 6:57 PM, Balbir Singh wrote:
> I ran into a bug where after hibernation due to incompatible
> backends, the block driver returned BLK_STS_NOTSUPP, with the
> current message it's hard to find out what the command flags
> were. Adding req->cmd_flags help make the problem easier to
> diagnose.

I recently did the same thing to debug something, so I like
this change. One comment:

> +	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu flags %llx\n",
> +				__func__, blk_errors[idx].name,
> +				req->rq_disk ?  req->rq_disk->disk_name : "?",
> +				(unsigned long long)blk_rq_pos(req),
> +				(unsigned long long)req->cmd_flags);

Why are you casting it to unsigned long long for printing? A simple
%x should suffice, no cast necessary.

-- 
Jens Axboe
