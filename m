Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] bcache: fix 0day error of setting writeback_rate by sysfs
 interface
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Kai Krakow <kai@kaishome.de>,
 Stefan Priebe <s.priebe@profihost.ag>
References: <20180810154550.5020-1-colyli@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a418aaaf-f392-79d6-4892-60737d748887@kernel.dk>
Date: Fri, 10 Aug 2018 12:19:19 -0600
MIME-Version: 1.0
In-Reply-To: <20180810154550.5020-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/10/18 9:45 AM, Coly Li wrote:
> Commit ea8c5356d390 ("bcache: set max writeback rate when I/O request
> is idle") changes struct bch_ratelimit member rate from uint32_t to
> atomic_long_t and uses atomic_long_set() in drivers/md/bcache/sysfs.c
> to set new writeback rate, after the input is converted from memory
> buf to long int by sysfs_strtoul_clamp().
> 
> The above change has a problem because there is an implicit return
> inside sysfs_strtoul_clamp() so the following atomic_long_set()
> won't be called. This error is detected by 0day system with following
> snipped smatch warnings:
> 
> drivers/md/bcache/sysfs.c:271 __cached_dev_store() error: uninitialized
> symbol 'v'.
> 270  sysfs_strtoul_clamp(writeback_rate, v, 1, INT_MAX);
>      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> @271 atomic_long_set(&dc->writeback_rate.rate, v);
> 
> This patch fixes the above error by using strtoul_safe_clamp() to
> convert the input buffer into a long int type result.
> 
> Fixes: Commit ea8c5356d390 ("bcache: set max writeback rate when I/O request is idle")
> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: stable@vger.kernel.org #4.16+
> Cc: Kai Krakow <kai@kaishome.de>
> Cc: Stefan Priebe <s.priebe@profihost.ag>

You don't need to CC stable for this, the commit isn't in a released kernel
yet. In fact, it's not even in Linus's tree, it's just queued up for 4.19.

Also, the fixes line should be:

Fixes: ea8c5356d390 ("bcache: set max writeback rate when I/O request is idle")

(no Commit). I missed that on some of your earlier commits.

Applied with those edits, and some wording changes.

-- 
Jens Axboe
