Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE48CC38A02
	for <linux-block@archiver.kernel.org>; Fri, 28 Oct 2022 19:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiJ1TPE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 15:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ1TPD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 15:15:03 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3576A4CA3C
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 12:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=diqs7nCb+kYQLzsDPqW0DMHHGecdG9PnDlTDzIl2yN8=; b=sjUMZHBIVX4NxxWqfElc5Y3dqk
        4PZS81LSOk6ApGyi/+FRXYFe0yWoYzyx/fM0WhSQwKpeOkRX7Ss3pmEgN6AWp2qEg23UYoQl5O8dM
        L/Y9tYzb85deXumqY8eMjxHvw2uZE8c7sHhfrmVmND79SeV4lWsTb/V1T0lSoUTHTdxmRldaulmj3
        A2yd5B0JvfaqBVooIJBEAD3q8YwyOgA+1K6NnEoSijk6DUF+kMyoxy+NemHAa7la7P2NmmQigup3X
        U7HqOfANsj3MOUpyzX0/IV882B1fSN4VWfB/I0irBQMFzVN4fvgQwA8snjhe7nYrV3mKN85v6BCHc
        oe+xngaQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ooUok-00F1cN-2c;
        Fri, 28 Oct 2022 19:14:58 +0000
Date:   Fri, 28 Oct 2022 20:14:58 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
Subject: Re: [bug?] blk_queue_may_bounce() has the comparison max_low_pfn and
 max_pfn wrong way
Message-ID: <Y1wqMhQTsKopZuVP@ZenIV>
References: <Y1wZTtENDq3fvs6n@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1wZTtENDq3fvs6n@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 28, 2022 at 07:02:54PM +0100, Al Viro wrote:

> AFAICS, this condition is backwards - it should be
> 
> static inline bool blk_queue_may_bounce(struct request_queue *q)
> {
>         return IS_ENABLED(CONFIG_BOUNCE) &&
>                 q->limits.bounce == BLK_BOUNCE_HIGH &&
>                 max_low_pfn < max_pfn;
> }
> 
> What am I missing here?

More fun in that area:
	/*
	 * Bvec table can't be updated by bio_for_each_segment_all(),
	 * so retrieve bvec from the table directly. This way is safe
	 * because the 'bio' is single-page bvec.
	 */
	for (i = 0, to = bio->bi_io_vec; i < bio->bi_vcnt; to++, i++) {
		struct page *bounce_page;

		if (!PageHighMem(to->bv_page))
			continue;

		bounce_page = mempool_alloc(&page_pool, GFP_NOIO);
		inc_zone_page_state(bounce_page, NR_BOUNCE);

		if (rw == WRITE) {
			flush_dcache_page(to->bv_page);
			memcpy_from_bvec(page_address(bounce_page), to);
					 ^^^^^^^^^^^^^^^^^^^^^^^^^
		}
		to->bv_page = bounce_page;
	}

Consider the case when highmem page comes in bio_vec that covers the
second half of it.  We
	* allocate a bounce page
	* copy the second half of old page into the first half of new one
	* point the bio_vec to the second half of the new page.
	* submit the mangled bio.

While we are at it, the logics above that re splitting the bio before
bothering with bounces also looks somewhat fishy; if it triggers (which
needs > 256 elements in the original vector) we get bio split and
parts chained, then, assuming we run into a highmem page in each
half, we end up with

	bounce bio 1:	has ->bi_private pointing to bio 1, ->bi_end_io
			bounce_end_io_{read,write}().  Queued.
	bounce bio 2:	has ->bi_private pointing to bio 2, ->bi_end_io
			bounce_end_io_{read,write}().  Queued.
	bio 1:		original, covers the tail of original range.
	bio 2:		covers the beginning of original range,
			->bi_private points to bio 1, ->bi_end_io is
			bio_chain_endio().

Suppose the IO on bounce bio 2 fails.  We get ->bi_status of that sucker
set to non-zero.  ->bi_end_io() is called, leading to bounce_end_io(),
which will copy that status to bio 2 and call bio_endio() on bio 2.
Which will check ->bi_status on bio 1, see it zero and propagate the
error to bio 1.  Now bounce bio 1 completes without an error.
We still have zero in its ->bi_status and the call of bounce_end_io()
hits
        bio_orig->bi_status = bio->bi_status;
        bio_endio(bio_orig);
copying that zero to bio 1.  Oops - we'd just lost the error reported
by the IO on the other half...
