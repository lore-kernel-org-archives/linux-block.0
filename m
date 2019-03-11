Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D1CC43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 14:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8192E206BA
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 14:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfCKOgB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:36:01 -0400
Received: from verein.lst.de ([213.95.11.211]:41848 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfCKOgB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 10:36:01 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 92E9968CEC; Mon, 11 Mar 2019 15:35:54 +0100 (CET)
Date:   Mon, 11 Mar 2019 15:35:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/6] block: enable multi-page bvec for passthrough IO
Message-ID: <20190311143554.GE7850@lst.de>
References: <20190309013737.27741-1-ming.lei@redhat.com> <20190309013737.27741-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309013737.27741-6-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>  		struct bio_vec *prev = &bio->bi_io_vec[bio->bi_vcnt - 1];
>  
> +		/* segment size is always >= PAGE_SIZE */

I don't think that actually is true.  We have various drivers with 4k
segment size, for which this would not be true with a 64k page size
system.

>  		if (page == prev->bv_page &&
>  		    offset == prev->bv_offset + prev->bv_len) {
>  			if (put_same_page)
>  				put_page(page);
> + bvec_merge:
>  			prev->bv_len += len;
>  			bio->bi_iter.bi_size += len;

Please throw in a cleanup patch that removes prev and and always uses
bvec, then we can just move the done label up by two lines and handle
the increment of bv_len and bi_size in a common branch.

>   done:
> +	bio->bi_phys_segments = bio->bi_vcnt;
> +	if (!bio_flagged(bio, BIO_SEG_VALID))
> +		bio_set_flag(bio, BIO_SEG_VALID);

How would BIO_SEG_VALID get set previously?  And even if it did
we wouldn't optimize much here, I'd just do it unconditionally.

Btw, there are various comments in this function that either already
were or have become out of data, like talking about REQ_PC or
file system I/O - I think they could use some love.
