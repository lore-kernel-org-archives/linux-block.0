Return-Path: <SRS0=cawq=TY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A14C072B5
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 14:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A8D20879
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 14:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="SkKlsrUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403955AbfEXOKi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 May 2019 10:10:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42418 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403864AbfEXOKh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 May 2019 10:10:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id l25so14569347eda.9
        for <linux-block@vger.kernel.org>; Fri, 24 May 2019 07:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zd6uEkSfOKcIDHK5M0+W3LMhr+2Unkt5+6YPVhWe7SM=;
        b=SkKlsrUNFydZnTSDgAJCNmm25cQr0RFvH/gxkbDSO4X/IuMpZkG9GaK86csttJl1Ug
         RN740qB7AYInm4lZ6a6qXnZT9GL6QUh6Sghogqt31HmU+ZDpVfXCUNy/UCIwANvHyCx5
         WXg9OIqM1RIuzhYi2nqZC5apA8rY1IlvMsKEsGzOhh3bt17flX9SCwZGTL6Hd1k7kj9c
         U+OLGXw6VmNcyxuaSOCWtEWDqjP++kn6pp29i1CGCkECWKmUR92WJNE4GOds8gU0mKR8
         bPflpYnwiBXgjNek4/Dy4Arjvs1j2z6N2Yg3wTD4eHebZb58N8Fc6mAFI/wIC96VMOOi
         uD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zd6uEkSfOKcIDHK5M0+W3LMhr+2Unkt5+6YPVhWe7SM=;
        b=bivTYXno6J8eUR3qVezSOMnttvsiSGeM1ByxE4l0B2rpKh0c4T7vNgpehIDcCGU1SI
         AQstfpVr6mHvRBhK46UoHx5kZxxXkgTr+VNBU7mYU8Z2LnBnpWLfkCUq/VhBOv5Mr24l
         QH8pjxxJKaSILLbuXBcdfKg3/2CLYia9LtSC5d/E2tHOqT6r4eyrCoB22PLIZanYmvJi
         pzB2pZuDrCHhBT2TIS9mWGaj1XpxMkZM5SbKpYHCaEfn4QybYeE1kxhaxD7H70od62Or
         mZYQVjvgdD77mKZoHdkAbpDakeXi335k3oi/93Hbv6MDAPBMS4wwPMNUGhV4XzWcMaeD
         jzfQ==
X-Gm-Message-State: APjAAAXp70ZuN5MUFyubo4/yAMLyoAQ8Wi0aseWwsTPWXR2i6HYAEo35
        +7WpHUU3JVCR3BXHHGHJw408Ow==
X-Google-Smtp-Source: APXvYqydLmlPS6p7i7sq9DyqK7+pJX98Hsv8Ko41hQY0aJ5979RnYkXxMBcrmkJIy6kfjPg+6WmxWw==
X-Received: by 2002:a17:906:5f82:: with SMTP id a2mr47247409eju.297.1558707035452;
        Fri, 24 May 2019 07:10:35 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id dv13sm381962ejb.32.2019.05.24.07.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 07:10:34 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: Fix freeing merged pages
To:     Heiner Litz <hlitz@ucsc.edu>
Cc:     javier@javigon.com, Hans Holmberg <Hans.Holmberg@wdc.com>,
        igor.j.konopko@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190515003952.12541-1-hlitz@ucsc.edu>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <c50f1ce5-1d8b-a0e2-6954-cd920e3d1140@lightnvm.io>
Date:   Fri, 24 May 2019 16:10:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190515003952.12541-1-hlitz@ucsc.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/15/19 2:39 AM, Heiner Litz wrote:
> bio_add_pc_page() may merge pages when a bio is padded due to a flush.
> Fix iteration over the bio to free the correct pages in case of a merge.
> 
> Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
> ---
>   drivers/lightnvm/pblk-core.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 773537804319..88d61b27a9ab 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -323,14 +323,16 @@ void pblk_free_rqd(struct pblk *pblk, struct nvm_rq *rqd, int type)
>   void pblk_bio_free_pages(struct pblk *pblk, struct bio *bio, int off,
>   			 int nr_pages)
>   {
> -	struct bio_vec bv;
> -	int i;
> -
> -	WARN_ON(off + nr_pages != bio->bi_vcnt);
> -
> -	for (i = off; i < nr_pages + off; i++) {
> -		bv = bio->bi_io_vec[i];
> -		mempool_free(bv.bv_page, &pblk->page_bio_pool);
> +	struct bio_vec *bv;
> +	struct page *page;
> +	int i,e, nbv = 0;
> +
> +	for (i = 0; i < bio->bi_vcnt; i++) {
> +		bv = &bio->bi_io_vec[i];
> +		page = bv->bv_page;
> +		for (e = 0; e < bv->bv_len; e += PBLK_EXPOSED_PAGE_SIZE, nbv++)
> +			if (nbv >= off)
> +				mempool_free(page++, &pblk->page_bio_pool);
>   	}
>   }
>   
> 

Thanks Heiner. Picked up for 5.3.
