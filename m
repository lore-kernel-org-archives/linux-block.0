Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9783C6FA82
	for <linux-block@archiver.kernel.org>; Tue, 20 Sep 2022 07:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiITHkH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Sep 2022 03:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiITHjh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 03:39:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A8B61706
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 00:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lQEWbqYNJUNFIdRv8Z898OAPz16Sl1Mq1MnSEUghqfs=; b=aU5HjrcpIqDNkyABwLnVn/HIVs
        D4uKtb8rJ4LfAMANmd+cOfUhFVrHrYxzhxZVNpnrVPtIz3VLniaYBU/vxoma91cfcYTo4Ti0C8QQ3
        6aQfLFpIJXIjUSMFZI1Qj2NwFtH09r2hadivyU27fymqsTalGTg6xs2QrIH/nEyL5ViGn2w0raxk5
        XWTR97/KMkRY0Bljf/bE9+ZTftP0gBpEPoJcSCIvLcq9Nok2zKKsyWVSpTCPhu+ymrjjVPCzPU+k7
        eGf8C7rByZRgVv64idvW3dfdugf1pfS0IMQH0OhfJm/DmV/JCDz6ECASa/WF1Za5nfk31sSjz2XHY
        VsW5GmLw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaXqk-001Qp0-Kk; Tue, 20 Sep 2022 07:39:22 +0000
Date:   Tue, 20 Sep 2022 00:39:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 3/4] brd: enable discard
Message-ID: <YyluKtwOaLSPvNmI@infradead.org>
References: <alpine.LRH.2.02.2209151604410.13231@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2209160459470.543@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2209160459470.543@file01.intranet.prod.int.rdu2.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> @@ -289,6 +308,23 @@ static void brd_submit_bio(struct bio *b
>  	struct bio_vec bvec;
>  	struct bvec_iter iter;
>  
> +	if (bio_op(bio) == REQ_OP_DISCARD) {
> +		sector_t len = bio_sectors(bio);
> +		sector_t front_pad = -sector & (PAGE_SECTORS - 1);
> +		sector += front_pad;
> +		if (unlikely(len <= front_pad))
> +			goto endio;
> +		len -= front_pad;
> +		len = round_down(len, PAGE_SECTORS);
> +		while (len) {
> +			brd_free_page(brd, sector);
> +			sector += PAGE_SECTORS;
> +			len -= PAGE_SECTORS;
> +			cond_resched();
> +		}
> +		goto endio;
> +	}
> +
>  	bio_for_each_segment(bvec, bio, iter) {

Please add separate helpers to each type of IO and just make the
main submit_bio method a dispatch on the types instead of this
spaghetti code.

> +	disk->queue->limits.discard_granularity = PAGE_SIZE;
> +	blk_queue_max_discard_sectors(disk->queue, UINT_MAX);

We'll probably want an opt in for this new feature.
