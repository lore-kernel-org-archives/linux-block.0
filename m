Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B178C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 20:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D65720868
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 20:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="Z44Xoz/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D65720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbeK3H6K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 02:58:10 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40056 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbeK3H6K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 02:58:10 -0500
Received: by mail-oi1-f196.google.com with SMTP id t204so2854583oie.7
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 12:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nSb8eHcDHSrMn0mWOEhWqOZDSzsJ0L+eatirAtGoYkg=;
        b=Z44Xoz/Dx/nOfGasFjOpZkxvnD4wRzlziJ2biyYFbp772Og2tMFOJXurL6EIaebj2u
         coQ4YxCh++rsRZ92O979LOlDOUFqGFZ8G/utuWSCBLP6FnRIVxEW5CbD7YPtq/5DJSa3
         /jKf11Dmym4uoGDxCXUA9qxeezqlm35o35xdZJdZz17zZEox099joBwKrIGdShQ9K/Cj
         3oFeBycKL8+DGzwUgALhRWuXYYra7eS7v1GekqkGcw46x/e1WW0DqNTY0x+St/PIQTFe
         CmlaFh06Roo+Z6ttB33itQn7npxW5RPOptlYYQ8BroUVEwxVqj0+R4bCA4pV5y/zs7TY
         2PXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nSb8eHcDHSrMn0mWOEhWqOZDSzsJ0L+eatirAtGoYkg=;
        b=tnf+MH4TJSgPyZxqVYx17HT241XCH6y/XSrv5ohfftBLR3wceUXfllzhae2RE+kzWn
         z2Z14Ia8JMi0+HKwLI9xKNFrFL6jxUEJyVbNjogJHfbq07HSPGYja0Tc5siKFACcS67d
         tHcaN6nrLNJ0ORGcOWqeYY3aJttaoEHu6tf/Qq/KM8O9D41AZuIP72CcIq/QYecoiblZ
         2yzEU0fNurwjtD3X3ceTBYGn1ixNbZfiXwP7w+Km7SpdIO9Iny2hhcsSvwoooGpyYRb/
         p2ligdXuK6Q87eoJuZDZ7fkyURLuvxoY/V1sxt89FRkzIcmxbO8C9C2dyokw9x7BX2OE
         d4gA==
X-Gm-Message-State: AA+aEWbfRXO4SkNc6iT3sCLA+SHxJH0SMg7CyavMHUc3pQNiE2oOwNM0
        mqEanjGujl0LX21KF2RSkCw7bmBEMxo=
X-Google-Smtp-Source: AFSGD/WndgJ0cEHeDPx0Zy7MI3XvD/Mr+/PlNGnYIVD9K1DqvpYfO98/WBHmbMeZx5O9I/HUb4Q2OQ==
X-Received: by 2002:aca:de03:: with SMTP id v3mr1828411oig.152.1543524687185;
        Thu, 29 Nov 2018 12:51:27 -0800 (PST)
Received: from vader ([172.58.43.181])
        by smtp.gmail.com with ESMTPSA id 62sm1002074otu.42.2018.11.29.12.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 12:51:26 -0800 (PST)
Date:   Thu, 29 Nov 2018 12:51:23 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] sbitmap: don't loop for find_next_zero_bit() for
 !round_robin
Message-ID: <20181129205123.GA25153@vader>
References: <c9fd77ea-bbba-500d-804f-0e11e48993f3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9fd77ea-bbba-500d-804f-0e11e48993f3@kernel.dk>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 29, 2018 at 12:47:49PM -0700, Jens Axboe wrote:
> If we aren't forced to do round robin tag allocation, just use the
> allocation hint to find the index for the tag word, don't use it for the
> offset inside the word. This avoids a potential extra round trip in the
> bit looping, and since we're fetching this cacheline, we may as well
> check the whole word from the start.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> Since v1:
> 
> - Reset alloc_hint if we loop for the round-robin case
> - Update commit message
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index fdd1b8aa8ac6..45cab6bbc1c7 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -118,10 +118,19 @@ int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
>  
>  	index = SB_NR_TO_INDEX(sb, alloc_hint);
>  
> +	/*
> +	 * Unless we're doing round robin tag allocation, just use the
> +	 * alloc_hint to find the right word index. No point in looping
> +	 * twice in find_next_zero_bit() for that case.
> +	 */
> +	if (round_robin)
> +		alloc_hint = SB_NR_TO_BIT(sb, alloc_hint);
> +	else
> +		alloc_hint = 0;
> +
>  	for (i = 0; i < sb->map_nr; i++) {
>  		nr = __sbitmap_get_word(&sb->map[index].word,
> -					sb->map[index].depth,
> -					SB_NR_TO_BIT(sb, alloc_hint),
> +					sb->map[index].depth, alloc_hint,
>  					!round_robin);
>  		if (nr != -1) {
>  			nr += index << sb->shift;
> @@ -129,13 +138,9 @@ int sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint, bool round_robin)
>  		}
>  
>  		/* Jump to next index. */
> -		index++;
> -		alloc_hint = index << sb->shift;
> -
> -		if (index >= sb->map_nr) {
> +		alloc_hint = 0;
> +		if (++index >= sb->map_nr)
>  			index = 0;
> -			alloc_hint = 0;
> -		}
>  	}
>  
>  	return nr;
> -- 
> Jens Axboe
> 
