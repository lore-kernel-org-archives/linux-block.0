Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623BAC433C1
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 23:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32A1E61996
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 23:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhC3XNI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhC3XMq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 19:12:46 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EFBC061574;
        Tue, 30 Mar 2021 16:12:46 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so17202675otq.8;
        Tue, 30 Mar 2021 16:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qDX+ejIT41EUFfKn1nuqpiCeVTQFXcUBxJeHlcbY8F4=;
        b=Af/h9+axkeg+vrgvkxeU047UkCgwbeSgJkJfdGCh4UKoWnXh7dg0bIC8OuQ/ZObeIq
         Ujc9niOM9+OHd2IBJtm7djz6OlvQRLvmCvxI9jlh7ryWrJXQsoVGG/ggNm7S1s+stl4t
         4xYYMoE7YS9ZudGXMXkBHUoaDOMoyetNYH/gm0E/MS7UTFEF59+SOdXFrVghiemausa1
         DnoiXTmgBT2f+FU1v17g+GzBoYMQLAeAYBcBIe12Mi92yLOOjSTwMp5dI6SUY7908Cx4
         oM95Bc5GLTEBfdwWcnUNpn5Zs0PSoP3STgZ7tzC7yK0GEZD0l5QXVXUdDSuLjUuhuCZ1
         Z2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qDX+ejIT41EUFfKn1nuqpiCeVTQFXcUBxJeHlcbY8F4=;
        b=kc4yAa00MqjcBGPtg/cQoCcPBBzDPBVHG+Lv7MiTo6/jbk8EmwI0O7yQl2piArwzoK
         2ergXG2XY8YpNgtznaUoVR0QUODmOt9WhnH/LYSqig633/H0BEXRUSKQOLgC6QqGSjll
         I8SOFv/cwfDyrb1fe68AyhVQADm6JvTQGSgZL9FoOWyhur/0rr79w+6ehybAh8M3iEEt
         d7Y7pfqlD/HZrgftK9LcZFYFfijQhXGHRdtKXhNNZO6HjXl97/bHcrBpEYmpAiIZEAnx
         KWfLaJDGC7b1kE7S58REQCng6zBTrq+dGxZd6ppLeINWXWDVY+2uvO0rA6XzNk1zPFop
         Ls8A==
X-Gm-Message-State: AOAM533Zn3l7Qq0ybVUiunHrlwXIC96i2ZVcAfOmHEEvYq2EN8d8KSeR
        /LGGS7qT0SvIt8UuXnqB2pw=
X-Google-Smtp-Source: ABdhPJx1bqT6fqOTR4f0qXEIEkv1Nc998kCbj5y74Qz5gLtWIGrsUBM+w8TIOd1co2Hgh8fRrGc+5g==
X-Received: by 2002:a9d:5911:: with SMTP id t17mr231853oth.148.1617145965706;
        Tue, 30 Mar 2021 16:12:45 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y11sm80003oov.9.2021.03.30.16.12.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Mar 2021 16:12:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 30 Mar 2021 16:12:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jian Cai <jiancai@google.com>
Cc:     cjdb@google.com, manojgupta@google.com, llozano@google.com,
        clang-built-linux@googlegroups.com, Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: fix alignment mismatch.
Message-ID: <20210330231239.GA18041@roeck-us.net>
References: <20210330230249.709221-1-jiancai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330230249.709221-1-jiancai@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 30, 2021 at 04:02:49PM -0700, Jian Cai wrote:
> This fixes the mismatch of alignments between csd and its use as an
> argument to smp_call_function_single_async, which causes build failure
> when -Walign-mismatch in Clang is used.
> 
> Link:
> http://crrev.com/c/1193732

That link does not work. You probably meant
	http://crbug.com/1193732

You'll probably want drop the link and to copy the relevant information
directly into the patch description. Generate the error with an upstream
kernel and cut-and-paste the output here.

For others, the observed error message is:

block/blk-mq.c:622:44: error: passing 8-byte aligned argument to 32-byte
	aligned parameter 2 of 'smp_call_function_single_async' may result
	in an unaligned pointer access [-Werror,-Walign-mismatch]

Thanks,
Guenter

> 
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Jian Cai <jiancai@google.com>
> ---
>  include/linux/blkdev.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index bc6bc8383b43..3b92330d95ad 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -231,7 +231,7 @@ struct request {
>  	unsigned long deadline;
>  
>  	union {
> -		struct __call_single_data csd;
> +		call_single_data_t csd;
>  		u64 fifo_time;
>  	};
>  
> -- 
> 2.31.0.291.g576ba9dcdaf-goog
> 
