Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E1FC04A68
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 15:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbiG0PV5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 11:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiG0PVu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 11:21:50 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D2E1571F
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 08:21:48 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h145so13790485iof.9
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=m9D4aRTTd1l7v7V2LibsBqRcCV4wVw/hGMe1VGtLEYU=;
        b=OjBXxmK3rZJzqhCD1thCamxOk8yVe0Jfpr5OlHXB+qDqb0xT83XrCaXmbHsulJqMpC
         d+Br8WyLksEaGAvDvIq3m1a1hrs0PKweNfKGu1acGuW9VuMIVsAoSASIQ+ufDZqmew0E
         dgIDSkdYiy06DIuJqil1smg7OmOQIZ0LlI2PXUZWte77mPQNmr4DQWptXXwAoJUgi9yv
         XCBAfT1z5F27zv68yFfowQlLKrdBIr96y4I/ycvFHaDkfx/HLVh2KSVO9W7PFzmP1XFM
         X0DAbInx0UXAktyFuchIumzw9YXmALnpwP6haBqZdyqxAcbcrZzBx8NC+6Jyae/8niw+
         le0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m9D4aRTTd1l7v7V2LibsBqRcCV4wVw/hGMe1VGtLEYU=;
        b=U8LbCKyc0LIgBFiBvhdmjkNPXtiPDoJeFVV9CQtKjqzNseM993ftjTzFCTOUW/TOEz
         L0p02LTkVWIrkEHZA6KgVURQ/GZ7A7KVdT9FKysYV7aSsnBF9WCoqzaqspgKqgzoOIYI
         IFWCtb98+bhLttjFyDC9MSiPFSnGHRvPiwDRU0y7lfopHSh2pxrx6LTyJhLhsRdbdTIy
         lAB5vzM3qTP5kzTX7wJiS5t84RlOzJOJV211OmmaOtoIaQSEPAuW7PtfztkJFV8tbqbW
         Rv9suNUl0elsdy2jZfucYx44qm0fD7DvDciXwwkAlUIg2F8hSGjxtknJwDfq6JU2kjzs
         D7hw==
X-Gm-Message-State: AJIora/wFmH1KndcjULlL0YaOEPaKswYUU0quxHkZ2oVofUmOMORYYYg
        ade1I4Qw5E4HX8J6srLoFdK2vw==
X-Google-Smtp-Source: AGRyM1uKWeYELIzQJPcBhoyigdj5YM//qChOtJ+4M1k2Jp38ll9FwQ5YYxqx1YYndmsnxKQmA7mgAg==
X-Received: by 2002:a05:6638:d45:b0:340:5c58:51f4 with SMTP id d5-20020a0566380d4500b003405c5851f4mr8915622jak.280.1658935307618;
        Wed, 27 Jul 2022 08:21:47 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x8-20020a0566022c4800b0067c09fd0b53sm8358300iov.21.2022.07.27.08.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 08:21:47 -0700 (PDT)
Message-ID: <41868484-07cd-2408-41c9-d48953b7a1af@kernel.dk>
Date:   Wed, 27 Jul 2022 09:21:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [bug report] compiling error with latest linux-block/for-next
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
References: <CAHj4cs8HjT6T8VCZtWzB1DzqHqcqex+bV6vdh2MdVwqNP9GH=A@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHj4cs8HjT6T8VCZtWzB1DzqHqcqex+bV6vdh2MdVwqNP9GH=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/22 9:18 AM, Yi Zhang wrote:
> Hello
> I found below compiling error[2] on latest linux-block/for-next[1],
> pls check it.
> 
> [1]
> b8b914c06a6f (HEAD, origin/for-next) Merge branch
> 'for-5.20/drivers-post' into for-next
> 
> [2]
> In file included from ./include/linux/export.h:33,
>                  from ./include/linux/linkage.h:7,
>                  from ./include/linux/kernel.h:17,
>                  from io_uring/notif.c:1:
> io_uring/notif.c: In function ?io_alloc_notif?:
> io_uring/notif.c:52:23: error: implicit declaration of function
> ?io_alloc_req_refill?; did you mean ?io_rsrc_refs_refill??
> [-Werror=implicit-function-declaration]
>    52 |         if (unlikely(!io_alloc_req_refill(ctx)))
>       |                       ^~~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:78:45: note: in definition of macro ?unlikely?
>    78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>       |                                             ^
>   CC      kernel/trace/trace_seq.o
>   CC      drivers/mfd/stmpe.o
> io_uring/notif.c:54:17: error: implicit declaration of function
> ?io_alloc_req?; did you mean ?xa_alloc_irq??
> [-Werror=implicit-function-declaration]
>    54 |         notif = io_alloc_req(ctx);
>       |                 ^~~~~~~~~~~~
>       |                 xa_alloc_irq
> io_uring/notif.c:54:15: warning: assignment to ?struct io_kiocb *?
> from ?int? makes pointer from integer without a cast
> [-Wint-conversion]
>    54 |         notif = io_alloc_req(ctx);
>       |               ^

This is fixed in the current tree.

-- 
Jens Axboe

