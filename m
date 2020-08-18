Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E592C433DF
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 08:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208862075E
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 08:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtufONaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHRIIa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgHRII2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 04:08:28 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F691C061389;
        Tue, 18 Aug 2020 01:08:28 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u128so9583551pfb.6;
        Tue, 18 Aug 2020 01:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m313s21wEJmxuhmPKtbGUqqWEllj2MTtaFTQwb2enIE=;
        b=OtufONajKNzIP6gr7YDun/QW3ro9rpD04mkuKT4cs+IerR6bXb0EEfSZrBS86/akD4
         40cKAY+zckJTFvGRxXLDJV5Q6EKJOWF826rEIUXiuWkZ6++GkoSndNCSw9ZU7GBtrnPJ
         i7MJyDe0rLgw2grjYZR04unLuVxIcEUuJWxvksVfW0sRqqkrgLpkzBjI8BfX1/iJSifw
         x6S/P+uJlioFkC+WA1Ir9HVeYPsD6P717k5LZaF9FJcVQv1OrOheoeQGF4fa2YbyLGcB
         lYGWp9L6RNZmuRKTngHOMi8necWZDhCHsD1I5gDGscs5KYPXc22len0n7aTY2UhIP8u4
         hx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m313s21wEJmxuhmPKtbGUqqWEllj2MTtaFTQwb2enIE=;
        b=HGzsKhEQK6GjaTuxtmRbBqZ0PsmBO+lmz6VfFuXNkamZbb+iQzYO3+ytHAZupokyqE
         1okAGiYAahJ/YZt//C5oKFwKaRA+C9t8/vrpzqqoF+scEEysa0/DuG2k/n5XawHNmTFn
         hB3nQ66U4IjS7cWwmEf0BzZFWl4pi8DmQSIz35bPfhReRr8tjTv7JLbDkNIF7ftPId0Y
         sFi2ApcFsXDP5wg3V2equSO1Mo7IM9sxT3hH9sqWj48WID8ytcflf54qamuYR/nFfV1A
         /ijHWGypFzDL9Kvdatb7cxW767yRQQpx+tNtof1GN1RVzJpgwRxZv4SPDOw/RteBuXh0
         gfMg==
X-Gm-Message-State: AOAM5319r30R3tDzPV3RyyheTIgNhoaXjlSUlPe6u8S6o4TxTxbW6HYn
        Adr8cxHkgv/oLqQcmzCaR3E=
X-Google-Smtp-Source: ABdhPJwQ0ucHp+nnSbkI/I+/r1bCwZGaElzEDSzF9ufRJ5nFtWB5QNUo904wdRubof6ip0h0WAbsIQ==
X-Received: by 2002:a63:7d3:: with SMTP id 202mr8695071pgh.230.1597738107451;
        Tue, 18 Aug 2020 01:08:27 -0700 (PDT)
Received: from [10.1.10.11] (c-73-241-150-58.hsd1.ca.comcast.net. [73.241.150.58])
        by smtp.gmail.com with ESMTPSA id x28sm23667645pfj.73.2020.08.18.01.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 01:08:26 -0700 (PDT)
Subject: Re: [PATCH v5 1/3] net: introduce helper sendpage_ok() in
 include/linux/net.h
To:     Coly Li <colyli@suse.de>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc:     netdev@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Jan Kara <jack@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Vlastimil Babka <vbabka@suse.com>
References: <20200816070814.6806-1-colyli@suse.de>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <66b4f454-dc97-a23e-81d6-0c547dced694@gmail.com>
Date:   Tue, 18 Aug 2020 01:08:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200816070814.6806-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 8/16/20 12:08 AM, Coly Li wrote:
> The original problem was from nvme-over-tcp code, who mistakenly uses
> kernel_sendpage() to send pages allocated by __get_free_pages() without
> __GFP_COMP flag. Such pages don't have refcount (page_count is 0) on
> tail pages, sending them by kernel_sendpage() may trigger a kernel panic
> from a corrupted kernel heap, because these pages are incorrectly freed
> in network stack as page_count 0 pages.
> 
> This patch introduces a helper sendpage_ok(), it returns true if the
> checking page,
> - is not slab page: PageSlab(page) is false.
> - has page refcount: page_count(page) is not zero
> 
> All drivers who want to send page to remote end by kernel_sendpage()
> may use this helper to check whether the page is OK. If the helper does
> not return true, the driver should try other non sendpage method (e.g.
> sock_no_sendpage()) to handle the page.
> 
>
> 
> diff --git a/include/linux/net.h b/include/linux/net.h
> index d48ff1180879..a807fad31958 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -21,6 +21,7 @@
>  #include <linux/rcupdate.h>
>  #include <linux/once.h>
>  #include <linux/fs.h>
> +#include <linux/mm.h>
>  #include <linux/sockptr.h>
>  
>  #include <uapi/linux/net.h>
> @@ -286,6 +287,21 @@ do {									\
>  #define net_get_random_once_wait(buf, nbytes)			\
>  	get_random_once_wait((buf), (nbytes))
>  
> +/*
> + * E.g. XFS meta- & log-data is in slab pages, or bcache meta
> + * data pages, or other high order pages allocated by
> + * __get_free_pages() without __GFP_COMP, which have a page_count
> + * of 0 and/or have PageSlab() set. We cannot use send_page for
> + * those, as that does get_page(); put_page(); and would cause
> + * either a VM_BUG directly, or __page_cache_release a page that
> + * would actually still be referenced by someone, leading to some
> + * obscure delayed Oops somewhere else.
> + */
> +static inline bool sendpage_ok(struct page *page)
> +{
> +	return  (!PageSlab(page) && page_count(page) >= 1);
> +}
>

return (A);

Can simply be written :

return A;

In this case :

return !PageSlab(page) && page_count(page) >= 1;

BTW, do you have plans to refine code added with commit a10674bf2406afc2554f9c7d31b2dc65d6a27fd9
("tcp: detecting the misuse of .sendpage for Slab objects")
