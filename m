Return-Path: <hare@suse.de>
Subject: Re: [PATCH v6 09/10] blk-mq: Add blk_mq_ops.show_rq()
To: Bart Van Assche <bart.vanassche@sandisk.com>, Jens Axboe <axboe@kernel.dk>
References: <20170426204757.18910-1-bart.vanassche@sandisk.com>
 <20170426204757.18910-10-bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <8260522f-fba8-aef0-d7a8-fcf999f2a63a@suse.de>
Date: Thu, 27 Apr 2017 08:41:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170426204757.18910-10-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/26/2017 10:47 PM, Bart Van Assche wrote:
> This new callback function will be used in the next patch to show
> more information about SCSI requests.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-mq-debugfs.c | 6 +++++-
>  include/linux/blk-mq.h | 8 ++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
