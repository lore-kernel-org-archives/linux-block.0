Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/3] blk-iolatency related ref counting fixes
To: Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 kernel-team@fb.com
References: <20180731163904.21856-1-josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c86b5e87-53f5-6660-9561-ac19530f05ea@kernel.dk>
Date: Wed, 1 Aug 2018 09:16:15 -0600
MIME-Version: 1.0
In-Reply-To: <20180731163904.21856-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/31/18 10:39 AM, Josef Bacik wrote:
> These are three ref counting issues we found in testing.  They are pretty
> straightforward, the first two don't really happen in practice but need to be
> fixed, but the last one fixes a real panic we saw pretty regularly in our stress
> testing.  They've been running on our test boxes internally under stress tests
> and seem to have fixed the remaining issues we were seeing.  Thanks,

Applied for 4.19, thanks.

-- 
Jens Axboe
