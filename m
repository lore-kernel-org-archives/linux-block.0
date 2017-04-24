Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:35617 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1166043AbdDXH0T (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Mon, 24 Apr 2017 03:26:19 -0400
Subject: Re: [PATCH v4 03/10] blk-mq-debugfs: Rename functions for registering
 and unregistering the mq directory
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
 <20170421234026.18970-4-bart.vanassche@sandisk.com>
Cc: linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
From: Hannes Reinecke <hare@suse.com>
Message-ID: <14f25ed1-01d1-ad4b-3c2f-eba958c54a2d@suse.com>
Date: Mon, 24 Apr 2017 09:26:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170421234026.18970-4-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/22/2017 01:40 AM, Bart Van Assche wrote:
> Since the blk_mq_debugfs_*register_hctxs() functions register and
> unregister all attributes under the "mq" directory, rename these
> into blk_mq_debugfs_*register_mq().
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-mq-debugfs.c | 8 ++++----
>  block/blk-mq-sysfs.c   | 6 +++---
>  block/blk-mq.h         | 8 ++++----
>  3 files changed, 11 insertions(+), 11 deletions(-)
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
