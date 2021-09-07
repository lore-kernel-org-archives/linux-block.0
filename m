Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EEFC433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3220E610FE
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhIGOiy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 10:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbhIGOiy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 10:38:54 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21FBC061575
        for <linux-block@vger.kernel.org>; Tue,  7 Sep 2021 07:37:47 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id u7so10287957ilk.7
        for <linux-block@vger.kernel.org>; Tue, 07 Sep 2021 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k7UIabWHD6NhE//8e0Wk3ieOxe6NDASRxwbZqmCHGys=;
        b=l9YV0fG70+xwUx5Lg/F8zIIYSomUp4yUqgA7tawlD0GR2rFagHPu4vFzf5EuUTqrRy
         E495IdM2X8eSprMng75VVogV4+BFFf/0C9/i6CYE1Z9ksXbIfBc7MGX+rFWlrZpdx9DQ
         0NQ63qtx1wSK47s64nvDPjR4AWU3oYGd4yBuPWhefGctgLvfb9UeMvwXZJWrPvk27cz2
         3RYOdRxwmPZNiGZ57N2nebAYLLxslFtWc3feW6se+QAx+VwoMqh1tWISfNvNeefgID2d
         DiudYcWp+QueQAiOd1n3Z0aG6S4NGSZ4BTNFZdK+Oi6wAHMNZAxdqyBDb8hi3WhaNq0H
         t8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k7UIabWHD6NhE//8e0Wk3ieOxe6NDASRxwbZqmCHGys=;
        b=Zf3f7SwRsf79dCnM8cjG9bYDOSvfrN67doCGtO923WuN4iyhcKNobXfO1g7q5cGBdG
         xlugfHh2iGitbTlp+CumIqBX9drt88lUt8SzCASOveJk9faIeKV5eQrHDNKMA8WN4YM1
         SumON+6gaRHa7TEWDIclkry1ix0o1WF692GQ2q7fw5L00KiSls57PH5jSK+TSNvdKeE9
         +JQ+6f8iKSEPn9U7Axdsa5+qZ/wsG1G9Js5kaIsavnz33g7jI0UR8QK7WMdt8fzUejOf
         iHbWxqtStjzaS22MHOLyjPCxtu7CxFoPxQTKyyS4Hl4YcWoFD2GTDt6Tbzl95gc2Ij4J
         TF8w==
X-Gm-Message-State: AOAM53388ZirqOOJ29NcgL8lHMf7biDvhL64+4b2Eo+3bsW8o73Wuhe9
        4yx01os+C8YAxqNY01xYWzMkng==
X-Google-Smtp-Source: ABdhPJz4LjPNz2+qX9UkOekJK+Wo+oqlhj8waX5ArBaUO802fVOIkwukcyCKxfkE/aGBDktZuR/XDw==
X-Received: by 2002:a05:6e02:1564:: with SMTP id k4mr12373217ilu.146.1631025467210;
        Tue, 07 Sep 2021 07:37:47 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x15sm6369990ilp.23.2021.09.07.07.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 07:37:46 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.15
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YTdyu/Y/d9woHINJ@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <406a8f15-16ff-e2e2-d17c-a804f8710cba@kernel.dk>
Date:   Tue, 7 Sep 2021 08:37:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YTdyu/Y/d9woHINJ@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/7/21 8:10 AM, Christoph Hellwig wrote:
> The following changes since commit 1c500ad706383f1a6609e63d0b5d1723fd84dab9:
> 
>   loop: reduce the loop_ctl_mutex scope (2021-09-03 22:14:40 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.15-2021-09-07

Pulled, thanks.

-- 
Jens Axboe

