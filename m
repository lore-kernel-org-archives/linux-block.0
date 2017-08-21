Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33694 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751062AbdHUF7M (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Aug 2017 01:59:12 -0400
Subject: Re: [PATCH v2 3/3] loop: always return block size in LOOP_GET_STATUS
To: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Ming Lei <ming.lei@redhat.com>,
        Karel Zak <kzak@redhat.com>
References: <cover.1503084216.git.osandov@fb.com>
 <1cd56dabbd92fd4b5936577048aa117ae85d74a3.1503084216.git.osandov@fb.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c3ec661c-68b0-fbc7-2b84-6f99cc85cbb1@suse.de>
Date: Mon, 21 Aug 2017 07:59:10 +0200
MIME-Version: 1.0
In-Reply-To: <1cd56dabbd92fd4b5936577048aa117ae85d74a3.1503084216.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/18/2017 09:27 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> When I was writing a test for the new loop device block size
> functionality, I noticed a couple of issues with how LOOP_GET_STATUS
> handles the block size:
> 
> - lo_init[0] is never filled in with the logical block size we
>   previously set
> - lo_flags returned from LOOP_GET_STATUS will have LO_FLAGS_BLOCKSIZE
>   set if we previously called LOOP_SET_STATUS with LO_FLAGS_BLOCKSIZE
>   set, which doesn't really mean anything
> 
> Instead, for LOOP_GET_STATUS, let's always fill in lo_init[0] and set
> the LO_FLAGS_BLOCKSIZE flag to indicate we support it.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  drivers/block/loop.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 94227a327ce2..a1ac50bc4812 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1224,7 +1224,7 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
>  	info->lo_rdevice = huge_encode_dev(lo->lo_device ? stat.rdev : stat.dev);
>  	info->lo_offset = lo->lo_offset;
>  	info->lo_sizelimit = lo->lo_sizelimit;
> -	info->lo_flags = lo->lo_flags;
> +	info->lo_flags = lo->lo_flags | LO_FLAGS_BLOCKSIZE;
>  	memcpy(info->lo_file_name, lo->lo_file_name, LO_NAME_SIZE);
>  	memcpy(info->lo_crypt_name, lo->lo_crypt_name, LO_NAME_SIZE);
>  	info->lo_encrypt_type =
> @@ -1234,6 +1234,7 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
>  		memcpy(info->lo_encrypt_key, lo->lo_encrypt_key,
>  		       lo->lo_encrypt_key_size);
>  	}
> +	LO_INFO_BLOCKSIZE(info) = queue_logical_block_size(lo->lo_queue);
>  	return 0;
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
