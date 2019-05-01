Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660ABC43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 12:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33ED421734
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 12:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dzt4LVcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfEAMnW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 08:43:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41631 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfEAMnV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 08:43:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so8556368pfd.8
        for <linux-block@vger.kernel.org>; Wed, 01 May 2019 05:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kAWzTRrdQQn0qB9WvEEBykXGzB1SmroEGLap8Zwt/1o=;
        b=dzt4LVcMRuFRz8l0Da+88RygX+vIW/dOAQeGl+J91ns8q7w+Ee8YXFS+BrXhPuKxUI
         EhOKEWQZfCLb+DXI8lqNmY4Mq3RHN2RSapcf6KDZr4driq2nJzMosH8Fm2yuKIF31ehy
         SRrSD+BGY9H6UwGQWuK9s+FqEu5h+2X+8PdPgvGVXrh4Hc1A0pLr1V+WaIDGLBimgfsi
         LGpwiSEN5XS6QqVl/We1UVxyuSET5D1FHfDRU4iEI07tSoCSSATijGI4Pn4VI0lSrTGd
         VmqXXSRA6QBYN1NtYrXeo9iJ7EjEkxnkgpagEBye89vJQstnCtILX98lXqcNpKukMj02
         24tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kAWzTRrdQQn0qB9WvEEBykXGzB1SmroEGLap8Zwt/1o=;
        b=iJV0hjePtVc2GSNQ53oBEEZ4sWSkjH19rJ6eniBbm47yD6EvVZdz2vR1ijnyZvrGno
         YpjnwrJLyWEqXlGOcElGPOWDuIk9KZ4BA7A8i32i1OLWd2Ttn7fkv5uLBm2L/JtTQ5pM
         gH2X45r6HbfogZTpyLwoEspFmoWvKZaSaWqTNnaVZhox/j4kFyAQcSr5uuq4QFQt8l9X
         sINR9FCxS6aTqd6eiZdfkOfkNLCL+c9ZZCqPpKoFviqSAoJcMwImLY7mGonH4QLTXZSP
         ngGQm3fkdL0q3y1Fbvnvdez3/Nq1Z6g7uvMFkgnmoEgHgUo+quHh+wIIpzTLYBTd142q
         ZlfQ==
X-Gm-Message-State: APjAAAWCkpHkPU1zUfiY4WnTJ6Q8uTDegXceCounrJsYEKOyf1llqcv2
        5wKP/iZFiK9u4jf5tnlP9iHMbw==
X-Google-Smtp-Source: APXvYqwYrYbpsn35wp/hZRoyJ374/7VO7aJBmeBJ0DNcETxhReKmX/Xc5wSuV3tsCKoq/Sr1zB3cAg==
X-Received: by 2002:a62:2ad5:: with SMTP id q204mr77227243pfq.259.1556714600995;
        Wed, 01 May 2019 05:43:20 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id c8sm6783930pfr.16.2019.05.01.05.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 05:43:19 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] [io_uring] require RWF_HIPRI for iopoll reads and
 writes
To:     =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20190501115223.13296-1-source@stbuehler.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <628e59c6-716f-5af3-c1dc-bf5cb9003105@kernel.dk>
Date:   Wed, 1 May 2019 06:43:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501115223.13296-1-source@stbuehler.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/1/19 5:52 AM, Stefan Bühler wrote:
> This makes the mapping RWF_HIPRI <-> IOCB_HIPRI <-> iopoll more
> consistent; it also allows supporting iopoll operations without
> IORING_SETUP_IOPOLL in the future.

I don't want to make this change now. Additionally, it's never
going to be possible to support polled IO mixed with non-polled
IO on an io_uring instance, as that makes the wait part of IO
impossible to support without adding tracking of requests.

As we can never mix them, it doesn't make a lot of sense to
request RWF_HIPRI for polled IO.

-- 
Jens Axboe

