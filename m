Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA38C71156
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 15:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CBE206A5
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 15:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgLBP6O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 10:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgLBP6O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 10:58:14 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DE3C0617A6
        for <linux-block@vger.kernel.org>; Wed,  2 Dec 2020 07:57:34 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id n14so2376609iom.10
        for <linux-block@vger.kernel.org>; Wed, 02 Dec 2020 07:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EwUegCCtoiOqTe1WLKSG6GoeoAUOBpqMnMBopVd31OY=;
        b=UGvmlcyL3xZCL1YHN7IiOFmWmNcWCVYLeuhrb4G5XUMX7PxER6ke/+TeIIJReHdHto
         ppF0VQt7Hjf74qZQwhmQBcq6ngbvD9RqivH8w+vtrqQn1URXfu4nvq6TclF3lZftclNo
         Oybd1poZd4mpZspF1FW0v84RdbNfA38O9f29vqXHi+YplT+5eOciwrawljGN9O2ZZCfW
         tVx077PVhxumJmN8BKoWqByWpikUxJEH13XvbLdAQEZMwolvPtx1hlQTSeEOVQVh6/TT
         Wyq5Js7VRav2L7RlJ5cPjVyCqyvbSM3fzREG8Mbnro9B5uCknoe4eAP279UF7pS74GM3
         gRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EwUegCCtoiOqTe1WLKSG6GoeoAUOBpqMnMBopVd31OY=;
        b=omvDRoOFLK7ZhSNsBotFOlMMQs9TBWD6WONkXdMnY5GYlqb/23z5suyooWECHqzWo3
         GRpeaQhx6bgjKtPxduuAoSmwOw9tjhWs0Km4lxtNSoqnTe8GCbI1qQ+C59Ac4nIBS9kQ
         E9qlLJiK7Pq2mo72QJhtFOIebJiI0gw9z5polc+PG25JGlgAk2BG4JfjcIqPbOmdp/fP
         lgnD55DfHHCXageYxI25Qy+G0wMG6QqRPA6RlMo4kR46T4EhDMAlv5UtLgtUPXTi9q7o
         +C8pFJuJj+agVuh6kHNKwbM2F+JhAqgULrbEh+0hLhUxSZ9vECyI2p0eenq6ewYSxAX1
         3xbw==
X-Gm-Message-State: AOAM5333FuRNEHZ7w5XomYIRFoF3jrxlQk3tZ/tJ3+wA7sTqcyHHXt/d
        gHadRMU/UhqDZVmK7/xBYJFbJaMdJYGkvA==
X-Google-Smtp-Source: ABdhPJyDnO9kCE403mrZkpxn7VBVAx3kwrYK+p5fJ/mss9JvuJJbMnlKq5O9HoHvb/189cEv+JzP3A==
X-Received: by 2002:a05:6602:2c8f:: with SMTP id i15mr2547840iow.66.1606924653601;
        Wed, 02 Dec 2020 07:57:33 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b12sm1272034ilc.21.2020.12.02.07.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 07:57:33 -0800 (PST)
Subject: Re: [GIT PULL] first round of nvme updates for 5.11
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20201202132549.GA2060796@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4cbeda1b-dbb1-1743-7843-1cb04891f00d@kernel.dk>
Date:   Wed, 2 Dec 2020 08:57:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201202132549.GA2060796@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/2/20 6:25 AM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git tags/nvme-5.11-20201202

Pulled, thanks.

-- 
Jens Axboe

