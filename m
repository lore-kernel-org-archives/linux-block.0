Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH blktests] tests: use nproc to get number of CPUs for fio
 jobs
To: Johannes Thumshirn <jthumshirn@suse.de>,
 Omar Sandoval <osandov@osandov.com>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>
References: <20170629114050.11733-1-jthumshirn@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <31774cc0-7aa5-7be0-eee4-ea466ac3fd1a@kernel.dk>
Date: Thu, 29 Jun 2017 08:08:32 -0600
MIME-Version: 1.0
In-Reply-To: <20170629114050.11733-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/29/2017 05:40 AM, Johannes Thumshirn wrote:
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  tests/block/004 | 2 +-
>  tests/block/005 | 2 +-
>  tests/block/006 | 2 +-
>  tests/block/008 | 2 +-
>  tests/block/011 | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/block/004 b/tests/block/004
> index 754d30260d63..2dc0f25b27cc 100755
> --- a/tests/block/004
> +++ b/tests/block/004
> @@ -29,7 +29,7 @@ test_device() {
>  
>  	FIO_PERF_FIELDS=("write iops")
>  	_fio_perf --bs=4k --rw=randwrite --norandommap --fsync=1 \
> -		--number_ios=256 --numjobs=64 --name=flushes \
> +		--number_ios=256 --numjobs=$(nproc) --name=flushes \
>  		--filename="$TEST_DEV"

NAK on this bit. Let's use the nproc for cases that just want a random
suitable workload for their machine. For flush, the idea here is to
use a ton of flushes. This has shown bugs in the past, like this
for instance:

commit 7520872c0cf4d3df6d74242c6edfb9e70a47df4d
Author: Jens Axboe <axboe@fb.com>
Date:   Fri Feb 17 11:40:44 2017 -0700

    block: don't defer flushes on blk-mq + scheduling

For the other tests in your patch, the change looks fine. But I would
greatly prefer if we just turned that into a

__run_fio_mix

or similar command, since the jobs should basically be identical.

-- 
Jens Axboe
