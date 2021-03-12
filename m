Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA234C433DB
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 14:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F5A64FD6
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 14:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhCLOVm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 09:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbhCLOVj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 09:21:39 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDFFC061574
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 06:21:39 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id g9so2721199ilc.3
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 06:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E61zkshFErZvXwXXuG6eHT/uAMrwiprKwUlm/Jt8qKA=;
        b=UFvsmMq8GC/8RpJgAwOoqBuWirjkiwtoO3aTyOSlf+jZEMSzQvpbygbWeJDs3Nq96F
         PGETCYGxDq4j+QKuZr3RU8S0bH20bpWKemt/cyXlSG3Nx7hMMdPBSQ0E/spC1ct6UVq5
         25NciDA2wxhJRplCMFcGM3eRNjQI9n+ZUudeVHLGxwBDxPmXlHYIYgHjH4Y5YveGtxF7
         lHniiQtsuWosvtrnpgtQZ9wUnuSqHsI5ZcZKTOII+0b3EYXYwjNbi4EsBzM58LicUXXi
         n6haLNgHmNvQKXdryAdcxW9KZossNXMSVjLP+AeXJNISVub2uGUjDdDqQ9raCqKbcdaa
         8ENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E61zkshFErZvXwXXuG6eHT/uAMrwiprKwUlm/Jt8qKA=;
        b=OK86NBYVgxP0itNwdgNdmnFeP1VZ4qAQ3adhIHel2cgBo4lTJkBJslCUV8NDNSoSTn
         eqs/DY0U7tInAqiucvdfGD1ax/MjYVO6fbE7aBdVGhtsDa46LTXoU4jXYAfgaaIVIjKP
         NqrM/Uu/aAW01BHdhjY7bJHuB8LEdLM2rE8nGISSaVnzOZsunnc4iQOxFc5BPAPnX/zW
         y0vlOqHClglxwz4qf510GECJ3CHL1dEKVRy9WBBwjaz6//u9iz818aeAbQasm0mvUpxC
         KOssS8hq8luY+eUUbHPDcVD9RU3m2ukCazAyOi1wC4wKGLaSStOVQGpMEWZkHdbrT6V4
         pWsg==
X-Gm-Message-State: AOAM531kKGGG+JHxhVFPvkVTpuODfC/r0ZwuAANK+xuSd6/2dW8VX8gI
        zgv0+Fdjg0W6MIPgEIdPVOd9iA==
X-Google-Smtp-Source: ABdhPJz3ST4OLgnhxfMSrAKuyp0V67FNBCcu3PSlX/U6NVi94ExgQoTRrdvtdqgdWgOzwVEOn9wI7A==
X-Received: by 2002:a05:6e02:ee1:: with SMTP id j1mr2834065ilk.179.1615558898838;
        Fri, 12 Mar 2021 06:21:38 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c9sm3098343ili.34.2021.03.12.06.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 06:21:38 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.12
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YEszeMEAQyfTPgHH@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2a34717a-b5c5-0a3c-02b0-eb8a144aba15@kernel.dk>
Date:   Fri, 12 Mar 2021 07:21:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YEszeMEAQyfTPgHH@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/12/21 2:25 AM, Christoph Hellwig wrote:
> The following changes since commit df66617bfe87487190a60783d26175b65d2502ce:
> 
>   block: rsxx: fix error return code of rsxx_pci_probe() (2021-03-10 08:25:37 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.12-2021-03-12

Pulled, thanks.

-- 
Jens Axboe

