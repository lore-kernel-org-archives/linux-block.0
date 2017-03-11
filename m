Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] brd: make rd_size static
To: Jason Yan <yanaijie@huawei.com>, linux-block@vger.kernel.org
References: <1489131159-840-1-git-send-email-yanaijie@huawei.com>
Cc: miaoxie@huawei.com, zhaohongjiang@huawei.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4dd2367b-61b9-d390-5bb1-955e90fef0b0@kernel.dk>
Date: Sat, 11 Mar 2017 15:29:57 -0700
MIME-Version: 1.0
In-Reply-To: <1489131159-840-1-git-send-email-yanaijie@huawei.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/10/2017 12:32 AM, Jason Yan wrote:
> Fixes the following sparse warning:
> 
> drivers/block/brd.c:411:15: warning: symbol 'rd_size' was not declared.
> Should it be static?

If you do a search on this topic, you'll find others that attempted
to do the same. Arm uses it for tag parsing, for some reason, your
patch below would break it.

It'd be great if this was fixed up for real, though.

-- 
Jens Axboe
