Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8304C5519F
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 03:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F3D206F8
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 03:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgKYDrt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Nov 2020 22:47:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45389 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgKYDrt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 22:47:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id 62so1123394pgg.12
        for <linux-block@vger.kernel.org>; Tue, 24 Nov 2020 19:47:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tuEEqFff68LxNg8K0WH7k+TFM+Y5XoKUY/E9VMvpbCo=;
        b=fynZsPWd+2ZfV2RhjBhMCkxjNm+kc8iBaQJx4mA4ylyukYeWWSEowWEB0NvCrD9sx9
         twYQq2fiEpsM9ep/L4THSLuJW+ETSvHwq8ByYkneFdB2DkJfHae7Xn1hLfMY43rqfG6I
         lU73fiAdpsBvfWoCnSpkuA+McR849KV5gBX0zNx93axiN0WadLC0pBBEJRGeMXR6I3Tq
         +7iQY6Rx35a786OUuJpSLmoEx3Nu5u9Y4+9CGSVaSNWMTA44a3muIontX3y9H8bJxuee
         9ssF7zuhTztI+DYSa8VdqdSjb3LCQv9P9raLthDD05tiixa7GqjAYeMnCFuUyslR6p1v
         uwVg==
X-Gm-Message-State: AOAM533I3FWxhX4vZPf1SQOunUe+7yf8xslxnMMz/LDqMZ34894XKuS6
        heQP2eV7nDQK1QAfrZInIuMhi/hN2BU=
X-Google-Smtp-Source: ABdhPJxbIEVGkqtmvJmgWbEOxfGOOx9WtJksQYRH7406bfb+juGv8KUzqLAXgG0kK5kVQmGaCxSHqQ==
X-Received: by 2002:a17:90a:178b:: with SMTP id q11mr1713671pja.132.1606276068628;
        Tue, 24 Nov 2020 19:47:48 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id j11sm516794pgp.82.2020.11.24.19.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 19:47:47 -0800 (PST)
Subject: Re: [PATCH blktests 1/5] tests/srp/rc: update the ib_srpt module name
To:     Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-2-yi.zhang@redhat.com>
 <7b6d00d7-2cf8-5a4b-f861-a7efe152843f@acm.org>
 <54f41dc8-41a5-e782-e135-dc7dc81209c0@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <3e4208ef-3508-0db2-3b1d-96f055e1a37f@acm.org>
Date:   Tue, 24 Nov 2020 19:47:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <54f41dc8-41a5-e782-e135-dc7dc81209c0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/24/20 6:01 AM, Yi Zhang wrote:
> On 11/24/20 11:23 AM, Bart Van Assche wrote:
>> On 11/23/20 5:04 PM, Yi Zhang wrote:
>>> -    insmod "/lib/modules/$(uname
>>> -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko" "${opts[@]}" ||
>>> return $?
>>> +    insmod "$(ls /lib/modules/"$(uname
>>> -r)"/kernel/drivers/infiniband/ulp/srpt/ib_srpt.*)" "${opts[@]}" ||
>>> return $?
>> Is 'ls' needed here or is 'echo' sufficient?
> Actually it doesn't work without ls
> $ insmod "/lib/modules/"$(uname
> -r)"/kernel/drivers/infiniband/ulp/srpt/ib_srpt.*"
> insmod: ERROR: could not load module
> /lib/modules/5.10.0-rc5/kernel/drivers/infiniband/ulp/srpt/ib_srpt.*: No
> such file or directory
> 
> and it works with echo, I can change to echo if you prefer
> $ insmod "$(echo /lib/modules/"$(uname
> -r)"/kernel/drivers/infiniband/ulp/srpt/ib_srpt.*)" "${opts[@]}" ||
> return $?

'echo' is a shell built-in while ls is not built-in into bash, so echo
is faster.

How about insmod "/lib/modules/$(uname
-r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt."* (no echo, no ls,
asterisk outside double quotes)?

Thanks,

Bart.

