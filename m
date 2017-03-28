Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 28 Mar 2017 15:07:57 -0600
To: Omar Sandoval <osandov@osandov.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH 0/6] block: convert remaining drivers which share a
 request queue
Message-ID: <20170328210757.GA28778@kernel.dk>
References: <cover.1490681910.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1490681910.git.osandov@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 27 2017, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This is clearly the pinnacle of my career: converting all remaining
> block drivers which share a request queue across gendisks to use a
> separate request queue per gendisk. These are all compile tested (but
> the last two platform-specific ones involved hacking the Kconfig and
> commenting out a bunch of arch-dependent code to get the rest to
> compile), no runtime testing at all.
> 
> Let me know if I missed any. Even better, let me know if we can just
> delete some of these entirely.
> 
It's all downhill from here, Omar, I don't see how you are ever going to
top this in terms of impact.

Applied for 4.12!

-- 
Jens Axboe
