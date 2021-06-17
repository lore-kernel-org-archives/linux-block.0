Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6692DC48BE6
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 00:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 296C7613CB
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 00:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhFQAl2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 20:41:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhFQAl2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 20:41:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58A59613B9;
        Thu, 17 Jun 2021 00:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623890361;
        bh=03/ArqucxHWkgKNjFWE+MpTsoDqzRHJYD0xsgHKqwSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OAeJ38iRPpfWJVLqq4hxC0C4ILLheLnIaUrvFOT6NfQr1fc/dTpwMmhXL4lA0/sG1
         YtoD4k0ThX+oHg5iC1e9pCjxqEh9RHFYXMefih8rMxcImmc9qE8xHfFmX5yTzUM0io
         NctP8XqZwhFSqr7ScJQ5bK2zxZakyrVGSnFKHlRo4kEjdt44739MVS2xC7tCukRVgm
         j62d+wr6NLtggmeURNJdyT6V/7jMk3A+cfWXjOvjZO3/e9JmXfuNKUxviMIpFZinTz
         Ob+Br+NjrpiUKpPa80zA4KJErckGYKi+Ob76SVGibj17SiHGLBspOmF7ZTV+gG68zM
         e57KROc9triZQ==
Date:   Wed, 16 Jun 2021 17:39:20 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 04/10] block: respect bio_required_sector_alignment()
 in blk-crypto-fallback
Message-ID: <YMqZuBssXiMvDxIf@sol.localdomain>
References: <20210604195900.2096121-1-satyat@google.com>
 <20210604195900.2096121-5-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604195900.2096121-5-satyat@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 04, 2021 at 07:58:54PM +0000, Satya Tangirala wrote:
> Make blk_crypto_split_bio_if_needed() respect
> bio_required_sector_alignment() when calling bio_split(). Without this,
> blk-crypto-fallback could possibly split a bio in the middle of a data
> unit, and the resulting bios can no longer be encrypted (since encryption
> can only be done on complete crypto data units).
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  block/blk-crypto-fallback.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
> index c322176a1e09..85c813ef670b 100644
> --- a/block/blk-crypto-fallback.c
> +++ b/block/blk-crypto-fallback.c
> @@ -19,6 +19,7 @@
>  #include <linux/module.h>
>  #include <linux/random.h>
>  
> +#include "blk.h"
>  #include "blk-crypto-internal.h"
>  
>  static unsigned int num_prealloc_bounce_pg = 32;
> @@ -225,6 +226,8 @@ static bool blk_crypto_split_bio_if_needed(struct bio **bio_ptr)
>  	if (num_sectors < bio_sectors(bio)) {
>  		struct bio *split_bio;
>  
> +		num_sectors = round_down(num_sectors,
> +					 bio_required_sector_alignment(bio));
>  		split_bio = bio_split(bio, num_sectors, GFP_NOIO,
>  				      &crypto_bio_split);
>  		if (!split_bio) {
> -- 

Reviewed-by: Eric Biggers <ebiggers@google.com>
