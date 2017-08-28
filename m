Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block/nullb: delete unnecessary memory free
To: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org
Cc: dan.carpenter@oracle.com
References: <9df1970109b84fc170530a5ffa5c07e4480e445f.1503953204.git.shli@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2614b8bd-ed7a-7953-6d14-7e05850fe88b@kernel.dk>
Date: Mon, 28 Aug 2017 14:55:59 -0600
MIME-Version: 1.0
In-Reply-To: <9df1970109b84fc170530a5ffa5c07e4480e445f.1503953204.git.shli@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/28/2017 02:49 PM, Shaohua Li wrote:
> Commit 2984c86(nullb: factor disk parameters) has a typo. The
> nullb_device allocation/free is done outside of null_add_dev. The commit
> accidentally frees the nullb_device in error code path.

Is the code in nullb_device_power_store() correct after this?
Also, looks like the second else if in there should be using
'dev' instead of to_nullb_device(item)->power.

-- 
Jens Axboe
