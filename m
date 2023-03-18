Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093D9C761A6
	for <linux-block@archiver.kernel.org>; Sat, 18 Mar 2023 06:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCRGmN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Mar 2023 02:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCRGmM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Mar 2023 02:42:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EBB4345C
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 23:42:11 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6BDB168C4E; Sat, 18 Mar 2023 07:42:07 +0100 (CET)
Date:   Sat, 18 Mar 2023 07:42:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Message-ID: <20230318064206.GE24880@lst.de>
References: <20230317195938.1745318-1-bvanassche@acm.org> <20230317195938.1745318-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317195938.1745318-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 17, 2023 at 12:59:38PM -0700, Bart Van Assche wrote:
> @@ -380,8 +380,9 @@ struct bio *__bio_split_to_limits(struct bio *bio,
>  		blkcg_bio_issue_init(split);
>  		bio_chain(split, bio);
>  		trace_block_split(split, bio->bi_iter.bi_sector);
> -		submit_bio_noacct(bio);
> -		return split;
> +		submit_bio_noacct(split);
> +		*nr_segs = bio_nr_segments(lim, bio);

Please add this recalculation into the individual bio_split_*
functions, as the recalculation is only needed for regular read/write
bios.  It might also be slightly cheaper to just continue the segment
calculation there in the existing loop instead of starting a new
one after the split.
