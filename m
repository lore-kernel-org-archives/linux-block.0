Return-Path: <SRS0=GKfo=62=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C362FC54E8B
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 06:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5F70207DD
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 06:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgELG0L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 02:26:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40196 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgELG0L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 02:26:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id t16so4954798plo.7;
        Mon, 11 May 2020 23:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jH6jEu1pihJwdsncCxnvpckODz6I9Zd4teM1JAeqzH0=;
        b=hX0UgY4/59FSwpRDgH2V3aMsD439WVDt+/8URy68rOD4R42TUrsoSUxPERn0BH4gHn
         nqjo9RsV28W7AUixWKennc5B4bEuRKJqpIeY2fvcl2x4yp15uPfj+5km5vtIdqirEzAL
         4qmZsoIFlqAlqpvhV7fGccwf4Wc3Pd3KvrJ+TP5AKsZDqWubzafsua50QsJJ34DZ3Ejr
         oRMpQrmSrehQpl8PEGBrf0fE9tfxOxIDQ2MDFFwpdosIzRjoHs8Ogu6kxG1yp6oSa/jr
         NRNNKjqm6KgngJ7cPg+lrZF0Wkrh1iLd6C8ewcqrUCN7Vs4sK4ozX66RZd3vW/CBlkz5
         43Rg==
X-Gm-Message-State: AGi0PuYSeiW7FWYbdU5/Q+lALs/cQQ8mXCPa8FPBKnJlp2ck6AhyQuac
        DdBQdARAjrvZPXVXS56NDRYLmpOi
X-Google-Smtp-Source: APiQypIAMLDe1n/JcxEwd6ZbU5zIlwdNnv00GwINH1dY1lWr1ai4I/Ir/kpWkeT43FVxq4JJBxXWLw==
X-Received: by 2002:a17:90a:a584:: with SMTP id b4mr26253516pjq.106.1589264770108;
        Mon, 11 May 2020 23:26:10 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3949:7466:3de1:e65f? ([2601:647:4802:9070:3949:7466:3de1:e65f])
        by smtp.gmail.com with ESMTPSA id e196sm10805814pfh.43.2020.05.11.23.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 23:26:09 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/7] block: Extand commit_rqs() to do batch
 processing
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200427154645.GA1201@infradead.org>
 <e4d47000-f89c-a135-ae58-011f0e9cc39e@grimberg.me>
 <20200508214639.GA1389136@T590>
 <fe6bd8b9-6ed9-b225-f80c-314746133722@grimberg.me>
 <20200508232222.GA1391368@T590>
 <CADBw62ooysT7TJ5CjpPBC6zs7pvpUQysg8QqP9oW5jN7BSYS7g@mail.gmail.com>
 <20200509094306.GA1414369@T590>
 <6579459b-aa98-78f2-f805-a6cd46f37b6c@grimberg.me>
 <20200511012942.GA1418834@T590>
 <8f2ddabc-01d0-dae9-f958-1b26a6bdf58c@grimberg.me>
 <20200511114731.GA1525935@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9dc69d5a-b4f3-23a6-e033-377b4e133f97@grimberg.me>
Date:   Mon, 11 May 2020 23:26:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511114731.GA1525935@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> devices will benefit from the batching so maybe the flag needs to be
>> inverted? BLK_MQ_F_DONT_BATCHING_SUBMISSION?
> 
> Actually I'd rather to not add any flag, and we may use some algorithm
> (maybe EWMA or other intelligent stuff, or use hctx->dispatch_busy directly)
> to figure out one dynamic batching number which is used to dequeue requests
> from scheduler or sw queue.
> 
> Then just one single dispatch io code path is enough.

Sounds good to me, do you plan to submit a patchset?
