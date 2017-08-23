Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44009 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753300AbdHWGTd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2017 02:19:33 -0400
Subject: Re: [PATCH v3 2/4] loop: set discard and write zeroes limits in 512
 byte sectors
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Ming Lei <ming.lei@redhat.com>,
        Karel Zak <kzak@redhat.com>, Milan Broz <gmazyland@gmail.com>
References: <cover.1503422996.git.osandov@fb.com>
 <de779f09f7c7f38268967572eeeddbd071ab6533.1503422996.git.osandov@fb.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6dfd13bd-c439-b9a1-2c16-afa57cce4559@suse.de>
Date: Wed, 23 Aug 2017 08:19:31 +0200
MIME-Version: 1.0
In-Reply-To: <de779f09f7c7f38268967572eeeddbd071ab6533.1503422996.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/22/2017 07:32 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> max_discard_sectors and max_write_zeroes_sectors are in 512 byte
> sectors, not device sectors.
> 
> Fixes: f2c6df7dbf9a ("loop: support 4k physical blocksize")
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  drivers/block/loop.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 26548e07bc31..a444dc2d5977 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -820,7 +820,6 @@ static void loop_config_discard(struct loop_device *lo)
>  	struct file *file = lo->lo_backing_file;
>  	struct inode *inode = file->f_mapping->host;
>  	struct request_queue *q = lo->lo_queue;
> -	int lo_bits = 9;
>  
>  	/*
>  	 * We use punch hole to reclaim the free space used by the
> @@ -840,11 +839,8 @@ static void loop_config_discard(struct loop_device *lo)
>  
>  	q->limits.discard_granularity = inode->i_sb->s_blocksize;
>  	q->limits.discard_alignment = 0;
> -	if (lo->lo_flags & LO_FLAGS_BLOCKSIZE)
> -		lo_bits = blksize_bits(lo->lo_logical_blocksize);
> -
> -	blk_queue_max_discard_sectors(q, UINT_MAX >> lo_bits);
> -	blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> lo_bits);
> +	blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
> +	blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
>  	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
>  }
>  
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
