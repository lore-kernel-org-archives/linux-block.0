Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC44C4338F
	for <linux-block@archiver.kernel.org>; Sun,  8 Aug 2021 12:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04EF60EBC
	for <linux-block@archiver.kernel.org>; Sun,  8 Aug 2021 12:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhHHM6h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Aug 2021 08:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhHHM6h (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Aug 2021 08:58:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3DFC061760
        for <linux-block@vger.kernel.org>; Sun,  8 Aug 2021 05:58:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h13so17601384wrp.1
        for <linux-block@vger.kernel.org>; Sun, 08 Aug 2021 05:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oVDlGo2/GL5fB+ntlbYoUjx1btQ2ylvhx4xcIT+a7JE=;
        b=OW5Jg23oqret+mODZTBn4D1bPm3sybVmDlOjs2gnp5sTcGD/j9RK1957DXetQIXMPf
         0v337D4DslKw78ATcvv0tFVU9ASX/gC2aE1KTApARVVgO9EQPzInEKmvRSVm+H7bieab
         jFFWlkulsJ7hZFbj73ZME/7d1BGAYVPfLh/h54Y6lXpFoiYOI9x6aAASu/7p3a4UkZoG
         evnJtpgj1+SGrQRro3SVV1SxxNIeSyEde6eooDQntoeuwAtUE0J1aFUC0FFqtxw3ZldV
         w+OF4VM9WdgO+IxcP9wJOnIMrahF3imtAp197w4atM7TnlcbfO855gpUodMzBjiZlDYj
         b42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oVDlGo2/GL5fB+ntlbYoUjx1btQ2ylvhx4xcIT+a7JE=;
        b=bbYGSaGdXXcxOpVaCpFwaqhdPY2+2EgT75iNzkVcL0LgSpjcuW3lFozjexIke2ejLh
         Boy9EGijFdHO8XHB+PLdqLtOHYg8dabmUWMRCGbP//GA5N7IEJvvCciDggA5inulQpZM
         ZPz2D45C9c5A2Q1R2FrzDm3vFQnK9HCN1/vHkFyTpYuQavhR6g5alhBenHkralkP/zK/
         rAkEM411GWhr4nKHcAfga20TPi/EolucgExF2VA5Q61miz98TxAkKxsCQqVwTNy5o95A
         FUHfuOXRjQ+5Ql2JCq7bHE1IHjRBx52Q93ZV3Ewav5rvqVBvm0Qnley8ZS05cNTrAHar
         FiMQ==
X-Gm-Message-State: AOAM533/8pnWqXBkjseSQAJC+5D/RGrOvBn3cAmRGbqJuMq0uvsHa52r
        w6w5HFg3uGg7QLijsdrWKFE=
X-Google-Smtp-Source: ABdhPJzxfquvsXBpIQ6dchayeIcUF3WJmoU01wO5Z6RQZK21cJFRitCJchBdX5aQu8BM7V3nNL8Kkw==
X-Received: by 2002:a05:6000:7:: with SMTP id h7mr20079315wrx.298.1628427496401;
        Sun, 08 Aug 2021 05:58:16 -0700 (PDT)
Received: from [192.168.8.197] ([85.255.236.119])
        by smtp.gmail.com with ESMTPSA id i5sm15860560wrw.13.2021.08.08.05.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 05:58:15 -0700 (PDT)
Subject: Re: [RFC] bio: fix page leak bio_add_hw_page failure
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>
References: <1edfa6a2ffd66d55e6345a477df5387d2c1415d0.1626653825.git.asml.silence@gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <49550f27-2dac-7ee5-1e03-bd22b70b7ca1@gmail.com>
Date:   Sun, 8 Aug 2021 13:57:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1edfa6a2ffd66d55e6345a477df5387d2c1415d0.1626653825.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/19/21 11:53 AM, Pavel Begunkov wrote:
> __bio_iov_append_get_pages() doesn't put not appended pages on
> bio_add_hw_page() failure, so potentially leaking them, fix it. Also, do
> the same for __bio_iov_iter_get_pages(), even though it looks like it
> can't be triggered by userspace in this case.

Any comments?

> 
> Fixes: 0512a75b98f8 ("block: Introduce REQ_OP_ZONE_APPEND")
> Cc: stable@vger.kernel.org # 5.8+
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
> 
> I haven't tested the fail path, thus RFC. Would be great if someone can
> do it or take over the fix.
> 
>  block/bio.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 1fab762e079b..d95e3456ba0c 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -979,6 +979,14 @@ static int bio_iov_bvec_set_append(struct bio *bio, struct iov_iter *iter)
>  	return 0;
>  }
>  
> +static void bio_put_pages(struct page **pages, size_t size, size_t off)
> +{
> +	size_t i, nr = DIV_ROUND_UP(size + (off & ~PAGE_MASK), PAGE_SIZE);
> +
> +	for (i = 0; i < nr; i++)
> +		put_page(pages[i]);
> +}
> +
>  #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
>  
>  /**
> @@ -1023,8 +1031,10 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  			if (same_page)
>  				put_page(page);
>  		} else {
> -			if (WARN_ON_ONCE(bio_full(bio, len)))
> -                                return -EINVAL;
> +			if (WARN_ON_ONCE(bio_full(bio, len))) {
> +				bio_put_pages(pages + i, left, offset);
> +				return -EINVAL;
> +			}
>  			__bio_add_page(bio, page, len, offset);
>  		}
>  		offset = 0;
> @@ -1069,6 +1079,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
>  		len = min_t(size_t, PAGE_SIZE - offset, left);
>  		if (bio_add_hw_page(q, bio, page, len, offset,
>  				max_append_sectors, &same_page) != len) {
> +			bio_put_pages(pages + i, left, offset);
>  			ret = -EINVAL;
>  			break;
>  		}
> 

-- 
Pavel Begunkov
