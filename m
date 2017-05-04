Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45224 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751905AbdEDL0R (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 May 2017 07:26:17 -0400
Subject: Re: [PATCH v2 08/12] blk-mq: move debugfs declarations to a separate
 header file
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
References: <cover.1493882751.git.osandov@fb.com>
 <14d98327e1b274f2d39f7988faf1614a9a06716b.1493882751.git.osandov@fb.com>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <5a9f9fe6-1e22-3bce-0848-69b87823b194@suse.de>
Date: Thu, 4 May 2017 13:26:16 +0200
MIME-Version: 1.0
In-Reply-To: <14d98327e1b274f2d39f7988faf1614a9a06716b.1493882751.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/04/2017 09:31 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Preparation for adding more declarations.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-core.c       |  1 +
>  block/blk-mq-debugfs.c |  1 +
>  block/blk-mq-debugfs.h | 29 +++++++++++++++++++++++++++++
>  block/blk-mq-sysfs.c   |  1 +
>  block/blk-mq.h         | 28 ----------------------------
>  block/blk-sysfs.c      |  1 +
>  6 files changed, 33 insertions(+), 28 deletions(-)
>  create mode 100644 block/blk-mq-debugfs.h
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
