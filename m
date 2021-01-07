Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8FCC433E0
	for <linux-block@archiver.kernel.org>; Thu,  7 Jan 2021 17:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84010223E8
	for <linux-block@archiver.kernel.org>; Thu,  7 Jan 2021 17:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbhAGR7S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jan 2021 12:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbhAGR7R (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jan 2021 12:59:17 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D010C0612F4
        for <linux-block@vger.kernel.org>; Thu,  7 Jan 2021 09:58:37 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id v3so7583473ilo.5
        for <linux-block@vger.kernel.org>; Thu, 07 Jan 2021 09:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N1N/QLfCCD3Bn9W2m3Jf1n02WKhSUD0yqjgNAwgQY7s=;
        b=jzXdY1G/cEfuAPU/49xn6ofeNiSVDZCqEDfs9fOQe08yu2Huq+Dr9hrbOGL1J2dNvV
         a24TIfmhQsaHr9QWIYxYx1cOy3/9N9xqBYjyMS2SW2NZl62zpiYWKTAYDhzPj1NOFauI
         9A/gAAczFDsDsTYL6p88oeLMKSl7RiJc28QJCzVl8hsqR5xH8VuQM9hUWNyKeFx+uN1g
         K3/zeu11bRU3raUanfhfIL+5+cFFbh2i+hHByD9J/Q+uGK6ZM86WmYRASd9o1YRKGPes
         XSwW2JnpLuen2qDP4LwaiLYW/9i46knR9GB63KP4JFswQDTZhdOK8vRuRoM2l7l/jTZl
         O/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N1N/QLfCCD3Bn9W2m3Jf1n02WKhSUD0yqjgNAwgQY7s=;
        b=JxPJ8/WGnhkQhxlJgcnnnKqSnSeXxj2YbN20npqaN2tS3t3D3zHm5CBojXUWSnpzY7
         IHuwvKAiScdQmwV34S3yY8Lrp3fmK6WaNwqInBgFBWU/eDYbzcpyhatQuoBwxh/F73Tg
         8+EFqlFNm7b1DRlYlfsRsQ+7RMOJ1OX5A+ZxfFiIN4o5UiaHk3H0tEmHQWK3ghcOpVpK
         r5EbRFUQi9EL3grPnK/dkpIFIqJLmTudoKOB8nS3dqTfhpiTSYzv3BiVJYfKdDsdKyS4
         Jx8QRNRC2xG37dUkYZTRutmJfjr7abivSUQigbSuhGHhaaGs7u/8Gcyfdxb6vGywMSxn
         LoNg==
X-Gm-Message-State: AOAM5318dyJ4oM/QL8+bMgcDQzyrnaCqk7HFBBvqWkAacMAiI4keh9j0
        KG7HfUEwUwA2mC6Pv6dYdSLw0em2zx4otA==
X-Google-Smtp-Source: ABdhPJwkeq1edAJA9whnBK07Zc5rgw4LJXEHN9V5vq9RD7UgY+bVU7q/Uh5bIoGgKLH/HZCcPD5S1w==
X-Received: by 2002:a05:6e02:ca5:: with SMTP id 5mr17798ilg.183.1610042316570;
        Thu, 07 Jan 2021 09:58:36 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b6sm4912689ilv.79.2021.01.07.09.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 09:58:36 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.11
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <X/dIG7478C6ahGvo@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b91e3bd1-0f99-0aee-3e5a-1a8cd466f367@kernel.dk>
Date:   Thu, 7 Jan 2021 10:58:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X/dIG7478C6ahGvo@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/7/21 10:42 AM, Christoph Hellwig wrote:
>   git://git.infradead.org/nvme.git tags/nvme-5.11-2021-01-07

Pulled, thanks.

-- 
Jens Axboe

