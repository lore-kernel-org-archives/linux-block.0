Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43589 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbdAXN0d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 08:26:33 -0500
Subject: Re: [PATCH 03/10] blk-mq: move hctx->dispatch and ctx->rq_list from
 sysfs to debugfs
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
References: <cover.1485197480.git.osandov@fb.com>
 <c4344c36c87b05ad4b05280d2d95621b25c8d403.1485197480.git.osandov@fb.com>
Cc: kernel-team@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <08e94afe-78e6-d1ba-e914-39fa75ffda2b@suse.de>
Date: Tue, 24 Jan 2017 14:26:30 +0100
MIME-Version: 1.0
In-Reply-To: <c4344c36c87b05ad4b05280d2d95621b25c8d403.1485197480.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/23/2017 07:59 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> These lists are only useful for debugging; they definitely don't belong
> in sysfs. Putting them in debugfs also removes the limitation of a
> single page of output.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-debugfs.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++++
>  block/blk-mq-sysfs.c   |  57 --------------------------
>  2 files changed, 106 insertions(+), 57 deletions(-)
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
