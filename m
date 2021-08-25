Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466EDC4338F
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 12:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F8FC60F58
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 12:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238092AbhHYMrj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Aug 2021 08:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhHYMrj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 08:47:39 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7F7C061757
        for <linux-block@vger.kernel.org>; Wed, 25 Aug 2021 05:46:53 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id u7so23825235ilk.7
        for <linux-block@vger.kernel.org>; Wed, 25 Aug 2021 05:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wbIPsTQwtU2uH0M1NI1BLQZSQjKXmWivzlYahmAbCGI=;
        b=YaxGwI4ZvxtrL9SBCSvjhFhyJN4S9J/UFKAiLjUqVOQ/sW8ZRxR74A8YnHu6aFnzqT
         lyyh6QmN6p4gYB/oLRaqp17JiG/TizCLS/76mnjO2z6Ql8avhByl5P5EN/b2ZSwFMS1V
         BHgPTnFzKxThZsZgovDP+AxOV3TeM36E4YJyydzyq0KZGQdylVym7MkHv6DM9OtyPKsw
         EBeoqq229adnAHCSQtrJvxtDxETfcVX6l5X6SnKf6AUwChRW0M9B9Tuz30+2JNcN+NGs
         uhgnODT3EWAlMAoWw+4gZSbHb4AhTio1xEXRjqye5qTvX5Pwt/wHw9s8p4lpzinLj3kZ
         JlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wbIPsTQwtU2uH0M1NI1BLQZSQjKXmWivzlYahmAbCGI=;
        b=hBEq/0c4svWH6/9f0ti2pNvQqb29daGwKCvTfkoGy5olZLsHtQU5EUBaJvv4++XbCC
         wTc0gejQSJCptarHRqfwRUnWfN+LVdDdLENdNhv88C4CZVm7otarLVltHQKFeGUyHVGH
         d2ZCkoM+Pt2THomYCL4mm3kbKIlJ8Fm/I0iTW6lQPgtlrDZ1oM0HzYU8WcZDh4aPMWPm
         9HjJCbqyvzQZi0ZOBWa11AxM6tkm2GSFYEfxv67jA38F9r7krgVzEfNo+jA1TUllTbMk
         fUU9YpkAp1DhJOBiJRAvbOS1to2scgTxRuPu4hYppcJfqsLiXVvtsivArB/juopAqliS
         OKEg==
X-Gm-Message-State: AOAM531qBRPLGJhWW2cTzfjxyGR2VGom5nRv0tvBNOsbcnsyLTTUPPHU
        1+bjyxp+bnYXkEvy5K10hs/O8g==
X-Google-Smtp-Source: ABdhPJzaD+Q3oX05I8OGSNipGk67XX2fAPGub6cNX42i7SoBekLnv1xI3o1IEHqIU5Phtop09aDgDw==
X-Received: by 2002:a05:6e02:1d9c:: with SMTP id h28mr22890996ila.266.1629895613354;
        Wed, 25 Aug 2021 05:46:53 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id i14sm5833217iog.47.2021.08.25.05.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 05:46:52 -0700 (PDT)
Subject: Re: [PATCH] sg: pass the device name to blk_trace_setup
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org,
        syzbot+f74aa89114a236643919@syzkaller.appspotmail.com
References: <20210825075438.1883687-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <551ed725-2eeb-c67a-e9f3-3b8293b79c1f@kernel.dk>
Date:   Wed, 25 Aug 2021 06:46:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210825075438.1883687-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/25/21 1:54 AM, Christoph Hellwig wrote:
> Fix a regression that passd a NULL device name to blk_trace_setup
> accidentally.

Applied, thanks.

-- 
Jens Axboe

