Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Mon, 26 Jun 2017 13:45:39 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [GIT PULL] New test and a fixup for blktests
Message-ID: <20170626204539.GD6710@vader.dhcp.thefacebook.com>
References: <9fd24bc2-cddc-6f46-230a-dc1673242a54@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9fd24bc2-cddc-6f46-230a-dc1673242a54@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 21, 2017 at 09:22:47AM -0600, Jens Axboe wrote:
> Hi Omar,
> 
> Two changes here:
> 
> - block/006 wants to use the iops results, but it isn't using _fio_perf.
> - Add block/010 to test for shared vs non-shared tags performance.
> 
> 
>   https://github.com/axboe/blktests.git axboe
> 
> 
> ----------------------------------------------------------------
> Jens Axboe (2):
>       block/006: use _fio_perf to get perf results
>       block/010: add test case for shared/unshared tags
> 
>  tests/block/006     |  4 +--
>  tests/block/010     | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/block/010.out |  2 ++
>  3 files changed, 86 insertions(+), 2 deletions(-)
>  create mode 100755 tests/block/010
>  create mode 100644 tests/block/010.out
> 
> -- 
> Jens Axboe
> 

Thanks, Jens, applied the first one, but

[ 1876.142470] null_blk: unknown parameter 'shared_tags' ignored

Am I missing a patch?
