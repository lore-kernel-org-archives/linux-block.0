Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:46974 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760483AbdDXH0r (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Mon, 24 Apr 2017 03:26:47 -0400
Subject: Re: [PATCH v4 04/10] blk-mq: Check blk_mq_debugfs_register() return
 value
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
 <20170421234026.18970-5-bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
From: Hannes Reinecke <hare@suse.com>
Message-ID: <31735d25-79d6-56c2-814a-6506beac864c@suse.com>
Date: Mon, 24 Apr 2017 09:26:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170421234026.18970-5-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/22/2017 01:40 AM, Bart Van Assche wrote:
> Make __blk_mq_register_dev() check the blk_mq_debugfs_register()
> return value. In the error path, only unregister hctxs for which
> registration succeeded.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-mq-sysfs.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
