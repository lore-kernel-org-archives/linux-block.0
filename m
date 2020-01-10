Return-Path: <SRS0=/LTC=27=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EB4C282DD
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 16:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498A3206ED
	for <linux-block@archiver.kernel.org>; Fri, 10 Jan 2020 16:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578674764;
	bh=qVX1na3eKlg+jVvB2Llvljn85uT53mBXa1in+HWm/0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=STdv+eKpZ89CpRoT1qYdZ6OMHyw6L1URBkzfO1FkqJPdcwJeldd+gCZcJId6bqpr6
	 OmsjEmkbdO9PjbqZykQ+bk4q28U9WjJgraqSQRPGHTknb41ClV3LaRx/PdkxhgZWts
	 yRem2HgRREgv9suscbLA+3N+uusL+8nqVdv98lG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgAJQqB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:46:01 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38102 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgAJQqB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jan 2020 11:46:01 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so1401051pfc.5;
        Fri, 10 Jan 2020 08:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+zuEtxuDCNNPIe3EcK+m31UcAVGsvqFLpzNCTX1NQ6U=;
        b=dIt3wHfnfA4X8SdRxF8O7+f85bw6pcjAzv4vaXLPdUtjl1QvutERX5OwINkIfsfXK8
         QPCKaL5qS5PzCkxDpE4qG4ExpUJwtjVaCvdxKptkrE1nKCmKebThJPUnBtk7GEvccAcA
         RNYZyowteQU6mQRm5t+IHI7RzgstnhE2wtibH32It418Glfv07T+JJDLnfoKR9jTyk6T
         PXyLsiXRHMFfZv8cd3P4c8aAB0uj4/JK03YvpCWX5f2OeIBRYn0BtUTsjSwz6qrhXAdP
         Eq67EYzE0ZePFn2zYF+19xz6vQdKDq/vT//adK+u6vNKQu/BGePN+xNHmNDDD6x8v+Ho
         ReNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+zuEtxuDCNNPIe3EcK+m31UcAVGsvqFLpzNCTX1NQ6U=;
        b=EtrKDAPOjJu4VcUJ2RUnE9EuY8a7/HAmbbnwLxCdwdw1WDJ5FPgDZRQUEQELJtkETu
         4XJ+HfFvoJl6/4c9i0wzpk6om4VGGHlNuNyjygLMM8m54njP4HyoNkkOIfG29fr4JXF6
         mSmxXq/OPVfYOyeCc6oh1vD2AOiFqpe3U+2W8uolZQAJ9/GfibUOen6xungRsLu+infN
         pVSsjPwC+tyCskp56xANADjAoBj6hDRbxn2iEXtjCD+mu4j6La9mMrJ4MgaCVxkpBbW9
         eOUnzl3E214yAEuewhnMAP0VbgOPsP+JDU9p2lZZH/9etzrxNbrnbysHlCk8sFZ/LQIH
         kWqw==
X-Gm-Message-State: APjAAAWROPdYMSfWVK2XYHPqF+Gw1H02uJn8LCBEShpX4Pf4Yc6wKat+
        4HKB8sqL780vvSu+SAF/umHTH7Jg
X-Google-Smtp-Source: APXvYqx+sIxZF1KBeRyr4xjIy8PaGrt26bkAoyteGY5HatV0Fw+HzIXpZGWuYnFCU74+3OyOaReXzA==
X-Received: by 2002:aa7:961b:: with SMTP id q27mr5143360pfg.23.1578674760023;
        Fri, 10 Jan 2020 08:46:00 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id o17sm3389435pjq.1.2020.01.10.08.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 08:45:58 -0800 (PST)
Date:   Fri, 10 Jan 2020 08:45:57 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Taejoon Song <taejoon.song@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, yjay.kim@lge.com
Subject: Re: [PATCH] zram: try to avoid worst-case scenario on same element
 pages
Message-ID: <20200110164557.GA152286@google.com>
References: <1578642001-11765-1-git-send-email-taejoon.song@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578642001-11765-1-git-send-email-taejoon.song@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Andrew,

Previous version has a off-by-one error to check every unsigned long bytes
so it misses a unsigned long bytes in PAGE_SIZE. It could make zram
believe it's same page but not true.

This is a new patch Tejun fixed so could you replace [1] with this
version?

Thanks.

[1] mmotm: zram-try-to-avoid-worst-case-scenario-on-same-element-pages.patch with

On Fri, Jan 10, 2020 at 04:40:01PM +0900, Taejoon Song wrote:
> The worst-case scenario on finding same element pages is that almost
> all elements are same at the first glance but only last few elements
> are different.
> 
> Since the same element tends to be grouped from the beginning of the
> pages, if we check the first element with the last element before
> looping through all elements, we might have some chances to quickly
> detect non-same element pages.
> 
> 1. Test is done under LG webOS TV (64-bit arch)
> 2. Dump the swap-out pages (~819200 pages)
> 3. Analyze the pages with simple test script which counts the iteration
>    number and measures the speed at off-line
> 
> Under 64-bit arch, the worst iteration count is PAGE_SIZE / 8 bytes = 512.
> The speed is based on the time to consume page_same_filled() function only.
> The result, on average, is listed as below:
> 
>                                    Num of Iter    Speed(MB/s)
> Looping-Forward (Orig)                 38            99265
> Looping-Backward                       36           102725
> Last-element-check (This Patch)        33           125072
> 
> The result shows that the average iteration count decreases by 13% and
> the speed increases by 25% with this patch. This patch does not increase
> the overall time complexity, though.
> 
> I also ran simpler version which uses backward loop. Just looping backward
> also makes some improvement, but less than this patch.
> 
> Signed-off-by: Taejoon Song <taejoon.song@lge.com>

Acked-by: Minchan Kim <minchan@kernel.org>

> ---
>  drivers/block/zram/zram_drv.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 4285e75..71d5946 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -207,14 +207,17 @@ static inline void zram_fill_page(void *ptr, unsigned long len,
>  
>  static bool page_same_filled(void *ptr, unsigned long *element)
>  {
> -	unsigned int pos;
>  	unsigned long *page;
>  	unsigned long val;
> +	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;
>  
>  	page = (unsigned long *)ptr;
>  	val = page[0];
>  
> -	for (pos = 1; pos < PAGE_SIZE / sizeof(*page); pos++) {
> +	if (val != page[last_pos])
> +		return false;
> +
> +	for (pos = 1; pos < last_pos; pos++) {

FYI, this is fixed part from previous one.

>  		if (val != page[pos])
>  			return false;
>  	}
> -- 
> 2.7.4
> 
