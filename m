Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6577C433B4
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 12:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84686611AB
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 12:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241175AbhDPMKG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 08:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbhDPMKG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 08:10:06 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3C9C061574
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 05:09:41 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u15so5314088plf.10
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 05:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kalm4mobUMbEi2fiGq9fxLO7hrBXdcxOMDLAzJOaJgw=;
        b=GHzhAEh0ZJSuP3B9e6gxFZV9WFShFbszVgYKTb2p5OyrE2z3u0USPMEJuGOyvuUJsW
         adGYgCUh8e8PaLMwrDzfQfDhM9zsYRCOwlkLi4P8aXFvTHKhOo3pqkZV6wOfoXnv9wHI
         8oZsk63Z6eFCpEI+GEl7Ta83PBMOJ2HMr5m1dO9L5pyS+wmIXW1KqxvpdEwCo6wNLAvS
         t2YdiBKkMU3oHJqCtJFSiMyZTeq8UypLGJPadbM1Uek8kHShAotw21QIX0nxmDoNHWk0
         YCbFwSCXxfvGVrunaUWMEwEyaTVv6kG827MmgEINwXg8Grsi4y7v0NKsOgXJXAGo5oks
         N/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kalm4mobUMbEi2fiGq9fxLO7hrBXdcxOMDLAzJOaJgw=;
        b=CrJ2x7xtFmq9yBYle1A+NN3X0yoiP4sorSv9EFpsbwYAhQzF5MkUqaTeRoZIP4tgHE
         IpmjbqlL57eEUY6RvBJxqibRIJWmgILUWup/Axx9pyC1Ip6vhEs5KT5IncKVD1njbYHD
         Ja9QyoL2eN/BhuyhT9DBiclwIM3meOEpTmwpsxnxCfEdDGS0OH7Myc4Vy7EIYjUVN0vT
         kBMKt/2j5aUR96lgTWAjrZY4YXeU2h1dTX8DapKpGVkERPW6c5HZS8pS8cikcLFm2/jU
         9VdHjyFC17WbwYzZSAwFV8nm5lVYdUp4PTjryNpqax1acwNpwSRGwLdfV6NHbiHbgk3t
         hdUQ==
X-Gm-Message-State: AOAM533KkInZ5Hr9hv4Mfwfkqqdlcswoy7FyUYloLSv63JI8qWd4ASSN
        iObIJvtctDowNifVDyjc7UuVO955yYJpBw==
X-Google-Smtp-Source: ABdhPJylUhsIG3VFFpchvfgdpDQMlyoUHJCWyGL+z9R6gHxRFrqDkPaGSumQwmrQN6wr70fY1y/JRg==
X-Received: by 2002:a17:902:edc4:b029:eb:159f:32b7 with SMTP id q4-20020a170902edc4b02900eb159f32b7mr9277104plk.11.1618574980806;
        Fri, 16 Apr 2021 05:09:40 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id i17sm4726472pfd.84.2021.04.16.05.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 05:09:40 -0700 (PDT)
Subject: Re: [RFC PATCH 2/2] bfq/mq-deadline: remove redundant check for
 passthrough request
To:     Lin Feng <linf@wangsu.com>, paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210415034326.214227-1-linf@wangsu.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2ac2fd8d-08df-9412-c551-35f34bf7333b@kernel.dk>
Date:   Fri, 16 Apr 2021 06:09:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210415034326.214227-1-linf@wangsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/14/21 9:43 PM, Lin Feng wrote:
> Since commit 01e99aeca39796003 'blk-mq: insert passthrough request into
> hctx->dispatch directly', passthrough request should not appear in
> IO-scheduler any more, so blk_rq_is_passthrough checking in addon IO
> schedulers is redundant.
> 
> (Notes: this patch passes generic IO load test with hdds under SAS
> controller and hdds under AHCI controller but obviously not covers all.
> Not sure if passthrough request can still escape into IO scheduler from
> blk_mq_sched_insert_requests, which is used by blk_mq_flush_plug_list and
> has lots of indirect callers.)

Applied, with the bfq bits hand edited to apply for 5.13.

-- 
Jens Axboe

