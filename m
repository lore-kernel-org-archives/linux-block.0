Return-Path: <SRS0=vpK8=6T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7767AC47256
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 17:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605E92083B
	for <linux-block@archiver.kernel.org>; Tue,  5 May 2020 17:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbgEERvV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 May 2020 13:51:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43668 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730564AbgEERvV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 May 2020 13:51:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id v63so1219632pfb.10;
        Tue, 05 May 2020 10:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cN+c0TAgCOlkFWBaF5foyo3htOvmHpO3q6sLeWVc0hA=;
        b=qoUQwb5Crbom0QEajz4g4CjL99ZZTk5kwpRrTjm5+MZVitBo9kYsGvS5BfS56yXyhv
         BrskgavtJUhpf2eg6KTQtQLXGWd3Sdwnc8bZAi0ZIy3FdXfPHZQ5wWU11F6lJoV9wFIb
         yFb5TS0AaBRO2tERABhrd65tolWtX1X4P/E3xWYcCdfhPqNN4zd5Gj+CCfBZMI9s9FxV
         loA+NAQux7YVzwkdU2NRPP7atqDjYv+jeaOidNyPaLYk7G/SfuFaziZJeWKuDRkTLmJe
         /eBkGnwQVmYJ3YDwy8bD3Bjdss+VBWGvVFWdcbVY4dQGa6O74EilBGIdjmH4rQGtRIAn
         C3lQ==
X-Gm-Message-State: AGi0PuYOm0wmE4yrbux3prezvLeTf/AayJVSqEvAzCjltpYq2aWMcyY4
        2znbT41/Ue7TK0/OZ2Eq7DzAgiCPSSk=
X-Google-Smtp-Source: APiQypKDmVEHxp2kzQ0Os7lQFK4gehg8n4NjwhqbnaJ+sPp7i+3LUrLOrGPDoIwOjr/w1h7ZcGnyUA==
X-Received: by 2002:a62:6807:: with SMTP id d7mr4300566pfc.296.1588701078622;
        Tue, 05 May 2020 10:51:18 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:b435:750c:4181:403d? ([2601:647:4000:d7:b435:750c:4181:403d])
        by smtp.gmail.com with ESMTPSA id p66sm2532164pfb.65.2020.05.05.10.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 10:51:17 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Add missing header files to BLOCK LAYER
 section
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200505140728.29369-1-geert+renesas@glider.be>
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
Message-ID: <4029235a-1431-1dc2-8846-e79eb44b07b2@acm.org>
Date:   Tue, 5 May 2020 10:51:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505140728.29369-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-05-05 07:07, Geert Uytterhoeven wrote:
> The various <linux/blk*.h> header files are part of the Block Layer.
> Add them to the corresponding section in the MAINTAINERS file, so
> scripts/get_maintainer.pl will pick them up.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f3fd61cde5125f74..16644a41d42737fe 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3136,6 +3136,7 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>  F:	block/
>  F:	drivers/block/
> +F:	include/linux/blk*
>  F:	kernel/trace/blktrace.c
>  F:	lib/sbitmap.c

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
