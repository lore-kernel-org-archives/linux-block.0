Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E77C48BE5
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 03:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C68C613ED
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 03:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhFQD12 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 23:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhFQD11 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 23:27:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A373613E2;
        Thu, 17 Jun 2021 03:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623900320;
        bh=J0kzdhaMtpUvhbUW6biNjc2y50gU7Sy+I3gf/5v19Xw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AzmeQwm0Mm9a2QQ4rlF5B/3kk2Ym5VIE/9YrI00DosgWiREjUivMMufy/WNlEHuez
         UpX4TOy/7k2cE/vSuI6Kis0TXF/a/O98gYEKz2RnjsKbaXbPkHkjOm6+2dZ9nS3Xjl
         e7SXa6tle0ASPATqjVFrXh29nQsXaGve1ZjQgIUTS5QbHEdmr7Khj5/DxOW8MQU7gw
         xiZucwiJNAj4ZjI83TnToeqx3h6zjZEmlHWc4cDVyyCAnS5xSx3XP0tRTFNv0y2OKl
         XBdl2+uW2GSKE8/nztvlcsNqXrPMlXRzxi1ALnEAXEfF8yxi2OTWQN4j3kHqFtz31c
         a3ZMz9VAqVbbQ==
Date:   Wed, 16 Jun 2021 20:25:19 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 07/10] mmc: handle error from blk_ksm_register()
Message-ID: <YMrAn7EkKkNVEjUW@sol.localdomain>
References: <20210604195900.2096121-1-satyat@google.com>
 <20210604195900.2096121-8-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604195900.2096121-8-satyat@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 04, 2021 at 07:58:57PM +0000, Satya Tangirala wrote:
> Handle any error from blk_ksm_register() in the callers. Previously,
> the callers ignored the return value because blk_ksm_register() wouldn't
> fail as long as the request_queue didn't have integrity support too, but
> as this is no longer the case, it's safer for the callers to just handle
> the return value appropriately.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  drivers/mmc/core/crypto.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
> index 419a368f8402..cccd8c7d7e7a 100644
> --- a/drivers/mmc/core/crypto.c
> +++ b/drivers/mmc/core/crypto.c
> @@ -21,8 +21,17 @@ void mmc_crypto_set_initial_state(struct mmc_host *host)
>  
>  void mmc_crypto_setup_queue(struct request_queue *q, struct mmc_host *host)
>  {
> -	if (host->caps2 & MMC_CAP2_CRYPTO)
> -		blk_ksm_register(&host->ksm, q);
> +	if (host->caps2 & MMC_CAP2_CRYPTO) {
> +		/*
> +		 * This WARN_ON should never trigger since &host->ksm won't be
> +		 * "empty" (i.e. will support at least 1 crypto capability), an
> +		 * MMC device's request queue doesn't support integrity, and
> +		 * it also satisfies all the block layer constraints (i.e.
> +		 * supports SG gaps, doesn't have chunk sectors, has a
> +		 * sufficiently large supported max_segments per bio)
> +		 */
> +		WARN_ON(!blk_ksm_register(&host->ksm, q));
> +	}
>  }

There appear to be some MMC host drivers that set max_segments to 1, so this
explanation may not hold.  It may hold for every driver that actually supports
crypto, though.

- Eric
