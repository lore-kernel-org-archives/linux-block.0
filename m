Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] block: inflight counter fixes
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
References: <cover.1524727168.git.osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6173441b-3ffb-71e5-4805-a7e508e5db1b@kernel.dk>
Date: Thu, 26 Apr 2018 08:55:31 -0600
MIME-Version: 1.0
In-Reply-To: <cover.1524727168.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/26/18 1:21 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Hi, Jens,
> 
> I added a blktest (block/017) for the inflight counter after you
> mentioned that we should have one and it easily found a bug :) Patch 2
> fixes the bug found by the test, and patch 1 fixes another bug I
> noticed. Based on Linus' master.

That's hilarious! Awesome, thanks Omar.

-- 
Jens Axboe
