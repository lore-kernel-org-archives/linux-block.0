Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03260C433E0
	for <linux-block@archiver.kernel.org>; Wed, 20 Jan 2021 04:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC3752312B
	for <linux-block@archiver.kernel.org>; Wed, 20 Jan 2021 04:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbhATEH2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jan 2021 23:07:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726580AbhATEHZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jan 2021 23:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611115558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AywvAsEXQ6QfOLvyJDQnLT2m8SbrEucZASIOkJ5VmEo=;
        b=b56NOf/CVUFZ4mERJqJVJCaJOjXnbIIJH0A0Of1oeFKyCTorTQQ4vM0CJFMN/lcFaWNpg4
        XEaGP7wZuFQX8xAPLmlhMVQQACw39SaWSeLOQAvmDSvqtbEFM6+ftSKqpMEcYIphjWDCl8
        v4F/W5txKxnePb/uc7dX/XmTalTHU8o=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-QbDG7t-LPd-2QmjDAEHT0Q-1; Tue, 19 Jan 2021 23:05:57 -0500
X-MC-Unique: QbDG7t-LPd-2QmjDAEHT0Q-1
Received: by mail-pl1-f197.google.com with SMTP id q13so15624277pll.10
        for <linux-block@vger.kernel.org>; Tue, 19 Jan 2021 20:05:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AywvAsEXQ6QfOLvyJDQnLT2m8SbrEucZASIOkJ5VmEo=;
        b=gcuEkwUU1uZZe0Amt/Yrytca2NgwOvhNYxSGfQfXO9luLzJH3ztFKuRd8LSiaz2a5c
         ZHMhZFV3e4/rvwust+uSBotrvzQ4X7rq/BALsERGv+x5W6un+1BcjIk9h9XpWQEFENYf
         jpd1DQGAPlImeyHltve2xRYiLMRr/RbpWHVM4bUHJSUSEVh7cX7CCd6Teuo7VEAm+QyC
         R+yjpJ4iHv/NyEjOt24J5bbiTB0dlTh1he1bNXy4iZ7USJWRJxK/E488LOqu7Fl3Aa1f
         XqhcXHjxBJnGELCMADh1Ix+5W0Bxp3R4FgpzcIjhAK3/jlIGndBChc0WKIHRfS7d58EX
         C8IQ==
X-Gm-Message-State: AOAM530anK1/GSNer6p4P+5oQB2G6uDCY3adeQpDe9A5pzcjeCaLB1ZH
        f51gSAVfkl/+HpMU9wJhzFb2ouLPSHUd5+pVjtIbkw6T3CA0dRz5l0Tagb2GXJChLQkgCujKpeg
        2GbVFydRqqtvjnS2so+RWYqc=
X-Received: by 2002:a17:90b:e15:: with SMTP id ge21mr3208216pjb.185.1611115555707;
        Tue, 19 Jan 2021 20:05:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5B+6ZbSBY1zlOxNMrxAtroVhw7sy9A1mX+YBi99MEWpF7mf2MGUtrtchq7Pagy87yB/CGug==
X-Received: by 2002:a17:90b:e15:: with SMTP id ge21mr3208199pjb.185.1611115555492;
        Tue, 19 Jan 2021 20:05:55 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id kr9sm454363pjb.0.2021.01.19.20.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 20:05:55 -0800 (PST)
Date:   Wed, 20 Jan 2021 12:05:44 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 31/37] eros: use bio_init_fields in data
Message-ID: <20210120040544.GC2601261@xiangao.remote.csb>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
 <20210119050631.57073-32-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210119050631.57073-32-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Chaitanya,

(drop in-person Cc..)

On Mon, Jan 18, 2021 at 09:06:25PM -0800, Chaitanya Kulkarni wrote:

...it would be nice if you could update the subject line to
"erofs: use bio_init_fields xxxx"

The same to the following patch [RFC PATCH 32/37]... Also, IMHO,
these two patches could be merged as one patch if possible,
although just my own thoughts.

Thanks,
Gao Xiang

> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  fs/erofs/data.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index ea4f693bee22..15f3a3f01fa3 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -220,10 +220,8 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
>  
>  		bio = bio_alloc(GFP_NOIO, nblocks);
>  
> -		bio->bi_end_io = erofs_readendio;
> -		bio_set_dev(bio, sb->s_bdev);
> -		bio->bi_iter.bi_sector = (sector_t)blknr <<
> -			LOG_SECTORS_PER_BLOCK;
> +		bio_init_fields(bio, sb->s_bdev, (sector_t)blknr <<
> +			LOG_SECTORS_PER_BLOCK, NULL, erofs_readendio, 0, 0);
>  		bio->bi_opf = REQ_OP_READ | (ra ? REQ_RAHEAD : 0);
>  	}
>  
> -- 
> 2.22.1
> 

