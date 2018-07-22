Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-rq-qos: make depth comparisons unsigned
To: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 kernel-team@fb.com
References: <20180720014213.28772-1-josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <27dd9a4e-e5d9-d26c-f29a-c5bcbed44cd0@kernel.dk>
Date: Sun, 22 Jul 2018 11:31:20 -0600
MIME-Version: 1.0
In-Reply-To: <20180720014213.28772-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/19/18 7:42 PM, Josef Bacik wrote:
> With the change to use UINT_MAX I broke the depth check as any value of
> inflight (ie 0) would be less than (int)UINT_MAX.  Fix this by changing
> everything to unsigned int to match the depth.

Applied, thanks.

-- 
Jens Axboe
