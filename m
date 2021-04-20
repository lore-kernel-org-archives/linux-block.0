Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EDFC433ED
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 21:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE57561411
	for <linux-block@archiver.kernel.org>; Tue, 20 Apr 2021 21:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbhDTV43 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Apr 2021 17:56:29 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:43949 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbhDTV42 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 17:56:28 -0400
Received: by mail-pf1-f170.google.com with SMTP id p67so21703660pfp.10
        for <linux-block@vger.kernel.org>; Tue, 20 Apr 2021 14:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pS7rT2og1fs9SWN1ZskNeBAulVEG/ii7ymMZWxom2co=;
        b=RXyoY4G+RdVtkwYz1VJnE8UaUCD/I2X+M+o92IvNRMzAsh15FJ0T0RnhLL5hJNRxEY
         M4cyDH7GaY/py0yneKOjbF9+doUWpfttj4sz1i2d4L6AnxKufs/2OXi7Dh8A7qFB401Z
         FV/GPrlmU01HcyJbzL04LNuUEVVYrc3qWtJ0+TCaWeK24bPpHJipkOnXskn1uqC6coMx
         HMhtIPrSZyAQ7OUJJAJJ/c9L1q8DgI6vLMdjtIbq52ZL6A5qMP5Qu6yjsc2LhW3YBmqJ
         DpxAJgilYTWA949cVNGH977zjEuAot8+ZgmpcWHSr93Qnf9hEhkMj9fiQL4GrVGVWx2S
         SOsQ==
X-Gm-Message-State: AOAM530ys4//rZG3yhCcYw7RAp+UTC2bP3sQkRHOLfrs8vjSpMTbXJcP
        sbR+PU8wVNViX5/OemT6yxM6/uiGsgU/5A==
X-Google-Smtp-Source: ABdhPJwsooGOUn+X+EqlPVCWl5ePvl+A6lkmJAOvvANhg34B3ypBFA4w7DT2uS25j/klPSTgNnhP8w==
X-Received: by 2002:a17:90b:1d88:: with SMTP id pf8mr7204698pjb.114.1618955756619;
        Tue, 20 Apr 2021 14:55:56 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:6cb:4566:9005:c2af? ([2601:647:4000:d7:6cb:4566:9005:c2af])
        by smtp.gmail.com with ESMTPSA id a16sm41500pgl.12.2021.04.20.14.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 14:55:56 -0700 (PDT)
Subject: Re: [PATCH v6 0/5] blk-mq: Fix a race between iterating over requests
 and freeing requests
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20210406214905.21622-1-bvanassche@acm.org>
 <20210408064458.vx4t3tpfnrvrd52a@shindev.dhcp.fujisawa.hgst.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <bfaf540a-feea-8fa6-e12e-d15731b75b61@acm.org>
Date:   Tue, 20 Apr 2021 14:55:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210408064458.vx4t3tpfnrvrd52a@shindev.dhcp.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/7/21 11:45 PM, Shinichiro Kawasaki wrote:
> I applied this v6 series on top of the kernel v5.12-rc6 and tested again.
> I needed to apply another dependent fix patch [1] also to avoid conflict.
> 
> [1] https://marc.info/?l=linux-block&m=161545067909064&w=2
> 
> I confirmed this series fixes the use-after-free issue, and observed no
> regression in my test set. For the series, especially for the patches #3-5,
> 
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Hi Shin'ichiro,

Thanks again for the testing. You may want to know that this series has
been prepared and tested on top of Jens' for-next branch
(https://git.kernel.dk/cgit/linux-block/log/?h=for-next).

Bart.


