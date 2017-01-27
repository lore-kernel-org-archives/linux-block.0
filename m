Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 27 Jan 2017 08:18:54 -0700
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 00/10] blk-mq: move debugging information from sysfs
 to debugfs
Message-ID: <20170127151854.GA31422@kernel.dk>
References: <cover.1485360145.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1485360145.git.osandov@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jan 25 2017, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Changes from v1:
> 
> - Make the sbitmap seq_file helpers take a (struct sbitmap *) instead of a
>   (void *), since it's not possible to use them directly as the seq_file
>   show helper, anyways
> - Fix a crash when reading ctx_map because it was attempting to do
>   exactly that ^
> 
> Cover letter from v1:
> 
> This series ends our abuse of sysfs and puts all of the debugging information
> in debugfs instead. This has a few benefits:
> 
> 1. Removes the possibility of userspace being stupid and relying on something
>    in sysfs that we only exposed for debugging.
> 2. Lifts the limitations of sysfs, including the one-value-per-file convention
>    and maximum of one page of output.
> 3. Allows us to add more debugging information that we often want but don't
>    have when debugging a live system.

Thanks Omar, applied for 4.11. The series has already been helpful in
root causing a stall.

-- 
Jens Axboe
