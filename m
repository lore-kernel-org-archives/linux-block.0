Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45402 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750758AbdEDL2O (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 May 2017 07:28:14 -0400
Subject: Re: [PATCH v2 09/12] blk-mq: untangle debugfs and sysfs
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
References: <cover.1493882751.git.osandov@fb.com>
 <48cef16b7b8fbdbfd8686f828287370cdcb21650.1493882751.git.osandov@fb.com>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <deb3c5d6-982b-2baf-2423-6a07c8fe8fd8@suse.de>
Date: Thu, 4 May 2017 13:28:11 +0200
MIME-Version: 1.0
In-Reply-To: <48cef16b7b8fbdbfd8686f828287370cdcb21650.1493882751.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/04/2017 09:31 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Originally, I tied debugfs registration/unregistration together with
> sysfs. There's no reason to do this, and it's getting in the way of
> letting schedulers define their own debugfs attributes. Instead, tie the
> debugfs registration to the lifetime of the structures themselves.
> 
> The saner lifetimes mean we can also get rid of the extra mq directory
> and move everything one level up. I.e., nvme0n1/mq/hctx0/tags is now
> just nvme0n1/hctx0/tags.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-core.c       |   9 +---
>  block/blk-mq-debugfs.c | 110 ++++++++++++++++++++++++++++---------------------
>  block/blk-mq-debugfs.h |  21 ++++++++--
>  block/blk-mq-sysfs.c   |  11 -----
>  block/blk-mq.c         |   7 ++++
>  block/blk-sysfs.c      |   2 +
>  include/linux/blk-mq.h |   4 ++
>  include/linux/blkdev.h |   1 -
>  8 files changed, 94 insertions(+), 71 deletions(-)
> 
Again, I really liked the symmetry between sysfs and debugfs mq entries.
This will definitely break it.

Not sure if that's a real issue, but personally I liked the mapping.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
