Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFB9C433F5
	for <linux-block@archiver.kernel.org>; Sun, 12 Sep 2021 03:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136F9611BF
	for <linux-block@archiver.kernel.org>; Sun, 12 Sep 2021 03:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhILDU0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Sep 2021 23:20:26 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:41651 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhILDU0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Sep 2021 23:20:26 -0400
Received: by mail-pj1-f47.google.com with SMTP id m21-20020a17090a859500b00197688449c4so4142547pjn.0
        for <linux-block@vger.kernel.org>; Sat, 11 Sep 2021 20:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E65Lhy+ZNRO+L7xP2TNNf2DGZyFoa7l5Jk0q7mXn/yA=;
        b=xZnyv+Lvz5rUaWcVdOZH8XDWuP3+MwbIZzvZyAOEl9rwALvxt8kWqDBRRRwqt3I2lY
         eC9RubnQTzNWw1gDP3RjhCuj0WghYflftEu8tvI4BWiw9X4rJafnZv4RxN6SB65xUcVb
         bSRkbRqQUPcJgSIfW9eGpoojsqEZEfHgVeSa+5cKmDyNezISxDNQRX19+yAp3IV/jG/l
         ZnEStzOlCNiCkIbX0cKBzf0UcGuKTPfXdooZRViIGz0WjybzPjnEL9MsAk3z6tbTaq0m
         E2zYJpqDSYKzF04fjfHlagCleH7wtaUMWwroI8q/8OHlehrFoCyKi3/5Y0XCzKyhDleI
         NhSg==
X-Gm-Message-State: AOAM531ClU9C9GC7J5m9xctX2wSDvvtodbZc5fZLgJJu5BuKSS0sMc5/
        r+iW2ZVxI2vvIT1qmHhIQ78=
X-Google-Smtp-Source: ABdhPJwR8PIi2tU730YLxeNQ3ZO3UmD6a8cCsjtZerThfV88PTAJ4N9rJhHzg3RmRvuQfm2vSfCzAw==
X-Received: by 2002:a17:90a:351:: with SMTP id 17mr5725013pjf.233.1631416752624;
        Sat, 11 Sep 2021 20:19:12 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:8e23:83c0:a404:a54f? ([2601:647:4000:d7:8e23:83c0:a404:a54f])
        by smtp.gmail.com with UTF8SMTPSA id c9sm3378939pgq.58.2021.09.11.20.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 20:19:11 -0700 (PDT)
Message-ID: <c728eac8-3246-2a6d-84bd-a04fa62fbc04@acm.org>
Date:   Sat, 11 Sep 2021 20:19:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] block: Optimize bio_init()
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210911214734.4692-1-bvanassche@acm.org>
 <c61afcb0-dcee-8c02-d216-58f263093951@kernel.dk>
 <c810ce05-0893-d8c8-f288-0e018b0a08ca@kernel.dk>
 <fe7f7cc7-2403-7ec6-7c1c-abb6ac6a68fa@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <fe7f7cc7-2403-7ec6-7c1c-abb6ac6a68fa@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/11/21 15:16, Jens Axboe wrote:
> Looking at profile:
> 
>   43.34 │      rep    stos %rax,%es:(%rdi)
> I do wonder if rep stos is just not very well suited for small regions,
> either in general or particularly on AMD.
> 
> What do your profiles look like for before and after?

Since I do not know which tool was used to obtain the above
information, I ran perf record -ags sleep 10 while the test
was running. I could not find bio_init in the output. I think
that means that that function got inlined. But
bio_alloc_bioset() showed up in the output. The time spent in
that function is lower if IOPS are higher.

The performance numbers in the patch description come from a
Intel Xeon Gold 6154 CPU. I reran the test today on an old Intel
Core i7-4790 CPU and obtained the opposite result: higher IOPS
without this patch than with this patch although the assembler
code looks to be the same. It seems like how fast "rep stos"
runs depends on the CPU type?

Bart.

