Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] Blk-throttle: update to use rbtree with leftmost node
 cached
To: Liu Bo <bo.liu@linux.alibaba.com>, linux-block@vger.kernel.org
References: <1534800075-74931-1-git-send-email-bo.liu@linux.alibaba.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <227df034-69b9-a71f-7c1f-b9de9fc4cfb2@kernel.dk>
Date: Thu, 20 Sep 2018 19:31:33 -0600
MIME-Version: 1.0
In-Reply-To: <1534800075-74931-1-git-send-email-bo.liu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/20/18 3:21 PM, Liu Bo wrote:
> As rbtree has native support of caching leftmost node,
> i.e. rb_root_cached, no need to do the caching by ourselves.

This looks fine to me. I think this code was probably inherited
from a similar caching trick in cfq, an predates leftmost
caching being generally available in the rbtree code.

I'll apply it for 4.20.

-- 
Jens Axboe
