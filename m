Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4A9C6FA82
	for <linux-block@archiver.kernel.org>; Wed,  7 Sep 2022 20:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiIGUzu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Sep 2022 16:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiIGUzt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Sep 2022 16:55:49 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9E29CCDF
        for <linux-block@vger.kernel.org>; Wed,  7 Sep 2022 13:55:47 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g14so11408416qto.11
        for <linux-block@vger.kernel.org>; Wed, 07 Sep 2022 13:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=7QDpSKyGoyq0TfdmAsz5OOGorpsRw7jW9ugW7EIFS1Y=;
        b=5x2RRgeSS/INucnvmU9HgGyW5hG2MO6YHA9sFrzyddKdJsIP38EUxb3H++yiBZr3Vw
         MsrHqXqa76W0Ey39IRZ5xe8tKA/oN26D2czzVtwEekXbGdrBaGQBQSMSWLxtgay9YGRT
         P8CO93qG4JAMzClS//KoyvwjCb27Bl4EKy4+/cIkb6qhqgZn3v26qjJMARXx58lPLoxL
         QKaMXjCUwiYMkfHM1VfouuQmWzkCe1fDIwJWuT2FQ3wowsAioahwvaFqPQPi5cDrHWtz
         k+hYXmKtQvJ0HbPISbzqfw66DZDVsameyPl2cmHt6ut5FmF9IkcD4lCRoPfrZSa3HYnl
         AIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=7QDpSKyGoyq0TfdmAsz5OOGorpsRw7jW9ugW7EIFS1Y=;
        b=n+MrwTbD1DanZkU0QpkykveNkJudsScjli37VwL5EWW/KoXkKGUh7hZzYQjjUT1ITr
         Py2sqlsVxCZN9HKhJsGe9CEKuMJYuCzrtbFu7TKD/Eyq9GpXHd7L5qx+NCPjQLE1UA4u
         yWG0f4vm9f5DgdBu7IpXz8+Z1EE/n0uRzHkWwFLlGSim33nHwfJ9n4CTuxpPVnC9Kk9O
         /LJkK+uivEO6AouuqlQHW1Uj9231m188J59SY2RFyF5RjS9Ltaf2aOUMzUNbpnW/FAmv
         YrordyccWGskTzTZN+Ypjp9vFUso+f33qYmQXOgHmqV1TAKDR/7qJs62893IeTfYjh8N
         wRpQ==
X-Gm-Message-State: ACgBeo0kvX00fbjSi3gAiPX3UZjw6NUUmAtSkFl3RnJZM3Xrb5wRhlV2
        SD/VnD9U2bgtuJ21yPyqURKf+w==
X-Google-Smtp-Source: AA6agR6ZQ6FvGTHSjDRFmG4lPsnCGnHrEaMWr7Z46AK+gbY20ojw8yPogoqFqXUdktjW0eJ5BrWzXw==
X-Received: by 2002:ac8:5f4a:0:b0:344:5dd9:27d8 with SMTP id y10-20020ac85f4a000000b003445dd927d8mr5070628qta.543.1662584146882;
        Wed, 07 Sep 2022 13:55:46 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h12-20020a05620a284c00b006b8d9d53605sm15287968qkp.125.2022.09.07.13.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:55:46 -0700 (PDT)
Date:   Wed, 7 Sep 2022 16:55:45 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        osandov@osandov.com
Subject: Re: [PATCH 07/17] btrfs: allow btrfs_submit_bio to split bios
Message-ID: <YxkFUeLBWhnufb7U@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-8-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:06AM +0300, Christoph Hellwig wrote:
> Currently the I/O submitters have to split bios according to the
> chunk stripe boundaries.  This leads to extra lookups in the extent
> trees and a lot of boilerplate code.
> 
> To drop this requirement, split the bio when __btrfs_map_block
> returns a mapping that is smaller than the requested size and
> keep a count of pending bios in the original btrfs_bio so that
> the upper level completion is only invoked when all clones have
> completed.
> 
> Based on a patch from Qu Wenruo.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/volumes.c | 106 +++++++++++++++++++++++++++++++++++++--------
>  fs/btrfs/volumes.h |   1 +
>  2 files changed, 90 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 5c6535e10085d..0a2d144c20604 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -35,6 +35,7 @@
>  #include "zoned.h"
>  
>  static struct bio_set btrfs_bioset;
> +static struct bio_set btrfs_clone_bioset;
>  static struct bio_set btrfs_repair_bioset;
>  static mempool_t btrfs_failed_bio_pool;
>  
> @@ -6661,6 +6662,7 @@ static void btrfs_bio_init(struct btrfs_bio *bbio, struct inode *inode,
>  	bbio->inode = inode;
>  	bbio->end_io = end_io;
>  	bbio->private = private;
> +	atomic_set(&bbio->pending_ios, 1);
>  }
>  
>  /*
> @@ -6698,6 +6700,57 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size,
>  	return bio;
>  }
>  
> +static struct bio *btrfs_split_bio(struct bio *orig, u64 map_length)
> +{
> +	struct btrfs_bio *orig_bbio = btrfs_bio(orig);
> +	struct bio *bio;
> +
> +	bio = bio_split(orig, map_length >> SECTOR_SHIFT, GFP_NOFS,
> +			&btrfs_clone_bioset);
> +	btrfs_bio_init(btrfs_bio(bio), orig_bbio->inode, NULL, orig_bbio);
> +
> +	btrfs_bio(bio)->file_offset = orig_bbio->file_offset;
> +	orig_bbio->file_offset += map_length;

I'm worried about this for the ONE_ORDERED case.  We specifically used the
ONE_ORDERED thing because our file_offset was the start, but our length could go
past the range of the ordered extent, and then we wouldn't find our ordered
extent and things would go quite wrong.

Instead we should do something like

if (!(orig->bi_opf & REQ_BTRFS_ONE_ORDERED))
	orig_bbio->file_offset += map_length;

I've cc'ed Omar since he's the one who added this and I'm a little confused
about how this can happen.

> +
> +	atomic_inc(&orig_bbio->pending_ios);
> +	return bio;
> +}
> +
> +static void btrfs_orig_write_end_io(struct bio *bio);
> +static void btrfs_bbio_propagate_error(struct btrfs_bio *bbio,
> +				       struct btrfs_bio *orig_bbio)
> +{
> +	/*
> +	 * For writes btrfs tolerates nr_mirrors - 1 write failures, so we
> +	 * can't just blindly propagate a write failure here.
> +	 * Instead increment the error count in the original I/O context so
> +	 * that it is guaranteed to be larger than the error tolerance.
> +	 */
> +	if (bbio->bio.bi_end_io == &btrfs_orig_write_end_io) {
> +		struct btrfs_io_stripe *orig_stripe = orig_bbio->bio.bi_private;
> +		struct btrfs_io_context *orig_bioc = orig_stripe->bioc;
> +		

Whitespace error here.  Thanks,

Josef
