Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1EFC48BDF
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 21:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 903266128B
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 21:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhFOV6W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 17:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFOV6V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 17:58:21 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AA0C061574
        for <linux-block@vger.kernel.org>; Tue, 15 Jun 2021 14:56:16 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so442530otl.3
        for <linux-block@vger.kernel.org>; Tue, 15 Jun 2021 14:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NgykULCsEHnRGwNP/gRtK7BIZI5S+WXDFqlPC5ARpDQ=;
        b=tJP6LcxcuT++Q8IO0EWH0xfLoDIXKWwz26HyTvJg2MRNEXPa4vq/cDxPz5ALVzoJWG
         1ZWk1mhNqB6UkGl17eWtmyJF/COGeOzgzHYDdHU5ukFiIUeS20/mOBUb7BSw+/Sg2arZ
         WV4QuKM9HifLjxckCTdw+AydC3PYYkx0yiXDKE7o7G6akg7Mq2pq2pyGJ3KzHl2GmYnQ
         BUEsWRdTqGIhbctyq78jTr7+uYTj9xYCr60ByOcYP6u+TS08HtWtV9bmh1IiGUHgTXJO
         ql6QJsXc7U+nAsH2nDRRsvWMYesELQ24F2qATLgBpDxkTO1lwjOTuXyPlrArTDdB9T0C
         kcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NgykULCsEHnRGwNP/gRtK7BIZI5S+WXDFqlPC5ARpDQ=;
        b=NcDI4gTf1z+mt30OZZ8MfwRJHERZErCiUdE5l+g7blynQOxmGwEsWil4UpZ+gUlv7C
         qf0sONvq8dLjpZNYdBvnw+90zKGTDXzDXga2VLL4gy+espg6+rv3PgUoGHYk8qjAZZWW
         kQbwwr02fw25feJb1EK1CjaN7k76dQp9KziJS5ScGuwzmpuHj6ICzUYKwpFP3s5fI2xA
         3quthwEVava4O0EGlgbbsHGTo+fgHkaFgB8F3UCpVGQOC7RZxVdjgZu2RfPAq3WiYCCs
         pKa+TIN0eJNhQdOXclmQRdQVjHZpU7cI7feiIvtOyngzeO0gys9G4WYt76RKqE+a4c6U
         zfbg==
X-Gm-Message-State: AOAM530w9tpuUkrJvVhGqJzgboO4emOtNIG+WBwykyy6P9o7sb76x9A2
        FJncAvKQ+DBA0bIxfnsM8IefvYMHeN219g==
X-Google-Smtp-Source: ABdhPJyemOmoqigGzDnfShs0cXlsuSo5j0Gz1Ee5jqmaQ8PPi5Hwswct8yQjjUVbAsGQ2EslbkUmBA==
X-Received: by 2002:a9d:6f93:: with SMTP id h19mr1108187otq.292.1623794176172;
        Tue, 15 Jun 2021 14:56:16 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id 3sm49157oob.1.2021.06.15.14.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 14:56:15 -0700 (PDT)
Subject: Re: mtip32xx cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210614060343.3965416-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0a252d66-fe4d-23b1-0e75-ab5178ed2ae0@kernel.dk>
Date:   Tue, 15 Jun 2021 15:56:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210614060343.3965416-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/21 12:03 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series cleans up the sysfs setup in the mtip32xx driver and then
> converts it to use the new blk_mq_alloc_disk and blk_cleanup_disk helpers
> added in the for-5.14/block tree.

Applied, thanks.

-- 
Jens Axboe

