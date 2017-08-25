Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block/nullb: fix NULL deference
To: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org
Cc: dan.carpenter@oracle.com
References: <b70eb4a71a01a72a75f2f1efb1fadc4ef77fc7ff.1503693884.git.shli@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <02caab6e-ad03-807c-47a6-b69fd8f81b26@kernel.dk>
Date: Fri, 25 Aug 2017 14:52:25 -0600
MIME-Version: 1.0
In-Reply-To: <b70eb4a71a01a72a75f2f1efb1fadc4ef77fc7ff.1503693884.git.shli@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/25/2017 02:46 PM, Shaohua Li wrote:
> Dan reported this:
> 
> The patch 2984c8684f96: "nullb: factor disk parameters" from Aug 14,
> 2017, leads to the following Smatch complaint:
> 
> drivers/block/null_blk.c:1759 null_init_tag_set()
> 	 error: we previously assumed 'nullb' could be null (see line
> 1750)
> 
>   1755		set->cmd_size	= sizeof(struct nullb_cmd);
>   1756		set->flags = BLK_MQ_F_SHOULD_MERGE;
>   1757		set->driver_data = NULL;
>   1758
>   1759		if (nullb->dev->blocking)
>                     ^^^^^^^^^^^^^^^^^^^^
> And an unchecked dereference.
> 
> nullb could be NULL here.

Applied, thanks. Fixed up your subject line typo.

-- 
Jens Axboe
