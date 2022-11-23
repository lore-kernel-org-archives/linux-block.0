Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6C9C4332F
	for <linux-block@archiver.kernel.org>; Wed, 23 Nov 2022 18:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238282AbiKWS3Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 13:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238355AbiKWS24 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 13:28:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B3D94A59
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 10:28:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57EB861E69
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 18:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4602C433C1;
        Wed, 23 Nov 2022 18:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669228122;
        bh=c1QOASaIo+0UYVBWYG2Q8IJkg6i22hC4duAlGSseeVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YOCAzxTtxM5I6QYfChcaigs414QhMchA9CLeOaYQKuv1cCULRAxv5ow2zxhbtgvCM
         hUg3k1m8mbA6k4cNHQlX2+0zIS0MHrsx1c1jlvulfa4/2pfIjNjVog5A/rCyIN70ZC
         MDmFk3Y0r5uK6Z8KvN9LTpYv2CG24U0b/ShYC+20RfeGBfbcEue878tT2/yXAmTl1Q
         DWenvcYQ6MnGnrBfnd66CLzsj63OUyd8qUsZng+No5bmbxy8GnoiQM3WiPQpIYHXcr
         RU8K9QRoBDABU9ePBt6F9EUxu3vJ5OA8mXjT+I4zv7AzzD4gO3Z6o4T6gy/26CrwyR
         CDz2/DQRI2tqQ==
Date:   Wed, 23 Nov 2022 18:28:41 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] blk-crypto: Add a missing include directive
Message-ID: <Y35mWSUML0vdwqvz@gmail.com>
References: <20221123172923.434339-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221123172923.434339-1-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 23, 2022 at 09:29:23AM -0800, Bart Van Assche wrote:
> Allow the compiler to verify consistency of function declarations and
> function definitions. This patch fixes the following sparse errors:
> 
> block/blk-crypto-profile.c:241:14: error: no previous prototype for ‘blk_crypto_get_keyslot’ [-Werror=missing-prototypes]
>   241 | blk_status_t blk_crypto_get_keyslot(struct blk_crypto_profile *profile,
>       |              ^~~~~~~~~~~~~~~~~~~~~~
> block/blk-crypto-profile.c:318:6: error: no previous prototype for ‘blk_crypto_put_keyslot’ [-Werror=missing-prototypes]
>   318 | void blk_crypto_put_keyslot(struct blk_crypto_keyslot *slot)
>       |      ^~~~~~~~~~~~~~~~~~~~~~
> block/blk-crypto-profile.c:344:6: error: no previous prototype for ‘__blk_crypto_cfg_supported’ [-Werror=missing-prototypes]
>   344 | bool __blk_crypto_cfg_supported(struct blk_crypto_profile *profile,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
> block/blk-crypto-profile.c:373:5: error: no previous prototype for ‘__blk_crypto_evict_key’ [-Werror=missing-prototypes]
>   373 | int __blk_crypto_evict_key(struct blk_crypto_profile *profile,
>       |     ^~~~~~~~~~~~~~~~~~~~~~
> 
> Cc: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-crypto-profile.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
> index 96c511967386..0307fb0d95d3 100644
> --- a/block/blk-crypto-profile.c
> +++ b/block/blk-crypto-profile.c
> @@ -32,6 +32,7 @@
>  #include <linux/wait.h>
>  #include <linux/blkdev.h>
>  #include <linux/blk-integrity.h>
> +#include "blk-crypto-internal.h"
>  

Thanks.  This was already caught during testing and review of the patch that
introduced this problem, but I guess it is too late to fold this in.

- Eric
