Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C9BC4338F
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 17:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC3260EB5
	for <linux-block@archiver.kernel.org>; Fri, 23 Jul 2021 17:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhGWQuN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231430AbhGWQuM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jul 2021 12:50:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E73760EB4;
        Fri, 23 Jul 2021 17:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627061445;
        bh=fTHDLla3VU2ApOlEPZLBX3MOoVxOP6SWQW5g3oZuKM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N3CKUYxiL5NuZ1YgChzwR4kyXJYgWneQMbpQpMhMpc9GMnVYBFe0+0214nvxGP0Oe
         pS0FRqLwqSkMr+DgiQyx+tuzqmr28IB5u+HWhGTMGyUicskVDJz2h2ThFmI6GT4CXR
         3TZafadYWU5vArUdwZ6wKpoV5kwfmqhJkY4HJhsZfrOcB6XLpUugf0m6jt53EVbcYD
         mXlHopLUPbaDJZBwMi7ShdTFUKGo5ECMoSFdX+XZg1GF7pHde90VC1nBWg8QevZZrx
         y/dowxPDsP8omTZAviy4QH1feg5cYCsonowYXBLocvqqlUSYRrxE6KiwGpQnma2ELO
         zR0HXgqp0Ocmw==
Date:   Fri, 23 Jul 2021 10:30:44 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyaprateek2357@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v4 9/9] block: add WARN_ON_ONCE() to bio_split() for
 sector alignment
Message-ID: <YPr8xOKxROn0QuAQ@gmail.com>
References: <20210707052943.3960-1-satyaprateek2357@gmail.com>
 <20210707052943.3960-10-satyaprateek2357@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707052943.3960-10-satyaprateek2357@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 06, 2021 at 10:29:43PM -0700, Satya Tangirala wrote:
> From: Satya Tangirala <satyat@google.com>
> 
> The number of sectors passed to bio_split() must be aligned to
> bio_required_sector_alignment(). All callers (other than bounce.c) have
> been updated to ensure this, so add a WARN_ON_ONCE() if the number of
> sectors is not aligned. (bounce.c was not updated since it's legacy code
> - any device that enables bounce buffering won't declare inline
> encryption support, so bounce.c will never see a bio with an encryption
> context).

The last sentence could say "so bounce.c will never see a bio with
bio_required_sector_alignment() greater than the logical block size".

> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  block/bio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 1fab762e079b..4c7bfdeefe76 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1435,6 +1435,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
>  
>  	BUG_ON(sectors <= 0);
>  	BUG_ON(sectors >= bio_sectors(bio));
> +	WARN_ON_ONCE(!IS_ALIGNED(sectors, bio_required_sector_alignment(bio)));
>  
>  	/* Zone append commands cannot be split */
>  	if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND))

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
