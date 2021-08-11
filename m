Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D07C4338F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 19:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA6C261058
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 19:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhHKTsq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 15:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhHKTsp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 15:48:45 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3EDC061765
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 12:48:21 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so11446713pjs.0
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 12:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dQv2M4JkmrbMym4n5tMzV5mKtrOtzsiL6FmRrS6DLLE=;
        b=UOFafFCQp1/XqrRCTLqKJX6Vf7qd4Pu0y3NH9d1J1o7OtdcvCn7cO26pP2jUmxne3l
         QB9SKp+y0Tti2P/E0neBAIx0Hf1biygE0afwTibMyogl/T4iztJR7zr3OTeY4+c08/d2
         qRmyr9PJWDlMZmS8uOxp+c+KQ3serK+oGZyo+/0GOBhgDWh7y2E2S2085NuI0KCe1stv
         zL3b0tMSClUaBC876TTXwaA6W60gKGAcjQ+fwBnsU2z/rSEvECdxUHn7LH/aKphLYET3
         4pmvlQJUYxa+BXKj3faDnRrO7yFB7DnyUmUvYDAjojRVhiA6AanHipJf+wSRIHoEo35n
         nS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dQv2M4JkmrbMym4n5tMzV5mKtrOtzsiL6FmRrS6DLLE=;
        b=H/SHBSIevy+lkFwzsRfx6Zy0IajwyStoCBHx61jzD3/FFrQR0wmeJgCbS0HLM1nNRv
         WmEsr8XH4Q6ior9pfPq9y6QIZx/1h0lDRDKxXFRrNouN0QdJeSelMlnpxCjmfeTU45VN
         R7QsJ/lnFg4ORk2aZVRbdCoUP5eJr0kWTD2AVAI2EimC9q69TadwHC/e/pzryaNoO4rI
         WTrH2ooXW1hlifm54066u497oN0azm2mXp0ci1K0IcEwwBPv+94cKS/MdkFTUCy3gbIr
         BqoZzOC5yrh3APM8+k3sVk8ZXb2shDAQHasv+3xPtzZvlAP5OY+8hgkS/7HRnaChwoK8
         uzxg==
X-Gm-Message-State: AOAM531y14mA2m4rtJe2UWi3o9HHxmxwHpYHGX2EqlflEo6o7J8L+gDN
        Kb823F/EWtgQZbjWynFR3Gm5vw==
X-Google-Smtp-Source: ABdhPJwgwWs3ghDAShWReTmQtgNEOAyAvYDJhT3YXu4DEuMAsRYktQFUVk8N4FmAMYd9qjFVhk7tLw==
X-Received: by 2002:a63:134e:: with SMTP id 14mr348402pgt.312.1628711300904;
        Wed, 11 Aug 2021 12:48:20 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id 143sm388369pfz.13.2021.08.11.12.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 12:48:20 -0700 (PDT)
Subject: Re: [PATCH block-5.14] Revert "block/mq-deadline: Add cgroup support"
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <YRQL2dlLsQ6mGNtz@slm.duckdns.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9683ccee-776f-70d6-39a5-2f9b7552b189@kernel.dk>
Date:   Wed, 11 Aug 2021 13:48:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YRQL2dlLsQ6mGNtz@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/11/21 11:41 AM, Tejun Heo wrote:
> From e150c6478e453fe27b5cf83ed5d03b7582b6d35e Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Wed, 11 Aug 2021 07:29:20 -1000
> 
> This reverts commit 08a9ad8bf607 ("block/mq-deadline: Add cgroup support")
> and a follow-up commit c06bc5a3fb42 ("block/mq-deadline: Remove a
> WARN_ON_ONCE() call"). The added cgroup support has the following issues:
> 
> * It breaks cgroup interface file format rule by adding custom elements to a
>   nested key-value file.
> 
> * It registers mq-deadline as a cgroup-aware policy even though all it's
>   doing is collecting per-cgroup stats. Even if we need these stats, this
>   isn't the right way to add them.
> 
> * It hasn't been reviewed from cgroup side.

I missed that the cgroup side hadn't seen or signed off on this one. I
have applied this revert for 5.14.

-- 
Jens Axboe

