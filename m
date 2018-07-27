Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] partitions/aix: fix problems due to disk corruption
To: Mauricio Faria de Oliveira <mfo@canonical.com>
Cc: phdm@macqel.be, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel.axtens@canonical.com
References: <20180726014629.30411-1-mfo@canonical.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5ac51c6d-a7b5-9ae1-88dc-1536450d70fb@kernel.dk>
Date: Fri, 27 Jul 2018 09:17:21 -0600
MIME-Version: 1.0
In-Reply-To: <20180726014629.30411-1-mfo@canonical.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/25/18 7:46 PM, Mauricio Faria de Oliveira wrote:
> We've recently received a disk image from an AIX LUN that when
> attached on Linux displayed errors on console, then eventually
> hung the system.
> 
> Apparently the LUN was originally installed with AIX and later
> exercised with some I/O stress/overwrites which caused certain
> bits to be wrong in just the right way for Linux to get a NULL
> pointer and invalid data.
> 
> This is the test-case used ('--partscan' is the important bit).
>   $ sudo losetup --show --find --partscan aix-lun.img
> 
> Patch 1 resolves the particular problem the disk image has.
> Patch 2 improves the code a bit further (tested synthetically).
> 
> Mauricio Faria de Oliveira (2):
>   partitions/aix: fix usage of uninitialized lv_info and lvname
>     structures
>   partitions/aix: append null character to print data from disk
> 
>  block/partitions/aix.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Looks good to me, I have applied for 4.19.

-- 
Jens Axboe
