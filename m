Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Fix kernel-doc warnings reported when building
 with W=1
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>
References: <20180109181100.14968-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d24aedfe-e21d-5d79-06ad-1f3799de8a69@kernel.dk>
Date: Tue, 9 Jan 2018 11:15:39 -0700
MIME-Version: 1.0
In-Reply-To: <20180109181100.14968-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/9/18 11:11 AM, Bart Van Assche wrote:
> Commit 3a025e1d1c2e ("Add optional check for bad kernel-doc comments")
> causes W=1 the kernel-doc script to be run and thereby causes several
> new warnings to appear when building the kernel with W=1. Fix the
> block layer kernel-doc headers such that the block layer again builds
> cleanly with W=1.

Thanks, applied.

-- 
Jens Axboe
