Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39097 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751348AbdHXMXj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2017 08:23:39 -0400
Subject: Re: [PATCH 2/4] loop: set physical block size to PAGE_SIZE
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Ming Lei <ming.lei@redhat.com>,
        Karel Zak <kzak@redhat.com>, Milan Broz <gmazyland@gmail.com>
References: <cover.1503558155.git.osandov@fb.com>
 <378ae3760bd37441fd60a5188eae75f39babb6aa.1503558155.git.osandov@fb.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b6066a0b-ee02-609a-1d5b-867ba6af2e38@suse.de>
Date: Thu, 24 Aug 2017 14:23:37 +0200
MIME-Version: 1.0
In-Reply-To: <378ae3760bd37441fd60a5188eae75f39babb6aa.1503558155.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/24/2017 09:03 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The physical block size is "the lowest possible sector size that the
> hardware can operate on without reverting to read-modify-write
> operations" (from the comment on blk_queue_physical_block_size()). Since
> loop does buffered I/O on the backing file by default, the RMW unit is a
> page. This isn't the case for direct I/O mode, but let's keep it simple.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  drivers/block/loop.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 54e091887199..1a5b4ecf54ec 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1764,6 +1764,8 @@ static int loop_add(struct loop_device **l, int i)
>  	}
>  	lo->lo_queue->queuedata = lo;
>  
> +	blk_queue_physical_block_size(lo->lo_queue, PAGE_SIZE);
> +
>  	/*
>  	 * It doesn't make sense to enable merge because the I/O
>  	 * submitted to backing file is handled page by page.
> 
Let's see it this one goes through ...

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
