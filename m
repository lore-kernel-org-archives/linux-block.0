Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50131 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751751AbdC0MMV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2017 08:12:21 -0400
Date: Mon, 27 Mar 2017 14:11:24 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 1/4] blk-mq: comment on races related with timeout
 handler
Message-ID: <20170327121124.GA7237@linux-x5ow.site>
References: <20170327120658.29864-1-tom.leiming@gmail.com>
 <20170327120658.29864-2-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170327120658.29864-2-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Mar 27, 2017 at 08:06:55PM +0800, Ming Lei wrote:
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
