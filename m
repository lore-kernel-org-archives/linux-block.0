Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751208AbdCRLZa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Mar 2017 07:25:30 -0400
Subject: Re: [PATCH v1 2/3] blk-mq: comment on races related with timeout
 handler
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@fb.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
References: <20170317095711.5819-1-tom.leiming@gmail.com>
 <20170317095711.5819-3-tom.leiming@gmail.com>
Cc: Yi Zhang <yizhan@redhat.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ace6e758-8254-73a3-6dbd-60ae6ce9d4da@suse.de>
Date: Sat, 18 Mar 2017 12:25:21 +0100
MIME-Version: 1.0
In-Reply-To: <20170317095711.5819-3-tom.leiming@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/17/2017 10:57 AM, Ming Lei wrote:
> This patch adds comment on two races related with
> timeout handler:
> 
> - requeue from queue busy vs. timeout
> - rq free & reallocation vs. timeout
> 
> Both the races themselves and current solution aren't
> explicit enough, so add comments on them.
> 
> Cc: Bart Van Assche <bart.vanassche@sandisk.com>
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  block/blk-mq.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: J. Hawn, J. Guild, F. Imend�rffer, HRB 16746 (AG N�rnberg)
