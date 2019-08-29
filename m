Return-Path: <SRS0=37yO=WZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7D0C41514
	for <linux-block@archiver.kernel.org>; Thu, 29 Aug 2019 15:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424882341C
	for <linux-block@archiver.kernel.org>; Thu, 29 Aug 2019 15:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QX0u/cxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfH2PFD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:05:03 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33330 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfH2PFD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Aug 2019 11:05:03 -0400
Received: by mail-io1-f66.google.com with SMTP id z3so7651619iog.0
        for <linux-block@vger.kernel.org>; Thu, 29 Aug 2019 08:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m58uXEj+mZp8lYkN/2HdaWVcyi50cr4NHwQgbXe9aeg=;
        b=QX0u/cxa+B7F4tW0k4zBUQYtr7E9MKD3H0qpKQNMJhIom9seSyg3t3x7oXNyVrK5J/
         ugP5QAsn92r4nRhKoQrCdtlHIAuW6GqVo0hWlExZcHMaPOEfONAUD9xI1JQf7MDWoIml
         Hsnlw5ozeAgRDXBEFQtYhMBEP+KBx5UDhLoK60mWd3H0cjHIdk3xqoAywS43UmeEuhwB
         LlLflSonJFYo1g6I7T4rnn577k1nnNUwDIYci8iOB02AdmAakeMvqrT2PoiwumKTue9N
         Wa22ZZ8nvWAClV2QYb6UUOesUuxpur1mkOSHZh8nqjlKEsaPh+HqjLop1yiTm+Wf5a9V
         lH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m58uXEj+mZp8lYkN/2HdaWVcyi50cr4NHwQgbXe9aeg=;
        b=ZFva2XvQ9n8DJGIMba+C5EeuqLbW3xSGiqHJsVgJGeUK7cAfHrbULoL88Iqx/KqVtx
         IDePN8JidEJxMgc1wp96QmJmHlLCaYlPGSWN9+KSHfjR0nxYwcWQEpk4DorXJf3Pilt7
         w1UCsF0rXW8c8lcxmG17gIvHlcxhZe6HIUHRJH6QK9UporXAIxPIgkzHZt8W4d1T01do
         FHcPY4Hw6MKGMuC+1UrAGo2AhSPbohibmqXsCdqkg9HyUG2VMPQvzT+BTx0ox7+HmoPe
         SYNgQ+0hzlo0v/w1AH8KON/1b5gc23aYIc1mu5ohj1XaYPujkbL/cfEtDV8udYg23xCD
         wIcw==
X-Gm-Message-State: APjAAAXv0Ld+brlkdfSLTvICyuvbIXwCOrQVzrt+EHEROQLwmgUIGnvv
        M6sUGAoNsR6iwMKeOeVWYulVWiJxqJWOjw==
X-Google-Smtp-Source: APXvYqxM1LALXX+NOTNw5Zeef/QV6Y5VWHiFb2F/LSmExd1UbY+7YJiT+mT/cppUVWxTX0ksHLr0UA==
X-Received: by 2002:a6b:c88e:: with SMTP id y136mr4520215iof.68.1567091101883;
        Thu, 29 Aug 2019 08:05:01 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j11sm2028465ioa.55.2019.08.29.08.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 08:05:00 -0700 (PDT)
Subject: Re: [PATCH] io_uring: allocate the two rings together
To:     Hristo Venev <hristo@venev.name>
Cc:     linux-block@vger.kernel.org
References: <20190826172346.8341-1-hristo@venev.name>
 <80e0e408-f602-4446-d244-60f9d4ce9c71@kernel.dk>
 <2f409a14ea27516a97cb7a7f1d70de7fe45c7c69.camel@venev.name>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dec45613-ab82-24b2-71bb-69693a22ee46@kernel.dk>
Date:   Thu, 29 Aug 2019 09:04:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2f409a14ea27516a97cb7a7f1d70de7fe45c7c69.camel@venev.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/19 1:35 PM, Hristo Venev wrote:
> Sorry for the duplicate reply, I forgot to CC the mailing list.
> 
> On Tue, 2019-08-27 at 09:50 -0600, Jens Axboe wrote:
>> Outside of going for a cleanup, have you observed any wins from this
>> change?
> 
> I haven't ran any interesting benchmarks. The cp examples in liburing
> are running as fast as before, at least on x86_64.
> 
> Do you think it makes sense to tell userspace that the sq and cq mmap
> offsets now mean the same thing? We could add a flag set by the kernel
> to io_uring_params.

Not sure, there isn't a whole lot of overhead associated with having
to do two mmaps vs just one.

If you wanted to, the best approach would be to change one of the
io_uring_params reserved fields to be a feature field or something
like that. As features get added, we could flag them there. Then
the app could do:

io_uring_setup(depth, &params);
if (params.features & IORING_FEAT_SINGLE_MMAP)
	....
else
	mmap rings individually

and so forth.

-- 
Jens Axboe

