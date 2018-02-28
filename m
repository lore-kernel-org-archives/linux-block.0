Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] Make the zone locking information available in
 debugfs
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <damien.lemoal@wdc.com>
References: <20180228003214.3194-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6f54d688-5d55-98cf-1720-229aaafed280@kernel.dk>
Date: Wed, 28 Feb 2018 08:45:34 -0700
MIME-Version: 1.0
In-Reply-To: <20180228003214.3194-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2/27/18 5:32 PM, Bart Van Assche wrote:
> Hello Jens,
> 
> While analyzing the mq-deadline behavior for ZBC drives together with Damien
> we noticed the following:
> - That the request queue attribute methods are not contiguous in
>   blk-mq-debugfs.c.
> - That the information about which zones are locked is not yet available in
>   debugfs.
> 
> Hence this patch series. Please consider this patch series for kernel v4.17.

Looks sane to me, applied.

-- 
Jens Axboe
