Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50597 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751751AbdC0MQZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2017 08:16:25 -0400
Date: Mon, 27 Mar 2017 14:16:16 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 4/4] block: block new I/O just after queue is set as
 dying
Message-ID: <20170327121616.GD7237@linux-x5ow.site>
References: <20170327120658.29864-1-tom.leiming@gmail.com>
 <20170327120658.29864-5-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170327120658.29864-5-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Mar 27, 2017 at 08:06:58PM +0800, Ming Lei wrote:
> Before commit 780db2071a(blk-mq: decouble blk-mq freezing
> from generic bypassing), the dying flag is checked before
> entering queue, and Tejun converts the checking into .mq_freeze_depth,
> and assumes the counter is increased just after dying flag
> is set. Unfortunately we doesn't do that in blk_set_queue_dying().
> 
> This patch calls blk_freeze_queue_start() in blk_set_queue_dying(),
> so that we can block new I/O coming once the queue is set as dying.
> 
> Given blk_set_queue_dying() is always called in remove path
> of block device, and queue will be cleaned up later, we don't
> need to worry about undoing the counter.
> 
> Cc: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Tejun Heo <tj@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
