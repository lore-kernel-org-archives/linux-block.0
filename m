Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5E2C433B4
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 17:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F97610E9
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 17:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhECRnb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 May 2021 13:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhECRnb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 May 2021 13:43:31 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9756C06174A
        for <linux-block@vger.kernel.org>; Mon,  3 May 2021 10:42:37 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id b17so4281511ilh.6
        for <linux-block@vger.kernel.org>; Mon, 03 May 2021 10:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SQhh7q14AazVPSTXtqYUT/05mUeKsGqTxLgJAdxFD4I=;
        b=ZFPspN0/ZZqrUf8JR1To59HkX7d+Jzd333fLOAo6nAfNdA9Mfq3VmdeQXshdonGQlK
         YmXHGqyAfpz6RVViZTv63MdP1hmsv8oQ6pW0KLTkx+DG9q549+4E4KRRxdM8QVhzexAC
         wVwH3a0OdM4nlKJeJl45gg0PQBLCZzJqx95qezv6KTGavWUOH+vEyy+UfucRz2FX4so6
         0MLDQZpVQZ6bN973pa0RGFm8UdGzrCGUILT9xKD+Uss0+Ywlp5vCQxSTObJzJSw8lJJu
         qkQFJH/Tl48kY0hEVLtN7hjO0fMz/+nzIhgR/xXdTU40ODb252Z3Syu7quIfObWhqyDn
         Bpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SQhh7q14AazVPSTXtqYUT/05mUeKsGqTxLgJAdxFD4I=;
        b=CUyj6zfmPLVVZpebcGylFg4wThKOsJA76IaZoOwYUvPTAXcnJcdW7B6aViNoZBaJys
         6g2OupFVzj5aeIeKfHpJ5hUPkOGGl/BRrZyZVdVvZ9T7OR92Tho8pBb3hDH1pky8tQ3+
         w0ykVBuPDYGCq1BZcj4iZjrWC08dSqNCw0bZAj1bHHA99pWZikKqpCp6cBQ8REjQV8Yc
         H6t1TNlJuKIb0y84U39H7zmEGYUuz0ZTyOt3lOL9MwLdxdPyRttqpa41Wm3cToeK2Etd
         W/pNbOXvMn4GKVa0d+aZOkPS5uFcgtFvnUgbvo0Z+FZ1pkpCWaW4ntwbayaoh+X7ZWug
         ImPQ==
X-Gm-Message-State: AOAM532CXA7RZyZTfK+D9NCV2djvDXuuWai+PoKeThufEugdIJTNZNIT
        hMBhgBFyRnXIud+8lbP/Vo3fLeHvIb0ysw==
X-Google-Smtp-Source: ABdhPJyuCzIE1IGka5cz95ckMeQrW9JNadgkxUbdPnSQDk9smLMlzdYeYFutgG/db58bjwJDLrOCnw==
X-Received: by 2002:a92:7609:: with SMTP id r9mr17815153ilc.297.1620063757031;
        Mon, 03 May 2021 10:42:37 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h11sm5828377ilr.84.2021.05.03.10.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 10:42:36 -0700 (PDT)
Subject: Re: [PATCH] null_blk: poll queue support
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <baca710d-0f2a-16e2-60bd-b105b854e0ae@kernel.dk>
 <725ea863-c754-addf-f143-71d7e2f273de@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5e0c7e2f-3fe4-7537-98f5-b9c6de8e5c8f@kernel.dk>
Date:   Mon, 3 May 2021 11:42:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <725ea863-c754-addf-f143-71d7e2f273de@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/3/21 9:47 AM, Bart Van Assche wrote:
> On 4/17/21 8:29 AM, Jens Axboe wrote:
>> There's currently no way to experiment with polled IO with null_blk,
>> which seems like an oversight. This patch adds support for polled IO.
>> We keep a list of issued IOs on submit, and then process that list
>> when mq_ops->poll() is invoked.
>>
>> A new parameter is added, poll_queues. It defaults to 1 like the
>> submit queues, meaning we'll have 1 poll queue available.
> 
> Has anyone run blktests against blk-for-next since this patch got
> queued? The following appears in the kernel log if I run blktests:

Do you know what parameters the module was loaded with? I'll drop this
one from the 5.13 queue for now.

-- 
Jens Axboe

