Return-Path: <hare@suse.de>
Subject: Re: [PATCH 08/29] scsi: provide mq_ops->busy() hook
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181029163444.9940-1-axboe@kernel.dk>
 <20181029163444.9940-9-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <899d11a0-8459-38ed-1cf0-206d531dbabd@suse.de>
Date: Mon, 29 Oct 2018 17:57:36 +0100
MIME-Version: 1.0
In-Reply-To: <20181029163444.9940-9-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/29/18 5:34 PM, Jens Axboe wrote:
> Only the SCSI legacy path provides a way to check if target is
> currently busy, provide the same for the MQ path.
> 
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/scsi/scsi_lib.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
