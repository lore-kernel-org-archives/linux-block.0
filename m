Return-Path: <hare@suse.de>
Subject: Re: [PATCH 2/7] blk-mq: abstract out blk_mq_dispatch_rq_list() helper
To: Jens Axboe <axboe@fb.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1481228005-9245-1-git-send-email-axboe@fb.com>
 <1481228005-9245-3-git-send-email-axboe@fb.com>
Cc: paolo.valente@linaro.org, osandov@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <95c5869a-d85d-2790-657d-c19a2bacae4c@suse.de>
Date: Fri, 9 Dec 2016 07:44:53 +0100
MIME-Version: 1.0
In-Reply-To: <1481228005-9245-3-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 12/08/2016 09:13 PM, Jens Axboe wrote:
> Takes a list of requests, and dispatches it. Moves any residual
> requests to the dispatch list.
>
> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
>  block/blk-mq.c | 85 ++++++++++++++++++++++++++++++++--------------------------
>  block/blk-mq.h |  1 +
>  2 files changed, 48 insertions(+), 38 deletions(-)
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
