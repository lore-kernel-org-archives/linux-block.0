Return-Path: <hare@suse.de>
Subject: Re: [PATCH 24/29] bsg: move bsg-lib parts outside of request queue
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181029163444.9940-1-axboe@kernel.dk>
 <20181029163444.9940-25-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <9c37ae36-b41b-cea5-ba29-e60ecc2ea0b5@suse.de>
Date: Mon, 29 Oct 2018 18:00:58 +0100
MIME-Version: 1.0
In-Reply-To: <20181029163444.9940-25-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/29/18 5:34 PM, Jens Axboe wrote:
> Get rid of the special bsg job fn and timeout handler, move them
> into a private bsg_set instead.
> 
> Mostly from Christoph, with fixes for error handling and cleanups.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/bsg-lib.c         | 43 ++++++++++++++++++++++++++---------------
>   include/linux/blkdev.h  |  5 -----
>   include/linux/bsg-lib.h |  5 ++++-
>   3 files changed, 31 insertions(+), 22 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
