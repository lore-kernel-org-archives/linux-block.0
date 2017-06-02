Return-Path: <axboe@kernel.dk>
Subject: Re: Block device integrity support
To: Bart Van Assche <Bart.VanAssche@sandisk.com>, "hch@lst.de" <hch@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1496440434.1214.23.camel@sandisk.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <703036c0-a5d2-f1df-4eb9-d0c46a30dce7@kernel.dk>
Date: Fri, 2 Jun 2017 15:24:31 -0700
MIME-Version: 1.0
In-Reply-To: <1496440434.1214.23.camel@sandisk.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/02/2017 02:53 PM, Bart Van Assche wrote:
> Hello Jens and Christoph,
> 
> With Jens' for-next branch (commit fe02d46ab775), if I run the following
> commands:
> 
>     modprobe scsi_debug delay=0 dif=3 dix=-1 dev_size_mb=16
>     mkfs.xfs /dev/disk/by-id/scsi-1Linux_scsi_debug_22000
> 
> then the output shown below appears in the kernel log. Does anyone know how
> to fix this? Sorry but I'm not really familiar with the integrity code.

There's not much in my for-next/4.13 branches yet, so I'm assuming this also
triggers with current mainline?

-- 
Jens Axboe
