Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16ECC32771
	for <linux-block@archiver.kernel.org>; Wed, 28 Sep 2022 17:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiI1Rbb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Sep 2022 13:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbiI1Rb0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Sep 2022 13:31:26 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA087C1F9;
        Wed, 28 Sep 2022 10:31:24 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3B89D68BEB; Wed, 28 Sep 2022 19:31:21 +0200 (CEST)
Date:   Wed, 28 Sep 2022 19:31:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH for-next v10 5/7] block: factor out bio_map_get helper
Message-ID: <20220928173121.GC17153@lst.de>
References: <20220927173610.7794-1-joshi.k@samsung.com> <CGME20220927174636epcas5p49008baa36dcbf2f61c25ba89c4707c0c@epcas5p4.samsung.com> <20220927173610.7794-6-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173610.7794-6-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 27, 2022 at 11:06:08PM +0530, Kanchan Joshi wrote:
> Move bio allocation logic from bio_map_user_iov to a new helper
> bio_map_get. It is named so because functionality is opposite of what is
> done inside bio_map_put. This is a prep patch.

I'm still not a fan of using bio_sets for passthrough and would be
much happier if we could drill down what the problems with the
slab per-cpu allocator are, but it seems like I've lost that fight
against Jens..

> +static struct bio *bio_map_get(struct request *rq, unsigned int nr_vecs,
>  		gfp_t gfp_mask)

But these names just seems rather misleading.  Why not someting
like blk_rq_map_bio_alloc and blk_mq_map_bio_put?

Not really new in this code but a question to Jens:  The existing
bio_map_user_iov has no real upper bounds on the number of bios
allocated, how does that fit with the very limited pool size of
fs_bio_set?

