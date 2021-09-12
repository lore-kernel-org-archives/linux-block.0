Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A807BC433EF
	for <linux-block@archiver.kernel.org>; Sun, 12 Sep 2021 22:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBDF610A3
	for <linux-block@archiver.kernel.org>; Sun, 12 Sep 2021 22:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbhILWCa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Sep 2021 18:02:30 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:52137 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbhILWC3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Sep 2021 18:02:29 -0400
Received: by mail-pj1-f42.google.com with SMTP id dw14so4026213pjb.1
        for <linux-block@vger.kernel.org>; Sun, 12 Sep 2021 15:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NB6SVrz5GcwEVIZytRH9cwqCOJREXPxykm/HgWYd8UQ=;
        b=3694vmCf7hzOm9UmluxuGqsFsLlbu/ZIezAkGQXoBYu4X5JEhXCa69UHHJ6qTV8wG2
         8MQDefcSzYpAlEO9MkyjLcdn7bB5ThjnBkfY4OLVfuCdba9pDNJff2XdACyXls5qfT5R
         opOasyqw960EICAordAtmA4f/PWZWAiKKLoq65ZHmtdKRSjxjKWCSZXPRiFdCsLGgMUb
         cUEgy+vdp3/t7YJvcHvxVaOQoTL44qFDacAQMK6VrjTqCHI+ev6bwGHcpS/iGm2m+vmx
         UL71GHEn/gPbqHpDzFo06yx0G98LknSEvgpZ1ga2o+zO9uRtXVN9tA7cWHA63DTFDtnS
         OaFg==
X-Gm-Message-State: AOAM530DWpum2pCr9WDRxdADd0pm8/cR4ewi/2E/AskDKCR4EbEbwqaK
        +MLBhhHTmztauct5hlGu9kgsAOromTE=
X-Google-Smtp-Source: ABdhPJwYRUyJeMVdxLEpf2BdD1Xfv4DYHsi3cO/luSqizN7QsUT9oQj5JPXyjiI2O+Uwb5KfA6Wcjg==
X-Received: by 2002:a17:90b:1e4d:: with SMTP id pi13mr9415850pjb.9.1631484074807;
        Sun, 12 Sep 2021 15:01:14 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:559e:5ce1:19a:4ed6? ([2601:647:4000:d7:559e:5ce1:19a:4ed6])
        by smtp.gmail.com with UTF8SMTPSA id v4sm4900460pff.11.2021.09.12.15.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 15:01:14 -0700 (PDT)
Message-ID: <b81606eb-b2cb-eaf2-b64c-55390f9b5456@acm.org>
Date:   Sun, 12 Sep 2021 15:01:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] block: Optimize bio_init()
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210911214734.4692-1-bvanassche@acm.org>
 <c61afcb0-dcee-8c02-d216-58f263093951@kernel.dk>
 <c810ce05-0893-d8c8-f288-0e018b0a08ca@kernel.dk>
 <fe7f7cc7-2403-7ec6-7c1c-abb6ac6a68fa@kernel.dk>
 <c728eac8-3246-2a6d-84bd-a04fa62fbc04@acm.org>
 <200438e7-1a04-ae88-e79c-a4276b9dbb0f@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <200438e7-1a04-ae88-e79c-a4276b9dbb0f@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/12/21 06:03, Jens Axboe wrote:
> On 9/11/21 9:19 PM, Bart Van Assche wrote:
>> The performance numbers in the patch description come from a
>> Intel Xeon Gold 6154 CPU. I reran the test today on an old Intel
>> Core i7-4790 CPU and obtained the opposite result: higher IOPS
>> without this patch than with this patch although the assembler
>> code looks to be the same. It seems like how fast "rep stos"
>> runs depends on the CPU type?
> 
> It does appear so. Which is a bit frustrating...

Further measurements have shown that this behavior is specific to
gcc and also that clang always generates faster code for the version
of bio_init() in my patch. I have reported this as a bug to the gcc
project. See also https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102294.

Bart.


