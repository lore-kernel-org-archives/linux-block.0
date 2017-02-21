Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] scsi: zero per-cmd driver data before each I/O
To: Christoph Hellwig <hch@lst.de>, martin.petersen@oracle.com
References: <20170221090455.4633-1-hch@lst.de>
Cc: decui@microsoft.com, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d22be48c-51ca-ea12-6143-d1582eb6012f@kernel.dk>
Date: Tue, 21 Feb 2017 09:19:05 -0700
MIME-Version: 1.0
In-Reply-To: <20170221090455.4633-1-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/21/2017 02:04 AM, Christoph Hellwig wrote:
> Without this drivers that don't clear the state themselves can see off
> effects.  For example Hyper-V VMs using the storvsc driver will often
> hang during boot due to uncleared Test Unit Ready failures.
> 
> Fixes: e9c787e6 ("scsi: allocate scsi_cmnd structures as part of struct request")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reported-by: Dexuan Cui <decui@microsoft.com>
> Tested-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> Changes since V1:
>  - use a single memset as suggested by Bart

That's much better. I'll queue this up for the next pull in this merge
window.

-- 
Jens Axboe
