Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05665C43334
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 23:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379371AbiFPXVV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 19:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379359AbiFPXVU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 19:21:20 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E699362BD4
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 16:21:19 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id i19so4248803qvu.13
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 16:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xGBUeFZ3kzOUfo8Z+CVdU374hif3wHQ3Al0jBzW3Lq0=;
        b=6K22rddrtA1YS3SnYMPixhDgpmly7xN3P6fQaz/B3wxyUNKvYfe/RCbOBW0V8lkBmA
         GaofxGhl/tEKJUun2I5Wb/6VHxdBZ0+jf/ogunmuzKLN2ej+OCo4TKO0y+YFoJHT+X3G
         VdzYHsa30qYB55wT06nXDu8+yVuxuTQeQEW8RYmM1dO1gEQndrMBUdeX7fTmXa4hNGvi
         Y4tLAFpmbLZ40RwT5FMaE1yQM7gpfjOyJANV/EYG3jNzWpySzALxp8OpiBPxeb+sdceV
         Cmrzna3yLPqxEbm/5W2BGdC9VF7kt5uDI+s5uKWbE/eCiL7XsC42zpofdwJBxwpPu/0Z
         IoHA==
X-Gm-Message-State: AJIora+T4vC+f5UWuvcEHGqrMYRWsc2SjFlAKd9pYG6cJ4JAP432Yobd
        qsOUqOlgHwVOIYlaUFdSqy9A6n2wuX8O
X-Google-Smtp-Source: AGRyM1sbd0C9yAQtprkahYGVnorsFh8MimX5KCOPjnIsKQgw0Zel5KKGSpsnl0iVAj0zuc2/Di2GBw==
X-Received: by 2002:ac8:5a50:0:b0:305:20c4:791d with SMTP id o16-20020ac85a50000000b0030520c4791dmr6258068qta.437.1655421678946;
        Thu, 16 Jun 2022 16:21:18 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id q13-20020a37f70d000000b006a91da2fc8dsm2875780qkj.0.2022.06.16.16.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 16:21:18 -0700 (PDT)
Date:   Thu, 16 Jun 2022 19:21:17 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/6] dm: open code blk_max_size_offset in max_io_len
Message-ID: <Yqu67Y4+n9KzKUf1@redhat.com>
References: <20220614090934.570632-1-hch@lst.de>
 <20220614090934.570632-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614090934.570632-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 14 2022 at  5:09P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> max_io_len always passes an explicitly non-zero chunk_sectors into
> blk_max_size_offset.  That means much of blk_max_size_offset is not
> needed and can be open coded to simplify the code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/md/dm.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index d8f16183bf27c..0514358a1f8e5 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1079,23 +1079,18 @@ static sector_t max_io_len(struct dm_target *ti, sector_t sector)
>  {
>  	sector_t target_offset = dm_target_offset(ti, sector);
>  	sector_t len = max_io_len_target_boundary(ti, target_offset);
> -	sector_t max_len;
>  
>  	/*
>  	 * Does the target need to split IO even further?
>  	 * - varied (per target) IO splitting is a tenet of DM; this
>  	 *   explains why stacked chunk_sectors based splitting via
> -	 *   blk_max_size_offset() isn't possible here. So pass in
> -	 *   ti->max_io_len to override stacked chunk_sectors.
> +	 *   blk_queue_split() isn't possible here.
>  	 */
> -	if (ti->max_io_len) {
> -		max_len = blk_max_size_offset(ti->table->md->queue,
> -					      target_offset, ti->max_io_len);
> -		if (len > max_len)
> -			len = max_len;
> -	}
> -
> -	return len;
> +	if (!ti->max_io_len)
> +		return len;
> +	return min_t(sector_t, len,
> +		min(queue_max_sectors(ti->table->md->queue),
> +		    blk_chunk_sectors_left(target_offset, ti->max_io_len)));
>  }
>  
>  int dm_set_target_max_io_len(struct dm_target *ti, sector_t len)
> -- 
> 2.30.2
> 

Not in love with the nested min() but don't have a better suggestion.

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
