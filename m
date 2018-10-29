Return-Path: <hare@suse.de>
Subject: Re: [PATCH 18/28] block: remove non mq parts from the flush code
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-19-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2a223256-6a97-d6ec-3943-77b77e07fd71@suse.de>
Date: Mon, 29 Oct 2018 08:02:27 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-19-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-flush.c | 154 +++++++++-------------------------------------
>   block/blk.h       |   4 +-
>   2 files changed, 31 insertions(+), 127 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
