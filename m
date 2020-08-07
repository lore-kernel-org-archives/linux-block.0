Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10470C433DF
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 17:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D631F2224D
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 17:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgHGRX3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:23:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38983 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgHGRX1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Aug 2020 13:23:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id z20so1364509plo.6
        for <linux-block@vger.kernel.org>; Fri, 07 Aug 2020 10:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+yOXZvZf5Z6iGb9WbiP3azFYbI/Merq7JlcODjLgC08=;
        b=hW1eyGpEgFVbYU0tjWmF8mIr0OOW9MnEmd8weh+uoWnDLw6SL3P/L+9YM7ODvCOFvb
         hVJhL+9q1N5iHl8Uh3L52eTVv0z4Q23f4YISrlLNhk6puivLJVfZqVcB9b4qe7o5z9eC
         eZXwLoj/E9rBGXvyh/a+FXLW7bkaKmA76nDRPzrz34ac9FHVUtrl6Lel0sPd4YWsGymD
         ZXWOPiGC6BuMU0Eu2U5pZ3JZSqIev0RWKJz1fSM819ZlPz7QkRxxgNlpIhCo5HlfEDBt
         Q680mN+D+f2nnRZg82bAi8qMhn9bNNkCvUVFit2mezzsr7RNPfxPknkkBXPNFE8DcWfd
         ic0w==
X-Gm-Message-State: AOAM533nRRNXeKmxtL7pV8OIV4uhMnGRxSc6rDRkJXR7VKHXmcZYfHlQ
        Jp5vcevrNsQRi8nWwLuBNcM=
X-Google-Smtp-Source: ABdhPJzFStox2TGynJvnNPJ+3raN+8mXfnDTFGC29p5ftg+giyhihkM+BsHEWymB53wnKvwvhfUAgQ==
X-Received: by 2002:a17:90a:36a7:: with SMTP id t36mr14855295pjb.36.1596821006839;
        Fri, 07 Aug 2020 10:23:26 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dec:a6f0:8cde:ad1c? ([2601:647:4802:9070:3dec:a6f0:8cde:ad1c])
        by smtp.gmail.com with ESMTPSA id mr21sm11372690pjb.57.2020.08.07.10.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 10:23:26 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] common/multipath-over-rdma: don't retry module
 unload
To:     Bart Van Assche <bvanassche@acm.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-7-sagi@grimberg.me>
 <925e1ac6-38fa-6fe9-c0b7-7e665559a989@acm.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <155cb916-062f-e23f-9790-35dee850687b@grimberg.me>
Date:   Fri, 7 Aug 2020 10:23:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <925e1ac6-38fa-6fe9-c0b7-7e665559a989@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> There is no need to retry module unload for rdma_rxe
>> and siw. This also creates a dependency on
>> tests/nvmeof/rc which prevents it from using in
>> other test subsystems.
> 
> If it wouldn't be necessary to retry module unload I wouldn't have
> introduced a loop.

I thought it was to work-around a driver issue as these drivers
traditionally had plenty of stability issues.

To be honest this retry loop to me indicated that either the
driver has a bug or the test. But maybe there is a need I
am not seeing.

> How about moving the unload_module() function definitions from tests/srp/rc
> and tests/nvmeof-mp/rc into common/rc instead?

Don't have an issue with that.
