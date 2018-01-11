Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50351 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753948AbeAKHAW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jan 2018 02:00:22 -0500
Subject: Re: [PATCH v2 1/2] blk-mq: Reduce the number of if-statements in
 blk_mq_mark_tag_wait()
To: Bart Van Assche <bart.vanassche@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Omar Sandoval <osandov@fb.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20180110193919.6886-1-bart.vanassche@wdc.com>
 <20180110193919.6886-2-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ad3b628a-04c9-bd75-914c-fac1165819b1@suse.de>
Date: Thu, 11 Jan 2018 08:00:19 +0100
MIME-Version: 1.0
In-Reply-To: <20180110193919.6886-2-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/10/2018 08:39 PM, Bart Van Assche wrote:
> This patch does not change any functionality but makes the
> blk_mq_mark_tag_wait() code slightly easier to read.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/blk-mq.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
