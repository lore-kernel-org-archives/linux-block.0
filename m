Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2F8C43334
	for <linux-block@archiver.kernel.org>; Sun, 26 Jun 2022 21:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiFZVh1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jun 2022 17:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiFZVh0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jun 2022 17:37:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820222DC4
        for <linux-block@vger.kernel.org>; Sun, 26 Jun 2022 14:37:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 122B360FD1
        for <linux-block@vger.kernel.org>; Sun, 26 Jun 2022 21:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB63C34114;
        Sun, 26 Jun 2022 21:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656279444;
        bh=/CdIg2Lm6IhOh5xd8f2LTTXO9jR44gso01xIJfuultI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kHrJD4pCOpdaNcykNoBdK1K/S6OstTeR973gxwtCeHbiXkDV4wLCE6CKEAL/9YtNJ
         ufOeTE57mVLv6nXPkmS+mbes90YaOTDrEa4TZ+AA69jdDhilSeJdg0sTBTZZV5gMex
         my1AMHK5GXLLvnwfZs3ZEHIWmkBRtejdjS351G9DV0dMHfso2zi8/tqimdrxY2BKHO
         5aCnhYTLJY/oHV8ffpnHK0zsmZz9wVbZhiWUHYaNRwRngEKGwMky/MjSq7CoWP6vwI
         4DExX5WdcmswtTT1/nv8fGUgWmyt8coFZIrS+dntFt6UHDa75/kqL8FtAXpjcDbFM9
         Gi0OeQjuND4Ow==
Date:   Sun, 26 Jun 2022 14:37:22 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [dm-devel] [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <YrjRkp9y99KZdwMo@sol.localdomain>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
 <20220624141255.2461148-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624141255.2461148-2-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 24, 2022 at 10:12:52PM +0800, Ming Lei wrote:
> diff --git a/block/blk-crypto.c b/block/blk-crypto.c
> index a496aaef85ba..caae2f429fc7 100644
> --- a/block/blk-crypto.c
> +++ b/block/blk-crypto.c
> @@ -134,6 +134,21 @@ void bio_crypt_dun_increment(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
>  	}
>  }
>  
> +/* Decrements @dun by @dec, treating @dun as a multi-limb integer. */
> +void bio_crypt_dun_decrement(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
> +			     unsigned int dec)
> +{
> +	int i;
> +
> +	for (i = 0; dec && i < BLK_CRYPTO_DUN_ARRAY_SIZE; i++) {
> +		dun[i] -= dec;
> +		if (dun[i] > inc)
> +			dec = 1;
> +		else
> +			dec = 0;
> +	}
> +}

This doesn't compile.  Also this doesn't handle underflow into the next limb
correctly.  A correct version would be:

		u64 prev = dun[i];

		dun[i] -= dec;
		if (dun[i] > prev)
			dec = 1;
		else
			dec = 0;

- Eric
