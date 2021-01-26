Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A694CC4321A
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E55020674
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbhAZV74 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 16:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405398AbhAZUKo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 15:10:44 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CFFC061756
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 12:09:54 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id i63so11088510pfg.7
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 12:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qk2PO2MbANVrlX0xIKJKJxVfvdQIlWTTAdM2rav13JQ=;
        b=H03trmFdyNKzaHuFjSAa35vmyTMyF4QGyU1UDRwd2iuf672hXxobPYgIyQkXdajLnj
         XFpC6gWW36KSr8L6lFhk+AGJDQLYx9a+/liKgW5E5OBTobFBMqz2v9GYYw99ugNDKkIQ
         gQbX5coTg+LA0zbztV4abk0uti+iZ6N+3OqlUEDlmHi9+rNH6cLmRe0wZMWQl6VaEki7
         8xwqJzCQ1+TxDDLVkYk7z6tRAfrgJq52FUKylX8KpUtmDNa99GtuT5BL80Ie+VeihWlu
         LvjjRgL/sp4FQ/rfmYp+Zz+LtzaHab2j+25FpfwPOSg6rgLHFscw1wDp385eI0m2Hmpt
         7OPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qk2PO2MbANVrlX0xIKJKJxVfvdQIlWTTAdM2rav13JQ=;
        b=DHKTL6kOUz5dPbeW/Pp2HKBBNYpBwH2bkOhJpq8zKxMDhcXT/JaLC2+9OWHVXD+sej
         X8Oke4pRh0xlqW5xLbkC0cmKIjVeqWjGQnZNSHiczN6OphMHOFyNAZwGrVd6adg6eogU
         ncT3QBHek/xQ15OA9vgUQy1H5zaaVdEjQIe7/nWCQcRlbA29GsKmzLj1N+o0i1Y3Rrbw
         0f3Wl3xFhdUJg6GR8bv4KJpfx7Ex2rj9jSCc6vNAOBfPjrPzj31RVYztmvlcwAxLKeTr
         vAXd/s7M/KkoLklK6sjjP0KDOKxrH4iI8wAHH54eOcMaHtTMHUPQob2LFBTkriQPFDuB
         0rDA==
X-Gm-Message-State: AOAM530haHYRi9Gxj25OHFjLQf+bZnnRt1Uv7dRHJfDzfTwKcadtQCus
        52uE1WoYz/Ij9WWOZj1wbepQpw==
X-Google-Smtp-Source: ABdhPJwsILUYV8pBdbVxOqAkqLtRApBpCCdVZ5Miq3C6AblXsTg9tgeHSz2NCNQJyW5N/yPD9InTDQ==
X-Received: by 2002:a63:a10a:: with SMTP id b10mr7064693pgf.121.1611691794020;
        Tue, 26 Jan 2021 12:09:54 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id gl6sm2995411pjb.3.2021.01.26.12.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 12:09:53 -0800 (PST)
Subject: Re: [PATCH 0/2] mtip32xx: minor PCI cleanups
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20210126200433.2911982-1-helgaas@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <20ce0ad8-50e7-2f23-a66c-1c956494d790@kernel.dk>
Date:   Tue, 26 Jan 2021 13:09:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126200433.2911982-1-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/26/21 1:04 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Use PCI #defines and the special accessors for the PCIe capability.
> 
> Bjorn Helgaas (2):
>   mtip32xx: use PCI #defines instead of numbers
>   mtip32xx: prefer pcie_capability_read_word()
> 
>  drivers/block/mtip32xx/mtip32xx.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

Applied, thanks.

-- 
Jens Axboe

