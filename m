Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39005 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756965AbdCXPUF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2017 11:20:05 -0400
Subject: Re: [PATCH v2 3/4] block: rename blk_mq_freeze_queue_start()
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20170324123621.5227-1-tom.leiming@gmail.com>
 <20170324123621.5227-4-tom.leiming@gmail.com>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <85ec51a4-cc26-896b-bad1-4b58f18d05c0@suse.de>
Date: Fri, 24 Mar 2017 16:20:02 +0100
MIME-Version: 1.0
In-Reply-To: <20170324123621.5227-4-tom.leiming@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/24/2017 01:36 PM, Ming Lei wrote:
> As the .q_usage_counter is used by both legacy and
> mq path, we need to block new I/O if queue becomes
> dead in blk_queue_enter().
> 
> So rename it and we can use this function in both
> pathes.
> 
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  block/blk-core.c                  |  2 +-
>  block/blk-mq.c                    | 10 +++++-----
>  drivers/block/mtip32xx/mtip32xx.c |  2 +-
>  drivers/nvme/host/core.c          |  2 +-
>  include/linux/blk-mq.h            |  2 +-
>  5 files changed, 9 insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: J. Hawn, J. Guild, F. Imend�rffer, HRB 16746 (AG N�rnberg)
