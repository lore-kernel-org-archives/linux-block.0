Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC13FC433B4
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 02:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 947A161945
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 02:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhELCwJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 May 2021 22:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELCwJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 May 2021 22:52:09 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCADC061574
        for <linux-block@vger.kernel.org>; Tue, 11 May 2021 19:51:01 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id md17so12741026pjb.0
        for <linux-block@vger.kernel.org>; Tue, 11 May 2021 19:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wH9LtqZdrV82uryQNvQG57KCdHT182AjVpniYypTn5s=;
        b=ekZ2yF344cjQ1w+P7pdP5YE3qyPqszU1gfMoVhIghgGvBlVDotZUUdZKBm8p4LzN4K
         DQlYqB1DgsZqKX63DfWUjYaLmQQJOpKX8nTveCQaT23trBzrWevAXubvtKACRfXjPssx
         nPXp7rHUuGWKOBP86wHyAX7aMvHeyOu40NzEyQ2J5ctHygJK7Q/iXox3481w8aGd+fgi
         z4gw9VRikxgwoorJ2KscX857v09yyo/MUK+CC55zXB411rsMRtWI7Vs/xsK39UJRDB65
         kUGzyTt1Wp1mzE9S49sKC8irtXNB7PB5s/pDnvU7GevOkmx3bilmWkWsQa65/FcC0/qp
         yxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wH9LtqZdrV82uryQNvQG57KCdHT182AjVpniYypTn5s=;
        b=qTQ2exS1ZrOwKmV2jUA9Ge4KfKZzHUgNa3ESgTB+mfZsVJEnUeu0mX2cCRcVwsL+sn
         WaGl6Xis6D4ZSApYieYXHe8lOhMLDPmZNVW2PFYhJviG74Tg0z7vqWcQzrLLEp/XV5PC
         UogLPIP44PssJupVK5vTWauxyYCdWj0a+4Fk41dtgtsu1IRg3CdJF9x/F5d29RYF3/tM
         rmR7JBsirnCWQ0KZc5h2VWAwKvXzvzHwjwswASZ1TWqm+4D7xcGf9FTMrV+Reuf71wKh
         ragB2h6hjLvT+VYxeQlJHHCakmOKSV5YsCcDWHCLf3+7wfbpbi2dd49SOMmYzLKG73UL
         n48g==
X-Gm-Message-State: AOAM531NeKXHk/CZWlxcmbNGPxSv5VAOWzClS7zYIIPFW3j4H45E93WV
        IqOHLjfp8lW19SuBB6xuESGTMGnAX4HfvQ==
X-Google-Smtp-Source: ABdhPJyP52LdDjeTsjTDukmte0R2YcSNgj9ruhutJuuQT8j1AnFpiNXCNS+3tjtc2adP7M4NBPhhrw==
X-Received: by 2002:a17:90a:c203:: with SMTP id e3mr36267424pjt.168.1620787860361;
        Tue, 11 May 2021 19:51:00 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id t15sm1968672pja.51.2021.05.11.19.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 19:50:59 -0700 (PDT)
Subject: Re: [PATCH block-5.13] blk-iocost: fix weight updates of inner active
 iocgs
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@fb.com, Dan Schatzberg <dschatzberg@fb.com>
References: <YJsxnLZV1MnBcqjj@slm.duckdns.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <204404df-1ef8-d31b-8d4b-21f77810b774@kernel.dk>
Date:   Tue, 11 May 2021 20:50:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YJsxnLZV1MnBcqjj@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/11/21 7:38 PM, Tejun Heo wrote:
> When the weight of an active iocg is updated, weight_updated() is called
> which in turn calls __propagate_weights() to update the active and inuse
> weights so that the effective hierarchical weights are update accordingly.
> 
> The current implementation is incorrect for inner active nodes. For an
> active leaf iocg, inuse can be any value between 1 and active and the
> difference represents how much the iocg is donating. When weight is updated,
> as long as inuse is clamped between 1 and the new weight, we're alright and
> this is what __propagate_weights() currently implements.
> 
> However, that's not how an active inner node's inuse is set. An inner node's
> inuse is solely determined by the ratio between the sums of inuse's and
> active's of its children - ie. they're results of propagating the leaves'
> active and inuse weights upwards. __propagate_weights() incorrectly applies
> the same clamping as for a leaf when an active inner node's weight is
> updated. Consider a hierarchy which looks like the following with saturating
> workloads in AA and BB.
> 
>      R
>    /   \
>   A     B
>   |     |
>  AA     BB
> 
> 1. For both A and B, active=100, inuse=100, hwa=0.5, hwi=0.5.
> 
> 2. echo 200 > A/io.weight
> 
> 3. __propagate_weights() update A's active to 200 and leave inuse at 100 as
>    it's already between 1 and the new active, making A:active=200,
>    A:inuse=100. As R's active_sum is updated along with A's active,
>    A:hwa=2/3, B:hwa=1/3. However, because the inuses didn't change, the
>    hwi's remain unchanged at 0.5.
> 
> 4. The weight of A is now twice that of B but AA and BB still have the same
>    hwi of 0.5 and thus are doing the same amount of IOs.
> 
> Fix it by making __propgate_weights() always calculate the inuse of an
> active inner iocg based on the ratio of child_inuse_sum to child_active_sum.

Applied, thanks.

-- 
Jens Axboe

