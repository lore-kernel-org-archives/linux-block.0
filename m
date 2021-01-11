Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F99C433DB
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 04:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47958225AC
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 04:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbhAKErB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Jan 2021 23:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbhAKErA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 23:47:00 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6CBC061794
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 20:46:20 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id q75so13787771wme.2
        for <linux-block@vger.kernel.org>; Sun, 10 Jan 2021 20:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bMC425b0EXVS+7b+sWk9MJNLAJeOqw5l/hhwQF7C9u0=;
        b=owO/3wdrZkZHQOvSZOvWm2TYf/TBxuQFEqQPw3ACQ4bHNu4zdruuHKLLdNY+rAdjIp
         IZvZ+Ad9gLtWzfLhBFAuFN/2Gfp/YhRI137XOFTiAhnsQcfA3aDJFIGvuidmc2ZkOXhn
         t5BgBoKXLhv93JgctP2+/KLA1ACn49AArU2aigsV8bOdE+h3AUqSALDtBEz4qqTbYLUc
         UndtSsP1lzOAOgzpFVnfY5S5VjPtlaodyWN2Cwv6oxQp5wbR9Gw33n7QG1atEGrLnopE
         n3QAX/om6YBAq9YntPDHDWdqb6Bt8bUwz5L10/5Hf40jLcPMzOBDVLDqFYuQdGenuHFL
         pbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bMC425b0EXVS+7b+sWk9MJNLAJeOqw5l/hhwQF7C9u0=;
        b=cMN0xKWFVX/+F5W3ffM8DrGOKYerEVrxM8Z2Lap8Z6CWdV9wd+jK+4li3kW+vz4qn8
         ZI7O2VW2zpz8IL/OscXcA52Ai9DwNnfGX1Qm63tifLS3KPsRkkfJ0lveOoyuSx3xjuZ5
         MFOhc5qLWTlSixvHD9Rhdy4iF/9HbS00MOR1hJVNZh3RKrGSI9ajz/bSk3OENbQrg4G1
         ozZB+tcOCuffY1os6DmFjh9ZSl1Aqylgbwo1AIC/NCXplFq76W15V1WRaun5pDBLHsNi
         Y3nNXAm4LC4XLDg2t/nSdrHrMhtHLAYYXxcmFYhGjonVqIOiBvZZGQsEstDiYGKfJOIt
         vUCw==
X-Gm-Message-State: AOAM532FM5C6cOt+HfeCnh5OIaNTwbrDhRY8KU+4QvwK3uv88y47uDhA
        fAhM9vN0WCbQt33n5LwS+wY=
X-Google-Smtp-Source: ABdhPJw6ABZ2IlvVe+E+45ZniwIBlAdLv4Mh6aaM9uE8EkEPYZrjO4PrwCFb4TPnJfaWLUMv8r7TJQ==
X-Received: by 2002:a1c:9e86:: with SMTP id h128mr13213014wme.171.1610340378904;
        Sun, 10 Jan 2021 20:46:18 -0800 (PST)
Received: from [192.168.8.119] ([85.255.237.6])
        by smtp.gmail.com with ESMTPSA id n16sm22662494wrj.26.2021.01.10.20.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jan 2021 20:46:18 -0800 (PST)
Subject: Re: [PATCH V3 5/6] block: move three bvec helpers declaration into
 private helper
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210111030557.4154161-1-ming.lei@redhat.com>
 <20210111030557.4154161-6-ming.lei@redhat.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <8d8eb758-072c-4f98-4cda-65a26aa3eaec@gmail.com>
Date:   Mon, 11 Jan 2021 04:42:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20210111030557.4154161-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/01/2021 03:05, Ming Lei wrote:
> bvec_alloc(), bvec_free() and bvec_nr_vecs() are only used inside block
> layer core functions, no need to declare them in public header.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

> ---
>  block/blk.h         | 4 ++++
>  include/linux/bio.h | 3 ---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk.h b/block/blk.h
> index 7550364c326c..a21a35c4a3e4 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -55,6 +55,10 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
>  
>  void blk_freeze_queue(struct request_queue *q);
>  
> +struct bio_vec *bvec_alloc(gfp_t, int, unsigned long *, mempool_t *);
> +void bvec_free(mempool_t *, struct bio_vec *, unsigned int);
> +unsigned int bvec_nr_vecs(unsigned short idx);
> +
>  static inline bool biovec_phys_mergeable(struct request_queue *q,
>  		struct bio_vec *vec1, struct bio_vec *vec2)
>  {
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index f606eb1e556f..70914dd6a70d 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -478,9 +478,6 @@ static inline void zero_fill_bio(struct bio *bio)
>  	zero_fill_bio_iter(bio, bio->bi_iter);
>  }
>  
> -extern struct bio_vec *bvec_alloc(gfp_t, int, unsigned long *, mempool_t *);
> -extern void bvec_free(mempool_t *, struct bio_vec *, unsigned int);
> -extern unsigned int bvec_nr_vecs(unsigned short idx);
>  extern const char *bio_devname(struct bio *bio, char *buffer);
>  
>  #define bio_set_dev(bio, bdev) 			\
> 

-- 
Pavel Begunkov
