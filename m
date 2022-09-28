Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F21C04A95
	for <linux-block@archiver.kernel.org>; Wed, 28 Sep 2022 17:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiI1Rtg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Sep 2022 13:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiI1Rte (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Sep 2022 13:49:34 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B680F6F64
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 10:49:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e11-20020a17090a77cb00b00205edbfd646so3321096pjs.1
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 10:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=sbvQ8+O7Iu5pDsUhnetggBoxhwtGlOoUgDtHy9h5j3o=;
        b=ExvBbQ5KKBknu9xSg+qWbY/X1hG+kanpywR1B5ZpLcX5zZMnkusUvVsE2yTTNy5dS2
         KCUd9fpK0oJsxxdKmsquEDXqv/RqAl7gJrDyiBrtgLMVwNiZsMEao2uixWNVPMzCHm65
         FjlvXnxkvLI34FlfoH2qArhBK8IaqHYaS7EB7QuO85H5tr8wWWKsqASJDnhE6xwbZXiU
         UpdfLCo9hO90zqVeAVVQBS/NdcKO2uCxQUkreZpEvZySxDRIIeSU39dV/l3zbmWfI/eP
         Dg8uW0kll6L/k/5+b2dTO5ij+YIQRhM4MmSA5sl7+6opXvMDtTlilsugD3ft2z8W2Wha
         6gQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=sbvQ8+O7Iu5pDsUhnetggBoxhwtGlOoUgDtHy9h5j3o=;
        b=Tho++CVW7KUS2f1LXNEmQTeDlQXRT0tMd/CFIljt/H6V58dF+JASOSt6Ax7rgI9EY+
         iePLPlNwIYTcIzz33Xp4JbvYRyTYuYAyyIY/UT0iM6syPPxZMjoj4lhfASXtRVzXP4Gm
         OngpNZVCihH6P5gMYIpZIuNJCkGJj18twwBCGy/BITMhHpZ+Px9A3AjGWm6VKU79LlZq
         0EEA7d0ssAcQ/JkZvx+X96j+u65c5J8Qqs0PPyfN69b2U1S8a0xSuvkpMEuroLe29Uqp
         ePsan2XsJ/c5uASskSTQe7aewrQdB+MtgrR3+tk6NCMJCmJxKfxp2WQMX33wmaAzy5WL
         XYxg==
X-Gm-Message-State: ACrzQf0v8hgTGP8kQa7Y7vr8xYuBdssuDDIl2KP1yMQoNHNxHW4w1CFT
        Hiy+tvKlwUS0dI1xYQxoC/akUw==
X-Google-Smtp-Source: AMsMyM6mVbp8UjUgd6Ua1oZ/TXcLqXeNHxfIUwGmNRJyCLGXI4Ip9GabzGAflN9Nblr0Z3b/p3hrUg==
X-Received: by 2002:a17:902:da81:b0:178:1d8b:6cb4 with SMTP id j1-20020a170902da8100b001781d8b6cb4mr948463plx.43.1664387369974;
        Wed, 28 Sep 2022 10:49:29 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f27-20020aa79d9b000000b0053e3ed14419sm4256392pfq.48.2022.09.28.10.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:49:29 -0700 (PDT)
Message-ID: <6ffd1719-e7c2-420f-1f9e-0b6d16540b46@kernel.dk>
Date:   Wed, 28 Sep 2022 11:49:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH for-next v10 5/7] block: factor out bio_map_get helper
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>
Cc:     kbusch@kernel.org, io-uring@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        gost.dev@samsung.com
References: <20220927173610.7794-1-joshi.k@samsung.com>
 <CGME20220927174636epcas5p49008baa36dcbf2f61c25ba89c4707c0c@epcas5p4.samsung.com>
 <20220927173610.7794-6-joshi.k@samsung.com> <20220928173121.GC17153@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220928173121.GC17153@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/28/22 11:31 AM, Christoph Hellwig wrote:
> On Tue, Sep 27, 2022 at 11:06:08PM +0530, Kanchan Joshi wrote:
>> Move bio allocation logic from bio_map_user_iov to a new helper
>> bio_map_get. It is named so because functionality is opposite of what is
>> done inside bio_map_put. This is a prep patch.
> 
> I'm still not a fan of using bio_sets for passthrough and would be
> much happier if we could drill down what the problems with the
> slab per-cpu allocator are, but it seems like I've lost that fight
> against Jens..

I don't think there are necessarily big problems with the slab side,
it's just that the per-cpu freeing there needs to be IRQ safe. And the
double cmpxchg() used for that isn't that fast compared to being able
to cache these locally with just preempt protection.

>> +static struct bio *bio_map_get(struct request *rq, unsigned int nr_vecs,
>>  		gfp_t gfp_mask)
> 
> But these names just seems rather misleading.  Why not someting
> like blk_rq_map_bio_alloc and blk_mq_map_bio_put?
> 
> Not really new in this code but a question to Jens:  The existing
> bio_map_user_iov has no real upper bounds on the number of bios
> allocated, how does that fit with the very limited pool size of
> fs_bio_set?

Good question - I think we'd need to ensure that once we get
past the initial alloc that we clear any gfp flags that'd make
the mempool_alloc() wait for completions.

-- 
Jens Axboe


