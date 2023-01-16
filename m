Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F144C54EBE
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 18:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjAPSFl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 13:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjAPSFN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 13:05:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451FB302A5
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 09:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hb6b31FoQwhLhalxcMhLI6IdFl0GweKKbBJWHy1W4N0=; b=3nvhWYqHj4kTrEK1z/BI+mvRS/
        xuTmEElTQmAXnRF/p/zbyFgNLTh4G2TQLuP4/v1o371I2bl2lv3Dxn72mwzzfpyE2RH7w96+ljDH3
        CljuyLiRvSv2pDPIdx600n7U3DlR+ouqHIllUB05L8TGv22luOYsSGCFix69gpm7cY1pmOBZxj8Bc
        018g75SHoT0XaigPASW1x3XEArrueAfZzx0vlabe8DB//mKrXYhgq0FWE0orY7Mt2AsVokRWurcBn
        blGkjXSfYdb2HnV0RPqmP6zOU0+ahpjIFsCtPEwXqGeAyBFpJP1roUAww6VBY6y+kxSiBQ2PLkB2P
        WlGZ5zwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHTeC-00BaQi-Ke; Mon, 16 Jan 2023 17:51:52 +0000
Date:   Mon, 16 Jan 2023 09:51:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] block: don't allow multiple bios for IOCB_NOWAIT issue
Message-ID: <Y8WOuHQ21PP/W6Rv@infradead.org>
References: <c5631d66-3627-5d04-c810-c060c9fd7077@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5631d66-3627-5d04-c810-c060c9fd7077@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 16, 2023 at 09:01:37AM -0700, Jens Axboe wrote:
> This depends on: 613b14884b85 ("block: handle bio_split_to_limits() NULL return")

Can we sort the NUL vs ERR_PTR thing there first?

> +	/*
> +	 * We're doing more than a bio worth of IO (> 256 pages), and we
> +	 * cannot guarantee that one of the sub bios will not fail getting
> +	 * issued FOR NOWAIT as error results are coalesced across all of
> +	 * them. Be safe and ask for a retry of this from blocking context.
> +	 */
> +	if (iocb->ki_flags & IOCB_NOWAIT)
> +		return -EAGAIN;
>  	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));

If the I/O is too a huge page we could easily end up with a single
bio here.
