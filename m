Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: place trace_block_getrq() in correct place
To: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
 linux-block@vger.kernel.org
References: <20181023143050.121915-1-xiaoguang.wang@linux.alibaba.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3bce4e9d-2449-ec78-5b6c-19bca20a0892@kernel.dk>
Date: Wed, 24 Oct 2018 03:29:41 -0600
MIME-Version: 1.0
In-Reply-To: <20181023143050.121915-1-xiaoguang.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/23/18 8:30 AM, Xiaoguang Wang wrote:
> trace_block_getrq() is to indicate a request struct has been allcoated
                                                               ^^^

allocated

> for queue, so put it in right place.

Applied, thanks.

-- 
Jens Axboe
