Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AF1C4338F
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 16:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50C4A60E9C
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 16:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhGWQFC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230098AbhGWQFC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jul 2021 12:05:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96F8D60200;
        Fri, 23 Jul 2021 16:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627058735;
        bh=oG9Zb9KNT9SOC+hQzLLu3rLDODvxQljE/YxTyTbn1Kk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=emmO3/Pm3SSqfaFQOoPFs1BtxmTdejPYPYNj5YR9hVXjgLW6zQKA3RYTUJhK5e9p0
         AGT4Xm0/250bDC145wCUMSVIUEX1xIvLxbFMxues1eOO+E9wj/kHPbdgFZaStshU25
         SH6gJVEY4fbce9kEE4B0gkjxGjo3bgTFj0dTmp89X6WVuUfNDRZ8yOY2A4vPEfyAtc
         5W0aH3hZbdPdt/sm8yC6AZt4TgMLxcEiwk1wmdzHofeRk6aahXPLClMNzqsrGTIaoQ
         XIJj7dBOzkW+NGC3Q+upsSpE+Umox22B29mEH9n2GG1n6FzRWoHOSgx2QdfzUhtrCc
         RQkOsZT++ebNQ==
Date:   Fri, 23 Jul 2021 09:45:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyaprateek2357@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v4 2/9] block: blk-crypto: introduce
 blk_crypto_bio_sectors_alignment()
Message-ID: <YPryLugFwNW+hrT8@gmail.com>
References: <20210707052943.3960-1-satyaprateek2357@gmail.com>
 <20210707052943.3960-3-satyaprateek2357@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707052943.3960-3-satyaprateek2357@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 06, 2021 at 10:29:36PM -0700, Satya Tangirala wrote:
> From: Satya Tangirala <satyat@google.com>
> 
> The size of any bio must be aligned to the data unit size of the bio crypt
> context (if it exists) of that bio. This must also be ensured whenever a
> bio is split. Introduce blk_crypto_bio_sectors_alignment() that returns the
> required alignment in sectors. The number of sectors passed to any call of
> bio_split() must be aligned to blk_crypto_bio_sectors_alignment().
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  block/blk-crypto-internal.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
