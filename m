Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DDEC433FE
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2AC760551
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhJNPMP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 11:12:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232913AbhJNPMA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 11:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634224195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jTxRkwer/L1jMFbVHe+gmT8Lx5IDhS6y3cTZBhYxWZc=;
        b=eWI2+ntEGDvxMqgYGHg1UytVzGbsb/ESBu65u6w1058DTE8GcHpTnoTXW8h+3cGUybdRhW
        zN4iC5wE7lDrr7r+2ck2y20wwx/XvQEl58pQLH0huZ4Tj8f0kceoMfIJoHdQa+Hoziqu5b
        XodTLSXi6cahZMx3F3cOhhHD9lRc5wA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-gyykc-juMkiQh6t7O3VGaA-1; Thu, 14 Oct 2021 11:09:53 -0400
X-MC-Unique: gyykc-juMkiQh6t7O3VGaA-1
Received: by mail-wr1-f70.google.com with SMTP id f1-20020a5d64c1000000b001611832aefeso4794783wri.17
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 08:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=jTxRkwer/L1jMFbVHe+gmT8Lx5IDhS6y3cTZBhYxWZc=;
        b=TqCg7/CNjnOrbGqlGJT8xTK/xqaBOkvoNjSSWVi3z5GNDLQ3m963Ks6wj+5TWLG2ph
         kzhL6qBsX8hs7EMlA/tBsmlljA3RNYJHA5yL5wlnDUzoicyvisuY5WxPHWyEriQWVQhQ
         fyHu5W0cRYjRbhaxLS246+xebg5aEUr1lr5MNjM5tFbEaCJssi4nYqSVqAJXjmXbi322
         tYCAdLDIxF/tGS6pIcY/Y7iOGd6HQPbc1bYamjVwUz0enx4jCaPMb5Cj/Oq7Ly72SY9D
         E2MdP555j95BSjmjEAw01rB6A6C+Guwn8xKCE6VMQ9WDkKXvoT3IYAmKMQ78p1Uh9E0M
         l4mQ==
X-Gm-Message-State: AOAM5331G8sJPrH/u4+hXuI7mB+AwS1phKPZr2Mt2TlffgY7mEl+shc8
        q/ePzsIMg0/51z/asmR/hMwBt8lW4iskxypDWt0HNfNicziT5BX10evfAqjpKeeZTWDWHbWP04l
        s9F+pEJtZC7U5SzqS3D7/eeE=
X-Received: by 2002:a1c:29c7:: with SMTP id p190mr6271740wmp.65.1634224192160;
        Thu, 14 Oct 2021 08:09:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwspjmnn2UgF3wC80ffKADbfFGgTEqNvflKbpG+cgCWjua1idvpQ2j9r374S0fE1PxL0yFKA==
X-Received: by 2002:a1c:29c7:: with SMTP id p190mr6271697wmp.65.1634224191871;
        Thu, 14 Oct 2021 08:09:51 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c694e.dip0.t-ipconnect.de. [91.12.105.78])
        by smtp.gmail.com with ESMTPSA id p25sm7981463wma.2.2021.10.14.08.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 08:09:51 -0700 (PDT)
Message-ID: <eaa8ed55-f364-5518-0b30-3fec6bde99dc@redhat.com>
Date:   Thu, 14 Oct 2021 17:09:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 5/5] brd: Kill usage of page->index
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     alexander.h.duyck@linux.intel.com
References: <20211013160034.3472923-1-kent.overstreet@gmail.com>
 <20211013160034.3472923-6-kent.overstreet@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211013160034.3472923-6-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 13.10.21 18:00, Kent Overstreet wrote:
> As part of the struct page cleanups underway, we want to remove as much
> usage of page->mapping and page->index as possible, as frequently they
> are known from context.
> 
> In the brd code, we're never actually reading from page->index except in
> assertions, so references to it can be safely deleted.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> ---
>  drivers/block/brd.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 58ec167aa0..0a55aed832 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -72,8 +72,6 @@ static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
>  	page = radix_tree_lookup(&brd->brd_pages, idx);
>  	rcu_read_unlock();
>  
> -	BUG_ON(page && page->index != idx);
> -
>  	return page;
>  }
>  
> @@ -108,12 +106,10 @@ static struct page *brd_insert_page(struct brd_device *brd, sector_t sector)
>  
>  	spin_lock(&brd->brd_lock);
>  	idx = sector >> PAGE_SECTORS_SHIFT;
> -	page->index = idx;
>  	if (radix_tree_insert(&brd->brd_pages, idx, page)) {
>  		__free_page(page);
>  		page = radix_tree_lookup(&brd->brd_pages, idx);
>  		BUG_ON(!page);
> -		BUG_ON(page->index != idx);
>  	} else {
>  		brd->brd_nr_pages++;
>  	}
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

