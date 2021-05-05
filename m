Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DF7C433ED
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 14:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768DE61176
	for <linux-block@archiver.kernel.org>; Wed,  5 May 2021 14:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhEEOii (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 May 2021 10:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbhEEOii (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 May 2021 10:38:38 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37F6C061761
        for <linux-block@vger.kernel.org>; Wed,  5 May 2021 07:37:40 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id h7so1212850plt.1
        for <linux-block@vger.kernel.org>; Wed, 05 May 2021 07:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8GZL1Nhot4rChtp0bdAG2qidnsxonWOJYVyqDDAfWCI=;
        b=LmRJNcqbNIt02aXUGzGVJjqu67VWl3d2OMJcmUF2RVVgyeWBOBHrpStlkF9AmeWxus
         SykHCdKCMAVjZPZaREa/r/u99nBfhv6S7CcHUbpC3X/M3bgD3BFuNBnH73Fg3oj77iXW
         6DOgJ3uYOl0aOgPmU/HTBqRstRlTkb9yODkLvXfeT5Mh54kuK0bugItw7Vq//d9UYzxc
         On7q62BgZ+SV0epawDzbeda/ZtzgllXaciRR3PQSMFFU6gGXte7cV2Tr1hpnF+TDVpuH
         deI3WkDkiijH6isZbIO0W1XgXkcTtx5bjgB5+Gua7lJUQb+vt9L5S0Lakx9DVGMeGTgz
         sYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8GZL1Nhot4rChtp0bdAG2qidnsxonWOJYVyqDDAfWCI=;
        b=eV8oZBGjMPl50IQ40ABzq99yYNhXeWoafAZv0kWyL7YJDycHYi35g/yd0+HBMlzQRj
         sz8keaM7bzgXniZHO8lSVLlDkNF8T1pVvTu9n3RYtCvm/Us4tKViYiHwCBYY9yPGoDL0
         0rLuzBneCplDmBqi+Hp6UpevIEbYxL36JNOMDiI0UKLirleGvFZVhsvP0+5yqf0qjkm2
         Hq5lO3UR9aUQ/Vy3uPq/eHCEdurbtikmHqSLeRsJYTOCvPOEyl17v3IovZJq85CPI+SX
         67dE0+3lNTgoXxMb4i2tO1wU7qnso16VDuzlyxrCx2ZLAmxmRqe11yu69t72Dbvzqd7Q
         zq/g==
X-Gm-Message-State: AOAM531u2/KlEVqvGi0u68vTH7lZyn95x0Cg9c+B4doA/7z04Fay7/dW
        Ba+Qw5bJwUrXRgvvPIqxGbkvLSGQ29cgfQ==
X-Google-Smtp-Source: ABdhPJwNO3X8S6EzJWemGwOd0yldT99r9Edygtf5KgT6EEQFxlysERA3th37enrMzNdcXShp1520eg==
X-Received: by 2002:a17:90b:1e4e:: with SMTP id pi14mr11925670pjb.120.1620225460378;
        Wed, 05 May 2021 07:37:40 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s21sm7575378pjr.52.2021.05.05.07.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 07:37:39 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.13
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YJKsCBgfk5vjsUiQ@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2d751229-8efc-cd3f-cee1-a13c46e0a593@kernel.dk>
Date:   Wed, 5 May 2021 08:37:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YJKsCBgfk5vjsUiQ@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/5/21 8:30 AM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git tags/nvme-5.13-2021-05-05

Pulled, thanks.

-- 
Jens Axboe

