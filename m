Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v4 00/11] Zoned block device support improvements
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, dm-devel@redhat.com,
 Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Matias Bjorling <matias.bjorling@wdc.com>
References: <20181012100850.23316-1-damien.lemoal@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <78778e22-9c5e-99d0-ef5c-85e04d03a4b7@kernel.dk>
Date: Tue, 23 Oct 2018 09:59:16 -0600
MIME-Version: 1.0
In-Reply-To: <20181012100850.23316-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/12/18 4:08 AM, Damien Le Moal wrote:
> This series improves zoned block device support (reduce overhead) and
> introduces many simplifications to the code (overall, there are more deletions
> than insertions).
> 
> In more details:
> * Patches 1 to 3 are SCSI side (sd driver) cleanups and improvements reducing
>   the overhead of report zones command execution during disk scan and
>   revalidation.
> * Patches 4 to 9 improve the useability and user API of zoned block devices.
> * Patch 10 is the main part of this series. This patch replaces the
>   REQ_OP_ZONE_REPORT BIO/request operation for executing report zones commands
>   with a block device file operation, removing the need for the command reply
>   payload in-place rewriting in the BIO buffer. This leads to major
>   simplification of the code in many places.
> * Patch 11 further simplifies the code of low level drivers by providing a
>   generic implementation of zoned block device reuest queue zone bitmaps
>   initialization and revalidation.

I've applied this, but I have two complaints:

1) Two had to be hand applied, it wasn't against the block tree.
2) The ordering of the signed-off-by. Someone told me that this is
   patchwork, but I absolutely hate it. SOB should go last, not before
   the reviewed-by. I fixed that up too.

-- 
Jens Axboe
