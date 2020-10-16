Return-Path: <SRS0=I4RS=DX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603CDC433DF
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 15:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0AFE20866
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 15:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Q44QOqng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395514AbgJPP3M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Oct 2020 11:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405209AbgJPP3M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Oct 2020 11:29:12 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA72CC061755
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2020 08:29:11 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id hk7so1715630pjb.2
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2020 08:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ATPJ8G5Rmg2jkq9+2I73bf4/KgUptQXil2wgPNMHeQk=;
        b=Q44QOqngKKJ/Zmzmj6EmNbdx8ZS2w3pCGWlQWQVYcPlSztZkmr/0S1llaVBI1hiDJB
         1d6/uTZOJ4LAmH5oKWTI/3bgjb3zMQAzvIk0xgLmrnpD+BjG8muHCv4tZIhJtnq6Wpx2
         hEzspvd1UFlDMse7XufdYo7lR3ph/OdbAEgupMV7hT4MtQWne11+S1qKp2XHW7MIoCkX
         ceQohpfd6pXkCn3eWKVA4gYr0KiYkyQCyrCvJ1fTNbr54ubMlx6gsjKJHGoL6IwP8Dgx
         bO2HY/c1FCDbBNNbTW1owULlU5Ys6+1FkAmDX1KgOrB6quRjz8QL7CrHE4l8e4iJEQv7
         sUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ATPJ8G5Rmg2jkq9+2I73bf4/KgUptQXil2wgPNMHeQk=;
        b=ZH5/+v/gY704e9IbxC+Lbe/Hs6VwIAyY7TYxd+zrsLR1nVvFGrmP2TJdTHrLJl7ojv
         fFMlE1U88fGifcTp6EMumWr6QI5nrWmmCze54ab8TqTCP5h14Nk0YeN7NoNuw/Azj78T
         AX2jIHdTKxpcmaHnbVIV41bREtxwvMH3RAqvu0KqfoRevpN6vIm1tC1ryIfRw/O3BM7l
         vZMiRRPvTH9FeFRPl8tQ9KvcnMiWIHcPE/wpWGf5lImurVtttAzgKfqd0NLhMQDUb82n
         WtOh5/yDQH1JbtN2cxOIa+db3x8Uo3Nv4JiBCAFd64u8KCOJXpx57VJ1jVEsvfl7/26p
         CnAg==
X-Gm-Message-State: AOAM5306p+XXdxwfIaeOA4o3ImYp3osx5IukFe9xssBmz2Z8Qu0t2sZt
        5Pzw2vS+ZmElLEckG5XcTl7z0BClqGPGdbal
X-Google-Smtp-Source: ABdhPJyCjZq9ngO0zedh/4UnOXi8mIRRpTCWkpmy4XRTD6RWyWtogUjES0IBbmEJUp22Yke7kN59dg==
X-Received: by 2002:a17:902:c408:b029:d4:c99a:19e8 with SMTP id k8-20020a170902c408b02900d4c99a19e8mr4674795plk.8.1602862151187;
        Fri, 16 Oct 2020 08:29:11 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q5sm3210581pfb.184.2020.10.16.08.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 08:29:10 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: fix out-of-bounds write to array
 devices->info[]
To:     Colin King <colin.king@canonical.com>,
        Matias Bjorling <mb@lightnvm.io>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201016143351.677352-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <36ff7b17-eb2f-780d-17ca-269a8f5d4aac@kernel.dk>
Date:   Fri, 16 Oct 2020 09:29:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016143351.677352-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/16/20 8:33 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is an off-by-one array check that can lead to a out-of-bounds
> write to devices->info[i].  Fix this by checking by using >= rather
> than > for the size check. Also replace hard-coded array size limit
> with ARRAY_SIZE on the array.

Applied, thanks.

-- 
Jens Axboe

