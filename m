Return-Path: <SRS0=PnPs=7I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D540C433DF
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 23:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0920B20899
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 23:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590535254;
	bh=xrVFvxDC4L9h+KyIUKm+5dHHGSOZQYUfP3L/3TPpd1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2WrU6Jn24ZVo7VINE5vDtOhI1kLyMfaVNFZLhzzLcp6c61flH+Oza69uHAdaXtYD1
	 +XZ4zcdlIUm5065S+ylNFvNKuIGHPcJ+QFVHXLf7CFOJDVcmk/0nQyHPsgc4b7jN27
	 CNTZswmJ6lFl+bAzBp0IKdJ0ZsPOH8BSNu9e+Hlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389710AbgEZXUw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 May 2020 19:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389325AbgEZXUw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 May 2020 19:20:52 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5C98206D5;
        Tue, 26 May 2020 23:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590535252;
        bh=xrVFvxDC4L9h+KyIUKm+5dHHGSOZQYUfP3L/3TPpd1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LbUMb4xAkoLmZe+SD3jrSQBj5OmRJBV5CY7g/c9d9olwSx6BZHa5u4wyGKnrlz3JX
         cLhvwqob5PkRLckyvW8EekHX8Q54ROEokJPJNHIR4K8stAvrGybd8/iScxqsfg8baJ
         FbhshxKSckmkdne0feZ93cwom/fFkbJtiE518qI8=
Date:   Tue, 26 May 2020 16:20:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH][next] block: blk-crypto-fallback: remove redundant
 initialization of variable err
Message-ID: <20200526232050.GB182086@gmail.com>
References: <20200526224902.63975-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526224902.63975-1-colin.king@canonical.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 26, 2020 at 11:49:02PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable err is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  block/blk-crypto-fallback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
> index 74ab137ae3ba..6e49688a2d80 100644
> --- a/block/blk-crypto-fallback.c
> +++ b/block/blk-crypto-fallback.c
> @@ -529,7 +529,7 @@ static bool blk_crypto_fallback_inited;
>  static int blk_crypto_fallback_init(void)
>  {
>  	int i;
> -	int err = -ENOMEM;
> +	int err;
>  
>  	if (blk_crypto_fallback_inited)
>  		return 0;

Looks good, you can add:

	Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
