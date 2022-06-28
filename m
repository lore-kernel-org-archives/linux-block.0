Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFF4C43334
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 22:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiF1Wo0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 18:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiF1Wo0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 18:44:26 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9830427CF6
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 15:44:25 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so17400201pjl.5
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 15:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KdkaNZaAwyrqgmFffc+OxJ4Vi9xLHzsdMa09ypg9m0o=;
        b=6NcgYtFWr2hjYih5Q5NpNzhjKJK8d2rF0iMKiaCLxyYRdYVr9u+qIk5MF/jdzRdyds
         3KVtVK8uF2eKQMwG23f2wVGScS/T75YxKChX80T0zENp+N77uuCvSGikrNa4NWNzDgj6
         hG2LQTJQolI9yMGD20iK0x2fT16Gy7Wu472XvqEFxQAhvx8UVbM9c22I31/qm28F4Q7a
         ZfvGYVhm4VgFWhXgbPOYIAGFTXrl19GNxjSSkJSiz8mxEcDOHB/6DpwUhOzeX0qMJuy3
         cFJjPRIm125TvX4rbhChoVKEtcN/FrlkBLHY10L+6lwNB2S2e/2trHo+WBc7dlNOyIx5
         mbOg==
X-Gm-Message-State: AJIora8Glh30fQDwMkkGiK1HeRwrwSRpY04shzDBsBY08oHHG8wOsv33
        Edg9w6qW6RsOICk7Gzm/KSc=
X-Google-Smtp-Source: AGRyM1tMZ6LXEqXHmXE4NWd4OMwXAA8A4A6AMtdtcxTK8/vlzmwn2nzrqXF4MeS10/u2D7sSxysgcw==
X-Received: by 2002:a17:902:ea02:b0:16a:57bb:d344 with SMTP id s2-20020a170902ea0200b0016a57bbd344mr5868549plg.150.1656456264959;
        Tue, 28 Jun 2022 15:44:24 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id cu7-20020a056a00448700b00525373aac7csm9906741pfb.26.2022.06.28.15.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 15:44:24 -0700 (PDT)
Message-ID: <16e6b898-19b2-831f-c8d7-7ee606f6a7c5@acm.org>
Date:   Tue, 28 Jun 2022 15:44:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 00/51] Improve static type checking for request flags
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20220623180528.3595304-1-bvanassche@acm.org>
 <20220624050527.GA4716@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220624050527.GA4716@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/22 22:05, Christoph Hellwig wrote:
> I generally like this.  Two thoughs:
> 
>   - I suspect most places that currently pass a enum req_op might really
>     want a blk_opf_t for future extensibility, exceptions are very
>     low-level helpers like req_op() and bio_op() where the enum is
>     very nice to force switch statements to handle all ops or have
>     a default statements

Agreed. I will use blk_opf_t where enum req_op is passed today but where 
request flags might be passed in addition to the request type in the future.

>   - a lot of the flags printinting is a mess, and introduce the code
>     smell of __force casts.  It migh make sense to introduce a new
>     %psomething format specifier first to print a blk_opf_t using
>     printk/vsprintf/etc and switch everyone to that first instead of
>     hand crafted printing.

How about using blk_fill_rwbs() instead, a function that is already 
being used by the bcache tracing code?

No matter how tracing the request operation type and flags is unified, 
I'd like to defer this unification to a future patch series since this 
patch series is already too big.

Thanks,

Bart.
