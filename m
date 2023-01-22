Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B5DC54E94
	for <linux-block@archiver.kernel.org>; Sun, 22 Jan 2023 18:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjAVSYi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Jan 2023 13:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjAVSYg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Jan 2023 13:24:36 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453001EFFD
        for <linux-block@vger.kernel.org>; Sun, 22 Jan 2023 10:24:35 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b10so9837856pjo.1
        for <linux-block@vger.kernel.org>; Sun, 22 Jan 2023 10:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VYXT3cuwVqmhiU45SJkfbTJzA/k0OOoLR/Bulg+ymTg=;
        b=08GM/9QMyo0qGt5bdF5PtrKwclt3tL46D4ehwPduwqD5c7knUnuEsXaFM5wQP95kL/
         9GVOEI0R1jJWz1mxlhB6hxZPiDcXH895wniHo3crtloAsdYWTln2aFhIw0JIOIipSvQg
         WEOMxpWIN06OhzCHtYnbG/neRUEmPfZfu2MqvohI5SEMhJtYcjeg3+/0rkEYB5TXctdJ
         VRcBJmOTguYDVsUEgdFNhOHyBR2fYD42hDY+HvytP8MJt2A3VzirXclNaKaJBIXcnAdf
         p2TPK5H/vSs15KHr7Jd44EbvO5JWeWrkohgNwUUP424iy2cJCZ1Ce3dF0taAidUDLfrk
         2ZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYXT3cuwVqmhiU45SJkfbTJzA/k0OOoLR/Bulg+ymTg=;
        b=xeASerOUQanWsEOicgblgzoizmRSOXnKe0GukFPcWIPR2rCN5SM15Q5o8HSi+IfEIB
         0LLZNMSPgFAwiXbw9ZITJtjN7ifLvUiE1j1XwOqmEWBxa7yxZLQ8ECIRvRKwJ2LTKybR
         8OviYyEReuGu4+R0vHw34IPHttxcXbTTMj1PxypJr9FeKkZlluNKPqqULjVd39VIqh3E
         q4x4zaXWqOWvalWQ/2i+8J3ttWtHKcIUk1W11UDV++LFC0J5+/X4IQzrOePk/uzQui7Z
         QyPi+t91oNXF7WtijhQqcN99hOVzELbR9dVzYsGg3pQAUXT48fYy5JeizVfBcwCNk0h3
         X/6A==
X-Gm-Message-State: AFqh2kpB2wJuhxGYhzPrkLg4KscUcxKrX0iB/MFr4wRP2M5H0liF5FPK
        wFSQeQg5G01tQT2jqEbIA4jL2g==
X-Google-Smtp-Source: AMrXdXsHmIu3Q6R1sojtlTfOWWDxNNymStZpT7hHkJBKCU5SL6ZidTJS1aT9OVKdT+WjDQ1h5xFZGQ==
X-Received: by 2002:a17:90a:a581:b0:229:f6a3:4a9 with SMTP id b1-20020a17090aa58100b00229f6a304a9mr2875134pjq.0.1674411874665;
        Sun, 22 Jan 2023 10:24:34 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090a6e0a00b0022bb223ffe9sm4694529pjk.36.2023.01.22.10.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 10:24:34 -0800 (PST)
Message-ID: <38af9155-b940-d4df-b6cd-7420d1183927@kernel.dk>
Date:   Sun, 22 Jan 2023 11:24:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] pata_parport: add driver (PARIDE replacement)
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Ondrej Zary <linux@zary.sk>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230121225314.32459-1-linux@zary.sk>
 <20230122075710.GA4046@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230122075710.GA4046@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/22/23 12:57 AM, Christoph Hellwig wrote:
> I suspect a comment in the Kconfig for the old PARIDE code to point
> to this and maybe even a runtime warning when using the old paride
> code would be great.
> 
> But except for that the code looks awesome, so let's get it merged ASAP:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Since Ondrej is probably one of the few (maybe the only) user of this
code, why don't we just kill off the paride code in a separate patch
right after?

-- 
Jens Axboe


