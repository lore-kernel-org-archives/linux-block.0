Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED4DC433C1
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 18:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE43619D1
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 18:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhC3SHP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 14:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbhC3SHF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 14:07:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EF6C061574;
        Tue, 30 Mar 2021 11:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ikqdyaQPieS1igk4+QfbwgRhqOQlOvMU3Hk6slv/dvs=; b=ef2wi2xvLt0TG4RIghAyy9jVoc
        0sUS3+iLBFCGTy0jwTN/+ZeLRLcVlOYM+bCLA0oviPLb/SoortrsGw94ooWezevAiGEWeSj70N4SO
        znDAxVDkv8t+oUx7p+OoArsKeU4sEyu8KCfiWnZtVpaM0RxhXzjiZvF1Y6P3WylQ4voL0pXA37ah0
        MdWqZQH6Y2nlxbMaXpE9C4LIkwlOHgVi8nRcRdP2BiiTtZhIwLpqnfUsf0ONm9xKzv4abufX5btDl
        nTRWzeYnguqcPDNfIOcbZ/cEpEF7PBxe37HoMsBO4R08L/j/PMHGKPkCN14u/wP4moZxfflooo0iR
        72Ieh34Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRIlR-003PTG-8Z; Tue, 30 Mar 2021 18:06:56 +0000
Date:   Tue, 30 Mar 2021 19:06:53 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 4/8] block: introduce bio_required_sector_alignment()
Message-ID: <20210330180653.GB811594@infradead.org>
References: <20210325212609.492188-1-satyat@google.com>
 <20210325212609.492188-5-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325212609.492188-5-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 25, 2021 at 09:26:05PM +0000, Satya Tangirala wrote:
> +/*
> + * The required sector alignment for a bio. The number of sectors in any bio
> + * that's constructed/split must be aligned to this value.
> + */
> +static inline unsigned int bio_required_sector_alignment(struct bio *bio)
> +{
> +	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> +
> +	return max(queue_logical_block_size(q) >> SECTOR_SHIFT,
> +		   blk_crypto_bio_sectors_alignment(bio));
> +}

It might make more sense to just have a field in the request queue
for the max alignment so that the fast path just looks at one field.
Then the various setup time functions would update it to the maximum
required.
