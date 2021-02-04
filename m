Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A99C433DB
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 15:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1077364DE7
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 15:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbhBDP0W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 10:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237272AbhBDPZt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 10:25:49 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A65CC0613D6
        for <linux-block@vger.kernel.org>; Thu,  4 Feb 2021 07:25:07 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id q9so2937404ilo.1
        for <linux-block@vger.kernel.org>; Thu, 04 Feb 2021 07:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sai1+6RvSPig1mj2EiQ4vDagcziu7Bdngd2FkgBnOJQ=;
        b=OZbZVdo7cGClKymLkR0ySZFsAezEKOlcNuUn81XUGo0ZOyuJZ4K2KBmboTd+0P64NE
         sdVTkjI3A3rq+eVCEka+tZ9uYlRqhiY3WlrqJstrpbmbVLkNZ0/YfCvlUzO6LbaIKGdS
         7UHLwzkfc3A+GHvOgExu8INoO8SsIFMEBccjmcuqhiExLoYlSBeaGU3whyJRhvshzvd9
         3n00pxoKyqoZ4hWUY1q0EWo+TycsbSJ98w+1AcmL/l3zRG0/1OT7TZ7c60UwUQPolkrb
         2gOjUPF4VqWRekUPKcow/S2KaMM6OqW58Vt7//4vSqe562ZFSuHpHfLp1Ar5QdoKItyd
         MQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sai1+6RvSPig1mj2EiQ4vDagcziu7Bdngd2FkgBnOJQ=;
        b=dpgn/c1aZ5nx7QFNV/sFEZO4PvD9A/anq6xMm0IxNf7Tz3X3j6VxgHADOdWw0jaKUz
         PGfGrc5vHe5Nv5FfXa37zhxfdvJGyUGLQsVhHJu2KMUZnobG9BUlDWSHiXH0fy7XBHdj
         rptQoFY+XRqanpJqxSWtoUafpJhpGj8RURG/Vx5+C1+aYXLL22kSrweMR3LlX8dtodly
         CoOaHzfeRowxzGNMYBsGtr7pORuN8xm/yMVK5j+4JswOVJ4EOlh+SzFi/f72UYvzG4jO
         hYC04+0bIhinMwVcZuMDwRtP63CuQXj5JK2mHULL087IhUC7uhNfYKiQQY4ZSglx9QA0
         T/gA==
X-Gm-Message-State: AOAM533yUcc6QuaxWilnk5Glh/ghSaGh1E9muPlinGDsTtrSq1/tH2Qm
        x3rvJAhp0O7nBJYlPnI6BC2XdA==
X-Google-Smtp-Source: ABdhPJy5JJSK6zSOIARcwTjlz4jZA5OUcE/LTqoMFoK0Cyig2FdsLY5dwyPLh0PQY5PEAuH0QTtNHA==
X-Received: by 2002:a92:3f06:: with SMTP id m6mr7143541ila.283.1612452306896;
        Thu, 04 Feb 2021 07:25:06 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h23sm2607517ila.15.2021.02.04.07.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 07:25:06 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.11
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YBwNukLwQfsXQL9U@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e407087c-3760-b725-4b02-692eee28041b@kernel.dk>
Date:   Thu, 4 Feb 2021 08:25:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBwNukLwQfsXQL9U@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/4/21 8:07 AM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git nvme-5.11

You forgot the signed tag, but I pulled it.

-- 
Jens Axboe

