Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-iolatency: fix max_depth comparisons
To: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 kernel-team@fb.com
References: <20180711133012.15552-1-josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7dc883e2-7bb0-f837-9547-619b5e51f81d@kernel.dk>
Date: Wed, 11 Jul 2018 08:22:28 -0600
MIME-Version: 1.0
In-Reply-To: <20180711133012.15552-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/11/18 7:30 AM, Josef Bacik wrote:
> max_depth used to be a u64, but I changed it to a unsigned int but
> didn't convert my comparisons over everywhere.  Fix by comparing to
> INT_MAX instead of (u64)-1.

Should that be UINT_MAX?

-- 
Jens Axboe
