Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBE1C43603
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 21:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7132173E
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 21:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZZC9cYbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbfLLVVs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 16:21:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730979AbfLLVVs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 16:21:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KbwBsf8HF/6Mcj6G8sGAEenLIWzl0lTvPcql45QyUu8=; b=ZZC9cYbwcQuRMfDGOMRRnPqnb
        fLT4Sv63SGf29kzFN8ymNOWdOf2xM1HSEqzpejZXDyb+3BhFu9X+pM7HlkM0B22CHImrcRBbvigAk
        KXkVHEdKOxfyu8qCSxfzHHiEj4lxcuPOgvS6d99u9OmCXZqgt1SpqxmMj0yMr2Y83uWHErf3Sc6x2
        TABrDD3+JaR00BqgSRqia3Tm4PDeYWG7C6GR81L5UpuzLyDr4H8Oua95QJWeD2HgBQOjMJXikeL+r
        IZj/dMQmDI+zaEkdHTGqwjbNDppkJC6e2bC0nMWVX45fkMQ7QSPfnjzVtxV/Bb/Tni18+a8f75VhW
        Jh4CCWrZg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifVu6-0002AN-QB; Thu, 12 Dec 2019 21:21:46 +0000
Date:   Thu, 12 Dec 2019 13:21:46 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, clm@fb.com,
        torvalds@linux-foundation.org, david@fromorbit.com
Subject: Re: [PATCH 1/5] fs: add read support for RWF_UNCACHED
Message-ID: <20191212212146.GV32169@bombadil.infradead.org>
References: <20191212190133.18473-1-axboe@kernel.dk>
 <20191212190133.18473-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212190133.18473-2-axboe@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 12, 2019 at 12:01:29PM -0700, Jens Axboe wrote:
> @@ -2234,7 +2250,15 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  			error = -ENOMEM;
>  			goto out;
>  		}
> -		error = add_to_page_cache_lru(page, mapping, index,
[...]
> +		error = add_to_page_cache(page, mapping, index,
>  				mapping_gfp_constraint(mapping, GFP_KERNEL));

Surely a mistake?  (and does this mistake invalidate the testing you
did earlier?)

