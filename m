Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB28C433B4
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 20:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EBB16117A
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 20:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhDOUAw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 16:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234654AbhDOUAw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 16:00:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97EE461153;
        Thu, 15 Apr 2021 20:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618516828;
        bh=YdzC93TtVE0c8gSNhfkcwHAO6LR0ZLhJPv1nFw9o45U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u7o2RovIlzGObUUhH07Y1exQskWumZNUgqDq4bgFaqR7ntEHTgOfA0pgEXAF6s0s4
         utjLFEu5T3PDeGrp0WbEQavlsjP8l8t6MRJ8rxu+xUJyj6QuGWrVSQoMJ5/NltNaJ5
         KrU/OwCXCsCwQCcEGjehonlj1/SjJF+nUIF3PGFXmxfXFotXw5OjgPbMdXbiyDjfm1
         tkOcVuo6omwn/xXif89D4xiFhIV5KUZ+oxYhUcSREu0Wlcy4HZL5lfvyHk5/acx0TO
         ZdpF1W09qKOJAkO02sZ/tbrPSiSBZf3UEs6+C5n2OCp8wbngm9ZrvcJO7Q7SrrH1fy
         Eh1lhfGSz1QNA==
Date:   Thu, 15 Apr 2021 13:00:27 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 8/8] block: add WARN() in bio_split() for sector
 alignment
Message-ID: <YHibW4ndl4sQRkC2@gmail.com>
References: <20210325212609.492188-1-satyat@google.com>
 <20210325212609.492188-9-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325212609.492188-9-satyat@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 25, 2021 at 09:26:09PM +0000, Satya Tangirala wrote:
> The number of sectors passed to bio_split() should be aligned to
> bio_required_sector_alignment(). All callers (other than bounce.c) have
> been updated to ensure this, so add a WARN() if the number of sectors is
> not aligned. (bounce.c was not updated since it's legacy code that
> won't interact with inline encryption).

What does bounce.c "won't interact with inline encryption" mean, exactly?
Devices that enable bounce buffering won't declare inline encryption support, so
bounce.c will never see a bio that has an encryption context?

> diff --git a/block/bio.c b/block/bio.c
> index 26b7f721cda8..cb348f134a15 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1458,6 +1458,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
>  
>  	BUG_ON(sectors <= 0);
>  	BUG_ON(sectors >= bio_sectors(bio));
> +	WARN_ON(!IS_ALIGNED(sectors, bio_required_sector_alignment(bio)));

If this warning triggers, shouldn't the function return NULL to indicate a
failure rather than proceeding on?

- Eric
