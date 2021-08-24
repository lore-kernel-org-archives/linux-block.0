Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16542C4338F
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 12:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2C0961357
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 12:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbhHXMoS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 08:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237346AbhHXMoM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 08:44:12 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95502C061757
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 05:43:28 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e186so26095594iof.12
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 05:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CjtF/7jgbCr39An+/EWysxDVyq5Y2TOuawijHko2OOM=;
        b=LnuqLD9PuoWf3ZyHXhQrKS4qdNm1EZMZeXSEgQA5h9D56IVvh0M+CbI6z3VrzVeWg9
         d0YW5eJtkeJETjDD5nXCwC9hGtdP/KNFQdFDXbpzXeBs6v7GHNt/6rLBwZFgnL0IpG+z
         v1WqGguwE7QzZ5INpa/aE95qqyMpFPL1c7iSJ/m8FvrcbLeC/c2G3R4NbxkotXt9p76m
         3mGEItfDVJpBruC70KIVkkF1Q93guLirgZWsCtT0dBqLUPoSYLCO0+13GbV1yRUDHfe6
         RcYqva/tIGu7WYDulg6RCTiNz9I75McbpdiQgBshiWnMcIq7CQbefwhICl0HkgPmccjW
         DGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CjtF/7jgbCr39An+/EWysxDVyq5Y2TOuawijHko2OOM=;
        b=WTwFEDJi8inNdhMlqe9Gp6RvuCTl4XFnbbV3K8hJR+dBjEZKetfWCdaIGjdccal/c9
         8IvfBejP/kSjwSDF5ypZ3U+4Z4u8iOWsbWR3znn79/vDraox+CtHNuh4hddpcBwvpIok
         38vU1ZsP/nlPQFawtBmrnsP+BhJU8cC9HOvcoX5hiX506DBXtAi++lB92jt89n1r41oc
         2A+/k1IgHJtxAAJAB3/qiU/HiquCTgAgysrZDTGXFNY5ONjciELlMdmhV8RzrmSVxRRT
         Hzn1Gp8sEjqegL0uSpvJV8pqmT/Z6jbcDuqV/lFNaigeV9aepv9Rmjpx8OZvaYr/rPb5
         cWDQ==
X-Gm-Message-State: AOAM533tu98hx0qQq+iktSp8q6VruVA7EDfURj0Ei7UEenkfv/iJtbce
        CJNNwdWwZNdOrgypWMQqm5tiSAtZxtJN5w==
X-Google-Smtp-Source: ABdhPJyWIEQ/c5koPMxhByJk64AGSagLU2zIh9m9bxfy9h4PuK/TF3ri2vrWh8Le3biR6UaVSE2aMA==
X-Received: by 2002:a5d:9304:: with SMTP id l4mr31526721ion.167.1629809007829;
        Tue, 24 Aug 2021 05:43:27 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id n22sm9912749ioh.50.2021.08.24.05.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 05:43:27 -0700 (PDT)
Subject: Re: extended dev_t tidyups
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210824075216.1179406-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d683d7a1-e7d9-10ed-38ce-ae24259893f1@kernel.dk>
Date:   Tue, 24 Aug 2021 06:43:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210824075216.1179406-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/24/21 1:52 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> two small tidyups for the extended dev_t code.  One removes
> a not necessary maksing of a variable that already contains
> the minor number, and the other removes some long obsolete
> debugging code.

Applied - did 1/2 manually, doesn't seem to sit after the
add_disk() error handling changes.

-- 
Jens Axboe

