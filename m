Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] bcache: writeback rate clamping: make 32 bit safe
To: Michael Lyle <mlyle@lyle.org>, linux-bcache@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20171016173447.27253-1-mlyle@lyle.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <20f5b753-1d5f-eb7d-cbb9-6ecaf43294f8@kernel.dk>
Date: Mon, 16 Oct 2017 13:01:02 -0600
MIME-Version: 1.0
In-Reply-To: <20171016173447.27253-1-mlyle@lyle.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/16/2017 11:34 AM, Michael Lyle wrote:
> Sorry this got through to linux-block, was detected by the kbuilds test
> robot.  NSEC_PER_SEC is a long constant; 2.5 * 10^9 doesn't fit in a
> signed long constant.

Applied, but you should remember to add Fixes lines when a patch
explicitly fixes a problem introduced by a previous patch. Ala:

Fixes: e41166c5c44e ("bcache: writeback rate shouldn't artifically clamp")

so that backports have an easier time finding dependent fixes.

-- 
Jens Axboe
