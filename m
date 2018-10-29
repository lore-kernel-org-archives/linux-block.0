Return-Path: <hare@suse.de>
Subject: Re: [PATCH 26/28] block: remove req_no_special_merge() from merging
 code
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-27-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c24259c2-7187-2f93-0fa3-01d4706bc776@suse.de>
Date: Mon, 29 Oct 2018 08:12:04 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-27-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> It'll always be false at this point, just remove it.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-merge.c | 25 +++----------------------
>   1 file changed, 3 insertions(+), 22 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
