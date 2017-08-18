Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-throttle: ignore discard request size
To: Shaohua Li <shli@fb.com>, linux-block@vger.kernel.org
Cc: Kernel-team@fb.com
References: <67ffcf14c2d15622b84c60a493b590dd81a07f51.1503068984.git.shli@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e2144181-6129-96e2-0e44-66625da2f04a@kernel.dk>
Date: Fri, 18 Aug 2017 09:35:01 -0600
MIME-Version: 1.0
In-Reply-To: <67ffcf14c2d15622b84c60a493b590dd81a07f51.1503068984.git.shli@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 09:13 AM, Shaohua Li wrote:
> discard request usually is very big and easily use all bandwidth budget
> of a cgroup. discard request size doesn't really mean the size of data
> written, so it doesn't make sense to account it into bandwidth budget.
> This patch ignores discard requests size. It makes sense to account
> discard request into iops budget though.

Some (most) devices to touch media for a discard operation, but the
cost tends to be fairly constant and independent of discard size.
Would it make sense to just treat it as a constant cost? Zero
cost seems wrong.

-- 
Jens Axboe
