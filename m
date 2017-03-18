Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751320AbdCRLo6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Mar 2017 07:44:58 -0400
Subject: Re: [PATCH v1 3/3] blk-mq: start to freeze queue just after setting
 dying
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@fb.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
References: <20170317095711.5819-1-tom.leiming@gmail.com>
 <20170317095711.5819-4-tom.leiming@gmail.com>
Cc: Yi Zhang <yizhan@redhat.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Tejun Heo <tj@kernel.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <790d13bd-987a-cfde-deba-b874062d1e0b@suse.de>
Date: Sat, 18 Mar 2017 12:27:33 +0100
MIME-Version: 1.0
In-Reply-To: <20170317095711.5819-4-tom.leiming@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/17/2017 10:57 AM, Ming Lei wrote:
> Before commit 780db2071a(blk-mq: decouble blk-mq freezing
> from generic bypassing), the dying flag is checked before
> entering queue, and Tejun converts the checking into .mq_freeze_depth,
> and assumes the counter is increased just after dying flag
> is set. Unfortunately we doesn't do that in blk_set_queue_dying().
> 
> This patch calls blk_mq_freeze_queue_start() for blk-mq in
> blk_set_queue_dying(), so that we can block new I/O coming
> once the queue is set as dying.
> 
> Given blk_set_queue_dying() is always called in remove path
> of block device, and queue will be cleaned up later, we don't
> need to worry about undoing the counter.
> 
> Cc: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  block/blk-core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: J. Hawn, J. Guild, F. Imend�rffer, HRB 16746 (AG N�rnberg)
