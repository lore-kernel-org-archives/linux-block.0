Return-Path: <axboe@kernel.dk>
Subject: Re: [bug report] nullb: factor disk parameters
To: Dan Carpenter <dan.carpenter@oracle.com>, shli@fb.com
Cc: linux-block@vger.kernel.org
References: <20170825202400.7zj3ouyryojj2wxl@mwanda>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <143e945a-46ae-2731-6bca-a75970a5b4ba@kernel.dk>
Date: Fri, 25 Aug 2017 14:33:21 -0600
MIME-Version: 1.0
In-Reply-To: <20170825202400.7zj3ouyryojj2wxl@mwanda>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/25/2017 02:24 PM, Dan Carpenter wrote:
> Hello Shaohua Li,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 2984c8684f96: "nullb: factor disk parameters" from Aug 14, 
> 2017, leads to the following Smatch complaint:
> 
> drivers/block/null_blk.c:1759 null_init_tag_set()
> 	 error: we previously assumed 'nullb' could be null (see line 1750)

That's a bug, for shared tags we passed in nullb == NULL.

-- 
Jens Axboe
