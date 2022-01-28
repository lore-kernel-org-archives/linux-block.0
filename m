Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66170C433F5
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 06:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiA1GNM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 01:13:12 -0500
Received: from verein.lst.de ([213.95.11.211]:46930 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242326AbiA1GNM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 01:13:12 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C703668AA6; Fri, 28 Jan 2022 07:13:08 +0100 (CET)
Date:   Fri, 28 Jan 2022 07:13:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     axboe@kernel.dk, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3 1/3] block: add bio_start_io_acct_time() to control
 start_time
Message-ID: <20220128061308.GA1477@lst.de>
References: <20220128041753.32195-1-snitzer@redhat.com> <20220128041753.32195-2-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128041753.32195-2-snitzer@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 27, 2022 at 11:17:51PM -0500, Mike Snitzer wrote:
> +	__part_start_io_acct(bio->bi_bdev, bio_sectors(bio),
> +			     bio_op(bio), start_time);
>  }
> +EXPORT_SYMBOL_GPL(bio_start_io_acct_time);
>  
>  /**
>   * bio_start_io_acct - start I/O accounting for bio based drivers
> @@ -1084,14 +1096,15 @@ static unsigned long __part_start_io_acct(struct block_device *part,
>   */
>  unsigned long bio_start_io_acct(struct bio *bio)
>  {
> -	return __part_start_io_acct(bio->bi_bdev, bio_sectors(bio), bio_op(bio));
> +	return __part_start_io_acct(bio->bi_bdev, bio_sectors(bio),
> +				    bio_op(bio), jiffies);

Is droppingthe READ_ONCE safe here?  This is a honest question as these
helpers still confuse me.

The rest looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
