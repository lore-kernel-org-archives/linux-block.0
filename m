Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF66C38A02
	for <linux-block@archiver.kernel.org>; Fri, 28 Oct 2022 13:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJ1NQQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 09:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJ1NQP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 09:16:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97C297D7B
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 06:16:13 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so6585832wmr.2
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 06:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nAnGabjiccbZVdauHBtP+PiszJv4787NdPchiuB9FZ4=;
        b=GGwAmjBdV4UtJqMOyKeBbtzBJF5eONMmM4i1jabIOu6DIgoOuxoPqqDzYgAL9EMhs6
         3pF+2J0wgEcm7qWI7PN6dFnHwpdgkfMdJWQ4tykNbt7YngevVcfYIvBR3yOIc9nMpdcy
         zMuTOYEnIUO5GafaG+ADsafQVbmBNzhZx9vfoV6nsoOCqbnXHxs7rHKx10W3dp41jHW0
         ag69adz4aPe3gCSX3mtBTP6+lbHHxRXbeXWQDto/lH3S5IeRxedydqv47ElJNSSTzdAv
         yTmnksTArnWoB9IPRplbzGXCuTuph1hEYF+hMbRi4a11hNyaKd/GnQAKaYrj4ZUbPCch
         719w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAnGabjiccbZVdauHBtP+PiszJv4787NdPchiuB9FZ4=;
        b=LCVEo4U1gASE+wurOFINy5PkuJgbxh8+n3gWOcPowsfBRfqVWqqNA+lp646/MYrT43
         E78fogX8Z/qsWjLoI1vcs00vgfBIij0TA0C7bCzpGB8Rv0oD6u9lHNUa8O//LkNjQHG5
         zdl5pwSkewZXEz+CX/JkaLM3kxEXCcWOMPLh34SFUhSncJRLyCmKB+tKEuIMCNEysH0s
         ps2azmzNF8y+pt9ADMJvwODF+b8e1CFK9U0Q+SPalrJg22i23WFbRIxy6d6fOSc069Xa
         uk9Xc/qpmEFofM2SBBHXyu+1TDFP0ooyNtWBK5j8Tnwh4y9vczWVicdm84aX5ZBReq6q
         sMtQ==
X-Gm-Message-State: ACrzQf2BP5a5pK75TAX5CFjYxGWeteJ6mBMfaaaM76ph4LPD4dcjLMne
        RsToYBE7HKSnEFnClPK/xck=
X-Google-Smtp-Source: AMsMyM5sOS/g+N0n40mk58pjdWnA8rHIkrfmrc7AH0xkVafDdjSFvvBXGK9MZS3rt+lzAt95W/AGCQ==
X-Received: by 2002:a05:600c:3d9a:b0:3cf:4969:850f with SMTP id bi26-20020a05600c3d9a00b003cf4969850fmr9333904wmb.130.1666962972453;
        Fri, 28 Oct 2022 06:16:12 -0700 (PDT)
Received: from [192.168.43.77] (82-132-219-192.dab.02.net. [82.132.219.192])
        by smtp.gmail.com with ESMTPSA id j31-20020a05600c1c1f00b003c701c12a17sm7665957wms.12.2022.10.28.06.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 06:16:11 -0700 (PDT)
Message-ID: <5e151baa-1737-03a7-6163-cbb17008a07a@gmail.com>
Date:   Fri, 28 Oct 2022 14:14:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [bug report] block/bio: add pcpu caching for non-polling bio_put
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-block@vger.kernel.org
References: <Y1urWKutpJW9tqFK@kili>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <Y1urWKutpJW9tqFK@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Dan,

Thanks for the report! It has already been discussed and removed.

On 10/28/22 11:13, Dan Carpenter wrote:
> Hello Pavel Begunkov,
> 
> The patch 13a184e26965: "block/bio: add pcpu caching for non-polling
> bio_put" from Oct 21, 2022, leads to the following Smatch static
> checker warning:
> 
> 	block/bio.c:450 bio_alloc_percpu_cache()
> 	error: we previously assumed 'bio' could be null (see line 449)
> 
> block/bio.c
>      433 static struct bio *bio_alloc_percpu_cache(struct block_device *bdev,
>      434                 unsigned short nr_vecs, blk_opf_t opf, gfp_t gfp,
>      435                 struct bio_set *bs)
>      436 {
>      437         struct bio_alloc_cache *cache;
>      438         struct bio *bio;
>      439
>      440         cache = per_cpu_ptr(bs->cache, get_cpu());
>      441         if (!cache->free_list &&
>      442             READ_ONCE(cache->nr_irq) >= ALLOC_CACHE_THRESHOLD) {
> 
> Imagine "cache->free_list" is NULL but cache->nr_irq is less than the
> threshold.
> 
>      443                 bio_alloc_irq_cache_splice(cache);
>      444                 if (!cache->free_list) {
>      445                         put_cpu();
>      446                         return NULL;
>      447                 }
>      448         }
>      449         bio = cache->free_list;
> --> 450         cache->free_list = bio->bi_next;
>                                     ^^^^^^^^^^^^
> It would lead to a NULL dereference here.
> 
>      451         cache->nr--;
>      452         put_cpu();
>      453
>      454         bio_init(bio, bdev, nr_vecs ? bio->bi_inline_vecs : NULL, nr_vecs, opf);
>      455         bio->bi_pool = bs;
>      456         return bio;
>      457 }
> 
> regards,
> dan carpenter

-- 
Pavel Begunkov
