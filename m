Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2] blk-throttle: cap discard request size
To: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org
Cc: Kernel-team@fb.com
References: <13d341052771b20f5d538dd32510f1403af7475e.1503097540.git.shli@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7df31333-ecca-ddbe-33a8-b4e57d245ede@kernel.dk>
Date: Wed, 23 Aug 2017 08:52:09 -0600
MIME-Version: 1.0
In-Reply-To: <13d341052771b20f5d538dd32510f1403af7475e.1503097540.git.shli@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 05:08 PM, Shaohua Li wrote:
> discard request usually is very big and easily use all bandwidth budget
> of a cgroup. discard request size doesn't really mean the size of data
> written, so it doesn't make sense to account it into bandwidth budget.
> Jens pointed out treating the size 0 doesn't make sense too, because
> discard request does have cost. But it's not easy to find the actual
> cost. This patch simply makes the size one sector.

This looks good to me now, applied for 4.13.

-- 
Jens Axboe
