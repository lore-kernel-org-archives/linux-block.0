Return-Path: <SRS0=iZfY=C5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1953C43463
	for <linux-block@archiver.kernel.org>; Sun, 20 Sep 2020 15:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805D3206B8
	for <linux-block@archiver.kernel.org>; Sun, 20 Sep 2020 15:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgITP3m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Sep 2020 11:29:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44849 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITP3m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Sep 2020 11:29:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id 7so6557377pgm.11;
        Sun, 20 Sep 2020 08:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IaFHtmDM2KcL9E++emC0UGl3lJxhdOO/H9KX6vV34y8=;
        b=CaOmbZ1jxftBIc7SMkO6hrZ6jGv+8Wk6iUTjgUszutJASGS4ZA+Zn/8ROdjo6MRV39
         Oo8msbPKCS9Fb9j6e4r/0eZRpeVlTuQ0eGvZ9TSUJ7nk3/C5pnk42cPTeC9i9gnitAy8
         HnJ3pSjxhfuS3FsJCWZTZTkrVO/cSVvlP4tIADBR9p4jWBzqXYkFLMPsNLj4PkcrHBSY
         7lS+Dt5cBaP9uU8f1aoo+3uL64s6sP/Cmok+XDdtVt5etAW3YnNEs8xDog0a5xanfoYO
         1FhJT7WGZ9U+sx/H48mOvROtew/EiZu9Olcwui/JKm2MvbCjxu5rljDIBtpsSXb39ckQ
         RulQ==
X-Gm-Message-State: AOAM530hFxtBIK0yYsmuxWgDHbJ9o+t9v/az443vPwlnJsUVaXC2up6M
        bFiZRXmCbtfkjHlGVhUmMUHHHVUQE/0=
X-Google-Smtp-Source: ABdhPJykKoOKloGHqP7ry1sP67RpKCalk+VFRYJAk3Y9dBoAbHg0l2KDRmUqpLB3Hgv0NQvF86A0CQ==
X-Received: by 2002:a65:5cc2:: with SMTP id b2mr34134614pgt.124.1600615781747;
        Sun, 20 Sep 2020 08:29:41 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:7b71:dd79:a872:b92c? ([2601:647:4000:d7:7b71:dd79:a872:b92c])
        by smtp.gmail.com with ESMTPSA id bx18sm8233353pjb.6.2020.09.20.08.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 08:29:40 -0700 (PDT)
Subject: Re: [PATCH] sgl_alloc_order: memory leak
To:     Douglas Gilbert <dgilbert@interlog.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
References: <20200920053607.35002-1-dgilbert@interlog.com>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <6376bc21-0542-bdc5-fa30-4a76ab3cbc67@acm.org>
Date:   Sun, 20 Sep 2020 08:29:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200920053607.35002-1-dgilbert@interlog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-09-19 22:36, Douglas Gilbert wrote:
> Noticed that when sgl_alloc_order() failed with order > 0 that
> free memory on my machine shrank. That function shouldn't call
> sgl_free() on its error path since that is only correct when
> order==0 .
> 
> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
> ---
>  lib/scatterlist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> index 5d63a8857f36..c448642e0f78 100644
> --- a/lib/scatterlist.c
> +++ b/lib/scatterlist.c
> @@ -514,7 +514,7 @@ struct scatterlist *sgl_alloc_order(unsigned long long length,
>  		elem_len = min_t(u64, length, PAGE_SIZE << order);
>  		page = alloc_pages(gfp, order);
>  		if (!page) {
> -			sgl_free(sgl);
> +			sgl_free_order(sgl, order);
>  			return NULL;
>  		}

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
