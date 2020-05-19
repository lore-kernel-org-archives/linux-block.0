Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40231C433DF
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 15:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D6B520809
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 15:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ySydS5S7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgESPnC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 11:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgESPnC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 11:43:02 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C0AC08C5C0
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 08:43:01 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x13so63415pfn.11
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 08:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nDCjU7k2XMPXVzp/hHLiozXK2Q7t2yiQQnE2aeBeopA=;
        b=ySydS5S7NCcxW2sO7kS+ESFm9nQcmN/vQ1Ctcc2Rq1jGiYT7ZWbKXfY72i8et7nX5n
         LfGZysbkrQHm7rcDOyJ3Y4qiMNCm4NwoW8MCWbcUuh1v7ZOsguXwMwQ8azkHXUMoPnXt
         towh7OUR/rQbM440RD8pH1hzeLTe+XUpe+eUsHdYKHIrKU4vp/W2LVMouqFMxFIOJBCZ
         H+5ALyj3F6b8YRvBv7FGISsB4hKfLfn2oU6Yk7zOdl32d803oWftxco18RPOfCrX1OpD
         nMkw1sjMd4Ydu3NYoftN1uhAs9iDcaiVbpRbqraSykeGXnVnHj/sVeQ3hW730HQQShtc
         bmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nDCjU7k2XMPXVzp/hHLiozXK2Q7t2yiQQnE2aeBeopA=;
        b=Ho3PTdLtz0W6vOJllsduxCqKOD/VZ/bz/syy123CMbZT3mfwxxEzLkOCxf1WX9nlPd
         0wW7W/0hiZPuwx1qLG/lt0sWBAqwso4VZSCgeUtbVxUXWFHQW/vcUa5cK0snardpPcjJ
         mrLldjXk8qHX/1Jo4UgBH7/MJU+py7rxrmhU1Goq7LKLJnsY70zBHUgJ7J3JWFr8jg/H
         vHXuYqizis0OZ3wiZg89hm2S8ts8i1pnpxHYQi61sFjYTzMY/PsFXM9wkqXXvC1MAHZG
         DyUwpzfrHYCJua8w3b31eM5aVTdAJ/EXNdf0TZcpVXoaNn/UNHJ0SrNljgRinajZmu+m
         Huyw==
X-Gm-Message-State: AOAM533QzdNkBhsZmjtUHixTpS3/Ujx4Wxm2t8GA3M2Oz26W1FdCD+To
        frJpKRxCa/fRUxcXxwFI1gVPUY0w640=
X-Google-Smtp-Source: ABdhPJwTeViFpRe8oPY+FVS1lEyfrccIDBCPotb4uA6K/7gsrYzywZ8Vs+MxlhratyhUQ38VLXp/uQ==
X-Received: by 2002:a63:b0f:: with SMTP id 15mr6801029pgl.6.1589902980570;
        Tue, 19 May 2020 08:43:00 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:14f4:acbd:a5d0:25ca? ([2605:e000:100e:8c61:14f4:acbd:a5d0:25ca])
        by smtp.gmail.com with ESMTPSA id p30sm980275pgn.58.2020.05.19.08.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 08:42:59 -0700 (PDT)
Subject: Re: [PATCH] block: Remove unused flush_queue_delayed in struct
 blk_flush_queue
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d4104441539e9d8d2bc29a9c970713ba1ef2105d.1589715744.git.baolin.wang7@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ec068795-5fd9-9d90-19bc-c145456fa5c5@kernel.dk>
Date:   Tue, 19 May 2020 09:42:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d4104441539e9d8d2bc29a9c970713ba1ef2105d.1589715744.git.baolin.wang7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/20 5:49 AM, Baolin Wang wrote:
> The flush_queue_delayed was introdued to hold queue if flush is
> running for non-queueable flush drive by commit 3ac0cc450870
> ("hold queue if flush is running for non-queueable flush drive"),
> but the non mq parts of the flush code had been removed by
> commit 7e992f847a08 ("block: remove non mq parts from the flush code"),
> as well as removing the usage of the flush_queue_delayed flag.
> Thus remove the unused flush_queue_delayed flag.

Applied, thanks.

-- 
Jens Axboe

