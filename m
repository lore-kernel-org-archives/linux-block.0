Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750705AbdAXHhU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 02:37:20 -0500
Subject: Re: [PATCH 02/16] block: simplify blk_init_allocated_queue
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>
References: <1485185361-29786-1-git-send-email-hch@lst.de>
 <1485185361-29786-3-git-send-email-hch@lst.de>
Cc: Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <cb49deea-e15f-aaca-60ef-7a642532c2e9@suse.de>
Date: Tue, 24 Jan 2017 08:37:16 +0100
MIME-Version: 1.0
In-Reply-To: <1485185361-29786-3-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/23/2017 04:29 PM, Christoph Hellwig wrote:
> Return an errno value instead of the passed in queue so that the callers
> don't have to keep track of two queues, and move the assignment of the
> request_fn and lock to the caller as passing them as argument doesn't
> simplify anything.  While we're at it also remove two pointless NULL
> assignments, given that the request structure is zeroed on allocation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c       | 38 +++++++++++++++-----------------------
>  drivers/md/dm-rq.c     |  3 ++-
>  include/linux/blkdev.h |  3 +--
>  3 files changed, 18 insertions(+), 26 deletions(-)
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
