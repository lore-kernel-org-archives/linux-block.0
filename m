Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4A9C433E0
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 17:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C8964DA0
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 17:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbhA0RSG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 12:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbhA0RRH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 12:17:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8770EC061573
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 09:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EUnA4Dv41Tlb25xf8Fr87TWOaQGU815hKWgMiwbbQHE=; b=rihxa2EuKWaqJa8ohDr7574zqr
        xTzvhD6YnZuADi+g25b04azfPDEvDH9JmcVDjbDbTR6ei0l0MQsEwr3Wkzluf2M2ElatPtCR4tsNF
        uT7LmqWrCFNPv4otkOMCF3VZVMa5Zo/a38CQnlXjX3bGlM+suviqTIRrEKBJ0u/4s+r5py80IiTJZ
        kVQMxCBwke2TCu5hKlttFfzHi1n3VF21nH+VIaIRwZcGUxVWPprrby5wbFy4+G18uu+Bz53kx2Jwq
        2SFUJt3X7IIavlEurttbcDSBP4zdEr6Yjd0S7d94XP5XG27S4GrUhzEIOHcfFHftvaRv+fp+2p3H8
        bb9CK/3g==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4oQM-007HCb-76; Wed, 27 Jan 2021 17:16:12 +0000
Date:   Wed, 27 Jan 2021 17:16:10 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 2/2] block: add a fast path for seg split of large bio
Message-ID: <20210127171610.GA1733363@infradead.org>
References: <cover.1609875589.git.asml.silence@gmail.com>
 <53b86d4e86c4913658cb0f472dcc3e22ef75396b.1609875589.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53b86d4e86c4913658cb0f472dcc3e22ef75396b.1609875589.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 05, 2021 at 07:43:38PM +0000, Pavel Begunkov wrote:
> blk_bio_segment_split() is very heavy, but the current fast path covers
> only one-segment under PAGE_SIZE bios. Add another one by estimating an
> upper bound of sectors a bio can contain.
> 
> One restricting factor here is queue_max_segment_size(), which it
> compare against full iter size to not dig into bvecs. By default it's
> 64KB, and so for requests under 64KB, but for those falling under the
> conditions it's much faster.

I think this works, but it is a pretty gross heuristic, which also
doesn't help us with NVMe, which is the I/O fast path of choice for
most people.  What is your use/test case?

> +		/*
> +		 * Segments are contiguous, so only their ends may be not full.
> +		 * An upper bound for them would to assume that each takes 1B
> +		 * but adds a sector, and all left are just full sectors.
> +		 * Note: it's ok to round size down because all not full
> +		 * sectors are accounted by the first term.
> +		 */
> +		max_sectors = bio_segs * 2;
> +		max_sectors += bio->bi_iter.bi_size >> 9;
> +
> +		if (max_sectors < q_max_sectors) {

I don't think we need the max_sectors variable here.
