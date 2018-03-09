Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Suppress kernel-doc warnings triggered by
 blk-zoned.c
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <damien.lemoal@wdc.com>
References: <20180308232850.8934-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <57e9d5b9-645f-876a-aed3-c3bc6593431d@kernel.dk>
Date: Fri, 9 Mar 2018 08:24:51 -0700
MIME-Version: 1.0
In-Reply-To: <20180308232850.8934-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/8/18 4:28 PM, Bart Van Assche wrote:
> Avoid that building with W=1 causes the kernel-doc tool to complain
> about undocumented function arguments for the blk-zoned.c source file.

Applied, thanks.

-- 
Jens Axboe
